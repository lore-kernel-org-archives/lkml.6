Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDJHrE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:47:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37613 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeDJHqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:46:47 -0400
X-Google-Smtp-Source: AIpwx48PWxDZyyORE8HoE+oQeAfTp/rFEkNju894M5Dl657NqNLzbKmpw3H3IoziHZ0Il9Lm3q+xVw==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 5/5] dmaengine: sprd: Add 'device_config' and 'device_prep_slave_sg' interfaces
Date: Tue, 10 Apr 2018 15:46:07 +0800
Message-Id: <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the 'device_config' and 'device_prep_slave_sg' interfaces
for users to configure DMA.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index f8038de..c923fb0 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -869,6 +869,52 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 	return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *
+sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		       unsigned int sglen, enum dma_transfer_direction dir,
+		       unsigned long flags, void *context)
+{
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
+	struct sprd_dma_desc *sdesc;
+	struct scatterlist *sg;
+	int ret, i;
+
+	/* TODO: now we only support one sg for each DMA configuration. */
+	if (!is_slave_direction(slave_cfg->config.direction) || sglen > 1)
+		return NULL;
+
+	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
+	if (!sdesc)
+		return NULL;
+
+	for_each_sg(sgl, sg, sglen, i) {
+		if (slave_cfg->config.direction == DMA_MEM_TO_DEV)
+			slave_cfg->config.src_addr = sg_dma_address(sg);
+		else
+			slave_cfg->config.dst_addr = sg_dma_address(sg);
+	}
+
+	ret = sprd_dma_config(chan, sdesc, slave_cfg);
+	if (ret) {
+		kfree(sdesc);
+		return NULL;
+	}
+
+	return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
+}
+
+static int sprd_dma_slave_config(struct dma_chan *chan,
+				 struct dma_slave_config *config)
+{
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_config *slave_cfg =
+		container_of(config, struct sprd_dma_config, config);
+
+	memcpy(&schan->slave_cfg, slave_cfg, sizeof(*slave_cfg));
+	return 0;
+}
+
 static int sprd_dma_pause(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
@@ -996,6 +1042,8 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	sdev->dma_dev.device_tx_status = sprd_dma_tx_status;
 	sdev->dma_dev.device_issue_pending = sprd_dma_issue_pending;
 	sdev->dma_dev.device_prep_dma_memcpy = sprd_dma_prep_dma_memcpy;
+	sdev->dma_dev.device_prep_slave_sg = sprd_dma_prep_slave_sg;
+	sdev->dma_dev.device_config = sprd_dma_slave_config;
 	sdev->dma_dev.device_pause = sprd_dma_pause;
 	sdev->dma_dev.device_resume = sprd_dma_resume;
 	sdev->dma_dev.device_terminate_all = sprd_dma_terminate_all;
-- 
1.7.9.5
