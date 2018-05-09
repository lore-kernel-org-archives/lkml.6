Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeEILMU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:12:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40275 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933863AbeEILMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:12:15 -0400
X-Google-Smtp-Source: AB8JxZrFQuKdDsnWskj70eciVAfuDr8xl17CFWZebtMe74Vsp7fjwJ1/dujVxX8qE4PBhkxkR/vOaA==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org, lars@metafoo.de,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
Date: Wed,  9 May 2018 19:12:00 +0800
Message-Id: <67447aabb8e4e051ff39b814a0e169e6a91bb66e.1525863923.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
References: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
In-Reply-To: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
References: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

This patch adds the 'device_config' and 'device_prep_slave_sg' interfaces
for users to configure DMA, as well as adding one 'struct sprd_dma_config'
structure to save Spreadtrum DMA configuration for each DMA channel.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Fix the incorrect parameter type of sprd_dma_get_step().
---
 drivers/dma/sprd-dma.c       |  215 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma/sprd-dma.h |    4 +
 2 files changed, 219 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e07e253..26b4e01 100644
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
@@ -154,6 +156,35 @@ struct sprd_dma_chn_hw {
 	u32 des_blk_step;
 };
 
+/*
+ * struct sprd_dma_config - DMA configuration structure
+ * @cfg: dma slave channel runtime config
+ * @src_addr: the source physical address
+ * @dst_addr: the destination physical address
+ * @block_len: specify one block transfer length
+ * @transcation_len: specify one transcation transfer length
+ * @src_step: source transfer step
+ * @dst_step: destination transfer step
+ * @wrap_ptr: wrap pointer address, once the transfer address reaches the
+ * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
+ * @wrap_to: wrap jump to address
+ * @req_mode: specify the DMA request mode
+ * @int_mode: specify the DMA interrupt type
+ */
+struct sprd_dma_config {
+	struct dma_slave_config cfg;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	u32 block_len;
+	u32 transcation_len;
+	u32 src_step;
+	u32 dst_step;
+	phys_addr_t wrap_ptr;
+	phys_addr_t wrap_to;
+	enum sprd_dma_req_mode req_mode;
+	enum sprd_dma_int_type int_mode;
+};
+
 /* dma request description */
 struct sprd_dma_desc {
 	struct virt_dma_desc	vd;
@@ -164,6 +195,7 @@ struct sprd_dma_desc {
 struct sprd_dma_chn {
 	struct virt_dma_chan	vc;
 	void __iomem		*chn_base;
+	struct sprd_dma_config	slave_cfg;
 	u32			chn_num;
 	u32			dev_id;
 	struct sprd_dma_desc	*cur_desc;
@@ -552,6 +584,121 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
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
+static u32 sprd_dma_get_step(enum dma_slave_buswidth buswidth)
+{
+	switch (buswidth) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return SPRD_DMA_BYTE_STEP;
+
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return SPRD_DMA_SHORT_STEP;
+
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return SPRD_DMA_WORD_STEP;
+
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return SPRD_DMA_DWORD_STEP;
+
+	default:
+		return SPRD_DMA_DWORD_STEP;
+	}
+}
+
+static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
+			   struct sprd_dma_config *slave_cfg)
+{
+	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
+	u32 fix_mode = 0, fix_en = 0, wrap_en = 0, wrap_mode = 0;
+	u32 src_datawidth, dst_datawidth;
+
+	if (slave_cfg->cfg.slave_id)
+		schan->dev_id = slave_cfg->cfg.slave_id;
+
+	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
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
+		fix_en = 0;
+	} else {
+		fix_en = 1;
+		if (slave_cfg->src_step)
+			fix_mode = 1;
+		else
+			fix_mode = 0;
+	}
+
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
+
+	hw->intc = slave_cfg->int_mode | SPRD_DMA_CFG_ERR_INT_EN;
+
+	src_datawidth = sprd_dma_get_datawidth(slave_cfg->cfg.src_addr_width);
+	dst_datawidth = sprd_dma_get_datawidth(slave_cfg->cfg.dst_addr_width);
+	hw->frg_len = src_datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
+		dst_datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
+		slave_cfg->req_mode << SPRD_DMA_REQ_MODE_OFFSET |
+		wrap_mode << SPRD_DMA_WRAP_SEL_OFFSET |
+		wrap_en << SPRD_DMA_WRAP_EN_OFFSET |
+		fix_mode << SPRD_DMA_FIX_SEL_OFFSET |
+		fix_en << SPRD_DMA_FIX_EN_OFFSET |
+		(slave_cfg->cfg.src_maxburst & SPRD_DMA_FRG_LEN_MASK);
+
+	hw->blk_len = slave_cfg->block_len & SPRD_DMA_BLK_LEN_MASK;
+
+	hw->trsc_len = slave_cfg->transcation_len & SPRD_DMA_TRSC_LEN_MASK;
+
+	hw->trsf_step = (slave_cfg->dst_step & SPRD_DMA_TRSF_STEP_MASK) <<
+			SPRD_DMA_DEST_TRSF_STEP_OFFSET |
+			(slave_cfg->src_step & SPRD_DMA_TRSF_STEP_MASK) <<
+			SPRD_DMA_SRC_TRSF_STEP_OFFSET;
+
+	hw->frg_step = 0;
+	hw->src_blk_step = 0;
+	hw->des_blk_step = 0;
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *
 sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 			 size_t len, unsigned long flags)
@@ -606,6 +753,72 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
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
+			slave_cfg->dst_addr = slave_cfg->cfg.dst_addr;
+			slave_cfg->src_step =
+			sprd_dma_get_step(slave_cfg->cfg.src_addr_width);
+			slave_cfg->dst_step = SPRD_DMA_NONE_STEP;
+		} else {
+			slave_cfg->src_addr = slave_cfg->cfg.src_addr;
+			slave_cfg->dst_addr = sg_dma_address(sg);
+			slave_cfg->src_step = SPRD_DMA_NONE_STEP;
+			slave_cfg->dst_step =
+			sprd_dma_get_step(slave_cfg->cfg.dst_addr_width);
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
+	memcpy(&slave_cfg->cfg, config, sizeof(*config));
+
+	return 0;
+}
+
 static int sprd_dma_pause(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
@@ -732,6 +945,8 @@ static int sprd_dma_probe(struct platform_device *pdev)
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
