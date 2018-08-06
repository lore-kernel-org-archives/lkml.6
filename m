Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D2EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B4E21A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B4E21A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHFPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbeHFPwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2337E168F;
        Mon,  6 Aug 2018 06:43:25 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6AB93F2EA;
        Mon,  6 Aug 2018 06:43:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 07/13] coresight: dynamic-replicator: Handle multiple connections
Date:   Mon,  6 Aug 2018 14:41:49 +0100
Message-Id: <1533562915-21558-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a replicator port is enabled, we block the traffic
on the other port and route all traffic to the new enabled
port. If there are two active trace sessions each targeting
the two different paths from the replicator, the second session
will disable the first session and route all the data to the
second path.
                    ETR
                 /
e.g, replicator
                 \
                    ETB

If CPU0 is operated in sysfs mode to ETR and CPU1 is operated
in perf mode to ETB, depending on the order in which the
replicator is enabled one device is blocked.

Ideally we need trace-id for the session to make the
right choice. That implies we need a trace-id allocation
logic for the coresight subsystem and use that to route
the traffic. The short term solution is to only manage
the "target port" and leave the other port untouched.
That leaves both the paths unaffected, except that some
unwanted traffic may be pushed to the paths (if the Trace-IDs
are not far enough), which is still fine and can be filtered
out while processing rather than silently blocking the data.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c       | 66 ++++++++++++++++------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index ebb8043..97f4673 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -34,26 +34,42 @@ struct replicator_state {
 	struct coresight_device	*csdev;
 };
 
+/*
+ * replicator_reset : Reset the replicator configuration to sane values.
+ */
+static void replicator_reset(struct replicator_state *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+
+	CS_LOCK(drvdata->base);
+}
+
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
+	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	CS_UNLOCK(drvdata->base);
-
-	/*
-	 * Ensure that the other port is disabled
-	 * 0x00 - passing through the replicator unimpeded
-	 * 0xff - disable (or impede) the flow of ATB data
-	 */
-	if (outport == 0) {
-		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER0);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
-	} else {
-		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER1);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
 	}
 
+	CS_UNLOCK(drvdata->base);
+
+
+	/* Ensure that the outport is enabled. */
+	writel_relaxed(0x00, drvdata->base + reg);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
@@ -63,15 +79,25 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 static void replicator_disable(struct coresight_device *csdev, int inport,
 				int outport)
 {
+	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
 	CS_UNLOCK(drvdata->base);
 
 	/* disable the flow of ATB data through port */
-	if (outport == 0)
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	else
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+	writel_relaxed(0xff, drvdata->base + reg);
 
 	CS_LOCK(drvdata->base);
 
@@ -156,7 +182,11 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	if (!IS_ERR(drvdata->csdev)) {
+		replicator_reset(drvdata);
+		return 0;
+	}
+	return PTR_ERR(drvdata->csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4

