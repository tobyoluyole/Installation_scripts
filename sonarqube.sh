#!/bin/bash

sudo apt update

sudo apt install openjdk-11-jdk

sudo adduser sonar

sudo apt install postgresql postgresql-contrib

sudo -u postgres createdb sonarqube

wget https://sonarsource.com/downloads/sonarqube/sonarqube-9.3.0.zip

unzip sonarqube-9.3.0.zip

sudo mv sonarqube-9.3.0 /opt/sonarqube

sudo chown -R sonar:sonar /opt/sonarqube

sudo nano /opt/sonarqube/conf/sonar.properties

# Set the following properties:
# sonar.jdbc.username=sonar
# sonar.jdbc.password=my_password
# sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube

# Save and close the file

# Create a systemd service file for SonarQube
sudo nano /etc/systemd/system/sonarqube.service

# Paste the following code into the file:

[Unit]
Description=SonarQube
After=network.target

[Service]
User=sonar
Group=sonar
Type=simple
ExecStart=/opt/sonarqube/bin/start-sonar.sh

[Install]
WantedBy=multi-user.target

# Save and close the file

# Reload the systemd daemon
sudo systemctl daemon-reload

# Start the SonarQube service
sudo systemctl start sonarqube

# Enable the SonarQube service to start at boot
sudo systemctl enable sonarqube