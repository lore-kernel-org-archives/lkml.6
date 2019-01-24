Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C48C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5DB218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gEWM5HNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAXUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:52:06 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2173 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAXUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:52:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4a255e0000>; Thu, 24 Jan 2019 12:51:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 12:52:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 12:52:00 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 20:52:00 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 20:52:00 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4a25700001>; Thu, 24 Jan 2019 12:52:00 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Date:   Thu, 24 Jan 2019 12:51:52 -0800
Message-ID: <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548363102; bh=yFvwMRRAsJMqY01OOBxSBgTVcbKZm4ipvpLI/FUXNNM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gEWM5HNiRXQW432IBRIDIWOxlfv0mslqOP1tkHL42pJIauvs3ORmdKYXeev0DAK56
         ZNhYBMZ7i8ZJgPXVjNo33/1zfhDvoOz+5gri+cc082EgIMYBkJ5YcMrncXyGiL4eaA
         WSSJ6BFuHY0ihMI8Nho5oc4dfmvOirQZYE6z9M90VtTlKQr3Mmhbnbn+gku0AmrGZ+
         Tb362hW0VTdtvuY5+wB+GFkiSj+7r411PljmLYZAksP0sgZFfGsmNzyvRaWZfkiwCB
         C+XNUzeLj9W/Y4kBvXT+t/8235DCw/mPNjIH6znnw0xEvp9EFoH7OUcw4FZin9VGnJ
         mF9tikbZ3Avow==
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
same transaction adding overhead on CPU for large transfers.

DMA mode is helpful for Large transfers during downloading or
uploading FW over I2C to some external devices.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V2] : Updated based on V1 review feedback along with code cleanup for
	proper implementation of DMA.

 drivers/i2c/busses/i2c-tegra.c | 366 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 349 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 13bce1411ddc..769700d5a7f3 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -9,6 +9,9 @@
 #include <asm/unaligned.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -46,6 +49,8 @@
 #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
 #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
 #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
+#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
+#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
 #define I2C_FIFO_STATUS				0x060
 #define I2C_FIFO_STATUS_TX_MASK			0xF0
 #define I2C_FIFO_STATUS_TX_SHIFT		4
@@ -120,6 +125,16 @@
 /* Packet header size in bytes */
 #define I2C_PACKET_HEADER_SIZE			12
 
+#define DATA_DMA_DIR_TX				(1 << 0)
+#define DATA_DMA_DIR_RX				(1 << 1)
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
@@ -180,6 +195,7 @@ struct tegra_i2c_hw_feature {
  * @fast_clk: clock reference for fast clock of I2C controller
  * @rst: reset control for the I2C controller
  * @base: ioremapped registers cookie
+ * @phys_addr: Physical address of I2C base address to use for DMA configuration
  * @cont_id: I2C controller ID, used for packet header
  * @irq: IRQ number of transfer complete interrupt
  * @irq_disabled: used to track whether or not the interrupt is enabled
@@ -193,6 +209,14 @@ struct tegra_i2c_hw_feature {
  * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
  * @is_multimaster_mode: track if I2C controller is in multi-master mode
  * @xfer_lock: lock to serialize transfer submission and processing
+ * @has_dma: indicated if controller supports DMA
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
@@ -202,6 +226,7 @@ struct tegra_i2c_dev {
 	struct clk *fast_clk;
 	struct reset_control *rst;
 	void __iomem *base;
+	phys_addr_t phys_addr;
 	int cont_id;
 	int irq;
 	bool irq_disabled;
@@ -215,8 +240,18 @@ struct tegra_i2c_dev {
 	u16 clk_divisor_non_hs_mode;
 	bool is_multimaster_mode;
 	spinlock_t xfer_lock;
+	bool has_dma;
+	struct dma_chan *tx_dma_chan;
+	struct dma_chan *rx_dma_chan;
+	dma_addr_t dma_phys;
+	u32 *dma_buf;
+	unsigned int dma_buf_size;
+	bool is_curr_dma_xfer;
+	struct completion dma_complete;
 };
 
+static struct dma_chan *chan;
+
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
 		       unsigned long reg)
 {
@@ -283,6 +318,75 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
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
+
+	dev_dbg(i2c_dev->dev, "Starting DMA for length: %zu\n", len);
+	reinit_completion(&i2c_dev->dma_complete);
+	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
+	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
+					       len, dir, DMA_PREP_INTERRUPT |
+					       DMA_CTRL_ACK);
+	if (!dma_desc) {
+		dev_err(i2c_dev->dev, "Failed to get DMA descriptor\n");
+		return -EIO;
+	}
+
+	dma_desc->callback = tegra_i2c_dma_complete;
+	dma_desc->callback_param = i2c_dev;
+	dmaengine_submit(dma_desc);
+	dma_async_issue_pending(chan);
+	return 0;
+}
+
+static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
+				    bool dma_to_memory)
+{
+	struct dma_chan *dma_chan;
+	u32 *dma_buf;
+	dma_addr_t dma_phys;
+	int ret;
+	const char *chan_name = dma_to_memory ? "rx" : "tx";
+
+	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, chan_name);
+	if (IS_ERR(dma_chan))
+		return PTR_ERR(dma_chan);
+
+	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
+				     &dma_phys, GFP_KERNEL);
+
+	if (!dma_buf) {
+		dev_err(i2c_dev->dev, "Failed to allocate the DMA buffer\n");
+		ret = -ENOMEM;
+		goto scrub;
+	}
+
+	if (dma_to_memory)
+		i2c_dev->rx_dma_chan = dma_chan;
+	else
+		i2c_dev->tx_dma_chan = dma_chan;
+
+	i2c_dev->dma_buf = dma_buf;
+	i2c_dev->dma_phys = dma_phys;
+
+	return 0;
+
+scrub:
+	dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
+			  dma_buf, dma_phys);
+	dma_release_channel(dma_chan);
+	return ret;
+}
+
 static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -529,6 +633,8 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 		return err;
 	}
 
