Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CC424CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CC424CA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933140AbeFYLYT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:24:19 -0400
Received: from foss.arm.com ([217.140.101.70]:54898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755308AbeFYLXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:23:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4E415AD;
        Mon, 25 Jun 2018 04:23:01 -0700 (PDT)
Received: from localhost.localdomain.com (unknown [10.1.207.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD7163F59C;
        Mon, 25 Jun 2018 04:22:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 2/6] coresight: Add helper device type
Date:   Mon, 25 Jun 2018 12:22:09 +0100
Message-Id: <20180625112213.23492-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180625112213.23492-1-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new coresight device type, which do not belong to any
of the existing types, i.e, source, sink, link etc. A helper
device could be connected to a coresight device, which could
augment the functionality of the coresight device.

This is intended to cover Coresight Address Translation Unit (CATU)
devices, which provide improved Scatter Gather mechanism for TMC
ETR. The idea is that the helper device could be controlled by
the driver of the device it is attached to (in this case ETR),
transparent to the generic coresight driver (and paths).

The operations include enable(), disable(), both of which could
accept a device specific "data" which the driving device and
the helper device could share. Since they don't appear in the
coresight "path" tracked by software, we have to ensure that
they are powered up/down whenever the master device is turned
on.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 43 +++++++++++++++++++++++++++++++--
 include/linux/coresight.h               | 24 ++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 7f2b478..3e07fd3 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -425,6 +425,42 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+/*
+ * coresight_grab_device - Power up this device and any of the helper
+ * devices connected to it for trace operation. Since the helper devices
+ * don't appear on the trace path, they should be handled along with the
+ * the master device.
+ */
+static void coresight_grab_device(struct coresight_device *csdev)
+{
+	int i;
+
+	for (i = 0; i < csdev->nr_outport; i++) {
+		struct coresight_device *child = csdev->conns[i].child_dev;
+
+		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
+			pm_runtime_get_sync(child->dev.parent);
+	}
+	pm_runtime_get_sync(csdev->dev.parent);
+}
+
+/*
+ * coresight_drop_device - Release this device and any of the helper
+ * devices connected to it.
+ */
+static void coresight_drop_device(struct coresight_device *csdev)
+{
+	int i;
+
+	pm_runtime_put(csdev->dev.parent);
+	for (i = 0; i < csdev->nr_outport; i++) {
+		struct coresight_device *child = csdev->conns[i].child_dev;
+
+		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
+			pm_runtime_put(child->dev.parent);
+	}
+}
+
 /**
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
  * @csdev:	The device to start from.
@@ -473,9 +509,9 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	if (!node)
 		return -ENOMEM;
 
+	coresight_grab_device(csdev);
 	node->csdev = csdev;
 	list_add(&node->link, path);
-	pm_runtime_get_sync(csdev->dev.parent);
 
 	return 0;
 }
@@ -519,7 +555,7 @@ void coresight_release_path(struct list_head *path)
 	list_for_each_entry_safe(nd, next, path, link) {
 		csdev = nd->csdev;
 
-		pm_runtime_put_sync(csdev->dev.parent);
+		coresight_drop_device(csdev);
 		list_del(&nd->link);
 		kfree(nd);
 	}
@@ -770,6 +806,9 @@ static struct device_type coresight_dev_type[] = {
 		.name = "source",
 		.groups = coresight_source_groups,
 	},
+	{
+		.name = "helper",
+	},
 };
 
 static void coresight_device_release(struct device *dev)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 7c188c2..3d40a2b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -40,6 +40,7 @@ enum coresight_dev_type {
 	CORESIGHT_DEV_TYPE_LINK,
 	CORESIGHT_DEV_TYPE_LINKSINK,
 	CORESIGHT_DEV_TYPE_SOURCE,
+	CORESIGHT_DEV_TYPE_HELPER,
 };
 
 enum coresight_dev_subtype_sink {
@@ -62,6 +63,10 @@ enum coresight_dev_subtype_source {
 	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
 };
 
+enum coresight_dev_subtype_helper {
+	CORESIGHT_DEV_SUBTYPE_HELPER_NONE,
+};
+
 /**
  * union coresight_dev_subtype - further characterisation of a type
  * @sink_subtype:	type of sink this component is, as defined
@@ -70,6 +75,8 @@ enum coresight_dev_subtype_source {
  *			by @coresight_dev_subtype_link.
  * @source_subtype:	type of source this component is, as defined
  *			by @coresight_dev_subtype_source.
+ * @helper_subtype:	type of helper this component is, as defined
+ *			by @coresight_dev_subtype_helper.
  */
 union coresight_dev_subtype {
 	/* We have some devices which acts as LINK and SINK */
@@ -78,6 +85,7 @@ union coresight_dev_subtype {
 		enum coresight_dev_subtype_link link_subtype;
 	};
 	enum coresight_dev_subtype_source source_subtype;
+	enum coresight_dev_subtype_helper helper_subtype;
 };
 
 /**
@@ -172,6 +180,7 @@ struct coresight_device {
 #define source_ops(csdev)	csdev->ops->source_ops
 #define sink_ops(csdev)		csdev->ops->sink_ops
 #define link_ops(csdev)		csdev->ops->link_ops
+#define helper_ops(csdev)	csdev->ops->helper_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -231,10 +240,25 @@ struct coresight_ops_source {
 			struct perf_event *event);
 };
 
+/**
+ * struct coresight_ops_helper - Operations for a helper device.
+ *
+ * All operations could pass in a device specific data, which could
+ * help the helper device to determine what to do.
+ *
+ * @enable	: Enable the device
+ * @disable	: Disable the device
+ */
+struct coresight_ops_helper {
+	int (*enable)(struct coresight_device *csdev, void *data);
+	int (*disable)(struct coresight_device *csdev, void *data);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
+	const struct coresight_ops_helper *helper_ops;
 };
 
 #ifdef CONFIG_CORESIGHT
-- 
2.9.5

