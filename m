Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB4C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5462083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5462083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbeGZOLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:11:55 -0400
Received: from foss.arm.com ([217.140.101.70]:55020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZOLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83ED8174E;
        Thu, 26 Jul 2018 05:55:10 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FA953F6A8;
        Thu, 26 Jul 2018 05:55:09 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 07/13] coresight: tmc-etr: Handle driver mode specific ETR buffers
Date:   Thu, 26 Jul 2018 13:54:45 +0100
Message-Id: <1532609691-16863-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ETR could be driven either by SYSFS or by perf, it
becomes complicated how we deal with the buffers used for each
of these modes. The ETR driver cannot simply free the current
attached buffer without knowing the provider (i.e, sysfs vs perf).

To solve this issue, we provide:
1) the driver-mode specific etr buffer to be retained in the drvdata
2) the etr_buf for a session should be passed on when enabling the
   hardware, which will be stored in drvdata->etr_buf. This will be
   replaced (not free'd) as soon as the hardware is disabled, after
   necessary sync operation.

The advantages of this are :

1) The common code path doesn't need to worry about how to dispose
   an existing buffer, if it is about to start a new session with a
   different buffer, possibly in a different mode.
2) The driver mode can control its buffers and can get access to the
   saved session even when the hardware is operating in a different
   mode. (e.g, we can still access a trace buffer from a sysfs mode
   even if the etr is now used in perf mode, without disrupting the
   current session.)

Towards this, we introduce a sysfs specific data which will hold the
etr_buf used for sysfs mode of operation, controlled solely by the
sysfs mode handling code.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 58 ++++++++++++++++---------
 drivers/hwtracing/coresight/coresight-tmc.h     |  2 +
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 2eda5de..58c7935 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -895,10 +895,15 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
-static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
+static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
+			      struct etr_buf *etr_buf)
 {
 	u32 axictl, sts;
-	struct etr_buf *etr_buf = drvdata->etr_buf;
+
+	/* Callers should provide an appropriate buffer for use */
+	if (WARN_ON(!etr_buf || drvdata->etr_buf))
+		return;
+	drvdata->etr_buf = etr_buf;
 
 	/*
 	 * If this ETR is connected to a CATU, enable it before we turn
@@ -960,13 +965,16 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
  * also updating the @bufpp on where to find it. Since the trace data
  * starts at anywhere in the buffer, depending on the RRP, we adjust the
  * @len returned to handle buffer wrapping around.
+ *
+ * We are protected here by drvdata->reading != 0, which ensures the
+ * sysfs_buf stays alive.
  */
 ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 				loff_t pos, size_t len, char **bufpp)
 {
 	s64 offset;
 	ssize_t actual = len;
-	struct etr_buf *etr_buf = drvdata->etr_buf;
+	struct etr_buf *etr_buf = drvdata->sysfs_buf;
 
 	if (pos + actual > etr_buf->len)
 		actual = etr_buf->len - pos;
@@ -996,7 +1004,14 @@ tmc_etr_free_sysfs_buf(struct etr_buf *buf)
 
 static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
 {
-	tmc_sync_etr_buf(drvdata);
+	struct etr_buf *etr_buf = drvdata->etr_buf;
+
+	if (WARN_ON(drvdata->sysfs_buf != etr_buf)) {
+		tmc_etr_free_sysfs_buf(drvdata->sysfs_buf);
+		drvdata->sysfs_buf = NULL;
+	} else {
+		tmc_sync_etr_buf(drvdata);
+	}
 }
 
 static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
@@ -1017,6 +1032,8 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
+	/* Reset the ETR buf used by hardware */
+	drvdata->etr_buf = NULL;
 }
 
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
@@ -1024,7 +1041,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct etr_buf *new_buf = NULL, *free_buf = NULL;
+	struct etr_buf *sysfs_buf = NULL, *new_buf = NULL, *free_buf = NULL;
 
 	/*
 	 * If we are enabling the ETR from disabled state, we need to make
@@ -1035,7 +1052,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * with the lock released.
 	 */
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (!drvdata->etr_buf || (drvdata->etr_buf->size != drvdata->size)) {
+	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
+	if (!sysfs_buf || (sysfs_buf->size != drvdata->size)) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 		/* Allocate memory with the locks released */
@@ -1064,14 +1082,14 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * If we don't have a buffer or it doesn't match the requested size,
 	 * use the buffer allocated above. Otherwise reuse the existing buffer.
 	 */
-	if (!drvdata->etr_buf ||
-	    (new_buf && drvdata->etr_buf->size != new_buf->size)) {
-		free_buf = drvdata->etr_buf;
-		drvdata->etr_buf = new_buf;
+	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
+	if (!sysfs_buf || (new_buf && sysfs_buf->size != new_buf->size)) {
+		free_buf = sysfs_buf;
+		drvdata->sysfs_buf = new_buf;
 	}
 
 	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etr_enable_hw(drvdata);
+	tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -1156,13 +1174,13 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
-	/* If drvdata::etr_buf is NULL the trace data has been read already */
-	if (drvdata->etr_buf == NULL) {
+	/* If sysfs_buf is NULL the trace data has been read already */
+	if (!drvdata->sysfs_buf) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* Disable the TMC if need be */
+	/* Disable the TMC if we are trying to read from a running session */
 	if (drvdata->mode == CS_MODE_SYSFS)
 		tmc_etr_disable_hw(drvdata);
 
@@ -1176,7 +1194,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 {
 	unsigned long flags;
-	struct etr_buf *etr_buf = NULL;
+	struct etr_buf *sysfs_buf = NULL;
 
 	/* config types are set a boot time and never change */
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
@@ -1191,22 +1209,22 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
 		 * be NULL.
 		 */
-		tmc_etr_enable_hw(drvdata);
+		tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
 	} else {
 		/*
 		 * The ETR is not tracing and the buffer was just read.
 		 * As such prepare to free the trace buffer.
 		 */
-		etr_buf =  drvdata->etr_buf;
-		drvdata->etr_buf = NULL;
+		sysfs_buf = drvdata->sysfs_buf;
+		drvdata->sysfs_buf = NULL;
 	}
 
 	drvdata->reading = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free allocated memory out side of the spinlock */
-	if (etr_buf)
-		tmc_free_etr_buf(etr_buf);
+	if (sysfs_buf)
+		tmc_etr_free_sysfs_buf(sysfs_buf);
 
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 7027bd6..872f63e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -170,6 +170,7 @@ struct etr_buf {
  * @trigger_cntr: amount of words to store after a trigger.
  * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
  *		device configuration register (DEVID)
+ * @sysfs_data:	SYSFS buffer for ETR.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -189,6 +190,7 @@ struct tmc_drvdata {
 	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 	u32			etr_caps;
+	struct etr_buf		*sysfs_buf;
 };
 
 struct etr_buf_operations {
-- 
2.7.4

