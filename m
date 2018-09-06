Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8E2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089D32077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089D32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIFNne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:34 -0400
Received: from foss.arm.com ([217.140.101.70]:41224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbeIFNnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA471684;
        Thu,  6 Sep 2018 02:09:04 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7815F3F575;
        Thu,  6 Sep 2018 02:09:03 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 13/14] coresight: dynamic-replicator: Claim device for use
Date:   Thu,  6 Sep 2018 10:08:34 +0100
Message-Id: <1536224915-31766-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CLAIM protocol to make sure the device is available for use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c       | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 97f4673..299667b 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -41,8 +41,11 @@ static void replicator_reset(struct replicator_state *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+	if (!coresight_claim_device_unlocked(drvdata->base)) {
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+		coresight_disclaim_device_unlocked(drvdata->base);
+	}
 
 	CS_LOCK(drvdata->base);
 }
@@ -50,6 +53,7 @@ static void replicator_reset(struct replicator_state *drvdata)
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
+	int rc = 0;
 	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -67,13 +71,19 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_UNLOCK(drvdata->base);
 
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		rc = coresight_claim_device_unlocked(drvdata->base);
 
 	/* Ensure that the outport is enabled. */
-	writel_relaxed(0x00, drvdata->base + reg);
+	if (!rc) {
+		writel_relaxed(0x00, drvdata->base + reg);
+		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	}
+
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	return 0;
+	return rc;
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
@@ -99,6 +109,9 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 	/* disable the flow of ATB data through port */
 	writel_relaxed(0xff, drvdata->base + reg);
 
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
-- 
2.7.4

