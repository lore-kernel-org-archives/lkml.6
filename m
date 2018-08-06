Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83715C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4704621A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4704621A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeHFPwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:31 -0400
Received: from foss.arm.com ([217.140.101.70]:38872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbeHFPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF69C15BF;
        Mon,  6 Aug 2018 06:43:20 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E7B23F2EA;
        Mon,  6 Aug 2018 06:43:19 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 04/13] coresight: etm4x: Add support for handling errors
Date:   Mon,  6 Aug 2018 14:41:46 +0100
Message-Id: <1533562915-21558-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for handling errors in enabling the component.
The ETM is enabled via cross call to owner CPU. Make
necessary changes to report the error back from the cross
call.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index c1dcc7c..4f9e6bb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -77,10 +77,14 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
-static void etm4_enable_hw(void *info)
+struct etm4_enable_arg {
+	struct etmv4_drvdata *drvdata;
+	int rc;
+};
+
+static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i;
-	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
@@ -177,6 +181,16 @@ static void etm4_enable_hw(void *info)
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	return 0;
+}
+
+static void etm4_enable_hw_smp_call(void *info)
+{
+	struct etm4_enable_arg *arg = info;
+
+	if (WARN_ON(!arg))
+		return;
+	arg->rc = etm4_enable_hw(arg->drvdata);
 }
 
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
@@ -242,7 +256,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	if (ret)
 		goto out;
 	/* And enable it */
-	etm4_enable_hw(drvdata);
+	ret = etm4_enable_hw(drvdata);
 
 out:
 	return ret;
@@ -251,6 +265,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etm4_enable_arg arg = { 0 };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
@@ -259,19 +274,17 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
+	arg.drvdata = drvdata;
 	ret = smp_call_function_single(drvdata->cpu,
-				       etm4_enable_hw, drvdata, 1);
-	if (ret)
-		goto err;
-
-	drvdata->sticky_enable = true;
+				       etm4_enable_hw_smp_call, &arg, 1);
+	if (!ret)
+		ret = arg.rc;
+	if (!ret)
+		drvdata->sticky_enable = true;
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

