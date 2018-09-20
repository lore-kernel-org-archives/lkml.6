Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F7421531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQPqRJ7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F7421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeIUBDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40194 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbeIUBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so4791274plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPwq9RpZ3HZmGVoBRVZImO+Obs44n4fXrxe3KFa48HM=;
        b=HQPqRJ7A4zLKovaTX51MvDuqZqMkeVASOWIjZk/z6eUt7c57jAM+jl6pPDB64o2kZO
         HDwdMxqrOBK21i+x10MsnFDc/0MWFg/Fxv6sqCJyZXzf1hkWFE5HVR/pCPxqKJdCZFW2
         SKZ4b51ISiQ3aEXNHDmmbhZqQyHHYaW27HLfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPwq9RpZ3HZmGVoBRVZImO+Obs44n4fXrxe3KFa48HM=;
        b=BTtGdixT9/nGevFJDJvRJIrLud2Oa+65ClXxTcuu5QLPGQIGXYw/jWss5NBXc56dd+
         MVcxNaZTqmZ8wCvojJMuRv3ehQjTf7Xv7vdQJ9GxoayP/lmrTIfVpzSurOztBsMdJpL2
         7bHSIFvSWR5YmrlAZxwmfKS5PhLP9h+xWPri2w6V0lvmE5+OeCHJesF5pkQVsSdTmak8
         1w60uiOTHIpyWrDNrO4wi7WM4OcBCf5XhU/ig4vMU/jUDu4F/1bVl/3bmDyKrX5XK3nd
         ECD4qnadFzTEuRlywMQHTSsiDhpeF0NoxMOBvSwWdjUPIUTUAMuvPCDc0hkcYocS5FbD
         Ol8w==
X-Gm-Message-State: APzg51BYdbqXGgXevKXRkgdhStpBTYRamDm0Q780qXz8FKyzukOJW47T
        tsy7W3L3hcb7fzixrJYrVKNyRQ==
X-Google-Smtp-Source: ANB0VdZv8W6mjPVdgZ7In/Z5dP8u2R6KTOmxOSn18b6OQBFplg1Hbg7rKiJb+K6PI/R34tPsprs+hg==
X-Received: by 2002:a17:902:a715:: with SMTP id w21-v6mr40816192plq.61.1537471133811;
        Thu, 20 Sep 2018 12:18:53 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:52 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 21/44] coresight: perf: Remove set_buffer call back
Date:   Thu, 20 Sep 2018 13:17:56 -0600
Message-Id: <1537471099-19781-22-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

In coresight perf mode, we need to prepare the sink before
starting a session, which is done via set_buffer call back.
We then proceed to enable the tracing. If we fail to start
the session successfully, we leave the sink configuration
unchanged.  In order to make the operation atomic and to
avoid yet another call back to clear the buffer, we get
rid of the "set_buffer" call back and pass the buffer details
via enable() call back to the sink.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c    | 32 ++++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm-perf.c |  9 ++-----
 drivers/hwtracing/coresight/coresight-priv.h     |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 28 ++++++++++++++-------
 drivers/hwtracing/coresight/coresight-tmc-etr.c  |  7 +++---
 drivers/hwtracing/coresight/coresight-tpiu.c     |  2 +-
 drivers/hwtracing/coresight/coresight.c          | 11 ++++----
 include/linux/coresight.h                        |  6 +----
 8 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index dba75c905e57..9fd77fdc1244 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -28,6 +28,7 @@
 
 
 #include "coresight-priv.h"
+#include "coresight-etm-perf.h"
 
 #define ETB_RAM_DEPTH_REG	0x004
 #define ETB_STATUS_REG		0x00c
@@ -90,6 +91,9 @@ struct etb_drvdata {
 	u32			trigger_cntr;
 };
 