+	i2c_dev->is_curr_dma_xfer = false;
+
 	reset_control_assert(i2c_dev->rst);
 	udelay(2);
 	reset_control_deassert(i2c_dev->rst);
@@ -642,25 +748,45 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 		goto err;
 	}
 
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
+		if (!i2c_dev->msg_read &&
+		   (status & I2C_INT_TX_FIFO_DATA_REQ)) {
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
 
-	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
+	if (status & I2C_INT_ALL_PACKETS_XFER_COMPLETE) {
+	/*
+	 * During message read XFER_COMPLETE interrupt is triggered prior to
+	 * DMA complete notification and during message write XFER_COMPLETE
+	 * interrupt is triggered after DMA complete notification.
+	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfer.
+	 * so forcing msg_buf_remaining to 0.
+	 */
+		if (i2c_dev->is_curr_dma_xfer)
+			i2c_dev->msg_buf_remaining = 0;
+		status |= I2C_INT_PACKET_XFER_COMPLETE;
+		i2c_writel(i2c_dev, status, I2C_INT_STATUS);
+		if (!i2c_dev->msg_buf_remaining)
+			complete(&i2c_dev->msg_complete);
+	} else if (status & I2C_INT_PACKET_XFER_COMPLETE) {
+		if (i2c_dev->is_curr_dma_xfer)
+			i2c_dev->msg_buf_remaining = 0;
 		BUG_ON(i2c_dev->msg_buf_remaining);
 		complete(&i2c_dev->msg_complete);
 	}
@@ -669,17 +795,161 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	/* An error occurred, mask all interrupts */
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
-		I2C_INT_RX_FIFO_DATA_REQ);
+		I2C_INT_RX_FIFO_DATA_REQ | I2C_INT_ALL_PACKETS_XFER_COMPLETE);
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
+	if (i2c_dev->is_curr_dma_xfer) {
+		dmaengine_terminate_all(chan);
+		complete(&i2c_dev->dma_complete);
+	}
+
 	complete(&i2c_dev->msg_complete);
 done:
 	spin_unlock(&i2c_dev->xfer_lock);
 	return IRQ_HANDLED;
 }
 
