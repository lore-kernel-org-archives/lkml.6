Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbeDJHqt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:46:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36269 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeDJHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:46:45 -0400
X-Google-Smtp-Source: AIpwx485sFkzNhAoSX6CJFPCAxNWnohvO4kXImm7/6UK/vTw6qFIgM1V2EDV8cwNMAQDkG0SEnEu9g==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Date: Tue, 10 Apr 2018 15:46:06 +0800
Message-Id: <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some Spreadtrum special configuration for DMA controller,
thus this patch adds one 'struct sprd_dma_config' structure for users
to configure.

Moreover this patch did some optimization for sprd_dma_config() and
sprd_dma_prep_dma_memcpy() to prepare to configure DMA from users.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c       |  262 ++++++++++++++++++++++++++++++++++--------
 include/linux/dma/sprd-dma.h |   25 ++++
 2 files changed, 238 insertions(+), 49 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 5c26fde..f8038de 100644
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
@@ -173,6 +175,7 @@ struct sprd_dma_desc {
 struct sprd_dma_chn {
 	struct virt_dma_chan	vc;
 	void __iomem		*chn_base;
+	struct sprd_dma_config	slave_cfg;
 	u32			chn_num;
 	u32			dev_id;
 	struct sprd_dma_desc	*cur_desc;
@@ -561,52 +564,162 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
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
+static int sprd_dma_get_step(enum dma_slave_buswidth buswidth,
+			     enum dma_transfer_direction dir,
+			     enum sprd_dma_step *src_step,
+			     enum sprd_dma_step *dst_step)
+{
+	switch (dir) {
+	case DMA_MEM_TO_MEM:
+		switch (buswidth) {
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+			*src_step = SPRD_DMA_BYTE_STEP;
+			*dst_step = SPRD_DMA_BYTE_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+			*src_step = SPRD_DMA_SHORT_STEP;
+			*dst_step = SPRD_DMA_SHORT_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+			*src_step = SPRD_DMA_WORD_STEP;
+			*dst_step = SPRD_DMA_WORD_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_8_BYTES:
+			*src_step = SPRD_DMA_DWORD_STEP;
+			*dst_step = SPRD_DMA_DWORD_STEP;
+			break;
+
+		default:
+			*src_step = SPRD_DMA_WORD_STEP;
+			*dst_step = SPRD_DMA_WORD_STEP;
+			break;
+		}
+		break;
+
+	case DMA_MEM_TO_DEV:
+		switch (buswidth) {
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+			*src_step = SPRD_DMA_BYTE_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+			*src_step = SPRD_DMA_SHORT_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+			*src_step = SPRD_DMA_WORD_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_8_BYTES:
+			*src_step = SPRD_DMA_DWORD_STEP;
+			break;
+
+		default:
+			*src_step = SPRD_DMA_WORD_STEP;
+			break;
+		}
+
+		*dst_step = SPRD_DMA_NONE_STEP;
+		break;
+
+	case DMA_DEV_TO_MEM:
+		switch (buswidth) {
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+			*dst_step = SPRD_DMA_BYTE_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+			*dst_step = SPRD_DMA_SHORT_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+			*dst_step = SPRD_DMA_WORD_STEP;
+			break;
+
+		case DMA_SLAVE_BUSWIDTH_8_BYTES:
+			*dst_step = SPRD_DMA_DWORD_STEP;
+			break;
+
+		default:
+			*dst_step = SPRD_DMA_WORD_STEP;
+			break;
+		}
+
+		*src_step = SPRD_DMA_NONE_STEP;
+		break;
+
+	case DMA_DEV_TO_DEV:
+		*src_step = SPRD_DMA_NONE_STEP;
+		*dst_step = SPRD_DMA_NONE_STEP;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
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
+	u32 fix_mode = 0, fix_en = 0, wrap_en = 0, wrap_mode = 0;
+	enum sprd_dma_step src_step, dst_step;
+	enum sprd_dma_datawidth src_datawidth, dst_datawidth;
+	int ret;
 
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
+	ret = sprd_dma_get_step(slave_cfg->config.src_addr_width,
+				slave_cfg->config.direction,
+				&src_step, &dst_step);
+	if (ret) {
+		dev_err(sdev->dma_dev.dev, "invalid step values\n");
+		return ret;
 	}
 
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
+	if (slave_cfg->config.slave_id)
+		schan->dev_id = slave_cfg->config.slave_id;
 
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
+		((slave_cfg->config.src_addr >> SPRD_DMA_HIGH_ADDR_OFFSET) &
+		 SPRD_DMA_HIGH_ADDR_MASK));
+	hw->wrap_to = (u32)((slave_cfg->wrap_to & SPRD_DMA_LOW_ADDR_MASK) |
+		((slave_cfg->config.dst_addr >> SPRD_DMA_HIGH_ADDR_OFFSET) &
+		 SPRD_DMA_HIGH_ADDR_MASK));
+
+	hw->src_addr =
+		(u32)(slave_cfg->config.src_addr & SPRD_DMA_LOW_ADDR_MASK);
+	hw->des_addr =
+		(u32)(slave_cfg->config.dst_addr & SPRD_DMA_LOW_ADDR_MASK);
+
+	if ((src_step != 0 && dst_step != 0) || (src_step | dst_step) == 0) {
 		fix_en = 0;
 	} else {
 		fix_en = 1;
@@ -616,17 +729,37 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 			fix_mode = 0;
 	}
 
-	hw->frg_len = datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
-		datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
-		req_mode << SPRD_DMA_REQ_MODE_OFFSET |
+	if (slave_cfg->wrap_ptr && slave_cfg->wrap_to) {
+		wrap_en = 1;
+		if (slave_cfg->wrap_to == slave_cfg->config.src_addr) {
+			wrap_mode = 0;
+		} else if (slave_cfg->wrap_to == slave_cfg->config.dst_addr) {
+			wrap_mode = 1;
+		} else {
+			dev_err(sdev->dma_dev.dev, "invalid wrap mode\n");
+			return -EINVAL;
+		}
+	}
+
+	src_datawidth =
+		sprd_dma_get_datawidth(slave_cfg->config.src_addr_width);
+	dst_datawidth =
+		sprd_dma_get_datawidth(slave_cfg->config.dst_addr_width);
+
+	hw->frg_len = src_datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
+		dst_datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
+		slave_cfg->req_mode << SPRD_DMA_REQ_MODE_OFFSET |
+		wrap_mode << SPRD_DMA_WRAP_SEL_OFFSET |
+		wrap_en << SPRD_DMA_WRAP_EN_OFFSET |
 		fix_mode << SPRD_DMA_FIX_SEL_OFFSET |
 		fix_en << SPRD_DMA_FIX_EN_OFFSET |
-		(fragment_len & SPRD_DMA_FRG_LEN_MASK);
-	hw->blk_len = block_len & SPRD_DMA_BLK_LEN_MASK;
+		(slave_cfg->fragment_len & SPRD_DMA_FRG_LEN_MASK);
+
+	hw->blk_len = slave_cfg->block_len & SPRD_DMA_BLK_LEN_MASK;
 
 	hw->intc = SPRD_DMA_CFG_ERR_INT_EN;
 
-	switch (irq_mode) {
+	switch (slave_cfg->int_mode) {
 	case SPRD_DMA_NO_INT:
 		break;
 
@@ -667,12 +800,13 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 		return -EINVAL;
 	}
 
-	if (transcation_len == 0)
-		hw->trsc_len = block_len & SPRD_DMA_TRSC_LEN_MASK;
+	if (slave_cfg->transcation_len == 0)
+		hw->trsc_len = slave_cfg->block_len & SPRD_DMA_TRSC_LEN_MASK;
 	else
-		hw->trsc_len = transcation_len & SPRD_DMA_TRSC_LEN_MASK;
+		hw->trsc_len =
+			slave_cfg->transcation_len & SPRD_DMA_TRSC_LEN_MASK;
 
-	hw->trsf_step = (des_step & SPRD_DMA_TRSF_STEP_MASK) <<
+	hw->trsf_step = (dst_step & SPRD_DMA_TRSF_STEP_MASK) <<
 			SPRD_DMA_DEST_TRSF_STEP_OFFSET |
 			(src_step & SPRD_DMA_TRSF_STEP_MASK) <<
 			SPRD_DMA_SRC_TRSF_STEP_OFFSET;
@@ -680,7 +814,6 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 	hw->frg_step = 0;
 	hw->src_blk_step = 0;
 	hw->des_blk_step = 0;
-	hw->src_blk_step = 0;
 	return 0;
 }
 
@@ -689,6 +822,7 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 			 size_t len, unsigned long flags)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
 	struct sprd_dma_desc *sdesc;
 	int ret;
 
@@ -696,7 +830,37 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 	if (!sdesc)
 		return NULL;
 
-	ret = sprd_dma_config(chan, sdesc, dest, src, len);
+	memset(slave_cfg, 0, sizeof(*slave_cfg));
+
+	slave_cfg->config.src_addr = src;
+	slave_cfg->config.dst_addr = dest;
+	slave_cfg->config.direction = DMA_MEM_TO_MEM;
+
+	if (IS_ALIGNED(len, 4)) {
+		slave_cfg->config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		slave_cfg->config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else if (IS_ALIGNED(len, 2)) {
+		slave_cfg->config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_cfg->config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	} else {
+		slave_cfg->config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_cfg->config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
+
+	slave_cfg->fragment_len = SPRD_DMA_MEMCPY_MIN_SIZE;
+	if (len <= SPRD_DMA_BLK_LEN_MASK) {
+		slave_cfg->block_len = len;
+		slave_cfg->transcation_len = 0;
+		slave_cfg->req_mode = SPRD_DMA_BLK_REQ;
+		slave_cfg->int_mode = SPRD_DMA_BLK_INT;
+	} else {
+		slave_cfg->block_len = SPRD_DMA_MEMCPY_MIN_SIZE;
+		slave_cfg->transcation_len = len;
+		slave_cfg->req_mode = SPRD_DMA_TRANS_REQ;
+		slave_cfg->int_mode = SPRD_DMA_TRANS_INT;
+	}
+
+	ret = sprd_dma_config(chan, sdesc, slave_cfg);
 	if (ret) {
 		kfree(sdesc);
 		return NULL;
diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
index c545162..8bda7d7 100644
--- a/include/linux/dma/sprd-dma.h
+++ b/include/linux/dma/sprd-dma.h
@@ -3,6 +3,8 @@
 #ifndef _SPRD_DMA_H_
 #define _SPRD_DMA_H_
 
+#include <linux/dmaengine.h>
+
 /*
  * enum sprd_dma_req_mode: define the DMA request mode
  * @SPRD_DMA_FRAG_REQ: fragment request mode
@@ -54,4 +56,27 @@ enum sprd_dma_int_type {
 	SPRD_DMA_CFGERR_INT,
 };
 
+/*
+ * struct sprd_dma_config - DMA configuration structure
+ * @config: dma slave channel config
+ * @fragment_len: specify one fragment transfer length
+ * @block_len: specify one block transfer length
+ * @transcation_len: specify one transcation transfer length
+ * @wrap_ptr: wrap pointer address, once the transfer address reaches the
+ * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
+ * @wrap_to: wrap jump to address
+ * @req_mode: specify the DMA request mode
+ * @int_mode: specify the DMA interrupt type
+ */
+struct sprd_dma_config {
+	struct dma_slave_config config;
+	u32 fragment_len;
+	u32 block_len;
+	u32 transcation_len;
+	phys_addr_t wrap_ptr;
+	phys_addr_t wrap_to;
+	enum sprd_dma_req_mode req_mode;
+	enum sprd_dma_int_type int_mode;
+};
+
 #endif
-- 
1.7.9.5
