Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE811ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F50020825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TUBw3rUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F50020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeKEVZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:25:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbeKEVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=59F3mF78XfYEFCUofceLGHijk3OAuHV+szbpcwrFXWY=; b=TUBw3rUkyn3W
        nFxiqKQEyYegHXgl9bDCoQJt/xtw1fYZuj6W2Pz5/2qlN76PsZUT8e3h9hQXxW/sWBXA0HB4PQynP
        yLO3YRwJucb7WXzvvntV3v8iD0cioje5f6qwOLQLzPbU6EZscg2jvMZRnjQns3hpvS6HwNaMHRucE
        tMH/s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJde1-0008My-B9; Mon, 05 Nov 2018 12:06:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 163091124D98; Mon,  5 Nov 2018 12:06:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: use irq rather than polling" to the spi tree
In-Reply-To:  <20181031105711.19575-13-esmil@mailme.dk>
Message-Id: <20181105120613.163091124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: use irq rather than polling

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 01b59ce5dac856323a0c13c1d51d99a819f32efe Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:09 +0100
Subject: [PATCH] spi: rockchip: use irq rather than polling

Register an interrupt handler to fill/empty the
tx and rx fifos rather than busy-looping.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 155 ++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5fe6099ff366..1297f081818d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -172,6 +172,11 @@ struct rockchip_spi {
 	dma_addr_t dma_addr_rx;
 	dma_addr_t dma_addr_tx;
 
+	const void *tx;
+	void *rx;
+	unsigned int tx_left;
+	unsigned int rx_left;
+
 	atomic_t state;
 
 	/*depth of the FIFO buffer */
@@ -182,11 +187,6 @@ struct rockchip_spi {
 	u8 n_bytes;
 	u8 rsd;
 
-	const void *tx;
-	const void *tx_end;
-	void *rx;
-	void *rx_end;
-
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 };
 
@@ -222,24 +222,6 @@ static u32 get_fifo_len(struct rockchip_spi *rs)
 	return (fifo == 31) ? 0 : fifo;
 }
 
-static inline u32 tx_max(struct rockchip_spi *rs)
-{
-	u32 tx_left, tx_room;
-
-	tx_left = (rs->tx_end - rs->tx) / rs->n_bytes;
-	tx_room = rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
-
-	return min(tx_left, tx_room);
-}
-
-static inline u32 rx_max(struct rockchip_spi *rs)
-{
-	u32 rx_left = (rs->rx_end - rs->rx) / rs->n_bytes;
-	u32 rx_room = (u32)readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
-
-	return min(rx_left, rx_room);
-}
-
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct spi_master *master = spi->master;
@@ -277,6 +259,9 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 	 */
 	spi_enable_chip(rs, false);
 
+	/* make sure all interrupts are masked */
+	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+
 	if (atomic_read(&rs->state) & TXDMA)
 		dmaengine_terminate_async(master->dma_tx);
 
