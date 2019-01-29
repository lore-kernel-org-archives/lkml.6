Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282EAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E60218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HDc9Q5jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfA2XRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:17:54 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14914 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfA2XRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:17:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c50df030000>; Tue, 29 Jan 2019 15:17:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 15:17:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 15:17:50 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 23:17:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 23:17:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c50df1d0007>; Tue, 29 Jan 2019 15:17:50 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Date:   Tue, 29 Jan 2019 15:16:09 -0800
Message-ID: <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548803843; bh=BC8pSR3YYXnpg9ojywazQ3Peu/J2Z/EQZEdRiH2oFok=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=HDc9Q5jx4Hw3X7SRa0ua19RSN3FoUdtp7R6MJO/kRCveACdJdB/FtQfM2rDk8WMdF
         5Us287rI4DyQYixVpr956c1HVXnNRVsKKPFLfiZJCIQSZoJD7vdogNfCzvAqoeCNLJ
         faQ3bROwGqIP8XsinvzIzgqFcvvRYho7QRN8gqWbQgv0EqyQRwadSFLalrDdzxtV6G
         VsV6Elm0bpdxElQF7h/1un0IQ+5wePpJEpRokcyu8W6XKLvakh8hhFEZu/1pF1o7qd
         1qE2O+XJepPaG6Cto4Plw5nOfyH1Tb3QGX+ZcF6UkLtfhNAeoKbXQnsFQ2MA+2W1RR
         5Fjo8xCRcMQGQ==
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
 [V5] : Same as V4
 [V4] : Updated to allocate DMA buffer only when DMA mode.
	Updated to fall back to PIO mode when DMA channel request or
	buffer allocation fails.
 [V3] : Updated without additional buffer allocation.
 [V2] : Updated based on V1 review feedback along with code cleanup for
	proper implementation of DMA.

 drivers/i2c/busses/i2c-tegra.c | 359 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 334 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c4892a47a483..651b55fd9aa5 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -8,6 +8,9 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -44,6 +47,8 @@
 #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
 #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
 #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
+#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
+#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
 #define I2C_FIFO_STATUS				0x060
 #define I2C_FIFO_STATUS_TX_MASK			0xF0
 #define I2C_FIFO_STATUS_TX_SHIFT		4
@@ -125,6 +130,19 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
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
@@ -188,6 +206,7 @@ struct tegra_i2c_hw_feature {
  * @fast_clk: clock reference for fast clock of I2C controller
  * @rst: reset control for the I2C controller
  * @base: ioremapped registers cookie
+ * @phys_addr: Physical address of I2C base address to use for DMA configuration
  * @cont_id: I2C controller ID, used for packet header
  * @irq: IRQ number of transfer complete interrupt
  * @irq_disabled: used to track whether or not the interrupt is enabled
@@ -201,6 +220,14 @@ struct tegra_i2c_hw_feature {
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
@@ -210,6 +237,7 @@ struct tegra_i2c_dev {
 	struct clk *fast_clk;
 	struct reset_control *rst;
 	void __iomem *base;
+	phys_addr_t phys_addr;
 	int cont_id;
 	int irq;
 	bool irq_disabled;
@@ -223,8 +251,18 @@ struct tegra_i2c_dev {
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
@@ -291,6 +329,81 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
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
+	if (IS_ERR(dma_chan)) {
+		dev_err(i2c_dev->dev, "DMA Channel not available\n");
+		return PTR_ERR(dma_chan);
+	}
+
+	if (!i2c_dev->dma_buf) {
+		dma_buf = dma_alloc_coherent(i2c_dev->dev,
+					     i2c_dev->dma_buf_size,
+					     &dma_phys, GFP_KERNEL);
+
+		if (!dma_buf) {
+			dev_err(i2c_dev->dev,
+				"Failed to allocate the DMA buffer\n");
+			ret = -ENOMEM;
+			goto scrub;
+		}
+
+		i2c_dev->dma_buf = dma_buf;
+		i2c_dev->dma_phys = dma_phys;
+	}
+
+	if (dma_to_memory)
+		i2c_dev->rx_dma_chan = dma_chan;
+	else
+		i2c_dev->tx_dma_chan = dma_chan;
+
+	return 0;
+
+scrub:
+	dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size, dma_buf,
+			  dma_phys);
+	dma_release_channel(dma_chan);
+	return ret;
+}
+
 static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -656,25 +769,45 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
@@ -683,19 +816,70 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	/* An error occurred, mask all interrupts */
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
-		I2C_INT_RX_FIFO_DATA_REQ);
+		I2C_INT_RX_FIFO_DATA_REQ | I2C_INT_ALL_PACKETS_XFER_COMPLETE);
 	if (i2c_dev->hw->supports_bus_clear)
 		tegra_i2c_mask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
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
 static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
 {
 	int err;
@@ -740,6 +924,32 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	u32 int_mask;
 	unsigned long time_left;
 	unsigned long flags;
+	size_t xfer_size;
+	u32 *buffer = 0;
+	int ret = 0;
+	bool dma = false;
+
+	if (msg->flags & I2C_M_RD)
+		xfer_size = msg->len;
+	else
+		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
+
+	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
+	dma = i2c_dev->has_dma && (xfer_size > I2C_PIO_MODE_MAX_LEN);
+	if (dma) {
+		if ((msg->flags & I2C_M_RD) && !i2c_dev->rx_dma_chan)
+			ret = tegra_i2c_init_dma_param(i2c_dev, true);
+		else if (!i2c_dev->tx_dma_chan)
+			ret = tegra_i2c_init_dma_param(i2c_dev, false);
+
+		if (ret < 0) {
+			dev_dbg(i2c_dev->dev, "Switching to PIO mode\n");
+			dma = false;
+			ret = 0;
+		}
+	}
+
+	i2c_dev->is_curr_dma_xfer = dma;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
@@ -754,14 +964,50 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
 	tegra_i2c_unmask_irq(i2c_dev, int_mask);
 
+	if (dma) {
+		if (i2c_dev->msg_read) {
+			chan = i2c_dev->rx_dma_chan;
+			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
+						   DATA_DMA_DIR_RX);
+			/* make the dma buffer to read by dma */
+			dma_sync_single_for_device(i2c_dev->dev,
+						   i2c_dev->dma_phys,
+						   i2c_dev->dma_buf_size,
+						   DMA_FROM_DEVICE);
+			ret = tegra_i2c_dma_submit(i2c_dev, xfer_size);
+			if (ret < 0) {
+				dev_err(i2c_dev->dev,
+					"Starting RX DMA failed, err %d\n",
+					ret);
+				goto exit;
+			}
+		} else {
+			chan = i2c_dev->tx_dma_chan;
+			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
+						   DATA_DMA_DIR_TX);
+			/* Make the dma buffer to read by cpu */
+			dma_sync_single_for_cpu(i2c_dev->dev,
+						i2c_dev->dma_phys,
+						i2c_dev->dma_buf_size,
+						DMA_TO_DEVICE);
+			buffer = (u32 *)i2c_dev->dma_buf;
+		}
+	}
+
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
@@ -778,29 +1024,85 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		packet_header |= I2C_HEADER_CONT_ON_NAK;
 	if (msg->flags & I2C_M_RD)
 		packet_header |= I2C_HEADER_READ;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
