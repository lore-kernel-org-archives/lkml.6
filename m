Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755008AbeENQVF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:21:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51227 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754988AbeENQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:21:01 -0400
X-Google-Smtp-Source: AB8JxZp9y9Z+GpuYMRBPgfy5XRzy6UlDKh0t7qqBXAM7Hr+8+mpVseKnOwMZXUgB2LKMntqfxGFclw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: agross@codeaurora.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dmaengine: qcom: bam_dma: check if the runtime pm enabled
Date: Mon, 14 May 2018 17:18:52 +0100
Message-Id: <20180514161852.9620-1-srinivas.kandagatla@linaro.org>
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
 drivers/dma/qcom/bam_dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d29275b97e84..5f4babebc508 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -540,7 +540,7 @@ static void bam_free_chan(struct dma_chan *chan)
 	int ret;
 
 	ret = pm_runtime_get_sync(bdev->dev);
-	if (ret < 0)
+	if (pm_runtime_enabled(bdev->dev) && ret < 0)
 		return;
 
 	vchan_free_chan_resources(to_virt_chan(chan));
@@ -721,7 +721,7 @@ static int bam_pause(struct dma_chan *chan)
 	int ret;
 
 	ret = pm_runtime_get_sync(bdev->dev);
-	if (ret < 0)
+	if (pm_runtime_enabled(bdev->dev) && ret < 0)
 		return ret;
 
 	spin_lock_irqsave(&bchan->vc.lock, flag);
@@ -747,7 +747,7 @@ static int bam_resume(struct dma_chan *chan)
 	int ret;
 
 	ret = pm_runtime_get_sync(bdev->dev);
-	if (ret < 0)
+	if (pm_runtime_enabled(bdev->dev) && ret < 0)
 		return ret;
 
 	spin_lock_irqsave(&bchan->vc.lock, flag);
@@ -853,7 +853,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 		tasklet_schedule(&bdev->task);
 
 	ret = pm_runtime_get_sync(bdev->dev);
-	if (ret < 0)
+	if (pm_runtime_enabled(bdev->dev) && ret < 0)
 		return ret;
 
 	if (srcs & BAM_IRQ) {
@@ -970,7 +970,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 		return;
 
 	ret = pm_runtime_get_sync(bdev->dev);
-	if (ret < 0)
+	if (pm_runtime_enabled(bdev->dev) && ret < 0)
 		return;
 
 	while (vd && !IS_BUSY(bchan)) {
-- 
2.16.2
