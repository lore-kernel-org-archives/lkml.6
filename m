Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268E920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FRNzfNm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfAOTAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:00:16 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17222 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbfAOTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:00:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3e2da60000>; Tue, 15 Jan 2019 10:59:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 11:00:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 11:00:10 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 19:00:10 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 19:00:10 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 19:00:10 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c3e2db8000c>; Tue, 15 Jan 2019 11:00:08 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] i2c: tegra: Add DMA Support
Date:   Tue, 15 Jan 2019 11:00:06 -0800
Message-ID: <1547578806-17923-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547578790; bh=41ssgmolSxdsFmg66s5vUI9fYSvHinipMkjUOMfhzNs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=FRNzfNm301BxqTMls5w2BHqmxevyxXiNLmnFiZUEt7eZI8lUvJcvFhHyOmMYt7KOs
         fGrLhn88jNBkE5yXshV159C90NKFTHo4a09nZgcxUJdThtKAChmN5V5uzAfKAC6Eck
         rfowAvhU1I66r5H2Oo1YHOtIjIGVX+4oGX+WDCaFniYOhE5nPNwYLfbhgA1wjaQG+X
         14SwKm47ZZIvZ3FdEZQ/1dqsK8hAurNA/lw1uBLU/iGwQlXieZXhtbsbRO5nmflnFV
         Ap1kuwrPTPokuQD7kv09K5k3OjCsH8DsQ4oIIvJPDtiAxzLlDw3KrjF6GZB/CDq2g5
         6fbVicJnwa+lw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DMA support for Tegra I2C.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 494 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 456 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e417ebf7628c..abb576acc610 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -22,6 +22,9 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 
 #include <asm/unaligned.h>
 
@@ -47,6 +50,8 @@
 #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
 #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
 #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
+#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) <<  2)
+#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
 #define I2C_FIFO_STATUS				0x060
 #define I2C_FIFO_STATUS_TX_MASK			0xF0
 #define I2C_FIFO_STATUS_TX_SHIFT		4