+static int etb_set_buffer(struct coresight_device *csdev,
+			  struct perf_output_handle *handle);
+
 static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 {
 	u32 depth = 0;
@@ -131,12 +135,24 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int etb_enable(struct coresight_device *csdev, u32 mode)
+static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
+	int ret = 0;
 	u32 val;
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	/*
+	 * We don't have an internal state to clean up if we fail to setup
+	 * the perf buffer. So we can perform the step before we turn the
+	 * ETB on and leave without cleaning up.
+	 */
+	if (mode == CS_MODE_PERF) {
+		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+		if (ret)
+			goto out;
+	}
+
 	val = local_cmpxchg(&drvdata->mode,
 			    CS_MODE_DISABLED, mode);
 	/*
@@ -160,8 +176,9 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
-	dev_dbg(drvdata->dev, "ETB enabled\n");
-	return 0;
+	if (!ret)
+		dev_dbg(drvdata->dev, "ETB enabled\n");
+	return ret;
 }
 
 static void etb_disable_hw(struct etb_drvdata *drvdata)
@@ -298,12 +315,14 @@ static void etb_free_buffer(void *config)
 }
 
 static int etb_set_buffer(struct coresight_device *csdev,
-			  struct perf_output_handle *handle,
-			  void *sink_config)
+			  struct perf_output_handle *handle)
 {
 	int ret = 0;
 	unsigned long head;
-	struct cs_buffers *buf = sink_config;
+	struct cs_buffers *buf = etm_perf_sink_config(handle);
+
+	if (!buf)
+		return -EINVAL;
 
 	/* wrap head around to the amount of space we have */
 	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
@@ -457,7 +476,6 @@ static const struct coresight_ops_sink etb_sink_ops = {
 	.disable	= etb_disable,
 	.alloc_buffer	= etb_alloc_buffer,
 	.free_buffer	= etb_free_buffer,
-	.set_buffer	= etb_set_buffer,
 	.update_buffer	= etb_update_buffer,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 16b83d8b2ac2..abe8249b893b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -286,16 +286,11 @@ static void etm_event_start(struct perf_event *event, int flags)
 	path = etm_event_cpu_path(event_data, cpu);
 	/* We need a sink, no need to continue without one */
 	sink = coresight_get_sink(path);
-	if (WARN_ON_ONCE(!sink || !sink_ops(sink)->set_buffer))
-		goto fail_end_stop;
-
-	/* Configure the sink */
-	if (sink_ops(sink)->set_buffer(sink, handle,
-				       event_data->snk_config))
+	if (WARN_ON_ONCE(!sink))
 		goto fail_end_stop;
 
 	/* Nothing will happen without a path */
-	if (coresight_enable_path(path, CS_MODE_PERF))
+	if (coresight_enable_path(path, CS_MODE_PERF, handle))
 		goto fail_end_stop;
 
 	/* Tell the perf core the event is alive */
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 1a6cf3589866..c11da5564a67 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -137,7 +137,7 @@ static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
 }
 
 void coresight_disable_path(struct list_head *path);
-int coresight_enable_path(struct list_head *path, u32 mode);
+int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
 struct list_head *coresight_build_path(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 31a98f915641..4156c95ce1bb 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -10,6 +10,10 @@
 #include <linux/slab.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
+#include "coresight-etm-perf.h"
+
+static int tmc_set_etf_buffer(struct coresight_device *csdev,
+			      struct perf_output_handle *handle);
 
 static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
@@ -182,11 +186,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
-static int tmc_enable_etf_sink_perf(struct coresight_device *csdev)
+static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 {
 	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct perf_output_handle *handle = data;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
@@ -204,15 +209,19 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev)
 		goto out;
 	}
 
-	drvdata->mode = CS_MODE_PERF;
-	tmc_etb_enable_hw(drvdata);
+	ret = tmc_set_etf_buffer(csdev, handle);
+	if (!ret) {
+		drvdata->mode = CS_MODE_PERF;
+		tmc_etb_enable_hw(drvdata);
+	}
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
 
-static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etf_sink(struct coresight_device *csdev,
+			       u32 mode, void *data)
 {
 	int ret;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -222,7 +231,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 		ret = tmc_enable_etf_sink_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		ret = tmc_enable_etf_sink_perf(csdev);
+		ret = tmc_enable_etf_sink_perf(csdev, data);
 		break;
 	/* We shouldn't be here */
 	default:
@@ -328,12 +337,14 @@ static void tmc_free_etf_buffer(void *config)
 }
 
 static int tmc_set_etf_buffer(struct coresight_device *csdev,
-			      struct perf_output_handle *handle,
-			      void *sink_config)
+			      struct perf_output_handle *handle)
 {
 	int ret = 0;
 	unsigned long head;
-	struct cs_buffers *buf = sink_config;
+	struct cs_buffers *buf = etm_perf_sink_config(handle);
+
+	if (!buf)
+		return -EINVAL;
 
 	/* wrap head around to the amount of space we have */
 	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
@@ -472,7 +483,6 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.disable	= tmc_disable_etf_sink,
 	.alloc_buffer	= tmc_alloc_etf_buffer,
 	.free_buffer	= tmc_free_etf_buffer,
-	.set_buffer	= tmc_set_etf_buffer,
 	.update_buffer	= tmc_update_etf_buffer,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 5e9bb2f0e9c0..1aedfc3629c0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1103,19 +1103,20 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
-static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
+static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 {
 	/* We don't support perf mode yet ! */
 	return -EINVAL;
 }
 
-static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etr_sink(struct coresight_device *csdev,
+			       u32 mode, void *data)
 {
 	switch (mode) {
 	case CS_MODE_SYSFS:
 		return tmc_enable_etr_sink_sysfs(csdev);
 	case CS_MODE_PERF:
-		return tmc_enable_etr_sink_perf(csdev);
+		return tmc_enable_etr_sink_perf(csdev, data);
 	}
 
 	/* We shouldn't be here */
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index ce0b84583861..b2f72a1fa402 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -68,7 +68,7 @@ static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tpiu_enable(struct coresight_device *csdev, u32 mode)
+static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 07382c55b31d..e73ca6af4765 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -128,7 +128,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	return -ENODEV;
 }
 
-static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
+static int coresight_enable_sink(struct coresight_device *csdev,
+				 u32 mode, void *data)
 {
 	int ret;
 
@@ -137,7 +138,7 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
 	 * existing "mode" of operation.
 	 */
 	if (sink_ops(csdev)->enable) {
-		ret = sink_ops(csdev)->enable(csdev, mode);
+		ret = sink_ops(csdev)->enable(csdev, mode, data);
 		if (ret)
 			return ret;
 		csdev->enable = true;
@@ -315,7 +316,7 @@ void coresight_disable_path(struct list_head *path)
 	}
 }
 
-int coresight_enable_path(struct list_head *path, u32 mode)
+int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
 
 	int ret = 0;
@@ -340,7 +341,7 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-			ret = coresight_enable_sink(csdev, mode);
+			ret = coresight_enable_sink(csdev, mode, sink_data);
 			/*
 			 * Sink is the first component turned on. If we
 			 * failed to enable the sink, there are no components
@@ -643,7 +644,7 @@ int coresight_enable(struct coresight_device *csdev)
 		goto out;
 	}
 
-	ret = coresight_enable_path(path, CS_MODE_SYSFS);
+	ret = coresight_enable_path(path, CS_MODE_SYSFS, NULL);
 	if (ret)
 		goto err_path;
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 8e52682b1e90..53535821dc25 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -185,18 +185,14 @@ struct coresight_device {
  * @disable:		disables the sink.
  * @alloc_buffer:	initialises perf's ring buffer for trace collection.
  * @free_buffer:	release memory allocated in @get_config.
- * @set_buffer:		initialises buffer mechanic before a trace session.
  * @update_buffer:	update buffer pointers after a trace session.
  */
 struct coresight_ops_sink {
-	int (*enable)(struct coresight_device *csdev, u32 mode);
+	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
 	void (*disable)(struct coresight_device *csdev);
 	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
 			      void **pages, int nr_pages, bool overwrite);
 	void (*free_buffer)(void *config);
-	int (*set_buffer)(struct coresight_device *csdev,
-			  struct perf_output_handle *handle,
-			  void *sink_config);
 	unsigned long (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config);
-- 
2.7.4

