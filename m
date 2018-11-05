Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBED2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NAO92pSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBED2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbeKEV01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeKEV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=//HLNGQ0jLtzKn1eM3b/55t9xLU7S316HaLu20cIOzs=; b=NAO92pSvM1JB
        IvfvvWyBLPt2SobViur7nm+IjDvkT4EM/BqQ1eHW2oH+ZzevBfA+44jzl8hD+pQiyrA+plFL8Ujpo
        jz5+hSd/LPWRqksv2GrR8JsvmBjT3ej7dpPiW+wLJhFHn1O38oFHwOKVwHk6yb3UxkbU5HgVXyrdT
        mQeSY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeh-0008OZ-AV; Mon, 05 Nov 2018 12:06:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 15DAC1124D98; Mon,  5 Nov 2018 12:06:55 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: use designated init for dma config" to the spi tree
In-Reply-To:  <20181031105711.19575-3-esmil@mailme.dk>
Message-Id: <20181105120655.15DAC1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: use designated init for dma config

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

From 31bcb57be12fd815a9051f07d64334809b8cb472 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:56:59 +0100
Subject: [PATCH] spi: rockchip: use designated init for dma config

Use C99 designated initializers for dma slave config
structures. This also makes sure uninitialized fields
are zeroed so we don't need an explicit memset.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7e54e1a69cc8..87d1b9837d94 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -442,12 +442,8 @@ static void rockchip_spi_dma_txcb(void *data)
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
-	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	memset(&rxconf, 0, sizeof(rxconf));
-	memset(&txconf, 0, sizeof(txconf));
-
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
@@ -455,10 +451,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = DMA_DEV_TO_MEM;
-		rxconf.src_addr = rs->dma_rx.addr;
-		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = 1;
+		struct dma_slave_config rxconf = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr = rs->dma_rx.addr,
+			.src_addr_width = rs->n_bytes,
+			.src_maxburst = 1,
+		};
+
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -474,10 +473,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = DMA_MEM_TO_DEV;
-		txconf.dst_addr = rs->dma_tx.addr;
-		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->fifo_len / 2;
+		struct dma_slave_config txconf = {
+			.direction = DMA_MEM_TO_DEV,
+			.dst_addr = rs->dma_tx.addr,
+			.dst_addr_width = rs->n_bytes,
+			.dst_maxburst = rs->fifo_len / 2,
+		};
+
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-- 
2.19.0.rc2

