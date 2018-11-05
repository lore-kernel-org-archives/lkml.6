Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F357C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F2B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="h47FeMP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F2B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbeKEV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53236 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKEV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QapMirTrSue49meGmZo538TJH9bNh43JCBiee1C8mRc=; b=h47FeMP82peG
        QhuxE4oIgGeE2lWlr8EX/LvPRRO7aqi4ELLmuIJI4TWmgJ6FuVGjyMn1OogLEI1gLIGdPRT+snLnC
        DhlqmqGb5xH+xF4eoMVll3CYpx42R1ODvL0OxDKU0u/AUyrSsV5YTyFQiO7Cff9mKtTqXEf/Hbkpp
        EoAxU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeM-0008Nk-PP; Mon, 05 Nov 2018 12:06:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 791211124D98; Mon,  5 Nov 2018 12:06:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: don't store dma channels twice" to the spi tree
In-Reply-To:  <20181031105711.19575-8-esmil@mailme.dk>
Message-Id: <20181105120634.791211124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: don't store dma channels twice

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

From eee06a9ee2cd5deaddc5f77ce8f6118c8b82b2a0 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:04 +0100
Subject: [PATCH] spi: rockchip: don't store dma channels twice

The spi master (aka spi controller) structure already
has two fields for storing the rx and tx dma channels.
Just use them rather than duplicating them in driver data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 76 +++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5edc51820d35..f3fe6d4cf6f6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -157,11 +157,6 @@
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
 
-struct rockchip_spi_dma_data {
-	struct dma_chan *ch;
-	dma_addr_t addr;
-};
-
 struct rockchip_spi {
 	struct device *dev;
 	struct spi_master *master;
@@ -170,6 +165,8 @@ struct rockchip_spi {
 	struct clk *apb_pclk;
 
 	void __iomem *regs;
+	dma_addr_t dma_addr_rx;
+	dma_addr_t dma_addr_tx;
 
 	atomic_t state;
 
@@ -190,8 +187,6 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
-	struct rockchip_spi_dma_data dma_rx;
-	struct rockchip_spi_dma_data dma_tx;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -287,10 +282,10 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 	spi_enable_chip(rs, false);
 
 	if (atomic_read(&rs->state) & TXDMA)
-		dmaengine_terminate_async(rs->dma_tx.ch);
+		dmaengine_terminate_async(master->dma_tx);
 
 	if (atomic_read(&rs->state) & RXDMA)
-		dmaengine_terminate_async(rs->dma_rx.ch);
+		dmaengine_terminate_async(master->dma_rx);
 }
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
@@ -381,7 +376,7 @@ static void rockchip_spi_dma_txcb(void *data)
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
-		struct spi_transfer *xfer)
+		struct spi_master *master, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
@@ -391,15 +386,15 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (xfer->rx_buf) {
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
-			.src_addr = rs->dma_rx.addr,
+			.src_addr = rs->dma_addr_rx,
 			.src_addr_width = rs->n_bytes,
 			.src_maxburst = 1,
 		};
 
-		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
+		dmaengine_slave_config(master->dma_rx, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
-				rs->dma_rx.ch,
+				master->dma_rx,
 				xfer->rx_sg.sgl, xfer->rx_sg.nents,
 				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
@@ -413,20 +408,20 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (xfer->tx_buf) {
 		struct dma_slave_config txconf = {
 			.direction = DMA_MEM_TO_DEV,
-			.dst_addr = rs->dma_tx.addr,
+			.dst_addr = rs->dma_addr_tx,
 			.dst_addr_width = rs->n_bytes,
 			.dst_maxburst = rs->fifo_len / 2,
 		};
 
-		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
+		dmaengine_slave_config(master->dma_tx, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-				rs->dma_tx.ch,
+				master->dma_tx,
 				xfer->tx_sg.sgl, xfer->tx_sg.nents,
 				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
-				dmaengine_terminate_sync(rs->dma_rx.ch);
+				dmaengine_terminate_sync(master->dma_rx);
 			return -EINVAL;
 		}
 
@@ -438,7 +433,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (rxdesc) {
 		atomic_or(RXDMA, &rs->state);
 		dmaengine_submit(rxdesc);
-		dma_async_issue_pending(rs->dma_rx.ch);
+		dma_async_issue_pending(master->dma_rx);
 	}
 
 	spi_enable_chip(rs, true);
@@ -446,7 +441,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (txdesc) {
 		atomic_or(TXDMA, &rs->state);
 		dmaengine_submit(txdesc);
-		dma_async_issue_pending(rs->dma_tx.ch);
+		dma_async_issue_pending(master->dma_tx);
 	}
 
 	/* 1 means the transfer is in progress */
@@ -572,7 +567,7 @@ static int rockchip_spi_transfer_one(
 	rockchip_spi_config(rs, spi, xfer);
 
 	if (rs->use_dma)
-		return rockchip_spi_prepare_dma(rs, xfer);
+		return rockchip_spi_prepare_dma(rs, master, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
 }
@@ -669,34 +664,31 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->handle_err = rockchip_spi_handle_err;
 	master->flags = SPI_MASTER_GPIO_SS;
 
-	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
-	if (IS_ERR(rs->dma_tx.ch)) {
+	master->dma_tx = dma_request_chan(rs->dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
 		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_disable_pm_runtime;
 		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
-		rs->dma_tx.ch = NULL;
+		master->dma_tx = NULL;
 	}
 
-	rs->dma_rx.ch = dma_request_chan(rs->dev, "rx");
-	if (IS_ERR(rs->dma_rx.ch)) {
-		if (PTR_ERR(rs->dma_rx.ch) == -EPROBE_DEFER) {
+	master->dma_rx = dma_request_chan(rs->dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_free_dma_tx;
 		}
 		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
-		rs->dma_rx.ch = NULL;
+		master->dma_rx = NULL;
 	}
 
-	if (rs->dma_tx.ch && rs->dma_rx.ch) {
-		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
-		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
-
+	if (master->dma_tx && master->dma_rx) {
+		rs->dma_addr_tx = mem->start + ROCKCHIP_SPI_TXDR;
+		rs->dma_addr_rx = mem->start + ROCKCHIP_SPI_RXDR;
 		master->can_dma = rockchip_spi_can_dma;
-		master->dma_tx = rs->dma_tx.ch;
-		master->dma_rx = rs->dma_rx.ch;
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
@@ -708,11 +700,11 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_dma_rx:
-	if (rs->dma_rx.ch)
-		dma_release_channel(rs->dma_rx.ch);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
 err_free_dma_tx:
-	if (rs->dma_tx.ch)
-		dma_release_channel(rs->dma_tx.ch);
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 err_disable_spiclk:
@@ -739,10 +731,10 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	if (rs->dma_tx.ch)
-		dma_release_channel(rs->dma_tx.ch);
-	if (rs->dma_rx.ch)
-		dma_release_channel(rs->dma_rx.ch);
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
 
 	spi_master_put(master);
 
-- 
2.19.0.rc2

