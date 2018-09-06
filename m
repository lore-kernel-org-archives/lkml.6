Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBB32077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBB32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeIFNnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41152 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbeIFNnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC7B169E;
        Thu,  6 Sep 2018 02:08:53 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 497BA3F575;
        Thu,  6 Sep 2018 02:08:52 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 06/14] coresight: etm3: Add support for handling errors
Date:   Thu,  6 Sep 2018 10:08:27 +0100
Message-Id: <1536224915-31766-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reporting errors back from the SMP cross
function call for enabling ETM.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Fix build break, missing ;. (Mathieu Poirier)
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9ce8fba..206c238 100644
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
+};
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

