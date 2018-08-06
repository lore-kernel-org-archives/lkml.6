Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD027C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAD92083C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAD92083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeHFPwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:45 -0400
Received: from foss.arm.com ([217.140.101.70]:38938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732526AbeHFPwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6405915AB;
        Mon,  6 Aug 2018 06:43:32 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 335253F2EA;
        Mon,  6 Aug 2018 06:43:31 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 12/13] coresight: dynamic-replicator: Claim device for use
Date:   Mon,  6 Aug 2018 14:41:54 +0100
Message-Id: <1533562915-21558-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
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

