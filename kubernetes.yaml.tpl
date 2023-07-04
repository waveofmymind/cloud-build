apiVersion: apps/v1
kind: Deployment
metadata:
  name: goodjob
spec:
  replicas: 1
  selector:
    matchLabels:
      project: goodjob
      category: app
  template:
    metadata:
      labels:
        project: goodjob
        category: app
    spec:
      containers:
      - name: goodjob
        image: IMAGE_NAME_PLACEHOLDER
        ports:
        - containerPort: 8080
        envFrom:
        - secretRef:
            name: goodjob-config
        readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 20
        livenessProbe:
            httpGet:
              path: /actuator/health/liveness
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 20
