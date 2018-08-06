Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F12C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926F121A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926F121A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeHFPwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:33 -0400
Received: from foss.arm.com ([217.140.101.70]:38876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbeHFPwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A21D1682;
        Mon,  6 Aug 2018 06:43:22 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 095223F2EA;
        Mon,  6 Aug 2018 06:43:20 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 05/13] coresight: etm3: Add support for handling errors
Date:   Mon,  6 Aug 2018 14:41:47 +0100
Message-Id: <1533562915-21558-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reporting errors back from the SMP cross
function call for enabling ETM.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9ce8fba..771691c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -355,11 +355,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	return 0;
 }
 
-static void etm_enable_hw(void *info)
+static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
 	u32 etmcr;
-	struct etm_drvdata *drvdata = info;
 	struct etm_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
@@ -421,6 +420,21 @@ static void etm_enable_hw(void *info)
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	return 0;
+}
+
+struct etm_enable_arg {
+	struct etm_drvdata *drvdata;
+	int rc;
+}
+
+static void etm_enable_hw_smp_call(void *info)
+{
+	struct etm_enable_arg *arg = info;
+
+	if (WARN_ON(!arg))
+		return;
+	arg->rc = etm_enable_hw(arg->drvdata);
 }
 
 static int etm_cpu_id(struct coresight_device *csdev)
@@ -475,14 +489,13 @@ static int etm_enable_perf(struct coresight_device *csdev,
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
 	/* And enable it */
-	etm_enable_hw(drvdata);
-
-	return 0;
+	return etm_enable_hw(drvdata);
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etm_enable_arg arg = { 0 };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
@@ -492,20 +505,21 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	 * hw configuration will take place on the local CPU during bring up.
 	 */
 	if (cpu_online(drvdata->cpu)) {
+		arg.drvdata = drvdata;
 		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_hw, drvdata, 1);
-		if (ret)
-			goto err;
+					       etm_enable_hw_smp_call, &arg, 1);
+		if (!ret)
+			ret = arg.rc;
+		if (!ret)
+			drvdata->sticky_enable = true;
+	} else {
+		ret = -ENODEV;
 	}
 
-	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
-	return 0;
-
-err:
-	spin_unlock(&drvdata->spinlock);
+	if (!ret)
+		dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
-- 
2.7.4

