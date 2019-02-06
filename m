Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9180C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CFF2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nt3lOryT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfBFOrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:47:32 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14274 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfBFOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:47:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5af3820000>; Wed, 06 Feb 2019 06:47:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 06:47:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 06:47:27 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:47:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:47:26 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Feb 2019 14:47:26 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5af37d0000>; Wed, 06 Feb 2019 06:47:26 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V13 3/5] i2c: tegra: Add DMA support
Date:   Wed, 6 Feb 2019 06:47:19 -0800
Message-ID: <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549464450; bh=paUvy6EieuoRkUTPRCF583FW6JIGyugFePjcv1DksrE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nt3lOryTMuxhNRwvBm+SfIIyJvYJF5cXDKvztF8jw7hXfAxOUSWiusrpVFhVlKz7z
         wOEO1RS3Dclt7UnvmOUJuv5T1ha+5b8ZAiYESRSi5tnof1AIxbJsEowLAI4+H5cfjN
         l9/BgXlqDshPx0iesByJQEF7tJsGVS6kPAvWMrtNFhCaV4AcOHZxAF2M2hphCoGY3w
         DPm520JP/fXugai+41O2hlVB+VUf70rQyA/Tc59M2J0l9n18zTdj22RS6WiuI9F1fm
         YRnoQlIpQRZHiRgVbwN6/lrlZp6odjNCG9ol1cSti3lW5aOP0i92t0BB66wIJRvImY
         ShwXyPPThcNiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DMA support for Tegra I2C.

Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
transfer size of the max FIFO depth and DMA mode is used for
transfer size higher than max FIFO depth to save CPU overhead.

PIO mode needs full intervention of CPU to fill or empty FIFO's
and also need to service multiple data requests interrupt for the
same transaction. This adds delay between data bytes of the same
transfer when CPU is fully loaded and some slave devices has
internal timeout for no bus activity and stops transaction to
avoid bus hang. DMA mode is helpful in such cases.

DMA mode is also helpful for Large transfers during downloading or
uploading FW over I2C to some external devices.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V13] : T20 has DVC used for some power controls. This version has fix for using
	 proper DVC register offsets for DMA programming incase when used in DMA
	 mode.
 [V12] : Replaced dma_alloc_coherent with dma_alloc_attrs to force the allocated
	 buffer to be contiguous also in physical memory as Tegra194 supports max
	 64K and dma_alloc_coherent doesnt guarentee contiguous memory.
	 Changed return code from EIO to EINVAL incase of failure to obtain dma
	 descriptor.
	 Fixed coding style check issues.	 
 [V11] : Replaced deprecated dmaengine_terminate_all with dmaengine_termine_async
	 from non-atomic context and dmaengine_terminate_sync from atomic context.
	 Fixed to program fifo trigger levels properly when transfer falls back to
	 pio mode in case of dma slave configuration failure and other minor fixes.
 [V10] : APBDMA is replaced with GPCDMA on Tegra186 and Tegra194 designs.
	 Added apbdma hw support flag to now allow Tegra186 and later use
	 APBDMA driver.
	 Added explicit flow control enable for DMA slave config and error handling.
	 Moved releasing DMA resources to seperate function to reuse in
	 multiple places.
	 Updated to register tegra_i2c_driver from module level rather than subsys
	 level.
	 Other minor feedback
 [V9] :  Rebased to 5.0-rc4
	 Removed dependency of APB DMA in Kconfig and added conditional check
 	 in I2C driver to decide on using DMA mode.
	 Changed back the allocation of dma buffer during i2c probe.
	 Fixed FIFO triggers depending on DMA Vs PIO.
 [V8] :  Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
	 interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
	 other fixes
	 Updated Kconfig for APB_DMA dependency
 [V7] :  Same as V6
 [V6] :  Updated for proper buffer allocation/freeing, channel release.
	 Updated to use exact xfer size for syncing dma buffer.
 [V5] :  Same as V4
 [V4] :  Updated to allocate DMA buffer only when DMA mode.
	 Updated to fall back to PIO mode when DMA channel request or
	 buffer allocation fails.
 [V3] :  Updated without additional buffer allocation.
 [V2] :  Updated based on V1 review feedback along with code cleanup for
	 proper implementation of DMA.


 drivers/i2c/busses/i2c-tegra.c | 411 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 367 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 118b7023a0f4..47b1d08f7a08 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -8,6 +8,8 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -44,6 +46,8 @@
 #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
 #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
 #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
+#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
+#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
 #define I2C_FIFO_STATUS				0x060
 #define I2C_FIFO_STATUS_TX_MASK			0xF0
 #define I2C_FIFO_STATUS_TX_SHIFT		4
