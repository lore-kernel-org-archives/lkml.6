Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968060AbeBOM2i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:28:38 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45225 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031251AbeBOM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:27:18 -0500
X-Google-Smtp-Source: AH8x226roAy6lQ+dY0h1pMVbS8BEgDU8tilXMyQ8lPnufK52YeuxseCA7qJ9bAarhV02qhV/e+vI5A==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/5] dmaengine: qcom: bam_dma: make bam clk optional
Date: Thu, 15 Feb 2018 12:25:07 +0000
Message-Id: <20180215122511.13517-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
References: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

When BAM is remotely controlled it does not sound correct to control
its clk on Linux side. Make it optional, so that its not mandatory
for remote controlled BAM instances.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d076940e0c69..b79691fcc82d 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1233,8 +1233,12 @@ static int bam_dma_probe(struct platform_device *pdev)
 						"qcom,controlled-remotely");
 
 	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
-	if (IS_ERR(bdev->bamclk))
-		return PTR_ERR(bdev->bamclk);
+	if (IS_ERR(bdev->bamclk)) {
+		if (!bdev->controlled_remotely)
+			return PTR_ERR(bdev->bamclk);
+
+		bdev->bamclk = NULL;
+	}
 
 	ret = clk_prepare_enable(bdev->bamclk);
 	if (ret) {
-- 
2.15.1
