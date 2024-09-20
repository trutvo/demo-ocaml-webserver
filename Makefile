
all: run

build:
	docker build -f Dockerfile.build -t webserver-build .
	docker create --name=wsb-temp webserver-build
	mkdir -p out
	docker cp wsb-temp:/app/_build/default/bin/webserver.exe out/webserver.exe
	docker rm wsb-temp

run: build
	docker build -f Dockerfile.run -t webserver-run .
	docker run --name webserver-run -p 9999:8080 webserver-run

clean:
	rm -rf out
	rm -rf _build
	docker kill webserver-run
	docker rm webserver-run