+static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
+				       size_t len, int direction)
+{
+	u32 val, reg;
+	u8 dma_burst = 0;
+	struct dma_slave_config dma_sconfig;
+
+	if (i2c_dev->hw->has_mst_fifo)
+		reg = I2C_MST_FIFO_CONTROL;
+	else
+		reg = I2C_FIFO_CONTROL;
+	val = i2c_readl(i2c_dev, reg);
+
+	if (len & 0xF)
+		dma_burst = 1;
+	else if (len & 0x10)
+		dma_burst = 4;
+	else
+		dma_burst = 8;
+
+	if (direction == DATA_DMA_DIR_TX) {
+		if (i2c_dev->hw->has_mst_fifo)
+			val |= I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
+		else
+			val |= I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
+	} else {
+		if (i2c_dev->hw->has_mst_fifo)
+			val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
+		else
+			val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
+	}
+	i2c_writel(i2c_dev, val, reg);
+
+	if (direction == DATA_DMA_DIR_TX) {
+		dma_sconfig.dst_addr = i2c_dev->phys_addr + I2C_TX_FIFO;
+		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.dst_maxburst = dma_burst;
+	} else {
+		dma_sconfig.src_addr = i2c_dev->phys_addr + I2C_RX_FIFO;
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.src_maxburst = dma_burst;
+	}
+
+	dmaengine_slave_config(chan, &dma_sconfig);
+}
+
+static int tegra_i2c_start_dma_xfer(struct tegra_i2c_dev *i2c_dev)
+{
+	u32 *buffer = (u32 *)i2c_dev->msg_buf;
+	unsigned long time_left, flags;
+	int ret = 0;
+	u32 int_mask;
+	size_t tx_len = 0;
+	size_t rx_len = 0;
+
+	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
+	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+
+	if (i2c_dev->msg_read) {
+		chan = i2c_dev->rx_dma_chan;
+		rx_len = ALIGN(i2c_dev->msg_buf_remaining,
+							BYTES_PER_FIFO_WORD);
+
+		tegra_i2c_config_fifo_trig(i2c_dev, rx_len, DATA_DMA_DIR_RX);
+		/* make the dma buffer to read by dma */
+		dma_sync_single_for_device(i2c_dev->dev, i2c_dev->dma_phys,
+					   i2c_dev->dma_buf_size,
+					   DMA_FROM_DEVICE);
+
+		ret = tegra_i2c_dma_submit(i2c_dev, rx_len);
+		if (ret < 0) {
+			dev_err(i2c_dev->dev,
+				"Starting RX DMA failed, err %d\n", ret);
+			goto exit;
+		}
+
+		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+	} else {
+		chan = i2c_dev->tx_dma_chan;
+		tx_len = ALIGN(i2c_dev->msg_buf_remaining,
+				BYTES_PER_FIFO_WORD) + I2C_PACKET_HEADER_SIZE;
+
+		tegra_i2c_config_fifo_trig(i2c_dev, tx_len, DATA_DMA_DIR_TX);
+		/* Make the dma buffer to read by cpu */
+		dma_sync_single_for_cpu(i2c_dev->dev, i2c_dev->dma_phys,
+					i2c_dev->dma_buf_size, DMA_TO_DEVICE);
+
+		memcpy(i2c_dev->dma_buf, buffer, tx_len);
+		/* make the dma buffer to read by dma */
+		dma_sync_single_for_device(i2c_dev->dev, i2c_dev->dma_phys,
+					   i2c_dev->dma_buf_size,
+					   DMA_TO_DEVICE);
+
+		ret = tegra_i2c_dma_submit(i2c_dev, tx_len);
+		if (ret < 0) {
+			dev_err(i2c_dev->dev,
+				"Starting TX DMA failed, err %d\n", ret);
+			goto exit;
+		}
+	}
+
+	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
+		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
+	int_mask |= I2C_INT_ALL_PACKETS_XFER_COMPLETE;
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+
+exit:
+	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
+	if (ret)
+		return ret;
+
+	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
+		i2c_readl(i2c_dev, I2C_INT_MASK));
+
+	time_left = wait_for_completion_timeout(&i2c_dev->dma_complete,
+						TEGRA_I2C_TIMEOUT);
+	if (time_left == 0) {
+		dev_err(i2c_dev->dev, "DMA transfer timeout\n");
+		dmaengine_terminate_all(chan);
+		return -ETIMEDOUT;
+	}
+
+	if (i2c_dev->msg_read) {
+		if (likely(i2c_dev->msg_err == I2C_ERR_NONE)) {
+			dma_sync_single_for_cpu(i2c_dev->dev,
+						i2c_dev->dma_phys,
+						i2c_dev->dma_buf_size,
+						DMA_FROM_DEVICE);
+
+			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf, rx_len);
+		}
+	}
+
+	return 0;
+}
+
 static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev)
 {
 	u32 *buffer = (u32 *)i2c_dev->msg_buf;
@@ -695,7 +965,7 @@ static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev)
 	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
 	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
 
-	i2c_dev->msg_buf = (u8 *) buffer;
+	i2c_dev->msg_buf = (u8 *)buffer;
 
 	if (!i2c_dev->msg_read)
 		tegra_i2c_fill_tx_fifo(i2c_dev);
@@ -723,12 +993,25 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	unsigned long time_left;
 	u32 *buffer;
 	int ret = 0;
+	size_t xfer_size = 0;
+	bool dma = false;
 
 	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
