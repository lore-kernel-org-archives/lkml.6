Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeEKNG3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:06:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35006 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeEKNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:06:27 -0400
X-Google-Smtp-Source: AB8JxZqQGfrG0XPJhx5/alnzZ7bbJLottmwwtCZAQK7rMk9zEld9mOSzMhPjUfR7kcntNR6aPXNyTQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vkoul@kernel.org
Cc: eric.long@spreadtrum.com, broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dmaengine: sprd: Optimize the sprd_dma_prep_dma_memcpy()
Date: Fri, 11 May 2018 21:06:04 +0800
Message-Id: <08819489e52add194fecf2b4b234fff9deecdb4c.1526043689.git.baolin.wang@linaro.org>
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
Changes since v2:
 - Change logic to make code more readable.

Changes since v1:
 - No updates.
---
 drivers/dma/sprd-dma.c |  167 +++++++++++-------------------------------------
 1 file changed, 39 insertions(+), 128 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e715d07..924ada4 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -552,147 +552,58 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 }
 
-static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
-			   dma_addr_t dest, dma_addr_t src, size_t len)
-{
-	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
-	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
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
-
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
-
-	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
-	hw->wrap_ptr = (u32)((src >> SPRD_DMA_HIGH_ADDR_OFFSET) &
-			     SPRD_DMA_HIGH_ADDR_MASK);
-	hw->wrap_to = (u32)((dest >> SPRD_DMA_HIGH_ADDR_OFFSET) &
-			    SPRD_DMA_HIGH_ADDR_MASK);
-
-	hw->src_addr = (u32)(src & SPRD_DMA_LOW_ADDR_MASK);
-	hw->des_addr = (u32)(dest & SPRD_DMA_LOW_ADDR_MASK);
-
-	if ((src_step != 0 && des_step != 0) || (src_step | des_step) == 0) {
-		fix_en = 0;
-	} else {
-		fix_en = 1;
-		if (src_step)
-			fix_mode = 1;
-		else
-			fix_mode = 0;
-	}
-
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
-			SPRD_DMA_DEST_TRSF_STEP_OFFSET |
-			(src_step & SPRD_DMA_TRSF_STEP_MASK) <<
-			SPRD_DMA_SRC_TRSF_STEP_OFFSET;
-
-	hw->frg_step = 0;
-	hw->src_blk_step = 0;
-	hw->des_blk_step = 0;
-	hw->src_blk_step = 0;
-	return 0;
-}
-
 static struct dma_async_tx_descriptor *
 sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 			 size_t len, unsigned long flags)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct sprd_dma_desc *sdesc;
-	int ret;
+	struct sprd_dma_chn_hw *hw;
+	enum sprd_dma_datawidth datawidth;
+	u32 step, temp;
 
 	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
 	if (!sdesc)
 		return NULL;
 
-	ret = sprd_dma_config(chan, sdesc, dest, src, len);
-	if (ret) {
-		kfree(sdesc);
-		return NULL;
+	hw = &sdesc->chn_hw;
+
+	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
+	hw->intc = SPRD_DMA_TRANS_INT | SPRD_DMA_CFG_ERR_INT_EN;
+	hw->src_addr = src & SPRD_DMA_LOW_ADDR_MASK;
+	hw->des_addr = dest & SPRD_DMA_LOW_ADDR_MASK;
+	hw->wrap_ptr = (src >> SPRD_DMA_HIGH_ADDR_OFFSET) &
+		SPRD_DMA_HIGH_ADDR_MASK;
+	hw->wrap_to = (dest >> SPRD_DMA_HIGH_ADDR_OFFSET) &
+		SPRD_DMA_HIGH_ADDR_MASK;
+
+	if (IS_ALIGNED(len, 8)) {
+		datawidth = SPRD_DMA_DATAWIDTH_8_BYTES;
+		step = SPRD_DMA_DWORD_STEP;
+	} else if (IS_ALIGNED(len, 4)) {
+		datawidth = SPRD_DMA_DATAWIDTH_4_BYTES;
+		step = SPRD_DMA_WORD_STEP;
+	} else if (IS_ALIGNED(len, 2)) {
+		datawidth = SPRD_DMA_DATAWIDTH_2_BYTES;
+		step = SPRD_DMA_SHORT_STEP;
+	} else {
+		datawidth = SPRD_DMA_DATAWIDTH_1_BYTE;
+		step = SPRD_DMA_BYTE_STEP;
 	}
 
+	temp = datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET;
+	temp |= datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET;
+	temp |= SPRD_DMA_TRANS_REQ << SPRD_DMA_REQ_MODE_OFFSET;
+	temp |= len & SPRD_DMA_FRG_LEN_MASK;
+	hw->frg_len = temp;
+
+	hw->blk_len = len & SPRD_DMA_BLK_LEN_MASK;
+	hw->trsc_len = len & SPRD_DMA_TRSC_LEN_MASK;
+
+	temp = (step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_DEST_TRSF_STEP_OFFSET;
+	temp |= (step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_SRC_TRSF_STEP_OFFSET;
+	hw->trsf_step = temp;
+
 	return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
 }
 
-- 
1.7.9.5
