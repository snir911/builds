# Here you can use whatever base image is relevant for your application.
FROM fedora:latest

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="builder c webserver" \
    io.k8s.display-name="builder" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder"

# Install the nginx web server package and clean the yum cache
RUN dnf install make gcc -y

# Copy the S2I scripts to /usr/libexec/
COPY ./.s2i/bin/usage /usr/libexec/

# Set the default port for applications built using this image
EXPOSE 8080

# Modify the usage script in your application dir to inform the user how to run
# this image.
CMD ["./s2i/bin/usage"]

