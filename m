Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeBTMbE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:31:04 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57792 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeBTMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:30:57 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: dmaengine@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] dmaengine: Introduce DW AXI DMAC driver
Date: Tue, 20 Feb 2018 15:30:46 +0300
Message-Id: <20180220123047.24469-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180220123047.24469-1-Eugeniy.Paltsev@synopsys.com>
References: <20180220123047.24469-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the DW AXI DMAC controller.
DW AXI DMAC is a part of HSDK development board from Synopsys.

In this driver implementation only DMA_MEMCPY transfers are
supported.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 MAINTAINERS                                |    6 +
 drivers/dma/Kconfig                        |   10 +
 drivers/dma/Makefile                       |    1 +
 drivers/dma/dw-axi-dmac/Makefile           |    1 +
 drivers/dma/dw-axi-dmac/axi_dma_platform.c | 1010 ++++++++++++++++++++++++++++
 drivers/dma/dw-axi-dmac/axi_dma_platform.h |  342 ++++++++++
 6 files changed, 1370 insertions(+)
 create mode 100644 drivers/dma/dw-axi-dmac/Makefile
 create mode 100644 drivers/dma/dw-axi-dmac/axi_dma_platform.c
 create mode 100644 drivers/dma/dw-axi-dmac/axi_dma_platform.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..0cfb241 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13344,6 +13344,12 @@ F:	include/linux/dma/dw.h
 F:	include/linux/platform_data/dma-dw.h
 F:	drivers/dma/dw/
 
+SYNOPSYS DESIGNWARE AXI DMAC DRIVER
+M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+S:	Maintained
+F:	drivers/dma/dwi-axi-dmac/
+F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
+
 SYNOPSYS DESIGNWARE ENTERPRISE ETHERNET DRIVER
 M:	Jose Abreu <Jose.Abreu@synopsys.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 27df3e2..c36272a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -187,6 +187,16 @@ config DMA_SUN6I
 	help
 	  Support for the DMA engine first found in Allwinner A31 SoCs.
 
+config DW_AXI_DMAC
+	tristate "Synopsys DesignWare AXI DMA support"
+	depends on OF || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for Synopsys DesignWare AXI DMA controller.
+	  NOTE: This driver wasn't tested on 64 bit platform because
+	  of lack 64 bit platform with Synopsys DW AXI DMAC.
+
 config EP93XX_DMA
 	bool "Cirrus Logic EP93xx DMA support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index b9dca8a..c242a5e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_DMA_OMAP) += omap-dma.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
 obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
 obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
+obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
diff --git a/drivers/dma/dw-axi-dmac/Makefile b/drivers/dma/dw-axi-dmac/Makefile
new file mode 100644
index 0000000..4ba81ec
--- /dev/null
+++ b/drivers/dma/dw-axi-dmac/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DW_AXI_DMAC) += axi_dma_platform.o
diff --git a/drivers/dma/dw-axi-dmac/axi_dma_platform.c b/drivers/dma/dw-axi-dmac/axi_dma_platform.c
new file mode 100644
index 0000000..dbb25b9
--- /dev/null
+++ b/drivers/dma/dw-axi-dmac/axi_dma_platform.c
@@ -0,0 +1,1010 @@
+/*
+ * Synopsys DesignWare AXI DMA Controller driver.
+ *
+ * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
+ * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+#include "axi_dma_platform.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+#define DRV_NAME	"axi_dw_dmac"
+
+/*
+ * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
+ * master data bus width up to 512 bits (for both AXI master interfaces), but
+ * it depends on IP block configurarion.
+ */
+#define AXI_DMA_BUSWIDTHS		  \
+	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
+	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
+	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
+	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
+	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
+	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
+	DMA_SLAVE_BUSWIDTH_64_BYTES)
+
+static inline void
+axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
+{
+	iowrite32(val, chip->regs + reg);
+}
+
+static inline u32 axi_dma_ioread32(struct axi_dma_chip *chip, u32 reg)
+{
+	return ioread32(chip->regs + reg);
+}
+
+static inline void
+axi_chan_iowrite32(struct axi_dma_chan *chan, u32 reg, u32 val)
+{
+	iowrite32(val, chan->chan_regs + reg);
+}
+
+static inline u32 axi_chan_ioread32(struct axi_dma_chan *chan, u32 reg)
+{
+	return ioread32(chan->chan_regs + reg);
+}
+
+static inline void
+axi_chan_iowrite64(struct axi_dma_chan *chan, u32 reg, u64 val)
+{
+	/*
+	 * We split one 64 bit write for two 32 bit write as some HW doesn't
+	 * support 64 bit access.
+	 */
+	iowrite32((u32)val, chan->chan_regs + reg);
+	iowrite32(val >> 32, chan->chan_regs + reg + 4);
+}
+
+static inline void axi_dma_disable(struct axi_dma_chip *chip)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chip, DMAC_CFG);
+	val &= ~DMAC_EN_MASK;
+	axi_dma_iowrite32(chip, DMAC_CFG, val);
+}
+
+static inline void axi_dma_enable(struct axi_dma_chip *chip)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chip, DMAC_CFG);
+	val |= DMAC_EN_MASK;
+	axi_dma_iowrite32(chip, DMAC_CFG, val);
+}
+
+static inline void axi_dma_irq_disable(struct axi_dma_chip *chip)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chip, DMAC_CFG);
+	val &= ~INT_EN_MASK;
+	axi_dma_iowrite32(chip, DMAC_CFG, val);
+}
+
+static inline void axi_dma_irq_enable(struct axi_dma_chip *chip)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chip, DMAC_CFG);
+	val |= INT_EN_MASK;
+	axi_dma_iowrite32(chip, DMAC_CFG, val);
+}
+
+static inline void axi_chan_irq_disable(struct axi_dma_chan *chan, u32 irq_mask)
+{
+	u32 val;
+
+	if (likely(irq_mask == DWAXIDMAC_IRQ_ALL)) {
+		axi_chan_iowrite32(chan, CH_INTSTATUS_ENA, DWAXIDMAC_IRQ_NONE);
+	} else {
+		val = axi_chan_ioread32(chan, CH_INTSTATUS_ENA);
+		val &= ~irq_mask;
+		axi_chan_iowrite32(chan, CH_INTSTATUS_ENA, val);
+	}
+}
+
+static inline void axi_chan_irq_set(struct axi_dma_chan *chan, u32 irq_mask)
+{
+	axi_chan_iowrite32(chan, CH_INTSTATUS_ENA, irq_mask);
+}
+
+static inline void axi_chan_irq_sig_set(struct axi_dma_chan *chan, u32 irq_mask)
+{
+	axi_chan_iowrite32(chan, CH_INTSIGNAL_ENA, irq_mask);
+}
+
+static inline void axi_chan_irq_clear(struct axi_dma_chan *chan, u32 irq_mask)
+{
+	axi_chan_iowrite32(chan, CH_INTCLEAR, irq_mask);
+}
+
+static inline u32 axi_chan_irq_read(struct axi_dma_chan *chan)
+{
+	return axi_chan_ioread32(chan, CH_INTSTATUS);
+}
+
+static inline void axi_chan_disable(struct axi_dma_chan *chan)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+	val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
+	val |=   BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+}
+
+static inline void axi_chan_enable(struct axi_dma_chan *chan)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+	val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+	       BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+}
+
+static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+
+	return !!(val & (BIT(chan->id) << DMAC_CHAN_EN_SHIFT));
+}
+
+static void axi_dma_hw_init(struct axi_dma_chip *chip)
+{
+	u32 i;
+
+	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
+		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
+		axi_chan_disable(&chip->dw->chan[i]);
+	}
+}
+
+static u32 axi_chan_get_xfer_width(struct axi_dma_chan *chan, dma_addr_t src,
+				   dma_addr_t dst, size_t len)
+{
+	u32 max_width = chan->chip->dw->hdata->m_data_width;
+
+	return min_t(size_t, __ffs(src | dst | len), max_width);
+}
+
+static inline const char *axi_chan_name(struct axi_dma_chan *chan)
+{
+	return dma_chan_name(&chan->vc.chan);
+}
+
+static struct axi_dma_desc *axi_desc_get(struct axi_dma_chan *chan)
+{
+	struct dw_axi_dma *dw = chan->chip->dw;
+	struct axi_dma_desc *desc;
+	dma_addr_t phys;
+
+	desc = dma_pool_zalloc(dw->desc_pool, GFP_NOWAIT, &phys);
+	if (unlikely(!desc)) {
+		dev_err(chan2dev(chan), "%s: not enough descriptors available\n",
+			axi_chan_name(chan));
+		return NULL;
+	}
+
+	atomic_inc(&chan->descs_allocated);
+	INIT_LIST_HEAD(&desc->xfer_list);
+	desc->vd.tx.phys = phys;
+	desc->chan = chan;
+
+	return desc;
+}
+
+static void axi_desc_put(struct axi_dma_desc *desc)
+{
+	struct axi_dma_chan *chan = desc->chan;
+	struct dw_axi_dma *dw = chan->chip->dw;
+	struct axi_dma_desc *child, *_next;
+	unsigned int descs_put = 0;
+
+	list_for_each_entry_safe(child, _next, &desc->xfer_list, xfer_list) {
+		list_del(&child->xfer_list);
+		dma_pool_free(dw->desc_pool, child, child->vd.tx.phys);
+		descs_put++;
+	}
+
+	dma_pool_free(dw->desc_pool, desc, desc->vd.tx.phys);
+	descs_put++;
+
+	atomic_sub(descs_put, &chan->descs_allocated);
+	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
+		axi_chan_name(chan), descs_put,
+		atomic_read(&chan->descs_allocated));
+}
+
+static void vchan_desc_put(struct virt_dma_desc *vdesc)
+{
+	axi_desc_put(vd_to_axi_desc(vdesc));
+}
+
+static enum dma_status
+dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
+		  struct dma_tx_state *txstate)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	enum dma_status ret;
+
+	ret = dma_cookie_status(dchan, cookie, txstate);
+
+	if (chan->is_paused && ret == DMA_IN_PROGRESS)
+		return DMA_PAUSED;
+
+	return ret;
+}
+
+static void write_desc_llp(struct axi_dma_desc *desc, dma_addr_t adr)
+{
+	desc->lli.llp = cpu_to_le64(adr);
+}
+
+static void write_chan_llp(struct axi_dma_chan *chan, dma_addr_t adr)
+{
+	axi_chan_iowrite64(chan, CH_LLP, adr);
+}
+
+/* Called in chan locked context */
+static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
+				      struct axi_dma_desc *first)
+{
+	u32 priority = chan->chip->dw->hdata->priority[chan->id];
+	u32 reg, irq_mask;
+	u8 lms = 0;
+
+	if (unlikely(axi_chan_is_hw_enable(chan))) {
+		dev_err(chan2dev(chan), "%s is non-idle!\n",
+			axi_chan_name(chan));
+
+		return;
+	}
+
+	axi_dma_enable(chan->chip);
+
+	reg = (DWAXIDMAC_MBLK_TYPE_LL << CH_CFG_L_DST_MULTBLK_TYPE_POS |
+	       DWAXIDMAC_MBLK_TYPE_LL << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
+	axi_chan_iowrite32(chan, CH_CFG_L, reg);
+
+	reg = (DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC << CH_CFG_H_TT_FC_POS |
+	       priority << CH_CFG_H_PRIORITY_POS |
+	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_DST_POS |
+	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_SRC_POS);
+	axi_chan_iowrite32(chan, CH_CFG_H, reg);
+
+	write_chan_llp(chan, first->vd.tx.phys | lms);
+
+	irq_mask = DWAXIDMAC_IRQ_DMA_TRF | DWAXIDMAC_IRQ_ALL_ERR;
+	axi_chan_irq_sig_set(chan, irq_mask);
+
+	/* Generate 'suspend' status but don't generate interrupt */
+	irq_mask |= DWAXIDMAC_IRQ_SUSPENDED;
+	axi_chan_irq_set(chan, irq_mask);
+
+	axi_chan_enable(chan);
+}
+
+static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
+{
+	struct axi_dma_desc *desc;
+	struct virt_dma_desc *vd;
+
+	vd = vchan_next_desc(&chan->vc);
+	if (!vd)
+		return;
+
+	desc = vd_to_axi_desc(vd);
+	dev_vdbg(chan2dev(chan), "%s: started %u\n", axi_chan_name(chan),
+		vd->tx.cookie);
+	axi_chan_block_xfer_start(chan, desc);
+}
+
+static void dma_chan_issue_pending(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (vchan_issue_pending(&chan->vc))
+		axi_chan_start_first_queued(chan);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+
+	/* ASSERT: channel is idle */
+	if (axi_chan_is_hw_enable(chan)) {
+		dev_err(chan2dev(chan), "%s is non-idle!\n",
+			axi_chan_name(chan));
+		return -EBUSY;
+	}
+
+	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
+
+	dma_cookie_init(dchan);
+
+	pm_runtime_get(chan->chip->dev);
+
+	return 0;
+}
+
+static void dma_chan_free_chan_resources(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+
+	/* ASSERT: channel is idle */
+	if (axi_chan_is_hw_enable(chan))
+		dev_err(dchan2dev(dchan), "%s is non-idle!\n",
+			axi_chan_name(chan));
+
+	axi_chan_disable(chan);
+	axi_chan_irq_disable(chan, DWAXIDMAC_IRQ_ALL);
+
+	vchan_free_chan_resources(&chan->vc);
+
+	dev_vdbg(dchan2dev(dchan), "%s: free resources, descriptor still allocated: %u\n",
+		 axi_chan_name(chan), atomic_read(&chan->descs_allocated));
+
+	pm_runtime_put(chan->chip->dev);
+}
+
+/*
+ * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of the fetched LLI
+ * as 1, it understands that the current block is the final block in the
+ * transfer and completes the DMA transfer operation at the end of current
+ * block transfer.
+ */
+static void set_desc_last(struct axi_dma_desc *desc)
+{
+	u32 val;
+
+	val = le32_to_cpu(desc->lli.ctl_hi);
+	val |= CH_CTL_H_LLI_LAST;
+	desc->lli.ctl_hi = cpu_to_le32(val);
+}
+
+static void write_desc_sar(struct axi_dma_desc *desc, dma_addr_t adr)
+{
+	desc->lli.sar = cpu_to_le64(adr);
+}
+
+static void write_desc_dar(struct axi_dma_desc *desc, dma_addr_t adr)
+{
+	desc->lli.dar = cpu_to_le64(adr);
+}
+
+static void set_desc_src_master(struct axi_dma_desc *desc)
+{
+	u32 val;
+
+	/* Select AXI0 for source master */
+	val = le32_to_cpu(desc->lli.ctl_lo);
+	val &= ~CH_CTL_L_SRC_MAST;
+	desc->lli.ctl_lo = cpu_to_le32(val);
+}
+
+static void set_desc_dest_master(struct axi_dma_desc *desc)
+{
+	u32 val;
+
+	/* Select AXI1 for source master if available */
+	val = le32_to_cpu(desc->lli.ctl_lo);
+	if (desc->chan->chip->dw->hdata->nr_masters > 1)
+		val |= CH_CTL_L_DST_MAST;
+	else
+		val &= ~CH_CTL_L_DST_MAST;
+
+	desc->lli.ctl_lo = cpu_to_le32(val);
+}
+
+static struct dma_async_tx_descriptor *
+dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
+			 dma_addr_t src_adr, size_t len, unsigned long flags)
+{
+	struct axi_dma_desc *first = NULL, *desc = NULL, *prev = NULL;
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	size_t block_ts, max_block_ts, xfer_len;
+	u32 xfer_width, reg;
+	u8 lms = 0;
+
+	dev_dbg(chan2dev(chan), "%s: memcpy: src: %pad dst: %pad length: %zd flags: %#lx",
+		axi_chan_name(chan), &src_adr, &dst_adr, len, flags);
+
+	max_block_ts = chan->chip->dw->hdata->block_size[chan->id];
+
+	while (len) {
+		xfer_len = len;
+
+		/*
+		 * Take care for the alignment.
+		 * Actually source and destination widths can be different, but
+		 * make them same to be simpler.
+		 */
+		xfer_width = axi_chan_get_xfer_width(chan, src_adr, dst_adr, xfer_len);
+
+		/*
+		 * block_ts indicates the total number of data of width
+		 * to be transferred in a DMA block transfer.
+		 * BLOCK_TS register should be set to block_ts - 1
+		 */
+		block_ts = xfer_len >> xfer_width;
+		if (block_ts > max_block_ts) {
+			block_ts = max_block_ts;
+			xfer_len = max_block_ts << xfer_width;
+		}
+
+		desc = axi_desc_get(chan);
+		if (unlikely(!desc))
+			goto err_desc_get;
+
+		write_desc_sar(desc, src_adr);
+		write_desc_dar(desc, dst_adr);
+		desc->lli.block_ts_lo = cpu_to_le32(block_ts - 1);
+
+		reg = CH_CTL_H_LLI_VALID;
+		if (chan->chip->dw->hdata->restrict_axi_burst_len) {
+			u32 burst_len = chan->chip->dw->hdata->axi_rw_burst_len;
+
+			reg |= (CH_CTL_H_ARLEN_EN |
+				burst_len << CH_CTL_H_ARLEN_POS |
+				CH_CTL_H_AWLEN_EN |
+				burst_len << CH_CTL_H_AWLEN_POS);
+		}
+		desc->lli.ctl_hi = cpu_to_le32(reg);
+
+		reg = (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
+		       DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS |
+		       xfer_width << CH_CTL_L_DST_WIDTH_POS |
+		       xfer_width << CH_CTL_L_SRC_WIDTH_POS |
+		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
+		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS);
+		desc->lli.ctl_lo = cpu_to_le32(reg);
+
+		set_desc_src_master(desc);
+		set_desc_dest_master(desc);
+
+		/* Manage transfer list (xfer_list) */
+		if (!first) {
+			first = desc;
+		} else {
+			list_add_tail(&desc->xfer_list, &first->xfer_list);
+			write_desc_llp(prev, desc->vd.tx.phys | lms);
+		}
+		prev = desc;
+
+		/* update the length and addresses for the next loop cycle */
+		len -= xfer_len;
+		dst_adr += xfer_len;
+		src_adr += xfer_len;
+	}
+
+	/* Total len of src/dest sg == 0, so no descriptor were allocated */
+	if (unlikely(!first))
+		return NULL;
+
+	/* Set end-of-link to the last link descriptor of list */
+	set_desc_last(desc);
+
+	return vchan_tx_prep(&chan->vc, &first->vd, flags);
+
+err_desc_get:
+	axi_desc_put(first);
+	return NULL;
+}
+
+static void axi_chan_dump_lli(struct axi_dma_chan *chan,
+			      struct axi_dma_desc *desc)
+{
+	dev_err(dchan2dev(&chan->vc.chan),
+		"SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x",
+		le64_to_cpu(desc->lli.sar),
+		le64_to_cpu(desc->lli.dar),
+		le64_to_cpu(desc->lli.llp),
+		le32_to_cpu(desc->lli.block_ts_lo),
+		le32_to_cpu(desc->lli.ctl_hi),
+		le32_to_cpu(desc->lli.ctl_lo));
+}
+
+static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
+				   struct axi_dma_desc *desc_head)
+{
+	struct axi_dma_desc *desc;
+
+	axi_chan_dump_lli(chan, desc_head);
+	list_for_each_entry(desc, &desc_head->xfer_list, xfer_list)
+		axi_chan_dump_lli(chan, desc);
+}
+
+static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
+{
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	axi_chan_disable(chan);
+
+	/* The bad descriptor currently is in the head of vc list */
+	vd = vchan_next_desc(&chan->vc);
+	/* Remove the completed descriptor from issued list */
+	list_del(&vd->node);
+
+	/* WARN about bad descriptor */
+	dev_err(chan2dev(chan),
+		"Bad descriptor submitted for %s, cookie: %d, irq: 0x%08x\n",
+		axi_chan_name(chan), vd->tx.cookie, status);
+	axi_chan_list_dump_lli(chan, vd_to_axi_desc(vd));
+
+	vchan_cookie_complete(vd);
+
+	/* Try to restart the controller */
+	axi_chan_start_first_queued(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
+{
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (unlikely(axi_chan_is_hw_enable(chan))) {
+		dev_err(chan2dev(chan), "BUG: %s catched DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
+			axi_chan_name(chan));
+		axi_chan_disable(chan);
+	}
+
+	/* The completed descriptor currently is in the head of vc list */
+	vd = vchan_next_desc(&chan->vc);
+	/* Remove the completed descriptor from issued list before completing */
+	list_del(&vd->node);
+	vchan_cookie_complete(vd);
+
+	/* Submit queued descriptors after processing the completed ones */
+	axi_chan_start_first_queued(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static irqreturn_t dw_axi_dma_intretupt(int irq, void *dev_id)
+{
+	struct axi_dma_chip *chip = dev_id;
+	struct dw_axi_dma *dw = chip->dw;
+	struct axi_dma_chan *chan;
+
+	u32 status, i;
+
+	/* Disable DMAC inerrupts. We'll enable them after processing chanels */
+	axi_dma_irq_disable(chip);
+
+	/* Poll, clear and process every chanel interrupt status */
+	for (i = 0; i < dw->hdata->nr_channels; i++) {
+		chan = &dw->chan[i];
+		status = axi_chan_irq_read(chan);
+		axi_chan_irq_clear(chan, status);
+
+		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
+			axi_chan_name(chan), i, status);
+
+		if (status & DWAXIDMAC_IRQ_ALL_ERR)
+			axi_chan_handle_err(chan, status);
+		else if (status & DWAXIDMAC_IRQ_DMA_TRF)
+			axi_chan_block_xfer_complete(chan);
+	}
+
+	/* Re-enable interrupts */
+	axi_dma_irq_enable(chip);
+
+	return IRQ_HANDLED;
+}
+
+static int dma_chan_terminate_all(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	axi_chan_disable(chan);
+
+	vchan_get_all_descriptors(&chan->vc, &head);
+
+	/*
+	 * As vchan_dma_desc_free_list can access to desc_allocated list
+	 * we need to call it in vc.lock context.
+	 */
+	vchan_dma_desc_free_list(&chan->vc, &head);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	dev_vdbg(dchan2dev(dchan), "terminated: %s\n", axi_chan_name(chan));
+
+	return 0;
+}
+
+static int dma_chan_pause(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	unsigned long flags;
+	unsigned int timeout = 20; /* timeout iterations */
+	int ret = -EAGAIN;
+	u32 val;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+	val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
+	       BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
+	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+
+	do  {
+		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED) {
+			ret = 0;
+			break;
+		}
+		udelay(2);
+	} while (timeout--);
+
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+
+	chan->is_paused = true;
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	return ret;
+}
+
+/* Called in chan locked context */
+static inline void axi_chan_resume(struct axi_dma_chan *chan)
+{
+	u32 val;
+
+	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+	val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT);
+	val |=  (BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT);
+	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+
+	chan->is_paused = false;
+}
+
+static int dma_chan_resume(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (chan->is_paused)
+		axi_chan_resume(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	return 0;
+}
+
+static int axi_dma_runtime_suspend(struct device *dev)
+{
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
+
+	axi_dma_irq_disable(chip);
+	axi_dma_disable(chip);
+
+	clk_disable_unprepare(chip->core_clk);
+	clk_disable_unprepare(chip->cfgr_clk);
+
+	return 0;
+}
+
+static int axi_dma_runtime_resume(struct device *dev)
+{
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = clk_prepare_enable(chip->cfgr_clk);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(chip->core_clk);
+	if (ret < 0)
+		return ret;
+
+	axi_dma_enable(chip);
+	axi_dma_irq_enable(chip);
+
+	return 0;
+}
+
+static int parse_device_properties(struct axi_dma_chip *chip)
+{
+	struct device *dev = chip->dev;
+	u32 tmp, carr[DMAC_MAX_CHANNELS];
+	int ret;
+
+	ret = device_property_read_u32(dev, "dma-channels", &tmp);
+	if (ret)
+		return ret;
+	if (tmp == 0 || tmp > DMAC_MAX_CHANNELS)
+		return -EINVAL;
+
+	chip->dw->hdata->nr_channels = tmp;
+
+	ret = device_property_read_u32(dev, "snps,dma-masters", &tmp);
+	if (ret)
+		return ret;
+	if (tmp == 0 || tmp > DMAC_MAX_MASTERS)
+		return -EINVAL;
+
+	chip->dw->hdata->nr_masters = tmp;
+
+	ret = device_property_read_u32(dev, "snps,data-width", &tmp);
+	if (ret)
+		return ret;
+	if (tmp > DWAXIDMAC_TRANS_WIDTH_MAX)
+		return -EINVAL;
+
+	chip->dw->hdata->m_data_width = tmp;
+
+	ret = device_property_read_u32_array(dev, "snps,block-size", carr,
+					     chip->dw->hdata->nr_channels);
+	if (ret)
+		return ret;
+	for (tmp = 0; tmp < chip->dw->hdata->nr_channels; tmp++) {
+		if (carr[tmp] == 0 || carr[tmp] > DMAC_MAX_BLK_SIZE)
+			return -EINVAL;
+
+		chip->dw->hdata->block_size[tmp] = carr[tmp];
+	}
+
+	ret = device_property_read_u32_array(dev, "snps,priority", carr,
+					     chip->dw->hdata->nr_channels);
+	if (ret)
+		return ret;
+	/* Priority value must be programmed within [0:nr_channels-1] range */
+	for (tmp = 0; tmp < chip->dw->hdata->nr_channels; tmp++) {
+		if (carr[tmp] >= chip->dw->hdata->nr_channels)
+			return -EINVAL;
+
+		chip->dw->hdata->priority[tmp] = carr[tmp];
+	}
+
+	/* axi-max-burst-len is optional property */
+	ret = device_property_read_u32(dev, "snps,axi-max-burst-len", &tmp);
+	if (!ret) {
+		if (tmp > DWAXIDMAC_ARWLEN_MAX + 1)
+			return -EINVAL;
+		if (tmp < DWAXIDMAC_ARWLEN_MIN + 1)
+			return -EINVAL;
+
+		chip->dw->hdata->restrict_axi_burst_len = true;
+		chip->dw->hdata->axi_rw_burst_len = tmp - 1;
+	}
+
+	return 0;
+}
+
+static int dw_probe(struct platform_device *pdev)
+{
+	struct axi_dma_chip *chip;
+	struct resource *mem;
+	struct dw_axi_dma *dw;
+	struct dw_axi_dma_hcfg *hdata;
+	u32 i;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	hdata = devm_kzalloc(&pdev->dev, sizeof(*hdata), GFP_KERNEL);
+	if (!hdata)
+		return -ENOMEM;
+
+	chip->dw = dw;
+	chip->dev = &pdev->dev;
+	chip->dw->hdata = hdata;
+
+	chip->irq = platform_get_irq(pdev, 0);
+	if (chip->irq < 0)
+		return chip->irq;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	chip->regs = devm_ioremap_resource(chip->dev, mem);
+	if (IS_ERR(chip->regs))
+		return PTR_ERR(chip->regs);
+
+	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
+	if (IS_ERR(chip->core_clk))
+		return PTR_ERR(chip->core_clk);
+
+	chip->cfgr_clk = devm_clk_get(chip->dev, "cfgr-clk");
+	if (IS_ERR(chip->cfgr_clk))
+		return PTR_ERR(chip->cfgr_clk);
+
+	ret = parse_device_properties(chip);
+	if (ret)
+		return ret;
+
+	dw->chan = devm_kcalloc(chip->dev, hdata->nr_channels,
+				sizeof(*dw->chan), GFP_KERNEL);
+	if (!dw->chan)
+		return -ENOMEM;
+
+	ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_intretupt,
+			       IRQF_SHARED, DRV_NAME, chip);
+	if (ret)
+		return ret;
+
+	/* Lli address must be aligned to a 64-byte boundary */
+	dw->desc_pool = dmam_pool_create(DRV_NAME, chip->dev,
+					 sizeof(struct axi_dma_desc), 64, 0);
+	if (!dw->desc_pool) {
+		dev_err(chip->dev, "No memory for descriptors dma pool\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&dw->dma.channels);
+	for (i = 0; i < hdata->nr_channels; i++) {
+		struct axi_dma_chan *chan = &dw->chan[i];
+
+		chan->chip = chip;
+		chan->id = (u8)i;
+		chan->chan_regs = chip->regs + COMMON_REG_LEN + i * CHAN_REG_LEN;
+		atomic_set(&chan->descs_allocated, 0);
+
+		chan->vc.desc_free = vchan_desc_put;
+		vchan_init(&chan->vc, &dw->dma);
+	}
+
+	/* Set capabilities */
+	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
+
+	/* DMA capabilities */
+	dw->dma.chancnt = hdata->nr_channels;
+	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
+	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
+	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
+	dw->dma.dev = chip->dev;
+	dw->dma.device_tx_status = dma_chan_tx_status;
+	dw->dma.device_issue_pending = dma_chan_issue_pending;
+	dw->dma.device_terminate_all = dma_chan_terminate_all;
+	dw->dma.device_pause = dma_chan_pause;
+	dw->dma.device_resume = dma_chan_resume;
+
+	dw->dma.device_alloc_chan_resources = dma_chan_alloc_chan_resources;
+	dw->dma.device_free_chan_resources = dma_chan_free_chan_resources;
+
+	dw->dma.device_prep_dma_memcpy = dma_chan_prep_dma_memcpy;
+
+	platform_set_drvdata(pdev, chip);
+
+	pm_runtime_enable(chip->dev);
+
+	/*
+	 * We can't just call pm_runtime_get here instead of
+	 * pm_runtime_get_noresume + axi_dma_runtime_resume because we need
+	 * driver to work also without Runtime PM.
+	 */
+	pm_runtime_get_noresume(chip->dev);
+	ret = axi_dma_runtime_resume(chip->dev);
+	if (ret < 0)
+		goto err_pm_disable;
+
+	axi_dma_hw_init(chip);
+
+	pm_runtime_put(chip->dev);
+
+	ret = dma_async_device_register(&dw->dma);
+	if (ret)
+		goto err_pm_disable;
+
+	dev_info(chip->dev, "DesignWare AXI DMA Controller, %d channels\n",
+		 dw->hdata->nr_channels);
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(chip->dev);
+
+	return ret;
+}
+
+static int dw_remove(struct platform_device *pdev)
+{
+	struct axi_dma_chip *chip = platform_get_drvdata(pdev);
+	struct dw_axi_dma *dw = chip->dw;
+	struct axi_dma_chan *chan, *_chan;
+	u32 i;
+
+	/* Enable clk before accessing to registers */
+	clk_prepare_enable(chip->cfgr_clk);
+	clk_prepare_enable(chip->core_clk);
+	axi_dma_irq_disable(chip);
+	for (i = 0; i < dw->hdata->nr_channels; i++) {
+		axi_chan_disable(&chip->dw->chan[i]);
+		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
+	}
+	axi_dma_disable(chip);
+
+	pm_runtime_disable(chip->dev);
+	axi_dma_runtime_suspend(chip->dev);
+
+	devm_free_irq(chip->dev, chip->irq, chip);
+
+	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
+			vc.chan.device_node) {
+		list_del(&chan->vc.chan.device_node);
+		tasklet_kill(&chan->vc.task);
+	}
+
+	dma_async_device_unregister(&dw->dma);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_axi_dma_pm_ops = {
+	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
+};
+
+static const struct of_device_id dw_dma_of_id_table[] = {
+	{ .compatible = "snps,axi-dma-1.01a" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
+
+static struct platform_driver dw_driver = {
+	.probe		= dw_probe,
+	.remove		= dw_remove,
+	.driver = {
+		.name	= DRV_NAME,
+		.of_match_table = of_match_ptr(dw_dma_of_id_table),
+		.pm = &dw_axi_dma_pm_ops,
+	},
+};
+module_platform_driver(dw_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare AXI DMA Controller platform driver");
+MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
diff --git a/drivers/dma/dw-axi-dmac/axi_dma_platform.h b/drivers/dma/dw-axi-dmac/axi_dma_platform.h
new file mode 100644
index 0000000..2ae3053
--- /dev/null
+++ b/drivers/dma/dw-axi-dmac/axi_dma_platform.h
@@ -0,0 +1,342 @@
+/*
+ * Synopsys DesignWare AXI DMA Controller driver.
+ *
+ * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
+ * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _AXI_DMA_PLATFORM_H
+#define _AXI_DMA_PLATFORM_H
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/types.h>
+
+#include "../virt-dma.h"
+
+#define DMAC_MAX_CHANNELS	8
+#define DMAC_MAX_MASTERS	2
+#define DMAC_MAX_BLK_SIZE	0x200000
+
+struct dw_axi_dma_hcfg {
+	u32	nr_channels;
+	u32	nr_masters;
+	u32	m_data_width;
+	u32	block_size[DMAC_MAX_CHANNELS];
+	u32	priority[DMAC_MAX_CHANNELS];
+	/* maximum supported axi burst length */
+	u32	axi_rw_burst_len;
+	bool	restrict_axi_burst_len;
+};
+
+struct axi_dma_chan {
+	struct axi_dma_chip		*chip;
+	void __iomem			*chan_regs;
+	u8				id;
+	atomic_t			descs_allocated;
+
+	struct virt_dma_chan		vc;
+
+	/* these other elements are all protected by vc.lock */
+	bool				is_paused;
+};
+
+struct dw_axi_dma {
+	struct dma_device	dma;
+	struct dw_axi_dma_hcfg	*hdata;
+	struct dma_pool		*desc_pool;
+
+	/* channels */
+	struct axi_dma_chan	*chan;
+};
+
+struct axi_dma_chip {
+	struct device		*dev;
+	int			irq;
+	void __iomem		*regs;
+	struct clk		*core_clk;
+	struct clk		*cfgr_clk;
+	struct dw_axi_dma	*dw;
+};
+
+/* LLI == Linked List Item */
+struct __packed axi_dma_lli {
+	__le64		sar;
+	__le64		dar;
+	__le32		block_ts_lo;
+	__le32		block_ts_hi;
+	__le64		llp;
+	__le32		ctl_lo;
+	__le32		ctl_hi;
+	__le32		sstat;
+	__le32		dstat;
+	__le32		status_lo;
+	__le32		ststus_hi;
+	__le32		reserved_lo;
+	__le32		reserved_hi;
+};
+
+struct axi_dma_desc {
+	struct axi_dma_lli		lli;
+
+	struct virt_dma_desc		vd;
+	struct axi_dma_chan		*chan;
+	struct list_head		xfer_list;
+};
+
+static inline struct device *dchan2dev(struct dma_chan *dchan)
+{
+	return &dchan->dev->device;
+}
+
+static inline struct device *chan2dev(struct axi_dma_chan *chan)
+{
+	return &chan->vc.chan.dev->device;
+}
+
+static inline struct axi_dma_desc *vd_to_axi_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct axi_dma_desc, vd);
+}
+
+static inline struct axi_dma_chan *vc_to_axi_dma_chan(struct virt_dma_chan *vc)
+{
+	return container_of(vc, struct axi_dma_chan, vc);
+}
+
+static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
+{
+	return vc_to_axi_dma_chan(to_virt_chan(dchan));
+}
+
+
+#define COMMON_REG_LEN		0x100
+#define CHAN_REG_LEN		0x100
+
+/* Common registers offset */
+#define DMAC_ID			0x000 /* R DMAC ID */
+#define DMAC_COMPVER		0x008 /* R DMAC Component Version */
+#define DMAC_CFG		0x010 /* R/W DMAC Configuration */
+#define DMAC_CHEN		0x018 /* R/W DMAC Channel Enable */
+#define DMAC_CHEN_L		0x018 /* R/W DMAC Channel Enable 00-31 */
+#define DMAC_CHEN_H		0x01C /* R/W DMAC Channel Enable 32-63 */
+#define DMAC_INTSTATUS		0x030 /* R DMAC Interrupt Status */
+#define DMAC_COMMON_INTCLEAR	0x038 /* W DMAC Interrupt Clear */
+#define DMAC_COMMON_INTSTATUS_ENA 0x040 /* R DMAC Interrupt Status Enable */
+#define DMAC_COMMON_INTSIGNAL_ENA 0x048 /* R/W DMAC Interrupt Signal Enable */
+#define DMAC_COMMON_INTSTATUS	0x050 /* R DMAC Interrupt Status */
+#define DMAC_RESET		0x058 /* R DMAC Reset Register1 */
+
+/* DMA channel registers offset */
+#define CH_SAR			0x000 /* R/W Chan Source Address */
+#define CH_DAR			0x008 /* R/W Chan Destination Address */
+#define CH_BLOCK_TS		0x010 /* R/W Chan Block Transfer Size */
+#define CH_CTL			0x018 /* R/W Chan Control */
+#define CH_CTL_L		0x018 /* R/W Chan Control 00-31 */
+#define CH_CTL_H		0x01C /* R/W Chan Control 32-63 */
+#define CH_CFG			0x020 /* R/W Chan Configuration */
+#define CH_CFG_L		0x020 /* R/W Chan Configuration 00-31 */
+#define CH_CFG_H		0x024 /* R/W Chan Configuration 32-63 */
+#define CH_LLP			0x028 /* R/W Chan Linked List Pointer */
+#define CH_STATUS		0x030 /* R Chan Status */
+#define CH_SWHSSRC		0x038 /* R/W Chan SW Handshake Source */
+#define CH_SWHSDST		0x040 /* R/W Chan SW Handshake Destination */
+#define CH_BLK_TFR_RESUMEREQ	0x048 /* W Chan Block Transfer Resume Req */
+#define CH_AXI_ID		0x050 /* R/W Chan AXI ID */
+#define CH_AXI_QOS		0x058 /* R/W Chan AXI QOS */
+#define CH_SSTAT		0x060 /* R Chan Source Status */
+#define CH_DSTAT		0x068 /* R Chan Destination Status */
+#define CH_SSTATAR		0x070 /* R/W Chan Source Status Fetch Addr */
+#define CH_DSTATAR		0x078 /* R/W Chan Destination Status Fetch Addr */
+#define CH_INTSTATUS_ENA	0x080 /* R/W Chan Interrupt Status Enable */
+#define CH_INTSTATUS		0x088 /* R/W Chan Interrupt Status */
+#define CH_INTSIGNAL_ENA	0x090 /* R/W Chan Interrupt Signal Enable */
+#define CH_INTCLEAR		0x098 /* W Chan Interrupt Clear */
+
+
+/* DMAC_CFG */
+#define DMAC_EN_POS			0
+#define DMAC_EN_MASK			BIT(DMAC_EN_POS)
+
+#define INT_EN_POS			1
+#define INT_EN_MASK			BIT(INT_EN_POS)
+
+#define DMAC_CHAN_EN_SHIFT		0
+#define DMAC_CHAN_EN_WE_SHIFT		8
+
+#define DMAC_CHAN_SUSP_SHIFT		16
+#define DMAC_CHAN_SUSP_WE_SHIFT		24
+
+/* CH_CTL_H */
+#define CH_CTL_H_ARLEN_EN		BIT(6)
+#define CH_CTL_H_ARLEN_POS		7
+#define CH_CTL_H_AWLEN_EN		BIT(15)
+#define CH_CTL_H_AWLEN_POS		16
+
+enum {
+	DWAXIDMAC_ARWLEN_1		= 0x0,
+	DWAXIDMAC_ARWLEN_2		= 0x1,
+	DWAXIDMAC_ARWLEN_4		= 0x3,
+	DWAXIDMAC_ARWLEN_8		= 0x7,
+	DWAXIDMAC_ARWLEN_16		= 0xF,
+	DWAXIDMAC_ARWLEN_32		= 0x1F,
+	DWAXIDMAC_ARWLEN_64		= 0x3F,
+	DWAXIDMAC_ARWLEN_128		= 0x7F,
+	DWAXIDMAC_ARWLEN_256		= 0xFF,
+	DWAXIDMAC_ARWLEN_MIN		= DWAXIDMAC_ARWLEN_1,
+	DWAXIDMAC_ARWLEN_MAX		= DWAXIDMAC_ARWLEN_256
+};
+
+#define CH_CTL_H_LLI_LAST		BIT(30)
+#define CH_CTL_H_LLI_VALID		BIT(31)
+
+/* CH_CTL_L */
+#define CH_CTL_L_LAST_WRITE_EN		BIT(30)
+
+#define CH_CTL_L_DST_MSIZE_POS		18
+#define CH_CTL_L_SRC_MSIZE_POS		14
+
+enum {
+	DWAXIDMAC_BURST_TRANS_LEN_1	= 0,
+	DWAXIDMAC_BURST_TRANS_LEN_4,
+	DWAXIDMAC_BURST_TRANS_LEN_8,
+	DWAXIDMAC_BURST_TRANS_LEN_16,
+	DWAXIDMAC_BURST_TRANS_LEN_32,
+	DWAXIDMAC_BURST_TRANS_LEN_64,
+	DWAXIDMAC_BURST_TRANS_LEN_128,
+	DWAXIDMAC_BURST_TRANS_LEN_256,
+	DWAXIDMAC_BURST_TRANS_LEN_512,
+	DWAXIDMAC_BURST_TRANS_LEN_1024
+};
+
+#define CH_CTL_L_DST_WIDTH_POS		11
+#define CH_CTL_L_SRC_WIDTH_POS		8
+
+#define CH_CTL_L_DST_INC_POS		6
+#define CH_CTL_L_SRC_INC_POS		4
+enum {
+	DWAXIDMAC_CH_CTL_L_INC		= 0,
+	DWAXIDMAC_CH_CTL_L_NOINC
+};
+
+#define CH_CTL_L_DST_MAST		BIT(2)
+#define CH_CTL_L_SRC_MAST		BIT(0)
+
+/* CH_CFG_H */
+#define CH_CFG_H_PRIORITY_POS		17
+#define CH_CFG_H_HS_SEL_DST_POS		4
+#define CH_CFG_H_HS_SEL_SRC_POS		3
+enum {
+	DWAXIDMAC_HS_SEL_HW		= 0,
+	DWAXIDMAC_HS_SEL_SW
+};
+
+#define CH_CFG_H_TT_FC_POS		0
+enum {
+	DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC	= 0,
+	DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC,
+	DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC,
+	DWAXIDMAC_TT_FC_PER_TO_PER_DMAC,
+	DWAXIDMAC_TT_FC_PER_TO_MEM_SRC,
+	DWAXIDMAC_TT_FC_PER_TO_PER_SRC,
+	DWAXIDMAC_TT_FC_MEM_TO_PER_DST,
+	DWAXIDMAC_TT_FC_PER_TO_PER_DST
+};
+
+/* CH_CFG_L */
+#define CH_CFG_L_DST_MULTBLK_TYPE_POS	2
+#define CH_CFG_L_SRC_MULTBLK_TYPE_POS	0
+enum {
+	DWAXIDMAC_MBLK_TYPE_CONTIGUOUS	= 0,
+	DWAXIDMAC_MBLK_TYPE_RELOAD,
+	DWAXIDMAC_MBLK_TYPE_SHADOW_REG,
+	DWAXIDMAC_MBLK_TYPE_LL
+};
+
+/**
+ * DW AXI DMA channel interrupts
+ *
+ * @DWAXIDMAC_IRQ_NONE: Bitmask of no one interrupt
+ * @DWAXIDMAC_IRQ_BLOCK_TRF: Block transfer complete
+ * @DWAXIDMAC_IRQ_DMA_TRF: Dma transfer complete
+ * @DWAXIDMAC_IRQ_SRC_TRAN: Source transaction complete
+ * @DWAXIDMAC_IRQ_DST_TRAN: Destination transaction complete
+ * @DWAXIDMAC_IRQ_SRC_DEC_ERR: Source decode error
+ * @DWAXIDMAC_IRQ_DST_DEC_ERR: Destination decode error
+ * @DWAXIDMAC_IRQ_SRC_SLV_ERR: Source slave error
+ * @DWAXIDMAC_IRQ_DST_SLV_ERR: Destination slave error
+ * @DWAXIDMAC_IRQ_LLI_RD_DEC_ERR: LLI read decode error
+ * @DWAXIDMAC_IRQ_LLI_WR_DEC_ERR: LLI write decode error
+ * @DWAXIDMAC_IRQ_LLI_RD_SLV_ERR: LLI read slave error
+ * @DWAXIDMAC_IRQ_LLI_WR_SLV_ERR: LLI write slave error
+ * @DWAXIDMAC_IRQ_INVALID_ERR: LLI invalid error or Shadow register error
+ * @DWAXIDMAC_IRQ_MULTIBLKTYPE_ERR: Slave Interface Multiblock type error
+ * @DWAXIDMAC_IRQ_DEC_ERR: Slave Interface decode error
+ * @DWAXIDMAC_IRQ_WR2RO_ERR: Slave Interface write to read only error
+ * @DWAXIDMAC_IRQ_RD2RWO_ERR: Slave Interface read to write only error
+ * @DWAXIDMAC_IRQ_WRONCHEN_ERR: Slave Interface write to channel error
+ * @DWAXIDMAC_IRQ_SHADOWREG_ERR: Slave Interface shadow reg error
+ * @DWAXIDMAC_IRQ_WRONHOLD_ERR: Slave Interface hold error
+ * @DWAXIDMAC_IRQ_LOCK_CLEARED: Lock Cleared Status
+ * @DWAXIDMAC_IRQ_SRC_SUSPENDED: Source Suspended Status
+ * @DWAXIDMAC_IRQ_SUSPENDED: Channel Suspended Status
+ * @DWAXIDMAC_IRQ_DISABLED: Channel Disabled Status
+ * @DWAXIDMAC_IRQ_ABORTED: Channel Aborted Status
+ * @DWAXIDMAC_IRQ_ALL_ERR: Bitmask of all error interrupts
+ * @DWAXIDMAC_IRQ_ALL: Bitmask of all interrupts
+ */
+enum {
+	DWAXIDMAC_IRQ_NONE		= 0,
+	DWAXIDMAC_IRQ_BLOCK_TRF		= BIT(0),
+	DWAXIDMAC_IRQ_DMA_TRF		= BIT(1),
+	DWAXIDMAC_IRQ_SRC_TRAN		= BIT(3),
+	DWAXIDMAC_IRQ_DST_TRAN		= BIT(4),
+	DWAXIDMAC_IRQ_SRC_DEC_ERR	= BIT(5),
+	DWAXIDMAC_IRQ_DST_DEC_ERR	= BIT(6),
+	DWAXIDMAC_IRQ_SRC_SLV_ERR	= BIT(7),
+	DWAXIDMAC_IRQ_DST_SLV_ERR	= BIT(8),
+	DWAXIDMAC_IRQ_LLI_RD_DEC_ERR	= BIT(9),
+	DWAXIDMAC_IRQ_LLI_WR_DEC_ERR	= BIT(10),
+	DWAXIDMAC_IRQ_LLI_RD_SLV_ERR	= BIT(11),
+	DWAXIDMAC_IRQ_LLI_WR_SLV_ERR	= BIT(12),
+	DWAXIDMAC_IRQ_INVALID_ERR	= BIT(13),
+	DWAXIDMAC_IRQ_MULTIBLKTYPE_ERR	= BIT(14),
+	DWAXIDMAC_IRQ_DEC_ERR		= BIT(16),
+	DWAXIDMAC_IRQ_WR2RO_ERR		= BIT(17),
+	DWAXIDMAC_IRQ_RD2RWO_ERR	= BIT(18),
+	DWAXIDMAC_IRQ_WRONCHEN_ERR	= BIT(19),
+	DWAXIDMAC_IRQ_SHADOWREG_ERR	= BIT(20),
+	DWAXIDMAC_IRQ_WRONHOLD_ERR	= BIT(21),
+	DWAXIDMAC_IRQ_LOCK_CLEARED	= BIT(27),
+	DWAXIDMAC_IRQ_SRC_SUSPENDED	= BIT(28),
+	DWAXIDMAC_IRQ_SUSPENDED		= BIT(29),
+	DWAXIDMAC_IRQ_DISABLED		= BIT(30),
+	DWAXIDMAC_IRQ_ABORTED		= BIT(31),
+	DWAXIDMAC_IRQ_ALL_ERR		= 0x003F7FE0,
+	DWAXIDMAC_IRQ_ALL		= GENMASK(31, 0)
+};
+
+enum {
+	DWAXIDMAC_TRANS_WIDTH_8		= 0,
+	DWAXIDMAC_TRANS_WIDTH_16,
+	DWAXIDMAC_TRANS_WIDTH_32,
+	DWAXIDMAC_TRANS_WIDTH_64,
+	DWAXIDMAC_TRANS_WIDTH_128,
+	DWAXIDMAC_TRANS_WIDTH_256,
+	DWAXIDMAC_TRANS_WIDTH_512,
+	DWAXIDMAC_TRANS_WIDTH_MAX	= DWAXIDMAC_TRANS_WIDTH_512
+};
+
+#endif /* _AXI_DMA_PLATFORM_H */
-- 
2.9.3