-					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
+			 I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
+	if (msg->flags & I2C_M_RD)
+		xfer_size = msg->len;
+	else
+		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
+			    I2C_PACKET_HEADER_SIZE;
+
+	dma = ((xfer_size > I2C_PIO_MODE_MAX_LEN) &&
+		i2c_dev->tx_dma_chan && i2c_dev->rx_dma_chan);
+
+	i2c_dev->is_curr_dma_xfer = dma;
+
 	tegra_i2c_flush_fifos(i2c_dev);
 
 	i2c_dev->msg_buf = (u8 *)buffer;
@@ -764,12 +1047,24 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (!(msg->flags & I2C_M_RD))
 		memcpy(buffer, msg->buf, msg->len);
 
-	tegra_i2c_start_pio_xfer(i2c_dev);
+	if (dma)
+		ret = tegra_i2c_start_dma_xfer(i2c_dev);
+	else
+		ret = tegra_i2c_start_pio_xfer(i2c_dev);
+
+	if (ret == -EIO)
+		goto err_xfer;
+	else if (ret == -ETIMEDOUT)
+		goto end_xfer;
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
 						TEGRA_I2C_TIMEOUT);
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
+		if (i2c_dev->is_curr_dma_xfer) {
+			dmaengine_terminate_all(chan);
+			complete(&i2c_dev->dma_complete);
+		}
 
 		tegra_i2c_init(i2c_dev);
 		ret = -ETIMEDOUT;
@@ -777,12 +1072,20 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	}
 
 	if (i2c_dev->msg_read) {
-		i2c_dev->msg_buf = (u8 *)buffer;
+		if (!dma)
+			i2c_dev->msg_buf = (u8 *)buffer;
 		memcpy(msg->buf, i2c_dev->msg_buf, msg->len);
 	}
 
+end_xfer:
 	int_mask = i2c_readl(i2c_dev, I2C_INT_MASK);
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
+	if (i2c_dev->is_curr_dma_xfer && (ret < 0)) {
+		dev_err(i2c_dev->dev, "i2c DMA transfer failed\n");
+		tegra_i2c_init(i2c_dev);
+		ret = -ETIMEDOUT;
+		goto err_xfer;
+	}
 
 	dev_dbg(i2c_dev->dev, "transfer complete: %lu %d %d\n",
 		time_left, completion_done(&i2c_dev->msg_complete),
@@ -819,6 +1122,19 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		return ret;
 	}
 
+	if (i2c_dev->has_dma) {
+		if (!i2c_dev->rx_dma_chan) {
+			ret = tegra_i2c_init_dma_param(i2c_dev, true);
+			if (ret < 0)
+				return ret;
+		}
+		if (!i2c_dev->tx_dma_chan) {
+			ret = tegra_i2c_init_dma_param(i2c_dev, false);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	for (i = 0; i < num; i++) {
 		enum msg_end_type end_type = MSG_END_STOP;
 
@@ -861,6 +1177,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 
 	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
 			"multi-master");
+
+	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
 }
 
 static const struct i2c_algorithm tegra_i2c_algo = {
@@ -973,11 +1291,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	struct clk *div_clk;
 	struct clk *fast_clk;
 	void __iomem *base;
+	phys_addr_t phys_addr;
 	int irq;
 	int ret = 0;
 	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phys_addr = res->start;
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1000,12 +1320,14 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i2c_dev->base = base;
+	i2c_dev->phys_addr = phys_addr;
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.quirks = &tegra_i2c_quirks;
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
+	i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_write_len;
 
 	i2c_dev->rst = devm_reset_control_get_exclusive(&pdev->dev, "i2c");
 	if (IS_ERR(i2c_dev->rst)) {
@@ -1020,6 +1342,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 						  "nvidia,tegra20-i2c-dvc");
 	init_completion(&i2c_dev->msg_complete);
 	spin_lock_init(&i2c_dev->xfer_lock);
+	init_completion(&i2c_dev->dma_complete);
 
 	if (!i2c_dev->hw->has_single_clk_source) {
 		fast_clk = devm_clk_get(&pdev->dev, "fast-clk");
@@ -1079,6 +1402,15 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (i2c_dev->has_dma) {
+		ret = tegra_i2c_init_dma_param(i2c_dev, true);
+		if (ret == -EPROBE_DEFER)
+			goto disable_div_clk;
+		ret = tegra_i2c_init_dma_param(i2c_dev, false);
+		if (ret == -EPROBE_DEFER)
+			goto disable_div_clk;
+	}
+
 	ret = tegra_i2c_init(i2c_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
-- 
2.7.4

