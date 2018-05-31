Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeEaFhQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:37:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeEaFhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:37:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59436602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
From: Akhil P Oommen <akhilpo@codeaurora.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jcrouse@codeaurora.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-arm-msm@vger.kernel.org
Subject: [RFC] PM / devfreq: Add support for alerts
Date: Thu, 31 May 2018 11:06:59 +0530
Message-Id: <1527745019-25155-1-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, DEVFREQ reevaluates the device state periodically and/or
based on the OPP list changes. Private API has to be exposed to allow
the device driver to alert/notify the governor to reevaluate when a new
set of data is available. This makes the governor more coupled to a
particular device driver. We can improve here by exposing a DEVFREQ API
to allow the device drivers to send generic alerts to the governor.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
 drivers/devfreq/devfreq.c  | 21 +++++++++++++++++++++
 drivers/devfreq/governor.h |  1 +
 include/linux/devfreq.h    |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6a..24a8046 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1532,3 +1532,24 @@ void devm_devfreq_unregister_notifier(struct device *dev,
 			       devm_devfreq_dev_match, devfreq));
 }
 EXPORT_SYMBOL(devm_devfreq_unregister_notifier);
+
+/**
+ * devfreq_alert_governor() - Alert governor about an event
+ * @devfreq:	The devfreq object.
+ * @type:	Optional alert type.
+ *
+ * This function lets the device alert the governor about an event.
+ * A governor may not implement or choose to completely ignore this alert.
+ */
+void devfreq_alert_governor(struct devfreq *devfreq, unsigned int type)
+{
+	/* Don't let someone change the governor until we are done here. */
+	mutex_lock(&devfreq_list_lock);
+
+	if (devfreq)
+		devfreq->governor->event_handler(devfreq,
+				DEVFREQ_GOV_ALERT, &type);
+
+	mutex_unlock(&devfreq_list_lock);
+}
+EXPORT_SYMBOL(devfreq_alert_governor);
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index cfc50a6..e5da3442 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -24,6 +24,7 @@
 #define DEVFREQ_GOV_INTERVAL			0x3
 #define DEVFREQ_GOV_SUSPEND			0x4
 #define DEVFREQ_GOV_RESUME			0x5
+#define DEVFREQ_GOV_ALERT			0x6
 
 /**
  * struct devfreq_governor - Devfreq policy governor
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3aae5b3..740c228 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -193,6 +193,7 @@ extern struct devfreq *devm_devfreq_add_device(struct device *dev,
 				  void *data);
 extern void devm_devfreq_remove_device(struct device *dev,
 				  struct devfreq *devfreq);
+extern void devfreq_alert_governor(struct devfreq *devfreq, unsigned int type);
 
 /* Supposed to be called by PM callbacks */
 extern int devfreq_suspend_device(struct devfreq *devfreq);
@@ -306,6 +307,10 @@ static inline void devm_devfreq_remove_device(struct device *dev,
 {
 }
 
+static void devfreq_alert_governor(struct devfreq *devfreq, unsigned int type)
+{
+}
+
 static inline int devfreq_suspend_device(struct devfreq *devfreq)
 {
 	return 0;
-- 
1.9.1
