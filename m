Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030610AbeBNOsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:48:18 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37497 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031073AbeBNOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:47:12 -0500
X-Google-Smtp-Source: AH8x226D1Hxssn1nc90uSkDZlyzB7RRMB2Z/YtmXEF6ZC8vCk/xI7XD02orODuVk+fkTLqiBCbpUbA==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] dmaengine: qcom: bam_dma: get num-channels and num-ees from dt
Date: Wed, 14 Feb 2018 14:44:57 +0000
Message-Id: <20180214144459.29813-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
References: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

When Linux is master of BAM, it can directly read registers to know number
of supported channels, however when its remotely controlled reading these
registers would trigger a crash if the BAM is not yet initialized or
powered up on the remote side.

This patch allows driver to read num-channels and num-ees from Device Tree
for remotely controlled BAM.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index ae4c7b6930b8..146b5d03256f 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -393,6 +393,7 @@ struct bam_device {
 	struct device_dma_parameters dma_parms;
 	struct bam_chan *channels;
 	u32 num_channels;
+	u32 num_ees;
 
 	/* execution environment ID, from DT */
 	u32 ee;
@@ -1128,15 +1129,19 @@ static int bam_init(struct bam_device *bdev)
 	u32 val;
 
 	/* read revision and configuration information */
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION)) >> NUM_EES_SHIFT;
-	val &= NUM_EES_MASK;
+	if (!bdev->num_ees) {
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
+		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
+	}
 
 	/* check that configured EE is within range */
-	if (bdev->ee >= val)
+	if (bdev->ee >= bdev->num_ees)
 		return -EINVAL;
 
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_NUM_PIPES));
-	bdev->num_channels = val & BAM_NUM_PIPES_MASK;
+	if (!bdev->num_channels) {
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_NUM_PIPES));
+		bdev->num_channels = val & BAM_NUM_PIPES_MASK;
+	}
 
 	if (bdev->controlled_remotely)
 		return 0;
@@ -1232,6 +1237,18 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
 						"qcom,controlled-remotely");
 
+	if (bdev->controlled_remotely) {
+		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
+					   &bdev->num_channels);
+		if (ret)
+			dev_err(bdev->dev, "num-channels unspecified in dt\n");
+
+		ret = of_property_read_u32(pdev->dev.of_node, "qcom,num-ees",
+					   &bdev->num_ees);
+		if (ret)
+			dev_err(bdev->dev, "num-ees unspecified in dt\n");
+	}
+
 	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
 	if (IS_ERR(bdev->bamclk)) {
 		bdev->bamclk = NULL;
-- 
2.15.1
