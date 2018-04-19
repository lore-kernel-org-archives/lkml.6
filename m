Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeDSCBp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:01:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45910 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeDSCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:01:42 -0400
X-Google-Smtp-Source: AIpwx4/phvlMprLAhxLYyYx+WTld7xYsJ3VQmxlG4BJKTMjVdAAQfJwOpFYomfPsYfKb8TaIaitLNA==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH v2 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Date: Thu, 19 Apr 2018 10:00:49 +0800
Message-Id: <30ff22774f045db654d5e784716c3ee69e00775d.1524054807.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
In-Reply-To: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

This patch adds one 'struct sprd_dma_config' structure to save Spreadtrum
DMA configuration for each DMA channel. Meanwhile we also did some optimization
for sprd_dma_config() and sprd_dma_prep_dma_memcpy() to prepare to configure
DMA from users.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Remove 'struct sprd_dma_config' structure in 'sprd_dma.h'.
 - Add 'struct sprd_dma_config' for DMA channel.
 - Remove sprd_dma_get_datawidth() and sprd_dma_get_step().
 - Other optimization.
---
 drivers/dma/sprd-dma.c |  205 ++++++++++++++++++++++++++----------------------
 1 file changed, 110 insertions(+), 95 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index ccdeb8f..23846ed 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -100,6 +100,8 @@
 #define SPRD_DMA_DES_DATAWIDTH_OFFSET	28
 #define SPRD_DMA_SWT_MODE_OFFSET	26
 #define SPRD_DMA_REQ_MODE_OFFSET	24
+#define SPRD_DMA_WRAP_SEL_OFFSET	23
+#define SPRD_DMA_WRAP_EN_OFFSET		22
 #define SPRD_DMA_REQ_MODE_MASK		GENMASK(1, 0)
 #define SPRD_DMA_FIX_SEL_OFFSET		21
 #define SPRD_DMA_FIX_EN_OFFSET		20
@@ -154,6 +156,41 @@ struct sprd_dma_chn_hw {
 	u32 des_blk_step;
 };
 