@@ -125,6 +129,16 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
+/*
+ * Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
+ * above this, controller will use DMA to fill FIFO.
+ * MAX PIO len is 20 bytes excluding packet header.
+ */
+#define I2C_PIO_MODE_MAX_LEN			32
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -166,6 +180,7 @@ enum msg_end_type {
  *		allowing 0 length transfers.
  * @supports_bus_clear: Bus Clear support to recover from bus hang during
  *		SDA stuck low from device for some unknown reasons.
+ * @has_apb_dma: Support of APBDMA on corresponding Tegra chip.
  */
 struct tegra_i2c_hw_feature {
 	bool has_continue_xfer_support;
@@ -180,6 +195,7 @@ struct tegra_i2c_hw_feature {
 	bool has_mst_fifo;
 	const struct i2c_adapter_quirks *quirks;
 	bool supports_bus_clear;
+	bool has_apb_dma;
 };
 
 /**
@@ -191,6 +207,7 @@ struct tegra_i2c_hw_feature {
  * @fast_clk: clock reference for fast clock of I2C controller
  * @rst: reset control for the I2C controller
  * @base: ioremapped registers cookie
+ * @base_phys: Physical base address of the I2C controller
  * @cont_id: I2C controller ID, used for packet header
  * @irq: IRQ number of transfer complete interrupt
  * @irq_disabled: used to track whether or not the interrupt is enabled
@@ -204,6 +221,13 @@ struct tegra_i2c_hw_feature {
  * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
  * @is_multimaster_mode: track if I2C controller is in multi-master mode
  * @xfer_lock: lock to serialize transfer submission and processing
+ * @tx_dma_chan: DMA transmit channel
+ * @rx_dma_chan: DMA receive channel
+ * @dma_phys: handle to DMA resources
+ * @dma_buf: pointer to allocated DMA buffer
+ * @dma_buf_size: DMA buffer size
+ * @is_curr_dma_xfer: indicates active DMA transfer
+ * @dma_complete: DMA completion notifier
  */
 struct tegra_i2c_dev {
 	struct device *dev;
@@ -213,6 +237,7 @@ struct tegra_i2c_dev {
 	struct clk *fast_clk;
 	struct reset_control *rst;
 	void __iomem *base;
+	phys_addr_t base_phys;
 	int cont_id;
 	int irq;
 	bool irq_disabled;
@@ -226,6 +251,13 @@ struct tegra_i2c_dev {
 	u16 clk_divisor_non_hs_mode;
 	bool is_multimaster_mode;
 	spinlock_t xfer_lock;
+	struct dma_chan *tx_dma_chan;
+	struct dma_chan *rx_dma_chan;
+	dma_addr_t dma_phys;
+	u32 *dma_buf;
+	unsigned int dma_buf_size;
+	bool is_curr_dma_xfer;
+	struct completion dma_complete;
 };
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
@@ -294,6 +326,111 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
 	i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
 }
 
+static void tegra_i2c_dma_complete(void *args)
+{
+	struct tegra_i2c_dev *i2c_dev = args;
+
+	complete(&i2c_dev->dma_complete);
+}
+
+static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t len)
+{
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_transfer_direction dir;
+	struct dma_chan *chan;
+
+	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n", len);
+	reinit_completion(&i2c_dev->dma_complete);
+	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
+	chan = i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_chan;
+	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
+					       len, dir, DMA_PREP_INTERRUPT |
+					       DMA_CTRL_ACK);
+	if (!dma_desc) {
+		dev_err(i2c_dev->dev, "failed to get DMA descriptor\n");
+		return -EINVAL;
+	}
+
+	dma_desc->callback = tegra_i2c_dma_complete;
+	dma_desc->callback_param = i2c_dev;
+	dmaengine_submit(dma_desc);
+	dma_async_issue_pending(chan);
+	return 0;
+}
+
+static void tegra_i2c_release_dma(struct tegra_i2c_dev *i2c_dev)
+{
+	if (i2c_dev->dma_buf) {
+		dma_free_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
+			       i2c_dev->dma_buf, i2c_dev->dma_phys,
+			       DMA_ATTR_FORCE_CONTIGUOUS);
+		i2c_dev->dma_buf = NULL;
+	}
+
+	if (i2c_dev->tx_dma_chan) {
+		dma_release_channel(i2c_dev->tx_dma_chan);
+		i2c_dev->tx_dma_chan = NULL;
+	}
+
+	if (i2c_dev->rx_dma_chan) {
+		dma_release_channel(i2c_dev->rx_dma_chan);
+		i2c_dev->rx_dma_chan = NULL;
+	}
+}
+
+static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
+{
+	struct dma_chan *chan;
+	u32 *dma_buf;
+	dma_addr_t dma_phys;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) ||
+	    !i2c_dev->hw->has_apb_dma) {
+		err = -ENODEV;
+		goto err_out;
+	}
+
+	chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
+	if (IS_ERR(chan)) {
+		err = PTR_ERR(chan);
+		goto err_out;
+	}
+
+	i2c_dev->rx_dma_chan = chan;
+
+	chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
+	if (IS_ERR(chan)) {
+		err = PTR_ERR(chan);
+		goto err_out;
+	}
+
+	i2c_dev->tx_dma_chan = chan;
+
+	dma_buf = dma_alloc_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
+				  &dma_phys, GFP_KERNEL | __GFP_NOWARN,
+				  DMA_ATTR_FORCE_CONTIGUOUS);
+	if (!dma_buf) {
+		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	i2c_dev->dma_buf = dma_buf;
+	i2c_dev->dma_phys = dma_phys;
+	return 0;
+
+err_out:
+	tegra_i2c_release_dma(i2c_dev);
+	if (err != -EPROBE_DEFER) {
+		dev_err(i2c_dev->dev, "can't use DMA, err: %d, using PIO\n",
+			err);
+		return 0;
+	}
+
+	return err;
+}
+
 static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -571,16 +708,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 		i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);
 	}
 