@@ -118,6 +123,18 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+#define DATA_DMA_DIR_TX				(1 << 0)
+#define DATA_DMA_DIR_RX				(1 << 1)
+
+/* Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
+ * above this, controller will use DMA to fill FIFO.
+ * Here MAX PIO len is 20 bytes excluding packet header
+ */
+#define I2C_PIO_MODE_MAX_LEN			(32)
+
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			(12)
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -191,6 +208,19 @@ struct tegra_i2c_hw_feature {
  * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
  * @is_multimaster_mode: track if I2C controller is in multi-master mode
  * @xfer_lock: lock to serialize transfer submission and processing
+ * @has_dma: indicated if controller supports dma
+ * @rx_dma_desc: dma receive descriptor
+ * @rx_dma_chan: dma receive channel
+ * @rx_dma_buf: dma receive buffer
+ * @rx_dma_phys: dma receive handle
+ * @tx_dma_desc: dma transmit descriptor
+ * @tx_dma_chan: dma transmit channel
+ * @tx_dma_buf: dma transmit buffer
+ * @tx_dma_phys: dma transmit handle
+ * @dma_buf_size: dma transfer buffer size
+ * @is_curr_dma_xfer: indicates active dma transfer
+ * @rx_dma_complete: dma receive completion notifier
+ * @tx_dma_complete: dma transmit completion notifier
  */
 struct tegra_i2c_dev {
 	struct device *dev;
@@ -200,6 +230,7 @@ struct tegra_i2c_dev {
 	struct clk *fast_clk;
 	struct reset_control *rst;
 	void __iomem *base;
+	phys_addr_t phys_addr;
 	int cont_id;
 	int irq;
 	bool irq_disabled;
@@ -213,6 +244,19 @@ struct tegra_i2c_dev {
 	u16 clk_divisor_non_hs_mode;
 	bool is_multimaster_mode;
 	spinlock_t xfer_lock;
+	bool has_dma;
+	struct dma_async_tx_descriptor *rx_dma_desc;
+	struct dma_chan *rx_dma_chan;
+	u32 *rx_dma_buf;
+	dma_addr_t rx_dma_phys;
+	struct dma_async_tx_descriptor *tx_dma_desc;
+	struct dma_chan *tx_dma_chan;
+	u32 *tx_dma_buf;
+	dma_addr_t tx_dma_phys;
+	unsigned int dma_buf_size;
+	bool is_curr_dma_xfer;
+	struct completion rx_dma_complete;
+	struct completion tx_dma_complete;
 };
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
@@ -265,6 +309,110 @@ static void i2c_readsl(struct tegra_i2c_dev *i2c_dev, void *data,
 	readsl(i2c_dev->base + tegra_i2c_reg_addr(i2c_dev, reg), data, len);
 }
 
+static void tegra_i2c_dma_complete(void *args)
+{
+	struct completion *dma_complete = args;
+
+	complete(dma_complete);
+}
+
+static int tegra_i2c_start_tx_dma(struct tegra_i2c_dev *i2c_dev, int len)
+{
+	reinit_completion(&i2c_dev->tx_dma_complete);
+	dev_dbg(i2c_dev->dev, "Starting tx dma for len:%d\n", len);
+	i2c_dev->tx_dma_desc = dmaengine_prep_slave_single(i2c_dev->tx_dma_chan,
+				i2c_dev->tx_dma_phys, len, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
+	if (!i2c_dev->tx_dma_desc) {
+		dev_err(i2c_dev->dev, "Not able to get desc for Tx\n");
+		return -EIO;
+	}
+
+	i2c_dev->tx_dma_desc->callback = tegra_i2c_dma_complete;
+	i2c_dev->tx_dma_desc->callback_param = &i2c_dev->tx_dma_complete;
+
+	dmaengine_submit(i2c_dev->tx_dma_desc);
+	dma_async_issue_pending(i2c_dev->tx_dma_chan);
+	return 0;
+}
+
+static int tegra_i2c_start_rx_dma(struct tegra_i2c_dev *i2c_dev, int len)
+{
+	reinit_completion(&i2c_dev->rx_dma_complete);
+	dev_dbg(i2c_dev->dev, "Starting rx dma for len:%d\n", len);
+	i2c_dev->rx_dma_desc = dmaengine_prep_slave_single(i2c_dev->rx_dma_chan,
+				i2c_dev->rx_dma_phys, len, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
+	if (!i2c_dev->rx_dma_desc) {
+		dev_err(i2c_dev->dev, "Not able to get desc for Rx\n");
+		return -EIO;
+	}
+
+	i2c_dev->rx_dma_desc->callback = tegra_i2c_dma_complete;
+	i2c_dev->rx_dma_desc->callback_param = &i2c_dev->rx_dma_complete;
+
+	dmaengine_submit(i2c_dev->rx_dma_desc);
+	dma_async_issue_pending(i2c_dev->rx_dma_chan);
+	return 0;
+}
+
+static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
+							bool dma_to_memory)
+{
+	struct dma_chan *dma_chan;
+	u32 *dma_buf;
+	dma_addr_t dma_phys;
+	int ret;
+	struct dma_slave_config dma_sconfig;
+
+	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev,
+						dma_to_memory ? "rx" : "tx");
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(i2c_dev->dev,
+				"Dma channel is not available: %d\n", ret);
+		return ret;
+	}
+	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
+			&dma_phys, GFP_KERNEL);
+	if (!dma_buf) {
+		dev_err(i2c_dev->dev, "Not able to allocate the dma buffer\n");
+		dma_release_channel(dma_chan);
+		return -ENOMEM;
+	}
+
+	if (dma_to_memory) {
+		dma_sconfig.src_addr = i2c_dev->phys_addr + I2C_RX_FIFO;
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.src_maxburst = 0;
+	} else {
+		dma_sconfig.dst_addr = i2c_dev->phys_addr + I2C_TX_FIFO;
+		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.dst_maxburst = 0;
+	}
+
+	ret = dmaengine_slave_config(dma_chan, &dma_sconfig);
+	if (ret)
+		goto scrub;
+	if (dma_to_memory) {
+		i2c_dev->rx_dma_chan = dma_chan;
+		i2c_dev->rx_dma_buf = dma_buf;
+		i2c_dev->rx_dma_phys = dma_phys;
+	} else {
+		i2c_dev->tx_dma_chan = dma_chan;
+		i2c_dev->tx_dma_buf = dma_buf;
+		i2c_dev->tx_dma_phys = dma_phys;
+	}
+	return 0;
+
+scrub:
+	dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
+							dma_buf, dma_phys);
+	dma_release_channel(dma_chan);
+	return ret;
+}
+
 static void tegra_i2c_mask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
 {
 	u32 int_mask;
@@ -527,6 +675,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 		return err;
 	}
 
