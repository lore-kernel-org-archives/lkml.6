Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AH8x226CQwkoaQ3HSxy6qGVwX/Eg4o0BDLOWZxb/runkC6WQAZsqWXt9GEZMAh6dzvfih5bZRmfM
ARC-Seal: i=1; a=rsa-sha256; t=1519582203; cv=none;
        d=google.com; s=arc-20160816;
        b=e2i90zFa+KEy37UgiV/jYckiu2Zso26OcW+i+zCzE7mrkmPHVPeikVZmV45jjQkzPS
         CRNO/EoECHrzxf4KXMVjr3uxYV1ASo/i84DA9619m91VHm4Z3rCv2YkJfjSMZAoR6/Gd
         cCkPvUbTZ3lsjftkhwaTHJdcQwrGaano7XoGzMqHKLvgPHtiYnF/e3Kuy75vWJNfnVc/
         54ZmKdxoccz6dJaTS/fLa9k8wND+GViIRab2FJWp+TohPN1GbXNGsrIq7UcJQlhiDdMq
         F8fLPZZAS5Io9RnduTmXLIdfUi0pyOYBosQAM3Pd/kh7WMGlCXRkC60smNULG+IWD8tx
         r76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Y4ddAvjGv1XhrxkKWIipP6rYRDNwXvCSlYz5ZCTSZZM=;
        b=HgUSanD+y1Al3neQPw2dyMBeOWmjCDmlqHQ+iANQBfaMhbzurv1sImap7ZpodLx+gF
         ItKapEvbv5OSdR3Ja29fH/mP3E48qYpzcZ6JYXniN4nP6Avw+aa9wUHYVRCWjfL+CpJC
         LzAqONAi+9Ia+wykUcHSmr9q8674UbGdqD8SmiKg7ROs0eJSUFb81bWr7CZ9y7TvM2bV
         HdIv0kmXqbO/+yJ615OdmxgQG9bU3kGHN5MxYGYZaa56IRdQ2H1fjlRbfk4jma6Ls9J2
         LDgdbiq+/zDzMRPXvyzxy3SKXkkYOyvDxjBCr07bYJJ8PQddmgrPmCeEckkio8+7Jj8+
         r0ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,393,1515484800";
   d="scan'208";a="20124765"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: make module referencing local to the bus.c
Date: Sun, 25 Feb 2018 20:07:04 +0200
Message-Id: <20180225180705.9084-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593397428841733384?=
X-GMAIL-MSGID: =?utf-8?q?1593397428841733384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Module reference counting is relevant only to the
mei client devices. Make the implementation clean
and move it to bus.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c     | 66 ++++++++++++++++++++++++----------------------
 drivers/misc/mei/client.c  |  5 ----
 drivers/misc/mei/mei_dev.h |  2 --
 3 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 772d02922529..1dacc820bd7f 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -449,6 +449,29 @@ bool mei_cldev_enabled(struct mei_cl_device *cldev)
 }
 EXPORT_SYMBOL_GPL(mei_cldev_enabled);
 
+/**
+ * mei_cl_bus_module_get - acquire module of the underlying
+ *    hw driver.
+ *
+ * @cldev: mei client device
+ *
+ * Return: true on success; false if the module was removed.
+ */
+static bool mei_cl_bus_module_get(struct mei_cl_device *cldev)
+{
+	return try_module_get(cldev->bus->dev->driver->owner);
+}
+
+/**
+ * mei_cl_bus_module_put -  release the underlying hw module.
+ *
+ * @cldev: mei client device
+ */
+static void mei_cl_bus_module_put(struct mei_cl_device *cldev)
+{
+	module_put(cldev->bus->dev->driver->owner);
+}
+
 /**
  * mei_cldev_enable - enable me client device
  *     create connection with me client
@@ -487,9 +510,17 @@ int mei_cldev_enable(struct mei_cl_device *cldev)
 		goto out;
 	}
 
+	if (!mei_cl_bus_module_get(cldev)) {
+		dev_err(&cldev->dev, "get hw module failed");
+		ret = -ENODEV;
+		goto out;
+	}
+
 	ret = mei_cl_connect(cl, cldev->me_cl, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&cldev->dev, "cannot connect\n");
+		mei_cl_bus_module_put(cldev);
+	}
 
 out:
 	mutex_unlock(&bus->device_lock);
@@ -553,6 +584,8 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 		dev_err(bus->dev, "Could not disconnect from the ME client\n");
 
 out:
+	mei_cl_bus_module_put(cldev);
+
 	/* Flush queues and remove any pending read */
 	mei_cl_flush_queues(cl, NULL);
 	mei_cl_unlink(cl);
@@ -562,37 +595,6 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 }
 EXPORT_SYMBOL_GPL(mei_cldev_disable);
 
-/**
- * mei_cl_bus_module_get - acquire module of the underlying
- *    hw module.
- *
- * @cl: host client
- *
- * Return: true on success; false if the module was removed.
- */
-bool mei_cl_bus_module_get(struct mei_cl *cl)
-{
-	struct mei_cl_device *cldev = cl->cldev;
-
-	if (!cldev)
-		return true;
-
-	return try_module_get(cldev->bus->dev->driver->owner);
-}
-
-/**
- * mei_cl_bus_module_put -  release the underlying hw module.
- *
- * @cl: host client
- */
-void mei_cl_bus_module_put(struct mei_cl *cl)
-{
-	struct mei_cl_device *cldev = cl->cldev;
-
-	if (cldev)
-		module_put(cldev->bus->dev->driver->owner);
-}
-
 /**
  * mei_cl_device_find - find matching entry in the driver id table
  *
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 7e60c1817c31..bdfb4ecf848a 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -765,8 +765,6 @@ static void mei_cl_set_disconnected(struct mei_cl *cl)
 	cl->tx_flow_ctrl_creds = 0;
 	cl->timer_count = 0;
 
-	mei_cl_bus_module_put(cl);
-
 	if (!cl->me_cl)
 		return;
 
@@ -1076,9 +1074,6 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 
 	dev = cl->dev;
 
-	if (!mei_cl_bus_module_get(cl))
-		return -ENODEV;
-
 	rets = mei_cl_set_connecting(cl, me_cl);
 	if (rets)
 		goto nortpm;
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index ebcd5132e447..c08111441164 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -315,8 +315,6 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 bool mei_cl_bus_rx_event(struct mei_cl *cl);
 bool mei_cl_bus_notify_event(struct mei_cl *cl);
 void mei_cl_bus_remove_devices(struct mei_device *bus);
-bool mei_cl_bus_module_get(struct mei_cl *cl);
-void mei_cl_bus_module_put(struct mei_cl *cl);
 int mei_cl_bus_init(void);
 void mei_cl_bus_exit(void);
 
-- 
2.14.3
