Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031661AbeBOM13 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:27:29 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34252 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031468AbeBOM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:27:22 -0500
X-Google-Smtp-Source: AH8x225pCmok8Wk/i6odGKK22UDKsmsscB/Jwu+N4+l7qzdsboZhurfFcPEcAeBt4iw/ghTNE0yD3Q==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/5] dmaengine: qcom: bam_dma: do not write to global regs in remote mode
Date: Thu, 15 Feb 2018 12:25:10 +0000
Message-Id: <20180215122511.13517-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
References: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

BAM_DESC_CNT_TRSHLD register is global register, which can only be written
when BAM is in master mode, So check the mode of operation before writing
it.

Without this check SOC's xPU would catch such access and crash the system.
First noticed on DB820c while testing SLIMBus BAM.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 139e9f5e47a9..6919f501b9f3 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -935,12 +935,15 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 	struct bam_device *bdev = bchan->bdev;
 	u32 maxburst;
 
-	if (dir == DMA_DEV_TO_MEM)
-		maxburst = bchan->slave.src_maxburst;
-	else
-		maxburst = bchan->slave.dst_maxburst;
+	if (!bdev->controlled_remotely) {
+		if (dir == DMA_DEV_TO_MEM)
+			maxburst = bchan->slave.src_maxburst;
+		else
+			maxburst = bchan->slave.dst_maxburst;
 
-	writel_relaxed(maxburst, bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+		writel_relaxed(maxburst,
+			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+	}
 
 	bchan->reconfigure = 0;
 }
-- 
2.15.1