+	i2c_dev->is_curr_dma_xfer = false;
 	reset_control_assert(i2c_dev->rst);
 	udelay(2);
 	reset_control_deassert(i2c_dev->rst);
@@ -640,14 +789,16 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 		goto err;
 	}
 
-	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
+	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ) &&
+						!i2c_dev->is_curr_dma_xfer) {
 		if (i2c_dev->msg_buf_remaining)
 			tegra_i2c_empty_rx_fifo(i2c_dev);
 		else
 			BUG();
 	}
 
-	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
+	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ) &&
+						!i2c_dev->is_curr_dma_xfer) {
 		if (i2c_dev->msg_buf_remaining)
 			tegra_i2c_fill_tx_fifo(i2c_dev);
 		else
@@ -658,7 +809,16 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
-	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
+	if (status & I2C_INT_ALL_PACKETS_XFER_COMPLETE) {
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
@@ -667,90 +827,318 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	/* An error occurred, mask all interrupts */
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
-		I2C_INT_RX_FIFO_DATA_REQ);
+		I2C_INT_RX_FIFO_DATA_REQ | I2C_INT_ALL_PACKETS_XFER_COMPLETE);
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
+	if (i2c_dev->is_curr_dma_xfer) {
+		if (i2c_dev->msg_read) {
+			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
+			complete(&i2c_dev->rx_dma_complete);
+		} else {
+			dmaengine_terminate_all(i2c_dev->tx_dma_chan);
+			complete(&i2c_dev->tx_dma_complete);
+		}
+	}
+
 	complete(&i2c_dev->msg_complete);
 done:
 	spin_unlock(&i2c_dev->xfer_lock);
 	return IRQ_HANDLED;
 }
 
