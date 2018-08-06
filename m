Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B27C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A1321A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A1321A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeHFPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbeHFPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7E016A3;
        Mon,  6 Aug 2018 06:43:28 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF4603F2EA;
        Mon,  6 Aug 2018 06:43:26 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 09/13] coresight: etmx: Claim devices before use
Date:   Mon,  6 Aug 2018 14:41:51 +0100
Message-Id: <1533562915-21558-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CLAIM tags to grab the device for self-hosted usage.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 18 +++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c | 15 ++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 771691c..b810bbc 100644
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
@@ -561,6 +569,8 @@ static void etm_disable_hw(void *info)
 	struct etm_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
+
+
 	etm_set_prog(drvdata);
 
 	/* Read back sequencer and counters for post trace analysis */
@@ -569,6 +579,8 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 4f9e6bb..20d1015 100644
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
@@ -326,6 +332,7 @@ static void etm4_disable_hw(void *info)
 
 	CS_UNLOCK(drvdata->base);
 
+
 	/* power can be removed from the trace unit now */
 	control = readl_relaxed(drvdata->base + TRCPDCR);
 	control &= ~TRCPDCR_PU;
@@ -341,6 +348,8 @@ static void etm4_disable_hw(void *info)
 	isb();
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
-- 
2.7.4

