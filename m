Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14774C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A488D2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A488D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeIFNn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbeIFNn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A63115B2;
        Thu,  6 Sep 2018 02:09:00 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9FAD3F575;
        Thu,  6 Sep 2018 02:08:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 10/14] coresight: etmx: Claim devices before use
Date:   Thu,  6 Sep 2018 10:08:31 +0100
Message-Id: <1536224915-31766-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CLAIM tags to grab the device for self-hosted usage.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 16 +++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c | 14 +++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 206c238..fd5c4cc 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -357,7 +357,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 
 static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
-	int i;
+	int i, rc;
 	u32 etmcr;
 	struct etm_config *config = &drvdata->config;
 
@@ -369,6 +369,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_set_pwrup(drvdata);
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
 
 	etm_set_prog(drvdata);
 
@@ -417,10 +420,15 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
 	etm_clr_prog(drvdata);
+
+done:
+	if (rc)
+		etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
-	return 0;
+	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+		drvdata->cpu, rc);
+	return rc;
 }
 
 struct etm_enable_arg {
@@ -569,6 +577,8 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 4f9e6bb..ac311e5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -84,13 +84,17 @@ struct etm4_enable_arg {
 
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
-	int i;
+	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
 
 	etm4_os_unlock(drvdata);
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
+
 	/* Disable the trace unit before programming trace registers */
 	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
 
@@ -178,10 +182,12 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		dev_err(drvdata->dev,
 			"timeout while waiting for Idle Trace Status\n");
 
+done:
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
-	return 0;
+	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+		drvdata->cpu, rc);
+	return rc;
 }
 
 static void etm4_enable_hw_smp_call(void *info)
@@ -341,6 +347,8 @@ static void etm4_disable_hw(void *info)
 	isb();
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
-- 
2.7.4