+static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
+		int len, int direction)
+{
+	u32 val, reg;
+	u8 tx_burst = 0, rx_burst = 0;
+	struct dma_slave_config tx_dma_sconfig, rx_dma_sconfig;
+
+	if (i2c_dev->hw->has_mst_fifo)
+		reg = I2C_MST_FIFO_CONTROL;
+	else
+		reg = I2C_FIFO_CONTROL;
+	val = i2c_readl(i2c_dev, reg);
+
+	if (direction == DATA_DMA_DIR_TX) {
+		if (len & 0xF)
+			tx_burst = 1;
+		else if (((len) >> 4) & 0x1)
+			tx_burst = 4;
+		else
+			tx_burst = 8;
+		if (i2c_dev->hw->has_mst_fifo)
+			val |= I2C_MST_FIFO_CONTROL_TX_TRIG(tx_burst);
+		else
+			val |= I2C_FIFO_CONTROL_TX_TRIG(tx_burst);
+	}
+	if (direction == DATA_DMA_DIR_RX) {
+		if (len & 0xF)
+			rx_burst = 1;
+		else if (((len) >> 4) & 0x1)
+			rx_burst = 4;
+		else
+			rx_burst = 8;
+		if (i2c_dev->hw->has_mst_fifo)
+			val |= I2C_MST_FIFO_CONTROL_RX_TRIG(rx_burst);
+		else
+			val |= I2C_FIFO_CONTROL_RX_TRIG(rx_burst);
+	}
+	i2c_writel(i2c_dev, val, reg);
+
+	if (direction == DATA_DMA_DIR_TX) {
+		tx_dma_sconfig.dst_addr = i2c_dev->phys_addr + I2C_TX_FIFO;
+		tx_dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		tx_dma_sconfig.dst_maxburst = tx_burst;
+		dmaengine_slave_config(i2c_dev->tx_dma_chan, &tx_dma_sconfig);
+	}
+	if (direction == DATA_DMA_DIR_RX) {
+		rx_dma_sconfig.src_addr = i2c_dev->phys_addr + I2C_RX_FIFO;
+		rx_dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		rx_dma_sconfig.src_maxburst = rx_burst;
+		dmaengine_slave_config(i2c_dev->rx_dma_chan, &rx_dma_sconfig);
+	}
+}
+
+static int tegra_i2c_start_dma_xfer(struct tegra_i2c_dev *i2c_dev)
+{
+	u32 *buffer = (u32 *)i2c_dev->msg_buf;
+	unsigned long time_left, flags;
+	int ret = 0;
+	u32 int_mask;
+	u32 tx_len = 0;
+	u32 rx_len = 0;
+
+	if (i2c_dev->msg_read) {
+		tx_len = I2C_PACKET_HEADER_SIZE;
+		rx_len = ALIGN(i2c_dev->msg_buf_remaining,
+							BYTES_PER_FIFO_WORD);
+	} else {
+		tx_len = ALIGN(i2c_dev->msg_buf_remaining,
+				BYTES_PER_FIFO_WORD) + I2C_PACKET_HEADER_SIZE;
+		rx_len = 0;
+	}
+
+	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
+	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+
+	if (i2c_dev->msg_read) {
+		/* make the dma buffer to read by dma */
+		dma_sync_single_for_device(i2c_dev->dev, i2c_dev->rx_dma_phys,
+					i2c_dev->dma_buf_size, DMA_TO_DEVICE);
+		tegra_i2c_config_fifo_trig(i2c_dev, rx_len, DATA_DMA_DIR_RX);
+		ret = tegra_i2c_start_rx_dma(i2c_dev, rx_len);
+		if (ret < 0) {
+			dev_err(i2c_dev->dev,
+				"Starting rx dma failed, err %d\n", ret);
+			goto exit;
+		}
+		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+	} else {
+		/* Make the dma buffer to read by cpu */
+		dma_sync_single_for_cpu(i2c_dev->dev, i2c_dev->tx_dma_phys,
+				i2c_dev->dma_buf_size, DMA_TO_DEVICE);
+		memcpy(i2c_dev->tx_dma_buf, buffer, tx_len);
+		/* make the dma buffer to read by dma */
+		dma_sync_single_for_device(i2c_dev->dev, i2c_dev->tx_dma_phys,
+				i2c_dev->dma_buf_size, DMA_TO_DEVICE);
+
+		tegra_i2c_config_fifo_trig(i2c_dev, tx_len, DATA_DMA_DIR_TX);
+		ret = tegra_i2c_start_tx_dma(i2c_dev, tx_len);
+		if (ret < 0) {
+			dev_err(i2c_dev->dev,
+				"Starting tx dma failed, err %d\n", ret);
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
+	if (!i2c_dev->msg_read) {
+		time_left = wait_for_completion_timeout(
+					&i2c_dev->tx_dma_complete,
+					TEGRA_I2C_TIMEOUT);
+		if (time_left == 0) {
+			dev_err(i2c_dev->dev,
+					"tx dma timeout txlen:%d rxlen:%d\n",
+					tx_len, rx_len);
+			dmaengine_terminate_all(i2c_dev->tx_dma_chan);
+			return -ETIMEDOUT;
+		}
+	} else {
+		time_left = wait_for_completion_timeout(
+					&i2c_dev->rx_dma_complete,
+					TEGRA_I2C_TIMEOUT);
+		if (time_left == 0) {
+			dev_err(i2c_dev->dev,
+					"rx dma timeout txlen:%d rxlen:%d\n",
+					tx_len, rx_len);
+			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
+			return -ETIMEDOUT;
+		}
+		if (likely(i2c_dev->msg_err == I2C_ERR_NONE)) {
+			dma_sync_single_for_cpu(i2c_dev->dev,
+						i2c_dev->rx_dma_phys,
+						i2c_dev->dma_buf_size,
+						DMA_FROM_DEVICE);
+			memcpy(i2c_dev->msg_buf, i2c_dev->rx_dma_buf, rx_len);
+			dma_sync_single_for_device(i2c_dev->dev,
+						i2c_dev->rx_dma_phys,
+						i2c_dev->dma_buf_size,
+						DMA_FROM_DEVICE);
+		}
+	}
+	return 0;
+}
+
+static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev)
+{
+	u32 *buffer = (u32 *)i2c_dev->msg_buf;
+	unsigned long flags;
+	int ret = 0;
+	u32 int_mask;
+
+	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
+	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+
+	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+
+	i2c_dev->msg_buf = (u8 *) buffer;
+
+	if (!i2c_dev->msg_read)
+		tegra_i2c_fill_tx_fifo(i2c_dev);
+
+	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
+		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
+	if (i2c_dev->msg_read)
+		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
+	else if (i2c_dev->msg_buf_remaining)
+		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
+	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
+		i2c_readl(i2c_dev, I2C_INT_MASK));
+
+	return 0;
+}
+
 static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	struct i2c_msg *msg, enum msg_end_type end_state)
 {
-	u32 packet_header;
+	u32 val = 0;
+	u32 *buffer;
 	u32 int_mask;
 	unsigned long time_left;
 	unsigned long flags;
+	int ret = 0;
+	u32 xfer_size = 0;
+	bool dma = false;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
-	i2c_dev->msg_buf = msg->buf;
+	if (msg->flags & I2C_M_RD)
+		xfer_size = msg->len;
+	else
+		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
+							I2C_PACKET_HEADER_SIZE;
+	dma = ((xfer_size > I2C_PIO_MODE_MAX_LEN) &&
+				i2c_dev->tx_dma_chan && i2c_dev->rx_dma_chan);
+	i2c_dev->is_curr_dma_xfer = dma;
 	i2c_dev->msg_buf_remaining = msg->len;
 	i2c_dev->msg_err = I2C_ERR_NONE;
 	i2c_dev->msg_read = (msg->flags & I2C_M_RD);
 	reinit_completion(&i2c_dev->msg_complete);
 
-	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
-
-	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
-	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
+					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
+	i2c_dev->msg_buf = (u8 *)buffer;
 
-	packet_header = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
+	*(buffer++) = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
 			PACKET_HEADER0_PROTOCOL_I2C |
 			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
 			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
-	packet_header = msg->len - 1;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+	*(buffer++) = msg->len - 1;
 
-	packet_header = I2C_HEADER_IE_ENABLE;
+	val = I2C_HEADER_IE_ENABLE;
 	if (end_state == MSG_END_CONTINUE)
-		packet_header |= I2C_HEADER_CONTINUE_XFER;
+		val |= I2C_HEADER_CONTINUE_XFER;
 	else if (end_state == MSG_END_REPEAT_START)
-		packet_header |= I2C_HEADER_REPEAT_START;
+		val |= I2C_HEADER_REPEAT_START;
 	if (msg->flags & I2C_M_TEN) {
-		packet_header |= msg->addr;
-		packet_header |= I2C_HEADER_10BIT_ADDR;
+		val |= msg->addr;
+		val |= I2C_HEADER_10BIT_ADDR;
 	} else {
-		packet_header |= msg->addr << I2C_HEADER_SLAVE_ADDR_SHIFT;
+		val |= msg->addr << I2C_HEADER_SLAVE_ADDR_SHIFT;
 	}
 	if (msg->flags & I2C_M_IGNORE_NAK)
-		packet_header |= I2C_HEADER_CONT_ON_NAK;
+		val |= I2C_HEADER_CONT_ON_NAK;
 	if (msg->flags & I2C_M_RD)
-		packet_header |= I2C_HEADER_READ;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+		val |= I2C_HEADER_READ;
+	*(buffer++) = val;
 
-	if (!(msg->flags & I2C_M_RD))
-		tegra_i2c_fill_tx_fifo(i2c_dev);
+	if (!i2c_dev->msg_read)
+		memcpy(buffer, msg->buf, msg->len);
 
-	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
-		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
-	if (msg->flags & I2C_M_RD)
-		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
-	else if (i2c_dev->msg_buf_remaining)
-		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+	if (dma)
+		ret = tegra_i2c_start_dma_xfer(i2c_dev);
+	else
+		ret = tegra_i2c_start_pio_xfer(i2c_dev);
 
-	tegra_i2c_unmask_irq(i2c_dev, int_mask);
-	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
-	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
-		i2c_readl(i2c_dev, I2C_INT_MASK));
+	if (ret == -EIO)
+		return ret;
+	else if (ret == -ETIMEDOUT)
+		goto end_xfer;
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
 						TEGRA_I2C_TIMEOUT);
