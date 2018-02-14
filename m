Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031092AbeBNOrO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:47:14 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53719 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031055AbeBNOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:47:09 -0500
X-Google-Smtp-Source: AH8x2278vkuHELH1cVHUSxPz4bN1RzS1Jb3JeRHjnCNH4UIIgZYXTisvwgmRgp5TnDG6xommqLpi3Q==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] dmaengine: qcom: bam_dma: make bam clk optional
Date: Wed, 14 Feb 2018 14:44:55 +0000
Message-Id: <20180214144459.29813-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
References: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

When BAM is remotely controlled it does not sound correct to control
its clk on Linux side. Make it optional, so that its not mandatory
for remote controlled BAM instances.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d076940e0c69..ae4c7b6930b8 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1233,13 +1233,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 						"qcom,controlled-remotely");
 
 	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
-	if (IS_ERR(bdev->bamclk))
-		return PTR_ERR(bdev->bamclk);
-
-	ret = clk_prepare_enable(bdev->bamclk);
-	if (ret) {
-		dev_err(bdev->dev, "failed to prepare/enable clock\n");
-		return ret;
+	if (IS_ERR(bdev->bamclk)) {
+		bdev->bamclk = NULL;
+	} else {
+		ret = clk_prepare_enable(bdev->bamclk);
+		if (ret) {
+			dev_err(bdev->dev, "failed to prepare/enable clock\n");
+			return ret;
+		}
 	}
 
 	ret = bam_init(bdev);
-- 
2.15.1
