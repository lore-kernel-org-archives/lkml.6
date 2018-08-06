Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4569DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D7E21A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D7E21A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeHFPwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:30 -0400
Received: from foss.arm.com ([217.140.101.70]:38866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeHFPw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D3E15B2;
        Mon,  6 Aug 2018 06:43:19 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2021D3F2EA;
        Mon,  6 Aug 2018 06:43:17 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 03/13] coresight: tmc-etb/etf: Prepare to handle errors enabling
Date:   Mon,  6 Aug 2018 14:41:45 +0100
Message-Id: <1533562915-21558-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to handle errors in enabling the hardware and
report it back to the core driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 71 +++++++++++++++----------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4156c95..ceb4b30 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -15,7 +15,7 @@
 static int tmc_set_etf_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle);
 
-static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -34,6 +34,12 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etb_enable_hw(drvdata);
+	return 0;
+}
+
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
 	char *bufp;
@@ -76,7 +82,7 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -92,6 +98,12 @@ static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etf_enable_hw(drvdata);
+	return 0;
+}
+
 static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -174,8 +186,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		drvdata->buf = buf;
 	}
 
-	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etb_enable_hw(drvdata);
+	ret = tmc_etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
+	else
+		/* Free up the buffer if we failed to enable */
+		used = false;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -194,27 +210,25 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
+	do {
 		ret = -EINVAL;
-		goto out;
-	}
+		if (drvdata->reading)
+			break;
+		/*
+		 * In Perf mode there can be only one writer per sink.  There
+		 * is also no need to continue if the ETB/ETF is already
+		 * operated from sysFS.
+		 */
+		if (drvdata->mode != CS_MODE_DISABLED)
+			break;
 
-	/*
-	 * In Perf mode there can be only one writer per sink.  There
-	 * is also no need to continue if the ETB/ETR is already operated
-	 * from sysFS.
-	 */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = tmc_set_etf_buffer(csdev, handle);
-	if (!ret) {
-		drvdata->mode = CS_MODE_PERF;
-		tmc_etb_enable_hw(drvdata);
-	}
-out:
+		ret = tmc_set_etf_buffer(csdev, handle);
+		if (ret)
+			break;
+		ret  = tmc_etb_enable_hw(drvdata);
+		if (!ret)
+			drvdata->mode = CS_MODE_PERF;
+	} while (0);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
@@ -271,6 +285,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 static int tmc_enable_etf_link(struct coresight_device *csdev,
 			       int inport, int outport)
 {
+	int ret;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -280,11 +295,13 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	tmc_etf_enable_hw(drvdata);
-	drvdata->mode = CS_MODE_SYSFS;
+	ret = tmc_etf_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
+	if (!ret)
+		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
 	return 0;
 }
 
@@ -579,7 +596,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 		 * can't be NULL.
 		 */
 		memset(drvdata->buf, 0, drvdata->size);
-		tmc_etb_enable_hw(drvdata);
+		__tmc_etb_enable_hw(drvdata);
 	} else {
 		/*
 		 * The ETB/ETF is not tracing and the buffer was just read.
-- 
2.7.4