-	tegra_i2c_mask_irq(i2c_dev, int_mask);
-
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
-
+		if (i2c_dev->is_curr_dma_xfer) {
+			if (i2c_dev->msg_read) {
+				dmaengine_terminate_all(i2c_dev->rx_dma_chan);
+				complete(&i2c_dev->rx_dma_complete);
+			} else {
+				dmaengine_terminate_all(i2c_dev->tx_dma_chan);
+				complete(&i2c_dev->tx_dma_complete);
+			}
+		}
 		tegra_i2c_init(i2c_dev);
 		return -ETIMEDOUT;
 	}
+	if (i2c_dev->msg_read) {
+		if (!dma)
+			i2c_dev->msg_buf = (u8 *)buffer;
+		memcpy(msg->buf, i2c_dev->msg_buf, msg->len);
+	}
 
+end_xfer:
+	int_mask = i2c_readl(i2c_dev, I2C_INT_MASK);
+	tegra_i2c_mask_irq(i2c_dev, int_mask);
+	if (i2c_dev->is_curr_dma_xfer && (ret < 0)) {
+		dev_err(i2c_dev->dev, "i2c dma transfer timed out\n");
+		tegra_i2c_init(i2c_dev);
+		return -ETIMEDOUT;
+	}
 	dev_dbg(i2c_dev->dev, "transfer complete: %lu %d %d\n",
 		time_left, completion_done(&i2c_dev->msg_complete),
 		i2c_dev->msg_err);
