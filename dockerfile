	FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env    
	#gets base OS image that contains the required .NET runtime
	EXPOSE 8000
	#exposes port 8000 on the container
	WORKDIR /main
	#creates new folder called "main"
	COPY . ./
	#copies all files within the current "demowebwebapp" folder into "main"
	RUN dotnet restore  
	#restores all the .NET dependencies within the project
	RUN dotnet publish "./demowebapp.csproj" -c Release -o out --no-restore
	#publishes the app into another folder named "out"
	FROM mcr.microsoft.com/dotnet/aspnet:7.0
	#gets base OS image that contains all required ASP.NET dependencies for building web applications
	WORKDIR /App
	#creates new folder "App" in another instance
	COPY --from=build-env /main/out .
	#copies the files from the "out" folder where the published app resides from the old "build-env" instance
	ENTRYPOINT ["dotnet","demowebapp.dll"]
	#runs the code "dotnet mynewwebapp.dll" into the command line