-
-	if (!(msg->flags & I2C_M_RD))
-		tegra_i2c_fill_tx_fifo(i2c_dev);
-
+	if (dma && !i2c_dev->msg_read)
+		*buffer++ = packet_header;
+	else
+		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+
+	if (!i2c_dev->msg_read) {
+		if (dma) {
+			memcpy(buffer, msg->buf, msg->len);
+			/* make the dma buffer to read by dma */
+			dma_sync_single_for_device(i2c_dev->dev,
+						   i2c_dev->dma_phys,
+						   i2c_dev->dma_buf_size,
+						   DMA_TO_DEVICE);
+			ret = tegra_i2c_dma_submit(i2c_dev, xfer_size);
+			if (ret < 0) {
+				dev_err(i2c_dev->dev,
+					"Starting TX DMA failed, err %d\n",
+					ret);
+				goto exit;
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
+	if (dma) {
+		int_mask |= I2C_INT_ALL_PACKETS_XFER_COMPLETE;
+	} else {
+		if (msg->flags & I2C_M_RD)
+			int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
+		else if (i2c_dev->msg_buf_remaining)
+			int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+	}
 
 	tegra_i2c_unmask_irq(i2c_dev, int_mask);
-	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
 	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
 		i2c_readl(i2c_dev, I2C_INT_MASK));
 
+exit:
+	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
+	if (ret)
+		return ret;
+
+	if (dma) {
+		time_left = wait_for_completion_timeout(
+						&i2c_dev->dma_complete,
+						TEGRA_I2C_TIMEOUT);
+
+		if (time_left == 0) {
+			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
+			dmaengine_terminate_all(chan);
+			tegra_i2c_init(i2c_dev);
+			return -ETIMEDOUT;
+		}
+
+		if (i2c_dev->msg_read) {
+			if (likely(i2c_dev->msg_err == I2C_ERR_NONE)) {
+				dma_sync_single_for_cpu(i2c_dev->dev,
+							i2c_dev->dma_phys,
+							i2c_dev->dma_buf_size,
+							DMA_FROM_DEVICE);
+
+				memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
+					msg->len);
+			}
+		}
+	}
+
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
 						TEGRA_I2C_TIMEOUT);
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
 
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
+		if (dma) {
+			dmaengine_terminate_all(chan);
+			complete(&i2c_dev->dma_complete);
+		}
 
 		tegra_i2c_init(i2c_dev);
 		return -ETIMEDOUT;
@@ -884,6 +1186,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 
 	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
 			"multi-master");
+
+	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
 }
 
 static const struct i2c_algorithm tegra_i2c_algo = {
@@ -1002,11 +1306,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
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
@@ -1029,6 +1335,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i2c_dev->base = base;
+	i2c_dev->phys_addr = phys_addr;
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.quirks = &tegra_i2c_quirks;
@@ -1036,6 +1343,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
+	i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_write_len;
 
 	i2c_dev->rst = devm_reset_control_get_exclusive(&pdev->dev, "i2c");
 	if (IS_ERR(i2c_dev->rst)) {
@@ -1049,6 +1357,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
 						  "nvidia,tegra20-i2c-dvc");
 	init_completion(&i2c_dev->msg_complete);
+	init_completion(&i2c_dev->dma_complete);
 	spin_lock_init(&i2c_dev->xfer_lock);
 
 	if (!i2c_dev->hw->has_single_clk_source) {
-- 
2.7.4

