Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031817AbeBOM1p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:27:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56193 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031505AbeBOM1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:27:23 -0500
X-Google-Smtp-Source: AH8x227kmJUpX7YYdMCdB0RaVEGEyVUO6P4GRuBeRuU2q7j36MJnJ5hWTXVhhPaSgRebhsLqa2NoPQ==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 5/5] dmaengine: qcom: bam_dma: disable runtime pm on remote controlled
Date: Thu, 15 Feb 2018 12:25:11 +0000
Message-Id: <20180215122511.13517-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
References: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Remotely controlled BAM instance should not do any power management from
CPU side, as cpu can not reliably say if the BAM is busy or not.

Disable it for such instances.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 6919f501b9f3..d29275b97e84 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1333,6 +1333,11 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_dma;
 
+	if (bdev->controlled_remotely) {
+		pm_runtime_disable(&pdev->dev);
+		return 0;
+	}
+
 	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, BAM_DMA_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1416,7 +1421,8 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
 {
 	struct bam_device *bdev = dev_get_drvdata(dev);
 
-	pm_runtime_force_suspend(dev);
+	if (!bdev->controlled_remotely)
+		pm_runtime_force_suspend(dev);
 
 	clk_unprepare(bdev->bamclk);
 
@@ -1432,7 +1438,8 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	pm_runtime_force_resume(dev);
+	if (!bdev->controlled_remotely)
+		pm_runtime_force_resume(dev);
 
 	return 0;
 }
-- 
2.15.1
