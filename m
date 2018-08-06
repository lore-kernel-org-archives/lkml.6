Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D8421A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D8421A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeHFPw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38844 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeHFPw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6755E15AB;
        Mon,  6 Aug 2018 06:43:16 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 364813F2EA;
        Mon,  6 Aug 2018 06:43:15 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 01/13] coresight: tmc-etr: Refactor for handling errors
Date:   Mon,  6 Aug 2018 14:41:43 +0100
Message-Id: <1533562915-21558-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the tmc-etr enable operation to make it easier to
handle errors in enabling the hardware. We need to make
sure that the buffer is compatible with the ETR. This
patch re-arranges to make the error handling easier, by
deferring the hardware enablement until all the errors
are checked. This also avoids turning the CATU on/off
during a sysfs read session.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 67 ++++++++++++++++---------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 56fea4f..c426935 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -918,21 +918,10 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
-static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
-			      struct etr_buf *etr_buf)
+static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
-
-	/* Callers should provide an appropriate buffer for use */
-	if (WARN_ON(!etr_buf || drvdata->etr_buf))
-		return;
-	drvdata->etr_buf = etr_buf;
-
-	/*
-	 * If this ETR is connected to a CATU, enable it before we turn
-	 * this on
-	 */
-	tmc_etr_enable_catu(drvdata);
+	struct etr_buf *etr_buf = drvdata->etr_buf;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -952,11 +941,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 		axictl |= TMC_AXICTL_ARCACHE_OS;
 	}
 
-	if (etr_buf->mode == ETR_MODE_ETR_SG) {
-		if (WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
-			return;
+	if (etr_buf->mode == ETR_MODE_ETR_SG)
 		axictl |= TMC_AXICTL_SCT_GAT_MODE;
-	}
 
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, etr_buf->hwaddr);
@@ -982,6 +968,32 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
+			     struct etr_buf *etr_buf)
+{
+	/* Callers should provide an appropriate buffer for use */
+	if (WARN_ON(!etr_buf))
+		return -EINVAL;
+
+	if ((etr_buf->mode == ETR_MODE_ETR_SG) &&
+	    WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
+		return -EINVAL;
+
+	if (WARN_ON(drvdata->etr_buf))
+		return -EBUSY;
+
+	/* Set the buffer for the session */
+	drvdata->etr_buf = etr_buf;
+	/*
+	 * If this ETR is connected to a CATU, enable it before we turn
+	 * this on.
+	 */
+	tmc_etr_enable_catu(drvdata);
+
+	__tmc_etr_enable_hw(drvdata);
+	return 0;
+}
+
 /*
  * Return the available trace data in the buffer (starts at etr_buf->offset,
  * limited by etr_buf->len) from @pos, with a maximum limit of @len,
@@ -1037,7 +1049,7 @@ static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
 	}
 }
 
-static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -1053,6 +1065,11 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 	CS_LOCK(drvdata->base);
 
+}
+
+static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
 	/* Reset the ETR buf used by hardware */
@@ -1111,8 +1128,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		drvdata->sysfs_buf = new_buf;
 	}
 
-	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -1342,8 +1360,9 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
 	drvdata->perf_data = etr_perf;
-	drvdata->mode = CS_MODE_PERF;
-	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+	if (!rc)
+		drvdata->mode = CS_MODE_PERF;
 
 unlock_out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1425,7 +1444,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	/* Disable the TMC if we are trying to read from a running session. */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etr_disable_hw(drvdata);
+		__tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
@@ -1452,7 +1471,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
 		 * be NULL.
 		 */
-		tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+		__tmc_etr_enable_hw(drvdata);
 	} else {
 		/*
 		 * The ETR is not tracing and the buffer was just read.
-- 
2.7.4

