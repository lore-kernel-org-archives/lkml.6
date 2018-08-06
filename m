Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F41DC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91F421A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91F421A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeHFPwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:34 -0400
Received: from foss.arm.com ([217.140.101.70]:38884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbeHFPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A90781688;
        Mon,  6 Aug 2018 06:43:23 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 782A03F2EA;
        Mon,  6 Aug 2018 06:43:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 06/13] coresight: etb10: Handle errors enabling the device
Date:   Mon,  6 Aug 2018 14:41:48 +0100
Message-Id: <1533562915-21558-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the etb10 driver to return errors in enabling
the device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 9fd77fd..37d2c88 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -107,7 +107,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 	return depth;
 }
 
-static void etb_enable_hw(struct etb_drvdata *drvdata)
+static void __etb_enable_hw(struct etb_drvdata *drvdata)
 {
 	int i;
 	u32 depth;
@@ -135,6 +135,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int etb_enable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_enable_hw(drvdata);
+	return 0;
+}
+
 static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
 	int ret = 0;
@@ -150,7 +156,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 	if (mode == CS_MODE_PERF) {
 		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	val = local_cmpxchg(&drvdata->mode,
@@ -172,12 +178,14 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 		goto out;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-out:
-	if (!ret)
+	if (ret)
+		local_cmpxchg(&drvdata->mode, mode, CS_MODE_DISABLED);
+	else
 		dev_dbg(drvdata->dev, "ETB enabled\n");
+
 	return ret;
 }
 
-- 
2.7.4