-	if (i2c_dev->hw->has_mst_fifo) {
-		val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
-		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
-		i2c_writel(i2c_dev, val, I2C_MST_FIFO_CONTROL);
-	} else {
-		val = 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
-			0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
-		i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
-	}
-
 	err = tegra_i2c_flush_fifos(i2c_dev);
 	if (err)
 		goto err;
@@ -660,25 +787,37 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE))
 		goto err;
 
-	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
-		if (i2c_dev->msg_buf_remaining)
-			tegra_i2c_empty_rx_fifo(i2c_dev);
-		else
-			BUG();
-	}
+	if (!i2c_dev->is_curr_dma_xfer) {
+		if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
+			if (i2c_dev->msg_buf_remaining)
+				tegra_i2c_empty_rx_fifo(i2c_dev);
+			else
+				BUG();
+		}
 
-	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
-		if (i2c_dev->msg_buf_remaining)
-			tegra_i2c_fill_tx_fifo(i2c_dev);
-		else
-			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
+		if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
+			if (i2c_dev->msg_buf_remaining)
+				tegra_i2c_fill_tx_fifo(i2c_dev);
+			else
+				tegra_i2c_mask_irq(i2c_dev,
+						   I2C_INT_TX_FIFO_DATA_REQ);
+		}
 	}
 
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
+	/*
+	 * During message read XFER_COMPLETE interrupt is triggered prior to
+	 * DMA completion and during message write XFER_COMPLETE interrupt is
+	 * triggered after DMA completion.
+	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfer.
+	 * so forcing msg_buf_remaining to 0 in DMA mode.
+	 */
 	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
+		if (i2c_dev->is_curr_dma_xfer)
+			i2c_dev->msg_buf_remaining = 0;
 		BUG_ON(i2c_dev->msg_buf_remaining);
 		complete(&i2c_dev->msg_complete);
 	}
@@ -694,12 +833,91 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
+	if (i2c_dev->is_curr_dma_xfer) {
+		if (i2c_dev->msg_read)
+			dmaengine_terminate_async(i2c_dev->rx_dma_chan);
+		else
+			dmaengine_terminate_async(i2c_dev->tx_dma_chan);
+
+		complete(&i2c_dev->dma_complete);
+	}
+
 	complete(&i2c_dev->msg_complete);
 done:
 	spin_unlock(&i2c_dev->xfer_lock);
 	return IRQ_HANDLED;
 }
 
