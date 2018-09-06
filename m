Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FB52077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FB52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIFNnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41138 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbeIFNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC761684;
        Thu,  6 Sep 2018 02:08:50 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 197443F575;
        Thu,  6 Sep 2018 02:08:48 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 04/14] coresight: tmc-etb/etf: Prepare to handle errors enabling
Date:   Thu,  6 Sep 2018 10:08:25 +0100
Message-Id: <1536224915-31766-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to handle errors in enabling the hardware and
report it back to the core driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Fix return code for tmc_enable_etf_link (Mathieu Poirier)
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 73 +++++++++++++++----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4156c95..24908e0 100644
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
 
@@ -280,12 +295,14 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	tmc_etf_enable_hw(drvdata);
-	drvdata->mode = CS_MODE_SYSFS;
+	ret = tmc_etf_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
-	return 0;
+	if (!ret)
+		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
+	return ret;
 }
 
 static void tmc_disable_etf_link(struct coresight_device *csdev,
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