@@ -286,14 +271,17 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 {
-	u32 max = tx_max(rs);
-	u32 txw = 0;
+	u32 tx_free = rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
+	u32 words = min(rs->tx_left, tx_free);
+
+	rs->tx_left -= words;
+	for (; words; words--) {
+		u32 txw;
 
-	while (max--) {
 		if (rs->n_bytes == 1)
-			txw = *(u8 *)(rs->tx);
+			txw = *(u8 *)rs->tx;
 		else
-			txw = *(u16 *)(rs->tx);
+			txw = *(u16 *)rs->tx;
 
 		writel_relaxed(txw, rs->regs + ROCKCHIP_SPI_TXDR);
 		rs->tx += rs->n_bytes;
@@ -302,46 +290,72 @@ static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 
 static void rockchip_spi_pio_reader(struct rockchip_spi *rs)
 {
-	u32 max = rx_max(rs);
-	u32 rxw;
+	u32 words = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
+	u32 rx_left = rs->rx_left - words;
+
+	/* the hardware doesn't allow us to change fifo threshold
+	 * level while spi is enabled, so instead make sure to leave
+	 * enough words in the rx fifo to get the last interrupt
+	 * exactly when all words have been received
+	 */
+	if (rx_left) {
+		u32 ftl = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFTLR) + 1;
+
+		if (rx_left < ftl) {
+			rx_left = ftl;
+			words = rs->rx_left - rx_left;
+		}
+	}
+
+	rs->rx_left = rx_left;
+	for (; words; words--) {
+		u32 rxw = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
+
+		if (!rs->rx)
+			continue;
 
-	while (max--) {
-		rxw = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
 		if (rs->n_bytes == 1)
-			*(u8 *)(rs->rx) = (u8)rxw;
+			*(u8 *)rs->rx = (u8)rxw;
 		else
-			*(u16 *)(rs->rx) = (u16)rxw;
+			*(u16 *)rs->rx = (u16)rxw;
 		rs->rx += rs->n_bytes;
 	}
 }
 
-static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
+static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 {
-	int remain = 0;
+	struct spi_master *master = dev_id;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spi_enable_chip(rs, true);
+	if (rs->tx_left)
+		rockchip_spi_pio_writer(rs);
 
-	do {
-		if (rs->tx) {
-			remain = rs->tx_end - rs->tx;
-			rockchip_spi_pio_writer(rs);
-		}
+	rockchip_spi_pio_reader(rs);
+	if (!rs->rx_left) {
+		spi_enable_chip(rs, false);
+		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+		spi_finalize_current_transfer(master);
+	}
 
-		if (rs->rx) {
-			remain = rs->rx_end - rs->rx;
-			rockchip_spi_pio_reader(rs);
-		}
+	return IRQ_HANDLED;
+}
 
-		cpu_relax();
-	} while (remain);
+static int rockchip_spi_prepare_irq(struct rockchip_spi *rs,
+		struct spi_transfer *xfer)
+{
+	rs->tx = xfer->tx_buf;
+	rs->rx = xfer->rx_buf;
+	rs->tx_left = rs->tx ? xfer->len / rs->n_bytes : 0;
+	rs->rx_left = xfer->len / rs->n_bytes;
 
-	/* If tx, wait until the FIFO data completely. */
-	if (rs->tx)
-		wait_for_idle(rs);
+	writel_relaxed(INT_RF_FULL, rs->regs + ROCKCHIP_SPI_IMR);
+	spi_enable_chip(rs, true);
 
-	spi_enable_chip(rs, false);
+	if (rs->tx_left)
+		rockchip_spi_pio_writer(rs);
 
-	return 0;
+	/* 1 means the transfer is in progress */
+	return 1;
 }
 
 static void rockchip_spi_dma_rxcb(void *data)
@@ -465,7 +479,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
 	else if (xfer->rx_buf)
 		cr0 |= CR0_XFM_RO << CR0_XFM_OFFSET;
-	else
+	else if (use_dma)
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
 	if (use_dma) {
@@ -484,8 +498,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
-	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
-	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
+	/* unfortunately setting the fifo threshold level to generate an
+	 * interrupt exactly when the fifo is full doesn't seem to work,
+	 * so we need the strict inequality here
+	 */
+	if (xfer->len < rs->fifo_len)
+		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
+	else
+		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
@@ -527,11 +547,6 @@ static int rockchip_spi_transfer_one(
 
 	rs->n_bytes = xfer->bits_per_word >> 3;
 
-	rs->tx = xfer->tx_buf;
-	rs->tx_end = rs->tx + xfer->len;
-	rs->rx = xfer->rx_buf;
-	rs->rx_end = rs->rx + xfer->len;
-
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
 	rockchip_spi_config(rs, spi, xfer, use_dma);
@@ -539,7 +554,7 @@ static int rockchip_spi_transfer_one(
 	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, master, xfer);
 
-	return rockchip_spi_pio_transfer(rs);
+	return rockchip_spi_prepare_irq(rs, xfer);
 }
 
 static bool rockchip_spi_can_dma(struct spi_master *master,
@@ -547,8 +562,13 @@ static bool rockchip_spi_can_dma(struct spi_master *master,
 				 struct spi_transfer *xfer)
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
+	unsigned int bytes_per_word = xfer->bits_per_word <= 8 ? 1 : 2;
 
-	return (xfer->len > rs->fifo_len);
+	/* if the numbor of spi words to transfer is less than the fifo
+	 * length we can just fill the fifo and wait for a single irq,
+	 * so don't bother setting up dma
+	 */
+	return xfer->len / bytes_per_word >= rs->fifo_len;
 }
 
 static int rockchip_spi_probe(struct platform_device *pdev)
@@ -603,6 +623,15 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_disable_spiclk;
+
+	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
+			IRQF_ONESHOT, dev_name(&pdev->dev), master);
+	if (ret)
+		goto err_disable_spiclk;
+
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
 
-- 
2.19.0.rc2

