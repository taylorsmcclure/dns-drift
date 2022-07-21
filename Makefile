# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


# Go tasks
go-run-dev:
	go run cmd/dns-drift/main.go config/branch.yaml dns-exercise.dev 8.8.8.8

go-build: ## build the application binary with local GOOS
	go build -ldflags="main.Version='development'" -o ./dns-drift cmd/dns-drift/main.go
	
go-build-linux: ## Build the go application with linux support
	GOOS=linux GOARCH=amd64 go build -ldflags="main.Version='development'" -o ./dns-drift cmd/dns-drift/main.go

lint: ## format the code with gofmt
	gofmt -w -s -l ./