+/*
+ * struct sprd_dma_config - DMA configuration structure
+ * @src_addr: the physical address where DMA slave data should be read
+ * @dst_addr: the physical address where DMA slave data should be written
+ * @fragment_len: specify one fragment transfer length
+ * @block_len: specify one block transfer length
+ * @transcation_len: specify one transcation transfer length
+ * @src_step: source transfer step
+ * @dst_step: destination transfer step
+ * @src_datawidth: source transfer data width
+ * @dst_datawidth: destination transfer data width
+ * @wrap_ptr: wrap pointer address, once the transfer address reaches the
+ * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
+ * @wrap_to: wrap jump to address
+ * @req_mode: specify the DMA request mode
+ * @int_mode: specify the DMA interrupt type
+ * @slave_id: slave channel requester id
+ */
+struct sprd_dma_config {
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	u32 fragment_len;
+	u32 block_len;
+	u32 transcation_len;
+	u32 src_step;
+	u32 dst_step;
+	enum sprd_dma_datawidth src_datawidth;
+	enum sprd_dma_datawidth dst_datawidth;
+	phys_addr_t wrap_ptr;
+	phys_addr_t wrap_to;
+	enum sprd_dma_req_mode req_mode;
+	enum sprd_dma_int_type int_mode;
+	u32 slave_id;
+};
+
 /* dma request description */
 struct sprd_dma_desc {
 	struct virt_dma_desc	vd;
@@ -164,6 +201,7 @@ struct sprd_dma_desc {
 struct sprd_dma_chn {
 	struct virt_dma_chan	vc;
 	void __iomem		*chn_base;
+	struct sprd_dma_config	slave_cfg;
 	u32			chn_num;
 	u32			dev_id;
 	struct sprd_dma_desc	*cur_desc;
@@ -553,125 +591,74 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
 }
 
 static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
-			   dma_addr_t dest, dma_addr_t src, size_t len)
+			   struct sprd_dma_config *slave_cfg)
 {
 	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
-	u32 datawidth, src_step, des_step, fragment_len;
-	u32 block_len, req_mode, irq_mode, transcation_len;
-	u32 fix_mode = 0, fix_en = 0;
-
-	if (IS_ALIGNED(len, 4)) {
-		datawidth = SPRD_DMA_DATAWIDTH_4_BYTES;
-		src_step = SPRD_DMA_WORD_STEP;
-		des_step = SPRD_DMA_WORD_STEP;
-	} else if (IS_ALIGNED(len, 2)) {
-		datawidth = SPRD_DMA_DATAWIDTH_2_BYTES;
-		src_step = SPRD_DMA_SHORT_STEP;
-		des_step = SPRD_DMA_SHORT_STEP;
-	} else {
-		datawidth = SPRD_DMA_DATAWIDTH_1_BYTE;
-		src_step = SPRD_DMA_BYTE_STEP;
-		des_step = SPRD_DMA_BYTE_STEP;
-	}
+	u32 fix_mode = 0, fix_en = 0, wrap_en = 0, wrap_mode = 0;
 
-	fragment_len = SPRD_DMA_MEMCPY_MIN_SIZE;
-	if (len <= SPRD_DMA_BLK_LEN_MASK) {
-		block_len = len;
-		transcation_len = 0;
-		req_mode = SPRD_DMA_BLK_REQ;
-		irq_mode = SPRD_DMA_BLK_INT;
-	} else {
-		block_len = SPRD_DMA_MEMCPY_MIN_SIZE;
-		transcation_len = len;
-		req_mode = SPRD_DMA_TRANS_REQ;
-		irq_mode = SPRD_DMA_TRANS_INT;
-	}
+	if (slave_cfg->slave_id)
+		schan->dev_id = slave_cfg->slave_id;
 
 	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
-	hw->wrap_ptr = (u32)((src >> SPRD_DMA_HIGH_ADDR_OFFSET) &
-			     SPRD_DMA_HIGH_ADDR_MASK);
-	hw->wrap_to = (u32)((dest >> SPRD_DMA_HIGH_ADDR_OFFSET) &
-			    SPRD_DMA_HIGH_ADDR_MASK);
-
-	hw->src_addr = (u32)(src & SPRD_DMA_LOW_ADDR_MASK);
-	hw->des_addr = (u32)(dest & SPRD_DMA_LOW_ADDR_MASK);
-
-	if ((src_step != 0 && des_step != 0) || (src_step | des_step) == 0) {
+	hw->wrap_ptr = (u32)((slave_cfg->wrap_ptr & SPRD_DMA_LOW_ADDR_MASK) |
+		((slave_cfg->src_addr >> SPRD_DMA_HIGH_ADDR_OFFSET) &
+		 SPRD_DMA_HIGH_ADDR_MASK));
+	hw->wrap_to = (u32)((slave_cfg->wrap_to & SPRD_DMA_LOW_ADDR_MASK) |
+		((slave_cfg->dst_addr >> SPRD_DMA_HIGH_ADDR_OFFSET) &
+		 SPRD_DMA_HIGH_ADDR_MASK));
+
+	hw->src_addr = (u32)(slave_cfg->src_addr & SPRD_DMA_LOW_ADDR_MASK);
+	hw->des_addr = (u32)(slave_cfg->dst_addr & SPRD_DMA_LOW_ADDR_MASK);
+
+	if ((slave_cfg->src_step != 0 && slave_cfg->dst_step != 0)
+	    || (slave_cfg->src_step | slave_cfg->dst_step) == 0) {
 		fix_en = 0;
 	} else {
 		fix_en = 1;
-		if (src_step)
+		if (slave_cfg->src_step)
 			fix_mode = 1;
 		else
 			fix_mode = 0;
 	}
 
-	hw->frg_len = datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
-		datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
-		req_mode << SPRD_DMA_REQ_MODE_OFFSET |
-		fix_mode << SPRD_DMA_FIX_SEL_OFFSET |
-		fix_en << SPRD_DMA_FIX_EN_OFFSET |
-		(fragment_len & SPRD_DMA_FRG_LEN_MASK);
-	hw->blk_len = block_len & SPRD_DMA_BLK_LEN_MASK;
-
-	hw->intc = SPRD_DMA_CFG_ERR_INT_EN;
-
-	switch (irq_mode) {
-	case SPRD_DMA_NO_INT:
-		break;
-
-	case SPRD_DMA_FRAG_INT:
-		hw->intc |= SPRD_DMA_FRAG_INT_EN;
-		break;
-
-	case SPRD_DMA_BLK_INT:
-		hw->intc |= SPRD_DMA_BLK_INT_EN;
-		break;
-
-	case SPRD_DMA_BLK_FRAG_INT:
-		hw->intc |= SPRD_DMA_BLK_INT_EN | SPRD_DMA_FRAG_INT_EN;
-		break;
-
-	case SPRD_DMA_TRANS_INT:
-		hw->intc |= SPRD_DMA_TRANS_INT_EN;
-		break;
-
-	case SPRD_DMA_TRANS_FRAG_INT:
-		hw->intc |= SPRD_DMA_TRANS_INT_EN | SPRD_DMA_FRAG_INT_EN;
-		break;
+	if (slave_cfg->wrap_ptr && slave_cfg->wrap_to) {
+		wrap_en = 1;
+		if (slave_cfg->wrap_to == slave_cfg->src_addr) {
+			wrap_mode = 0;
+		} else if (slave_cfg->wrap_to == slave_cfg->dst_addr) {
+			wrap_mode = 1;
+		} else {
+			dev_err(sdev->dma_dev.dev, "invalid wrap mode\n");
+			return -EINVAL;
+		}
+	}
 
-	case SPRD_DMA_TRANS_BLK_INT:
-		hw->intc |= SPRD_DMA_TRANS_INT_EN | SPRD_DMA_BLK_INT_EN;
-		break;
+	hw->intc = slave_cfg->int_mode | SPRD_DMA_CFG_ERR_INT_EN;
 
-	case SPRD_DMA_LIST_INT:
-		hw->intc |= SPRD_DMA_LIST_INT_EN;
-		break;
+	hw->frg_len =
+		slave_cfg->src_datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
+		slave_cfg->dst_datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
+		slave_cfg->req_mode << SPRD_DMA_REQ_MODE_OFFSET |
+		wrap_mode << SPRD_DMA_WRAP_SEL_OFFSET |
+		wrap_en << SPRD_DMA_WRAP_EN_OFFSET |
+		fix_mode << SPRD_DMA_FIX_SEL_OFFSET |
+		fix_en << SPRD_DMA_FIX_EN_OFFSET |
+		(slave_cfg->fragment_len & SPRD_DMA_FRG_LEN_MASK);
 
-	case SPRD_DMA_CFGERR_INT:
-		hw->intc |= SPRD_DMA_CFG_ERR_INT_EN;
-		break;
+	hw->blk_len = slave_cfg->block_len & SPRD_DMA_BLK_LEN_MASK;
 
-	default:
-		dev_err(sdev->dma_dev.dev, "invalid irq mode\n");
-		return -EINVAL;
-	}
+	hw->trsc_len = slave_cfg->transcation_len & SPRD_DMA_TRSC_LEN_MASK;
 
-	if (transcation_len == 0)
-		hw->trsc_len = block_len & SPRD_DMA_TRSC_LEN_MASK;
-	else
-		hw->trsc_len = transcation_len & SPRD_DMA_TRSC_LEN_MASK;
-
-	hw->trsf_step = (des_step & SPRD_DMA_TRSF_STEP_MASK) <<
+	hw->trsf_step = (slave_cfg->dst_step & SPRD_DMA_TRSF_STEP_MASK) <<
 			SPRD_DMA_DEST_TRSF_STEP_OFFSET |
-			(src_step & SPRD_DMA_TRSF_STEP_MASK) <<
+			(slave_cfg->src_step & SPRD_DMA_TRSF_STEP_MASK) <<
 			SPRD_DMA_SRC_TRSF_STEP_OFFSET;
 
 	hw->frg_step = 0;
 	hw->src_blk_step = 0;
 	hw->des_blk_step = 0;
-	hw->src_blk_step = 0;
 	return 0;
 }
 
@@ -680,6 +667,7 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 			 size_t len, unsigned long flags)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
 	struct sprd_dma_desc *sdesc;
 	int ret;
 
