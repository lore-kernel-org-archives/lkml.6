Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD5C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F1D2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="o0dyFsHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F1D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeKEV0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53608 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeKEV0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KG8Mqiq+fBqT8G5nzXj7cCbwijfOZaHrHGYnzpTLX7s=; b=o0dyFsHUuPF1
        6tNnk2oKI+cucIdtd02gc7dp6+qaKEyeqxmSY9eULPqahwemFa1huglgE5KBKNtpkXpQnoKLqxwng
        ewBE/unMzDuLvde+h30VAXvA1zvU77C3MHdMME+91oWqrv0OPB9UvgpCrCjPEkcolqMwjfo9k6uVp
        kUnGE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeZ-0008OD-Ay; Mon, 05 Nov 2018 12:06:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0E9EF1124D98; Mon,  5 Nov 2018 12:06:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: use atomic_t state" to the spi tree
In-Reply-To:  <20181031105711.19575-5-esmil@mailme.dk>
Message-Id: <20181105120647.0E9EF1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: use atomic_t state

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

From fab3e4871f623c8f86e8a0e00749f1480ffa08db Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:01 +0100
Subject: [PATCH] spi: rockchip: use atomic_t state

The state field is currently only used to make sure
only the last of the tx and rx dma callbacks issue
an spi_finalize_current_transfer.
Rather than using a spinlock we can get away
with just turning the state field into an atomic_t.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 75 +++++++++++++-------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7fac4253075e..1c813797f963 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -142,8 +142,9 @@
 #define RF_DMA_EN					(1 << 0)
 #define TF_DMA_EN					(1 << 1)
 
-#define RXBUSY						(1 << 0)
-#define TXBUSY						(1 << 1)
+/* Driver state flags */
+#define RXDMA					(1 << 0)
+#define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
 #define MAX_SCLK_OUT		50000000
@@ -169,6 +170,9 @@ struct rockchip_spi {
 	struct clk *apb_pclk;
 
 	void __iomem *regs;
+
+	atomic_t state;
+
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
 	/* max bus freq supported */
@@ -187,10 +191,6 @@ struct rockchip_spi {
 	void *rx;
 	void *rx_end;
 
-	u32 state;
-	/* protect state */
-	spinlock_t lock;
-
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
@@ -302,28 +302,21 @@ static int rockchip_spi_prepare_message(struct spi_master *master,
 static void rockchip_spi_handle_err(struct spi_master *master,
 				    struct spi_message *msg)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
 	/*
 	 * For DMA mode, we need terminate DMA channel and flush
 	 * fifo for the next transfer if DMA thansfer timeout.
 	 * handle_err() was called by core if transfer failed.
 	 * Maybe it is reasonable for error handling here.
 	 */
-	if (rs->use_dma) {
-		if (rs->state & RXBUSY) {
-			dmaengine_terminate_async(rs->dma_rx.ch);
-			flush_fifo(rs);
-		}
+	if (atomic_read(&rs->state) & TXDMA)
+		dmaengine_terminate_async(rs->dma_tx.ch);
 
-		if (rs->state & TXBUSY)
-			dmaengine_terminate_async(rs->dma_tx.ch);
+	if (atomic_read(&rs->state) & RXDMA) {
+		dmaengine_terminate_async(rs->dma_rx.ch);
+		flush_fifo(rs);
 	}
-
-	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
 static int rockchip_spi_unprepare_message(struct spi_master *master,
@@ -398,48 +391,36 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 
 static void rockchip_spi_dma_rxcb(void *data)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = data;
+	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
-	rs->state &= ~RXBUSY;
-	if (!(rs->state & TXBUSY)) {
-		spi_enable_chip(rs, false);
-		spi_finalize_current_transfer(rs->master);
-	}
+	if (state & TXDMA)
+		return;
 
-	spin_unlock_irqrestore(&rs->lock, flags);
+	spi_enable_chip(rs, false);
+	spi_finalize_current_transfer(rs->master);
 }
 
 static void rockchip_spi_dma_txcb(void *data)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = data;
+	int state = atomic_fetch_andnot(TXDMA, &rs->state);
+
+	if (state & RXDMA)
+		return;
 
 	/* Wait until the FIFO data completely. */
 	wait_for_idle(rs);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
-	rs->state &= ~TXBUSY;
-	if (!(rs->state & RXBUSY)) {
-		spi_enable_chip(rs, false);
-		spi_finalize_current_transfer(rs->master);
-	}
-
-	spin_unlock_irqrestore(&rs->lock, flags);
+	spi_enable_chip(rs, false);
+	spi_finalize_current_transfer(rs->master);
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
-	unsigned long flags;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	spin_lock_irqsave(&rs->lock, flags);
-	rs->state &= ~RXBUSY;
-	rs->state &= ~TXBUSY;
-	spin_unlock_irqrestore(&rs->lock, flags);
+	atomic_set(&rs->state, 0);
 
 	rxdesc = NULL;
 	if (rs->rx) {
@@ -490,9 +471,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	/* rx must be started before tx due to spi instinct */
 	if (rxdesc) {
-		spin_lock_irqsave(&rs->lock, flags);
-		rs->state |= RXBUSY;
-		spin_unlock_irqrestore(&rs->lock, flags);
+		atomic_or(RXDMA, &rs->state);
 		dmaengine_submit(rxdesc);
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
@@ -500,9 +479,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	spi_enable_chip(rs, true);
 
 	if (txdesc) {
-		spin_lock_irqsave(&rs->lock, flags);
-		rs->state |= TXBUSY;
-		spin_unlock_irqrestore(&rs->lock, flags);
+		atomic_or(TXDMA, &rs->state);
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
@@ -716,8 +693,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_spiclk;
 	}
 
-	spin_lock_init(&rs->lock);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.19.0.rc2

