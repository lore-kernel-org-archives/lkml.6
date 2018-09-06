Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C9D20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C9D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeIFNnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbeIFNnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BE0A1B4B;
        Thu,  6 Sep 2018 02:08:55 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB7FD3F575;
        Thu,  6 Sep 2018 02:08:53 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 07/14] coresight: etb10: Handle errors enabling the device
Date:   Thu,  6 Sep 2018 10:08:28 +0100
Message-Id: <1536224915-31766-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the etb10 driver to return errors in enabling
the device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Rebased to the coresight/next
---
 drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 08fa660..824be0c 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -106,7 +106,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 	return depth;
 }
 
-static void etb_enable_hw(struct etb_drvdata *drvdata)
+static void __etb_enable_hw(struct etb_drvdata *drvdata)
 {
 	int i;
 	u32 depth;
@@ -134,6 +134,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int etb_enable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_enable_hw(drvdata);
+	return 0;
+}
+
 static int etb_enable_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
@@ -152,8 +158,9 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	if (drvdata->mode == CS_MODE_SYSFS)
 		goto out;
 
-	drvdata->mode = CS_MODE_SYSFS;
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -183,8 +190,9 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	if (ret)
 		goto out;
 
-	drvdata->mode = CS_MODE_PERF;
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_PERF;
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.7.4

