Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDSCB7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:01:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41715 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSCBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:01:44 -0400
X-Google-Smtp-Source: AIpwx48M8hgg14GgJwhqbVZfoPJXKshUhUsFAGUaSmLAR96U+5t85PgszK5M+N+3D3RdlWMyj4F/sQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH v2 5/5] dmaengine: sprd: Add 'device_config' and 'device_prep_slave_sg' interfaces
Date: Thu, 19 Apr 2018 10:00:50 +0800
Message-Id: <2efb90f1d86529a51e566824566016b9430f56ea.1524054807.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
In-Reply-To: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

This patch adds the 'device_config' and 'device_prep_slave_sg' interfaces
for users to configure DMA.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - The request mode and interrupt type will be passed from flags.
 - Add sprd_dma_get_step() to get src/dst step.
 - Add sprd_dma_get_datawidth() to convert data width values which
 can be used by Spreadtrum DMA.
---
 drivers/dma/sprd-dma.c       |  115 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma/sprd-dma.h |    4 ++
 2 files changed, 119 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 23846ed..f2598ed 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -590,6 +590,47 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 }
 
+static enum sprd_dma_datawidth
+sprd_dma_get_datawidth(enum dma_slave_buswidth buswidth)
+{
+	switch (buswidth) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return SPRD_DMA_DATAWIDTH_1_BYTE;
+
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return SPRD_DMA_DATAWIDTH_2_BYTES;
+
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return SPRD_DMA_DATAWIDTH_4_BYTES;
+
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return SPRD_DMA_DATAWIDTH_8_BYTES;
+
+	default:
+		return SPRD_DMA_DATAWIDTH_4_BYTES;
+	}
+}
+
+static u32 sprd_dma_get_step(enum sprd_dma_datawidth datawidth)
+{
+	switch (datawidth) {
+	case SPRD_DMA_DATAWIDTH_1_BYTE:
+		return SPRD_DMA_BYTE_STEP;
+
+	case SPRD_DMA_DATAWIDTH_2_BYTES:
+		return SPRD_DMA_SHORT_STEP;
+
+	case SPRD_DMA_DATAWIDTH_4_BYTES:
+		return SPRD_DMA_WORD_STEP;
+
+	case SPRD_DMA_DATAWIDTH_8_BYTES:
+		return SPRD_DMA_DWORD_STEP;
+
+	default:
+		return SPRD_DMA_DWORD_STEP;
+	}
+}
+
 static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 			   struct sprd_dma_config *slave_cfg)
 {
@@ -711,6 +752,78 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
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
+	if (!is_slave_direction(dir) || sglen > 1)
+		return NULL;
+
+	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
+	if (!sdesc)
+		return NULL;
+
+	for_each_sg(sgl, sg, sglen, i) {
+		if (dir == DMA_MEM_TO_DEV) {
+			slave_cfg->src_addr = sg_dma_address(sg);
+			slave_cfg->src_step =
+				sprd_dma_get_step(slave_cfg->src_datawidth);
+			slave_cfg->dst_step = SPRD_DMA_NONE_STEP;
+		} else {
+			slave_cfg->dst_addr = sg_dma_address(sg);
+			slave_cfg->src_step = SPRD_DMA_NONE_STEP;
+			slave_cfg->dst_step =
+				sprd_dma_get_step(slave_cfg->dst_datawidth);
+		}
+
+		slave_cfg->block_len = sg_dma_len(sg);
+		slave_cfg->transcation_len = sg_dma_len(sg);
+	}
+
+	slave_cfg->req_mode =
+		(flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
+	slave_cfg->int_mode = flags & SPRD_DMA_INT_MASK;
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
+	struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
+
+	if (!is_slave_direction(config->direction))
+		return -EINVAL;
+
+	memset(slave_cfg, 0, sizeof(*slave_cfg));
+
+	slave_cfg->slave_id = config->slave_id;
+	slave_cfg->src_addr = config->src_addr;
+	slave_cfg->dst_addr = config->dst_addr;
+	slave_cfg->fragment_len = config->src_maxburst;
+	slave_cfg->src_datawidth =
+		sprd_dma_get_datawidth(config->src_addr_width);
+	slave_cfg->dst_datawidth =
+		sprd_dma_get_datawidth(config->dst_addr_width);
+
+	return 0;
+}
+
 static int sprd_dma_pause(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
@@ -838,6 +951,8 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	sdev->dma_dev.device_tx_status = sprd_dma_tx_status;
 	sdev->dma_dev.device_issue_pending = sprd_dma_issue_pending;
 	sdev->dma_dev.device_prep_dma_memcpy = sprd_dma_prep_dma_memcpy;
+	sdev->dma_dev.device_prep_slave_sg = sprd_dma_prep_slave_sg;
+	sdev->dma_dev.device_config = sprd_dma_slave_config;
 	sdev->dma_dev.device_pause = sprd_dma_pause;
 	sdev->dma_dev.device_resume = sprd_dma_resume;
 	sdev->dma_dev.device_terminate_all = sprd_dma_terminate_all;
diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
index c545162..b0115e3 100644
--- a/include/linux/dma/sprd-dma.h
+++ b/include/linux/dma/sprd-dma.h
@@ -3,6 +3,10 @@
 #ifndef _SPRD_DMA_H_
 #define _SPRD_DMA_H_
 
+#define SPRD_DMA_REQ_SHIFT 16
+#define SPRD_DMA_FLAGS(req_mode, int_type) \
+	((req_mode) << SPRD_DMA_REQ_SHIFT | (int_type))
+
 /*
  * enum sprd_dma_req_mode: define the DMA request mode
  * @SPRD_DMA_FRAG_REQ: fragment request mode
-- 
1.7.9.5
