Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeEGRzN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:55:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEGRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:55:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFFA26022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] drivers: thermal: do not clobber cooling dev state from userspace
Date: Mon,  7 May 2018 11:55:05 -0600
Message-Id: <20180507175505.2389-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Chandrasekar <rkumbako@codeaurora.org>

Let userspace be another voter for cooling device state instead of the
overriding authority. It is possible that the thermal governor may find
a higher cooling state desirable than what is recommended by the
userspace. Separate out the current cooling device state from the
userspace request and aggregate the userspace request with the
governors' recommendation.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/thermal_core.c    | 1 +
 drivers/thermal/thermal_helpers.c | 2 +-
 drivers/thermal/thermal_sysfs.c   | 8 +++++++-
 include/linux/thermal.h           | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 589925ac0994..c2e13e122934 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -970,6 +970,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
+	cdev->sysfs_req = 0;
 	thermal_cooling_device_setup_sysfs(cdev);
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756af76b7..f550fdee0f9b 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -166,7 +166,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
 void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
-	unsigned long target = 0;
+	unsigned long target = cdev->sysfs_req;
 
 	mutex_lock(&cdev->lock);
 	/* cooling device is updated*/
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 275ffee292bf..eddada715ad2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -719,7 +719,13 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	result = cdev->ops->set_cur_state(cdev, state);
 	if (result)
 		return result;
-	thermal_cooling_device_stats_update(cdev, state);
+
+	cdev->sysfs_req = state;
+	mutex_lock(&cdev->lock);
+	cdev->updated = false;
+	mutex_unlock(&cdev->lock);
+	thermal_cdev_update(cdev);
+
 	return count;
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..7a133bd6ff86 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -139,6 +139,7 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+	unsigned long sysfs_req;
 };
 
 struct thermal_attr {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
