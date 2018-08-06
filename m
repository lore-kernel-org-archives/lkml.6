Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F0C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56921A3B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA56921A3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeHFPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbeHFPwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ADF415B2;
        Mon,  6 Aug 2018 06:43:29 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 499FE3F2EA;
        Mon,  6 Aug 2018 06:43:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 10/13] coresight: funnel: Claim devices before use
Date:   Mon,  6 Aug 2018 14:41:52 +0100
Message-Id: <1533562915-21558-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CLAIM protocol to grab the ownership of the component.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ee7a30b..9279251 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -25,6 +25,7 @@
 #define FUNNEL_HOLDTIME_MASK	0xf00
 #define FUNNEL_HOLDTIME_SHFT	0x8
 #define FUNNEL_HOLDTIME		(0x7 << FUNNEL_HOLDTIME_SHFT)
+#define FUNNEL_ENSx_MASK	0xff
 
 /**
  * struct funnel_drvdata - specifics associated to a funnel component
@@ -42,31 +43,42 @@ struct funnel_drvdata {
 	unsigned long		priority;
 };
 
-static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
+static int funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 {
 	u32 functl;
+	int rc = 0;
 
 	CS_UNLOCK(drvdata->base);
 
 	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
+	/* Claim the device only when we enable the first slave */
+	if (!(functl & FUNNEL_ENSx_MASK)) {
+		rc = coresight_claim_device_unlocked(drvdata->base);
+		if (rc)
+			goto done;
+	}
+
 	functl &= ~FUNNEL_HOLDTIME_MASK;
 	functl |= FUNNEL_HOLDTIME;
 	functl |= (1 << port);
 	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
 	writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);
-
+done:
 	CS_LOCK(drvdata->base);
+	return rc;
 }
 
 static int funnel_enable(struct coresight_device *csdev, int inport,
 			 int outport)
 {
+	int rc;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	funnel_enable_hw(drvdata, inport);
+	rc = funnel_enable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
-	return 0;
+	if (!rc)
+		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	return rc;
 }
 
 static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
@@ -79,6 +91,10 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
 	functl &= ~(1 << inport);
 	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
 
+	/* Disclaim the device if none of the slaves are now active */
+	if (!(functl & FUNNEL_ENSx_MASK))
+		coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 }
 
-- 
2.7.4

