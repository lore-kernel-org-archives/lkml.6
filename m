Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B37DC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022272086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PxWEjA/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022272086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeKEV0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKEV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XCg8vXnz6G9b9SE9qBunByaJNBBcizqSA1C7j26Rg9o=; b=PxWEjA/0iVM8
        pzrgLV5kUrvuGX0IXRd6vxv+i5X/0xNoTrClwV+HVNn0CvV1rSmsrjuOPAzisJf67YjZjhEgL61q1
        ZYK0EkX2viupaF1RSq+WBqM0RuMLUeGhK6CZLSZWljbGyoXr6z08u0MctchpoL3Fu6m8hJGBJp0+J
        Tp450=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeV-0008Ny-82; Mon, 05 Nov 2018 12:06:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F26821124D99; Mon,  5 Nov 2018 12:06:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: disable spi on error" to the spi tree
In-Reply-To:  <20181031105711.19575-6-esmil@mailme.dk>
Message-Id: <20181105120642.F26821124D99@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: disable spi on error

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

From ce386100d99976442093ff57b5b24a9562c6cc27 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:02 +0100
Subject: [PATCH] spi: rockchip: disable spi on error

Successful transfers leave the spi disabled, so if
we just make sure to disable the spi on error
there should be no need to disable the spi from
master->unprepare_message.

This also flushes the tx and rx fifos,
so no need to do that manually.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1c813797f963..5729e6071729 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -210,12 +210,6 @@ static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
 	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
 }
 
-static inline void flush_fifo(struct rockchip_spi *rs)
-{
-	while (readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR))
-		readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
-}
-
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -304,29 +298,16 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	/*
-	 * For DMA mode, we need terminate DMA channel and flush
-	 * fifo for the next transfer if DMA thansfer timeout.
-	 * handle_err() was called by core if transfer failed.
-	 * Maybe it is reasonable for error handling here.
+	/* stop running spi transfer
+	 * this also flushes both rx and tx fifos
 	 */
+	spi_enable_chip(rs, false);
+
 	if (atomic_read(&rs->state) & TXDMA)
 		dmaengine_terminate_async(rs->dma_tx.ch);
 
-	if (atomic_read(&rs->state) & RXDMA) {
+	if (atomic_read(&rs->state) & RXDMA)
 		dmaengine_terminate_async(rs->dma_rx.ch);
-		flush_fifo(rs);
-	}
-}
-
-static int rockchip_spi_unprepare_message(struct spi_master *master,
-					  struct spi_message *msg)
-{
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
-
-	spi_enable_chip(rs, false);
-
-	return 0;
 }
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
@@ -705,7 +686,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->prepare_message = rockchip_spi_prepare_message;
-	master->unprepare_message = rockchip_spi_unprepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
-- 
2.19.0.rc2