+static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
+				       size_t len)
+{
+	u32 val, reg;
+	u8 dma_burst = 0;
+	struct dma_slave_config slv_config = {0};
+	struct dma_chan *chan;
+	int ret;
+
+	if (i2c_dev->hw->has_mst_fifo)
+		reg = I2C_MST_FIFO_CONTROL;
+	else
+		reg = I2C_FIFO_CONTROL;
+	val = i2c_readl(i2c_dev, reg);
+
+	if (i2c_dev->is_curr_dma_xfer) {
+		if (len & 0xF)
+			dma_burst = 1;
+		else if (len & 0x10)
+			dma_burst = 4;
+		else
+			dma_burst = 8;
+
+		if (i2c_dev->msg_read) {
+			chan = i2c_dev->rx_dma_chan;
+			slv_config.src_addr = i2c_dev->base_phys +
+					      tegra_i2c_reg_addr(i2c_dev, I2C_RX_FIFO);
+			slv_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			slv_config.src_maxburst = dma_burst;
+
+			if (i2c_dev->hw->has_mst_fifo)
+				val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
+			else
+				val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
+		} else {
+			chan = i2c_dev->tx_dma_chan;
+			slv_config.dst_addr = i2c_dev->base_phys +
+					      tegra_i2c_reg_addr(i2c_dev, I2C_TX_FIFO);;
+			slv_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			slv_config.dst_maxburst = dma_burst;
+
+			if (i2c_dev->hw->has_mst_fifo)
+				val |= I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
+			else
+				val |= I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
+		}
+
+		slv_config.device_fc = true;
+		ret = dmaengine_slave_config(chan, &slv_config);
+		if (ret < 0) {
+			dev_err(i2c_dev->dev, "DMA slave config failed: %d\n",
+				ret);
+			dev_err(i2c_dev->dev, "fallbacking to PIO\n");
+			tegra_i2c_release_dma(i2c_dev);
+			i2c_dev->is_curr_dma_xfer = false;
+		} else {
+			goto out;
+		}
+	}
+
+	if (i2c_dev->hw->has_mst_fifo)
+		val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
+		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
+	else
+		val = I2C_FIFO_CONTROL_TX_TRIG(8) |
+		      I2C_FIFO_CONTROL_RX_TRIG(1);
+out:
+	i2c_writel(i2c_dev, val, reg);
+}
+
 static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
 {
 	int err;
@@ -744,6 +962,10 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	u32 int_mask;
 	unsigned long time_left;
 	unsigned long flags;
+	size_t xfer_size;
+	u32 *buffer = NULL;
+	int err = 0;
+	bool dma;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
@@ -753,19 +975,57 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	i2c_dev->msg_read = (msg->flags & I2C_M_RD);
 	reinit_completion(&i2c_dev->msg_complete);
 
+	if (i2c_dev->msg_read)
+		xfer_size = msg->len;
+	else
+		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
+
+	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
+	i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
+				    i2c_dev->dma_buf;
+	tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
+	dma = i2c_dev->is_curr_dma_xfer;
+
 	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
 
 	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
 	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+	if (dma) {
+		if (i2c_dev->msg_read) {
+			dma_sync_single_for_device(i2c_dev->dev,
+						   i2c_dev->dma_phys,
+						   xfer_size,
+						   DMA_FROM_DEVICE);
+			err = tegra_i2c_dma_submit(i2c_dev, xfer_size);
+			if (err < 0) {
+				dev_err(i2c_dev->dev,
+					"starting RX DMA failed, err %d\n",
+					err);
+				goto unlock;
+			}
+		} else {
+			dma_sync_single_for_cpu(i2c_dev->dev,
+						i2c_dev->dma_phys,
+						xfer_size,
+						DMA_TO_DEVICE);
+			buffer = i2c_dev->dma_buf;
+		}
+	}
 
 	packet_header = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
 			PACKET_HEADER0_PROTOCOL_I2C |
 			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
 			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+	if (dma && !i2c_dev->msg_read)
+		*buffer++ = packet_header;
+	else
+		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
 	packet_header = msg->len - 1;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+	if (dma && !i2c_dev->msg_read)
+		*buffer++ = packet_header;
+	else
+		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
 	packet_header = I2C_HEADER_IE_ENABLE;
 	if (end_state == MSG_END_CONTINUE)
@@ -782,23 +1042,80 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		packet_header |= I2C_HEADER_CONT_ON_NAK;
 	if (msg->flags & I2C_M_RD)
 		packet_header |= I2C_HEADER_READ;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
-
-	if (!(msg->flags & I2C_M_RD))
-		tegra_i2c_fill_tx_fifo(i2c_dev);
+	if (dma && !i2c_dev->msg_read)
+		*buffer++ = packet_header;
+	else
+		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+
+	if (!msg->flags & I2C_M_RD) {
+		if (dma) {
+			memcpy(buffer, msg->buf, msg->len);
+			dma_sync_single_for_device(i2c_dev->dev,
+						   i2c_dev->dma_phys,
+						   xfer_size,
+						   DMA_TO_DEVICE);
+			err = tegra_i2c_dma_submit(i2c_dev, xfer_size);
+			if (err < 0) {
+				dev_err(i2c_dev->dev,
+					"starting TX DMA failed, err %d\n",
+					err);
+				goto unlock;
+			}
+		} else {
+			tegra_i2c_fill_tx_fifo(i2c_dev);
+		}
+	}
 
 	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
 		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
-	if (msg->flags & I2C_M_RD)
-		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
-	else if (i2c_dev->msg_buf_remaining)
-		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+
+	if (!dma) {
+		if (msg->flags & I2C_M_RD)
+			int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
+		else if (i2c_dev->msg_buf_remaining)
+			int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+	}
 
 	tegra_i2c_unmask_irq(i2c_dev, int_mask);
-	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
 	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
 		i2c_readl(i2c_dev, I2C_INT_MASK));
 
