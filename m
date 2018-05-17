Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEQJot (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:44:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35440 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeEQJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:44:47 -0400
X-Google-Smtp-Source: AB8JxZpoM4A/HolRK4s+J9uGBOOU4Bxh8F6Nz1gPrA+lfZ/km8JdXg/D1ddluD89xGoE+yaDRwz4yg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: agross@codeaurora.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] dmaengine: qcom: bam_dma: check if the runtime pm enabled
Date: Thu, 17 May 2018 10:42:32 +0100
Message-Id: <20180517094232.27924-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling pm runtime at probe is not sufficient to get BAM working
on remotely controller instances. pm_runtime_get_sync() would return
-EACCES in such cases.
So check if runtime pm is enabled before returning error from bam functions.

Fixes: 5b4a68952a89 ("dmaengine: qcom: bam_dma: disable runtime pm on remote controlled")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d29275b97e84..4a828c18099a 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -524,6 +524,14 @@ static int bam_alloc_chan(struct dma_chan *chan)
 	return 0;
 }
 
+static int bam_pm_runtime_get_sync(struct device *dev)
+{
+	if (pm_runtime_enabled(dev))
+		return pm_runtime_get_sync(dev);
+
+	return 0;
+}
+
 /**
  * bam_free_chan - Frees dma resources associated with specific channel
  * @chan: specified channel
@@ -539,7 +547,7 @@ static void bam_free_chan(struct dma_chan *chan)
 	unsigned long flags;
 	int ret;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return;
 
@@ -720,7 +728,7 @@ static int bam_pause(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -746,7 +754,7 @@ static int bam_resume(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -852,7 +860,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 	if (srcs & P_IRQ)
 		tasklet_schedule(&bdev->task);
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -969,7 +977,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 	if (!vd)
 		return;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return;
 
-- 
2.16.2