@@ -781,6 +1169,19 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		return ret;
 	}
 
+	if (i2c_dev->has_dma) {
+		if (!i2c_dev->rx_dma_chan) {
+			ret = tegra_i2c_init_dma_param(i2c_dev, true);
+			if (ret && (ret != -EPROBE_DEFER) && (ret != -ENODEV))
+				return ret;
+		}
+		if (!i2c_dev->tx_dma_chan) {
+			ret = tegra_i2c_init_dma_param(i2c_dev, false);
+			if (ret && (ret != -EPROBE_DEFER) && (ret != -ENODEV))
+				return ret;
+		}
+	}
+
 	for (i = 0; i < num; i++) {
 		enum msg_end_type end_type = MSG_END_STOP;
 
@@ -823,6 +1224,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 
 	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
 			"multi-master");
+
+	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
 }
 
 static const struct i2c_algorithm tegra_i2c_algo = {
@@ -935,11 +1338,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
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
@@ -962,12 +1367,14 @@ static int tegra_i2c_probe(struct platform_device *pdev)
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
@@ -982,6 +1389,8 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 						  "nvidia,tegra20-i2c-dvc");
 	init_completion(&i2c_dev->msg_complete);
 	spin_lock_init(&i2c_dev->xfer_lock);
+	init_completion(&i2c_dev->tx_dma_complete);
+	init_completion(&i2c_dev->rx_dma_complete);
 
 	if (!i2c_dev->hw->has_single_clk_source) {
 		fast_clk = devm_clk_get(&pdev->dev, "fast-clk");
@@ -1041,6 +1450,15 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (i2c_dev->has_dma) {
+		ret = tegra_i2c_init_dma_param(i2c_dev, true);
+		if (ret && (ret != -EPROBE_DEFER) && (ret != -ENODEV))
+			goto disable_div_clk;
+		ret = tegra_i2c_init_dma_param(i2c_dev, false);
+		if (ret && (ret != -EPROBE_DEFER) && (ret != -ENODEV))
+			goto disable_div_clk;
+	}
+
 	ret = tegra_i2c_init(i2c_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
-- 
2.7.4

