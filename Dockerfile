# Use official Maven image to build the app
FROM maven:3.9.8-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use a smaller runtime image
FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/target/demo-app-1.0-SNAPSHOT.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
