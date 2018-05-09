Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756209AbeEILMN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:12:13 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33792 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEILML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:12:11 -0400
X-Google-Smtp-Source: AB8JxZpIsHznUueG5PhCMSKMu5L1zIqkXNNpGVIGxAGhMg0O05a+o3xhSh0YAMbJFcsIDcxL923Ybg==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org, lars@metafoo.de,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: sprd: Optimize the sprd_dma_prep_dma_memcpy()
Date: Wed,  9 May 2018 19:11:59 +0800
Message-Id: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

This is one preparation patch, we can use default DMA configuration to
implement the device_prep_dma_memcpy() interface instead of issuing
sprd_dma_config().

We will implement one new sprd_dma_config() function with introducing
device_prep_slave_sg() interface in following patch. So we can remove
the obsolete sprd_dma_config() firstly.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - No updates.
---
 drivers/dma/sprd-dma.c |  154 ++++++++++--------------------------------------
 1 file changed, 32 insertions(+), 122 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e715d07..e07e253 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -552,147 +552,57 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 }
 
-static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
-			   dma_addr_t dest, dma_addr_t src, size_t len)
+static struct dma_async_tx_descriptor *
+sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+			 size_t len, unsigned long flags)
 {
-	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
-	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
-	u32 datawidth, src_step, des_step, fragment_len;
-	u32 block_len, req_mode, irq_mode, transcation_len;
-	u32 fix_mode = 0, fix_en = 0;
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_desc *sdesc;
+	struct sprd_dma_chn_hw *hw;
+	enum sprd_dma_datawidth datawidth;
+	u32 step;
 
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
+	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
+	if (!sdesc)
+		return NULL;
 
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
+	hw = &sdesc->chn_hw;
 
 	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
+	hw->intc = SPRD_DMA_TRANS_INT | SPRD_DMA_CFG_ERR_INT_EN;
+	hw->src_addr = (u32)(src & SPRD_DMA_LOW_ADDR_MASK);
+	hw->des_addr = (u32)(dest & SPRD_DMA_LOW_ADDR_MASK);
 	hw->wrap_ptr = (u32)((src >> SPRD_DMA_HIGH_ADDR_OFFSET) &
 			     SPRD_DMA_HIGH_ADDR_MASK);
 	hw->wrap_to = (u32)((dest >> SPRD_DMA_HIGH_ADDR_OFFSET) &
 			    SPRD_DMA_HIGH_ADDR_MASK);
 
-	hw->src_addr = (u32)(src & SPRD_DMA_LOW_ADDR_MASK);
-	hw->des_addr = (u32)(dest & SPRD_DMA_LOW_ADDR_MASK);
-
-	if ((src_step != 0 && des_step != 0) || (src_step | des_step) == 0) {
-		fix_en = 0;
+	if (IS_ALIGNED(len, 8)) {
+		datawidth = SPRD_DMA_DATAWIDTH_8_BYTES;
+		step = SPRD_DMA_DWORD_STEP;
+	} else if (IS_ALIGNED(len, 4)) {
+		datawidth = SPRD_DMA_DATAWIDTH_4_BYTES;
+		step = SPRD_DMA_WORD_STEP;
+	} else if (IS_ALIGNED(len, 2)) {
+		datawidth = SPRD_DMA_DATAWIDTH_2_BYTES;
+		step = SPRD_DMA_SHORT_STEP;
 	} else {
-		fix_en = 1;
-		if (src_step)
-			fix_mode = 1;
-		else
-			fix_mode = 0;
+		datawidth = SPRD_DMA_DATAWIDTH_1_BYTE;
+		step = SPRD_DMA_BYTE_STEP;
 	}
 
 	hw->frg_len = datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
 		datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
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
+		SPRD_DMA_TRANS_REQ << SPRD_DMA_REQ_MODE_OFFSET |
+		(len & SPRD_DMA_FRG_LEN_MASK);
+	hw->blk_len = len & SPRD_DMA_BLK_LEN_MASK;
+	hw->trsc_len = len & SPRD_DMA_TRSC_LEN_MASK;
 
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
-
-	case SPRD_DMA_TRANS_BLK_INT:
-		hw->intc |= SPRD_DMA_TRANS_INT_EN | SPRD_DMA_BLK_INT_EN;
-		break;
-
-	case SPRD_DMA_LIST_INT:
-		hw->intc |= SPRD_DMA_LIST_INT_EN;
-		break;
-
-	case SPRD_DMA_CFGERR_INT:
-		hw->intc |= SPRD_DMA_CFG_ERR_INT_EN;
-		break;
-
-	default:
-		dev_err(sdev->dma_dev.dev, "invalid irq mode\n");
-		return -EINVAL;
-	}
-
-	if (transcation_len == 0)
-		hw->trsc_len = block_len & SPRD_DMA_TRSC_LEN_MASK;
-	else
-		hw->trsc_len = transcation_len & SPRD_DMA_TRSC_LEN_MASK;
-
-	hw->trsf_step = (des_step & SPRD_DMA_TRSF_STEP_MASK) <<
+	hw->trsf_step = (step & SPRD_DMA_TRSF_STEP_MASK) <<
 			SPRD_DMA_DEST_TRSF_STEP_OFFSET |
-			(src_step & SPRD_DMA_TRSF_STEP_MASK) <<
+			(step & SPRD_DMA_TRSF_STEP_MASK) <<
 			SPRD_DMA_SRC_TRSF_STEP_OFFSET;
 
-	hw->frg_step = 0;
-	hw->src_blk_step = 0;
-	hw->des_blk_step = 0;
-	hw->src_blk_step = 0;
-	return 0;
-}
-
-static struct dma_async_tx_descriptor *
-sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
-			 size_t len, unsigned long flags)
-{
-	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
-	struct sprd_dma_desc *sdesc;
-	int ret;
-
-	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
-	if (!sdesc)
-		return NULL;
-
-	ret = sprd_dma_config(chan, sdesc, dest, src, len);
-	if (ret) {
-		kfree(sdesc);
-		return NULL;
-	}
-
 	return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
 }
 
-- 
1.7.9.5
