Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D98ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0D2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="j8uRUoug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA0D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeKEV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKEV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4sxaFDv5aquQXjqRzUyZAJOPGQhGTUdSwPoRu5j/bhY=; b=j8uRUougK1ee
        bntU0AdtoU76q+04Gmz97mRhbkFUa5Yn43a0aDXFsjfqJUsll1VnPFY4jFirVv2C0xAyWVJBzWAgW
        BJ2PRpSiiHxkx6G1x4Gs7Mtn2cxl4pd2gSYtCh4YKLxyY12nCC3TR/5CjeSA8T6qzgurL0TOAB8SR
        4yNdA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeV-0008Nx-W9; Mon, 05 Nov 2018 12:06:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A80121124D98; Mon,  5 Nov 2018 12:06:38 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: read transfer info directly" to the spi tree
In-Reply-To:  <20181031105711.19575-7-esmil@mailme.dk>
Message-Id: <20181105120638.A80121124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:38 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: read transfer info directly

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

From fc1ad8ee33480bdf0493b54907b74538bf9b75b8 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:03 +0100
Subject: [PATCH] spi: rockchip: read transfer info directly

Just read transfer info directly from the spi device
and transfer structures rather than storing it in
driver data first.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 70 +++++++++++++-------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5729e6071729..5edc51820d35 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -178,12 +178,8 @@ struct rockchip_spi {
 	/* max bus freq supported */
 	u32 max_freq;
 
-	u16 mode;
-	u8 tmode;
-	u8 bpw;
 	u8 n_bytes;
 	u32 rsd_nsecs;
-	unsigned len;
 	u32 speed;
 
 	const void *tx;
@@ -194,8 +190,6 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
-	struct sg_table tx_sg;
-	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
 };
@@ -282,17 +276,6 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	rs->cs_asserted[spi->chip_select] = cs_asserted;
 }
 
-static int rockchip_spi_prepare_message(struct spi_master *master,
-					struct spi_message *msg)
-{
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
-	struct spi_device *spi = msg->spi;
-
-	rs->mode = spi->mode;
-
-	return 0;
-}
-
 static void rockchip_spi_handle_err(struct spi_master *master,
 				    struct spi_message *msg)
 {
@@ -397,14 +380,15 @@ static void rockchip_spi_dma_txcb(void *data)
 	spi_finalize_current_transfer(rs->master);
 }
 
-static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
+static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
+		struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
 	atomic_set(&rs->state, 0);
 
 	rxdesc = NULL;
-	if (rs->rx) {
+	if (xfer->rx_buf) {
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = rs->dma_rx.addr,
@@ -416,7 +400,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 		rxdesc = dmaengine_prep_slave_sg(
 				rs->dma_rx.ch,
-				rs->rx_sg.sgl, rs->rx_sg.nents,
+				xfer->rx_sg.sgl, xfer->rx_sg.nents,
 				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
@@ -426,7 +410,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	}
 
 	txdesc = NULL;
-	if (rs->tx) {
+	if (xfer->tx_buf) {
 		struct dma_slave_config txconf = {
 			.direction = DMA_MEM_TO_DEV,
 			.dst_addr = rs->dma_tx.addr,
@@ -438,7 +422,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 		txdesc = dmaengine_prep_slave_sg(
 				rs->dma_tx.ch,
-				rs->tx_sg.sgl, rs->tx_sg.nents,
+				xfer->tx_sg.sgl, xfer->tx_sg.nents,
 				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
@@ -469,7 +453,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	return 1;
 }
 
-static void rockchip_spi_config(struct rockchip_spi *rs)
+static void rockchip_spi_config(struct rockchip_spi *rs,
+		struct spi_device *spi, struct spi_transfer *xfer)
 {
 	u32 div = 0;
 	u32 dmacr = 0;
@@ -481,13 +466,19 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
-	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
-	cr0 |= (rs->tmode << CR0_XFM_OFFSET);
+	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
+
+	if (xfer->rx_buf && xfer->tx_buf)
+		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
+	else if (xfer->rx_buf)
+		cr0 |= CR0_XFM_RO << CR0_XFM_OFFSET;
+	else
+		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
 	if (rs->use_dma) {
-		if (rs->tx)
+		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
-		if (rs->rx)
+		if (xfer->rx_buf)
 			dmacr |= RF_DMA_EN;
 	}
 
@@ -521,11 +512,11 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
 	if (rs->n_bytes == 1)
-		writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 	else if (rs->n_bytes == 2)
-		writel_relaxed((rs->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+		writel_relaxed((xfer->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 	else
-		writel_relaxed((rs->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
@@ -565,24 +556,12 @@ static int rockchip_spi_transfer_one(
 	}
 
 	rs->speed = xfer->speed_hz;
-	rs->bpw = xfer->bits_per_word;
-	rs->n_bytes = rs->bpw >> 3;
+	rs->n_bytes = xfer->bits_per_word >> 3;
 
 	rs->tx = xfer->tx_buf;
 	rs->tx_end = rs->tx + xfer->len;
 	rs->rx = xfer->rx_buf;
 	rs->rx_end = rs->rx + xfer->len;
-	rs->len = xfer->len;
-
-	rs->tx_sg = xfer->tx_sg;
-	rs->rx_sg = xfer->rx_sg;
-
-	if (rs->tx && rs->rx)
-		rs->tmode = CR0_XFM_TR;
-	else if (rs->tx)
-		rs->tmode = CR0_XFM_TO;
-	else if (rs->rx)
-		rs->tmode = CR0_XFM_RO;
 
 	/* we need prepare dma before spi was enabled */
 	if (master->can_dma && master->can_dma(master, spi, xfer))
@@ -590,10 +569,10 @@ static int rockchip_spi_transfer_one(
 	else
 		rs->use_dma = false;
 
-	rockchip_spi_config(rs);
+	rockchip_spi_config(rs, spi, xfer);
 
 	if (rs->use_dma)
-		return rockchip_spi_prepare_dma(rs);
+		return rockchip_spi_prepare_dma(rs, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
 }
@@ -685,7 +664,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 
 	master->set_cs = rockchip_spi_set_cs;
-	master->prepare_message = rockchip_spi_prepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
-- 
2.19.0.rc2