+unlock:
+	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
+
+	if (dma) {
+		if (err)
+			return err;
+
+		time_left = wait_for_completion_timeout(
+						&i2c_dev->dma_complete,
+						TEGRA_I2C_TIMEOUT);
+
+		if (time_left == 0) {
+			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
+			dmaengine_terminate_sync(i2c_dev->msg_read ?
+						  i2c_dev->rx_dma_chan :
+						  i2c_dev->tx_dma_chan);
+			tegra_i2c_init(i2c_dev);
+			return -ETIMEDOUT;
+		}
+
+		if (i2c_dev->msg_read && i2c_dev->msg_err == I2C_ERR_NONE) {
+			dma_sync_single_for_cpu(i2c_dev->dev,
+						i2c_dev->dma_phys,
+						xfer_size,
+						DMA_FROM_DEVICE);
+			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
+			       msg->len);
+		}
+
+		if (i2c_dev->msg_err != I2C_ERR_NONE) {
+			dmaengine_synchronize(i2c_dev->msg_read ?
+					      i2c_dev->rx_dma_chan :
+					      i2c_dev->tx_dma_chan);
+		}
+	}
+
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
 						TEGRA_I2C_TIMEOUT);
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
@@ -814,6 +1131,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		time_left, completion_done(&i2c_dev->msg_complete),
 		i2c_dev->msg_err);
 
+	i2c_dev->is_curr_dma_xfer = false;
 	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
 		return 0;
 
@@ -920,6 +1238,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -935,6 +1254,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -950,6 +1270,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -965,6 +1286,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -980,6 +1302,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -995,6 +1318,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.has_mst_fifo = true,
 	.quirks = &tegra194_i2c_quirks,
 	.supports_bus_clear = true,
+	.has_apb_dma = false,
 };
 
 /* Match table for of_platform binding */
@@ -1017,11 +1341,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	struct clk *div_clk;
 	struct clk *fast_clk;
 	void __iomem *base;
+	phys_addr_t base_phys;
 	int irq;
 	int ret = 0;
 	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base_phys = res->start;
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1044,6 +1370,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i2c_dev->base = base;
+	i2c_dev->base_phys = base_phys;
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.retries = 1;
@@ -1063,7 +1390,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
 						  "nvidia,tegra20-i2c-dvc");
 	i2c_dev->adapter.quirks = i2c_dev->hw->quirks;
+	i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_write_len;
 	init_completion(&i2c_dev->msg_complete);
+	init_completion(&i2c_dev->dma_complete);
 	spin_lock_init(&i2c_dev->xfer_lock);
 
 	if (!i2c_dev->hw->has_single_clk_source) {
@@ -1124,6 +1453,10 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = tegra_i2c_init_dma(i2c_dev);
+	if (ret < 0)
+		goto disable_div_clk;
+
 	ret = tegra_i2c_init(i2c_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
@@ -1188,6 +1521,7 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 	if (!i2c_dev->hw->has_single_clk_source)
 		clk_unprepare(i2c_dev->fast_clk);
 
+	tegra_i2c_release_dma(i2c_dev);
 	return 0;
 }
 
@@ -1211,18 +1545,7 @@ static struct platform_driver tegra_i2c_driver = {
 	},
 };
 
-static int __init tegra_i2c_init_driver(void)
-{
-	return platform_driver_register(&tegra_i2c_driver);
-}
-
-static void __exit tegra_i2c_exit_driver(void)
-{
-	platform_driver_unregister(&tegra_i2c_driver);
-}
-
-subsys_initcall(tegra_i2c_init_driver);
-module_exit(tegra_i2c_exit_driver);
+module_platform_driver(tegra_i2c_driver);
 
 MODULE_DESCRIPTION("nVidia Tegra2 I2C Bus Controller driver");
 MODULE_AUTHOR("Colin Cross");
-- 
2.7.4

