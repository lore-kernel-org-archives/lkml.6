Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDA6ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EEF2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xKcjIz9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EEF2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJSUfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:35:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1tJgNCU6ampVhhEakSX9sXxAB5mJeex5rc1gnKV21J0=; b=xKcjIz9TbSgm
        nchVGXCzyynn836eqlRzlYjRmJc0qulkMvWWbpIdJuBVULBzhNBag84pRKyY66eyphUHUV6FGCzx7
        88BbcdOFDGrw4ulen920POVon1Vsf7ZF3h0mYyUzjvJqa7Ms7DZenMOzy50My0tka7oO9d5BHWwvN
        H7Dzs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTuW-00004x-AP; Fri, 19 Oct 2018 12:29:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 131CE1122548; Fri, 19 Oct 2018 13:29:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: omap2-mcspi: Set FIFO DMA trigger level to word length" to the spi tree
In-Reply-To:  <20181015063829.26978-3-vigneshr@ti.com>
Message-Id: <20181019122948.131CE1122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:29:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: omap2-mcspi: Set FIFO DMA trigger level to word length

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

From c367dadf3cfda3760005eecb7613db49bd9aba7c Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Mon, 15 Oct 2018 12:08:28 +0530
Subject: [PATCH] spi: omap2-mcspi: Set FIFO DMA trigger level to word length

McSPI has 32 byte FIFO in Transmit-Receive mode. Current code tries to
configuration FIFO watermark level for DMA trigger to be GCD of transfer
length and max FIFO size which would mean trigger level may be set to 32
for transmit-receive mode if length is aligned. This does not work in
case of SPI slave mode where FIFO always needs to have data ready
whenever master starts the clock. With DMA trigger size of 32 there will
be a small window during slave TX where DMA is still putting data into
FIFO but master would have started clock for next byte, resulting in
shifting out of stale data. Similarly, on Slave RX side there may be RX
FIFO overflow
Fix this by setting FIFO watermark for DMA trigger to word
length. This means DMA is triggered as soon as FIFO has space for word
length bytes and DMA would make sure FIFO is almost always full
therefore improving FIFO occupancy in both master and slave mode.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 985f00d8a964..88469bb22235 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -300,7 +300,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
 	unsigned int wcnt;
-	int max_fifo_depth, fifo_depth, bytes_per_word;
+	int max_fifo_depth, bytes_per_word;
 	u32 chconf, xferlevel;
 
 	mcspi = spi_master_get_devdata(master);
@@ -316,10 +316,6 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
 
-		fifo_depth = gcd(t->len, max_fifo_depth);
-		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
-			goto disable_fifo;
-
 		wcnt = t->len / bytes_per_word;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
@@ -327,16 +323,17 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			xferlevel |= (fifo_depth - 1) << 8;
+			xferlevel |= (bytes_per_word - 1) << 8;
 		}
+
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			xferlevel |= fifo_depth - 1;
+			xferlevel |= bytes_per_word - 1;
 		}
 
 		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
 		mcspi_write_chconf0(spi, chconf);
-		mcspi->fifo_depth = fifo_depth;
+		mcspi->fifo_depth = max_fifo_depth;
 
 		return;
 	}
@@ -576,7 +573,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
-	u32			burst;
 	void __iomem		*chstat_reg;
 	void __iomem            *irqstat_reg;
 	int			wait_res;
@@ -596,22 +592,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	count = xfer->len;
-	burst = 1;
-
-	if (mcspi->fifo_depth > 0) {
-		if (count > mcspi->fifo_depth)
-			burst = mcspi->fifo_depth / es;
-		else
-			burst = count / es;
-	}
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = burst;
-	cfg.dst_maxburst = burst;
+	cfg.src_maxburst = es;
+	cfg.dst_maxburst = es;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.19.0.rc2

