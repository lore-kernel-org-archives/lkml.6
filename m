Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470749; cv=none;
        d=google.com; s=arc-20160816;
        b=jutLQioIDAc8nfSaH8WIvX+mDXrjzWXvDq8+sTVA8bvOKNSPVaTPNElDQSxxvIlH4T
         k+xIOXj157OB+fybVnitEbram8uKyALJi1TeYbq5wB/dRX7SwGSuN6a89YE7OEQeKyAX
         5Ym7fo2bxBctxl43sFisKx85ugt6z87ikRzDmuC41KpKkD6S2DyMmdAEznBxN1kIaRs9
         zuX6xzUlctUa0IxIkqe0Ad4FcWOk7s+1J129HtTkZOKkiowKlXFBfwMvLDfLdJRTqqS4
         8qSOpc3q+rB/sHplJ0MH+iDDboM/SITEHhYprFjIMn0ZlimqKXYFBjSYep2SbbDdNWtG
         VRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=orK3jueeD8iKHAfbK5diacUPArijIBIe08XpYi0WLvQ=;
        b=DIRGPQj4/j2eJRy5lzN1w93StHjQjq3td2pINJH4iXyEL/27GIEaAk9Juwvf6IOjh7
         vC8fr1HYLFnP3ZEGgcqeKZq6EWARpNb8/pTUxhf7gn3lCSiulAxieV6PbocfazTwWfVE
         +KEE6ed+a6SzX8J5OnaVqZ2HP8U0t7awk2VwJq/6vLn86flRhYtgqgXktSQFBQixyxZf
         uFAfbOAABvzWVV3zFN2jEb3Ei0j8B7GNmH1b5x4Jh8T6h3WBcf1v2A1s0kUcdUuC/hWG
         TlrFK56jE2Jm9vfIWK1kZqq3a8wuWQdt0QoG60j7zdTp+NpG5FzQBkaI6pnBZUy75Kt+
         bY3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QdR4wsqt;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QdR4wsqt;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoO5JriTfuuLrZYeCwZVhP//7EcIa3X2/3nwrHD5FQQFjZUI9rY6RdNSJpuEcLOM3r6JF6DXg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] slimbus: core: add of_slim_device_get() helper
Date: Wed, 16 May 2018 12:36:36 +0100
Message-Id: <20180516113642.28136-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620592399257344?=
X-GMAIL-MSGID: =?utf-8?q?1600620592399257344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On SLIMBus controllers like Qcom NGD(non ported device), controller
can request logical address once the remote side is powered, having a
helper function like this to explicitly enumerate the bus is helpful.
Also codec drivers which are taking to interface device would need
such a helper too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 7ddfc675b131..88248a4ecad9 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -356,6 +356,45 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
+static int of_slim_match_dev(struct device *dev, void *data)
+{
+	struct device_node *np = data;
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	return (sbdev->dev.of_node == np);
+}
+
+static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
+					       struct device_node *np)
+{
+	struct slim_device *sbdev;
+	struct device *dev;
+
+	dev = device_find_child(ctrl->dev, np, of_slim_match_dev);
+	if (dev) {
+		sbdev = to_slim_device(dev);
+		return sbdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * of_slim_get_device() - get handle to a device using dt node.
+ *
+ * @ctrl: Controller on which this device will be added/queried
+ * @np: node pointer to device
+ *
+ * Return: pointer to a device if it has already reported. Creates a new
+ * device and returns pointer to it if the device has not yet enumerated.
+ */
+struct slim_device *of_slim_get_device(struct slim_controller *ctrl,
+				       struct device_node *np)
+{
+	return of_find_slim_device(ctrl, np);
+}
+EXPORT_SYMBOL_GPL(of_slim_get_device);
+
 static int slim_device_alloc_laddr(struct slim_device *sbdev,
 				   bool report_present)
 {
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index c36cf121d2cd..efa36a852dc3 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -138,6 +138,8 @@ static inline void slim_set_devicedata(struct slim_device *dev, void *data)
 	dev_set_drvdata(&dev->dev, data);
 }
 
+struct slim_device *of_slim_get_device(struct slim_controller *ctrl,
+				       struct device_node *np);
 struct slim_device *slim_get_device(struct slim_controller *ctrl,
 				    struct slim_eaddr *e_addr);
 int slim_get_logical_addr(struct slim_device *sbdev);
-- 
2.16.2