@@ -687,7 +675,34 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 	if (!sdesc)
 		return NULL;
 
-	ret = sprd_dma_config(chan, sdesc, dest, src, len);
+	memset(slave_cfg, 0, sizeof(*slave_cfg));
+
+	slave_cfg->src_addr = src;
+	slave_cfg->dst_addr = dest;
+	slave_cfg->fragment_len = len;
+	slave_cfg->block_len = len;
+	slave_cfg->transcation_len = len;
+	slave_cfg->req_mode = SPRD_DMA_TRANS_REQ;
+	slave_cfg->int_mode = SPRD_DMA_TRANS_INT;
+
+	if (IS_ALIGNED(len, 4)) {
+		slave_cfg->src_datawidth = SPRD_DMA_DATAWIDTH_4_BYTES;
+		slave_cfg->dst_datawidth = SPRD_DMA_DATAWIDTH_4_BYTES;
+		slave_cfg->src_step = SPRD_DMA_WORD_STEP;
+		slave_cfg->dst_step = SPRD_DMA_WORD_STEP;
+	} else if (IS_ALIGNED(len, 2)) {
+		slave_cfg->src_datawidth = SPRD_DMA_DATAWIDTH_2_BYTES;
+		slave_cfg->dst_datawidth = SPRD_DMA_DATAWIDTH_2_BYTES;
+		slave_cfg->src_step = SPRD_DMA_SHORT_STEP;
+		slave_cfg->dst_step = SPRD_DMA_SHORT_STEP;
+	} else {
+		slave_cfg->src_datawidth = SPRD_DMA_DATAWIDTH_1_BYTE;
+		slave_cfg->dst_datawidth = SPRD_DMA_DATAWIDTH_1_BYTE;
+		slave_cfg->src_step = SPRD_DMA_BYTE_STEP;
+		slave_cfg->dst_step = SPRD_DMA_BYTE_STEP;
+	}
+
+	ret = sprd_dma_config(chan, sdesc, slave_cfg);
 	if (ret) {
 		kfree(sdesc);
 		return NULL;
-- 
1.7.9.5
