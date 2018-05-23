Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeEWJcB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:32:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45488 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932292AbeEWJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:54 -0400
X-Google-Smtp-Source: AB8JxZrnb8QQIceQay53vlRKP+i9D6TOODXdz2oXXpcFq14ZoICuqNS7gh0jDVN9KrCR16f0hMb90A==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vkoul@kernel.org
Cc: eric.long@spreadtrum.com, broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
Date: Wed, 23 May 2018 17:31:11 +0800
Message-Id: <ea34e18f29c37024fb0403c66176a60b3b253986.1527065569.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <08819489e52add194fecf2b4b234fff9deecdb4c.1527065569.git.baolin.wang@linaro.org>
References: <08819489e52add194fecf2b4b234fff9deecdb4c.1527065569.git.baolin.wang@linaro.org>
In-Reply-To: <08819489e52add194fecf2b4b234fff9deecdb4c.1527065569.git.baolin.wang@linaro.org>
References: <08819489e52add194fecf2b4b234fff9deecdb4c.1527065569.git.baolin.wang@linaro.org>
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
Changes since v3:
 - Remove the 'struct sprd_dma_config'.
 - Optimize the sprd_dma_fill_desc() function.
 - Error out for default operation when checking datawidth.
 - Add some comments to explain what we do.
 - Remove some current unused configuration.

Changes since v2:
 - Remove src/dst from struct sprd_dma_config.
 - Simplify sprd_dma_get_datawidth()/sprd_dma_get_step().
 - Change some logic to make code more readable.
 - Other optimization.

Changes since v1:
 - Fix the incorrect parameter type of sprd_dma_get_step().
---
 drivers/dma/sprd-dma.c       |  182 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma/sprd-dma.h |    4 +
 2 files changed, 186 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 924ada4..c3161c1 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -164,6 +164,7 @@ struct sprd_dma_desc {
 struct sprd_dma_chn {
 	struct virt_dma_chan	vc;
 	void __iomem		*chn_base;
+	struct dma_slave_config	slave_cfg;
 	u32			chn_num;
 	u32			dev_id;
 	struct sprd_dma_desc	*cur_desc;
@@ -552,6 +553,129 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 }
 
+static int sprd_dma_get_datawidth(enum dma_slave_buswidth buswidth)
+{
+	switch (buswidth) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return ffs(buswidth) - 1;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sprd_dma_get_step(enum dma_slave_buswidth buswidth)
+{
+	switch (buswidth) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return buswidth;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sprd_dma_fill_desc(struct dma_chan *chan,
+			      struct sprd_dma_desc *sdesc,
+			      dma_addr_t src, dma_addr_t dst, u32 len,
+			      enum dma_transfer_direction dir,
+			      unsigned long flags,
+			      struct dma_slave_config *slave_cfg)
+{
+	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
+	u32 req_mode = (flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
+	u32 int_mode = flags & SPRD_DMA_INT_MASK;
+	int src_datawidth, dst_datawidth, src_step, dst_step;
+	u32 temp, fix_mode = 0, fix_en = 0;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
+		if (src_step < 0) {
+			dev_err(sdev->dma_dev.dev, "invalid source step\n");
+			return src_step;
+		}
+		dst_step = SPRD_DMA_NONE_STEP;
+	} else {
+		dst_step = sprd_dma_get_step(slave_cfg->dst_addr_width);
+		if (dst_step < 0) {
+			dev_err(sdev->dma_dev.dev, "invalid destination step\n");
+			return dst_step;
+		}
+		src_step = SPRD_DMA_NONE_STEP;
+	}
+
+	src_datawidth = sprd_dma_get_datawidth(slave_cfg->src_addr_width);
+	if (src_datawidth < 0) {
+		dev_err(sdev->dma_dev.dev, "invalid source datawidth\n");
+		return src_datawidth;
+	}
+
+	dst_datawidth = sprd_dma_get_datawidth(slave_cfg->dst_addr_width);
+	if (dst_datawidth < 0) {
+		dev_err(sdev->dma_dev.dev, "invalid destination datawidth\n");
+		return dst_datawidth;
+	}
+
+	if (slave_cfg->slave_id)
+		schan->dev_id = slave_cfg->slave_id;
+
+	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
+
+	/*
+	 * wrap_ptr and wrap_to will save the high 4 bits source address and
+	 * destination address.
+	 */
+	hw->wrap_ptr = (src >> SPRD_DMA_HIGH_ADDR_OFFSET) & SPRD_DMA_HIGH_ADDR_MASK;
+	hw->wrap_to = (dst >> SPRD_DMA_HIGH_ADDR_OFFSET) & SPRD_DMA_HIGH_ADDR_MASK;
+	hw->src_addr = src & SPRD_DMA_LOW_ADDR_MASK;
+	hw->des_addr = dst & SPRD_DMA_LOW_ADDR_MASK;
+
+	/*
+	 * If the src step and dst step both are 0 or both are not 0, that means
+	 * we can not enable the fix mode. If one is 0 and another one is not,
+	 * we can enable the fix mode.
+	 */
+	if ((src_step != 0 && dst_step != 0) || (src_step | dst_step) == 0) {
+		fix_en = 0;
+	} else {
+		fix_en = 1;
+		if (src_step)
+			fix_mode = 1;
+		else
+			fix_mode = 0;
+	}
+
+	hw->intc = int_mode | SPRD_DMA_CFG_ERR_INT_EN;
+
+	temp = src_datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET;
+	temp |= dst_datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET;
+	temp |= req_mode << SPRD_DMA_REQ_MODE_OFFSET;
+	temp |= fix_mode << SPRD_DMA_FIX_SEL_OFFSET;
+	temp |= fix_en << SPRD_DMA_FIX_EN_OFFSET;
+	temp |= slave_cfg->src_maxburst & SPRD_DMA_FRG_LEN_MASK;
+	hw->frg_len = temp;
+
+	hw->blk_len = len & SPRD_DMA_BLK_LEN_MASK;
+	hw->trsc_len = len & SPRD_DMA_TRSC_LEN_MASK;
+
+	temp = (dst_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_DEST_TRSF_STEP_OFFSET;
+	temp |= (src_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_SRC_TRSF_STEP_OFFSET;
+	hw->trsf_step = temp;
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
@@ -607,6 +731,62 @@ static void sprd_dma_issue_pending(struct dma_chan *chan)
 	return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *
+sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		       unsigned int sglen, enum dma_transfer_direction dir,
+		       unsigned long flags, void *context)
+{
+	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct dma_slave_config *slave_cfg = &schan->slave_cfg;
+	dma_addr_t src = 0, dst = 0;
+	struct sprd_dma_desc *sdesc;
+	struct scatterlist *sg;
+	u32 len = 0;
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
+		len = sg_dma_len(sg);
+
+		if (dir == DMA_MEM_TO_DEV) {
+			src = sg_dma_address(sg);
+			dst = slave_cfg->dst_addr;
+		} else {
+			src = slave_cfg->src_addr;
+			dst = sg_dma_address(sg);
+		}
+	}
+
+	ret = sprd_dma_fill_desc(chan, sdesc, src, dst, len, dir, flags,
+				 slave_cfg);
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
+	struct dma_slave_config *slave_cfg = &schan->slave_cfg;
+
+	if (!is_slave_direction(config->direction))
+		return -EINVAL;
+
+	memcpy(slave_cfg, config, sizeof(*config));
+	return 0;
+}
+
 static int sprd_dma_pause(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
@@ -733,6 +913,8 @@ static int sprd_dma_probe(struct platform_device *pdev)
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
