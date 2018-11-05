Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E95C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7E320825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pOMtjh3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7E320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeKEV0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKEV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=b4pQejAkMGDDXfWlmS8wWRza9tmARHoPXwD18GZJss0=; b=pOMtjh3zmLav
        bWwnO7RkVOBopUbqly+cj8Ai+/No8G5lurVFr2HgUs1jE2YON548NwQZxW08beZExN7L8/B2s6sPH
        OVmkRsVQLMeqBCMJbv3uJkxGwKeIbolxxzJFcQSLrEljBFv9CN5rx9pewXWDYTnSNumprwyjPt7TI
        lT49k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeE-0008NR-8G; Mon, 05 Nov 2018 12:06:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CA85A1124D98; Mon,  5 Nov 2018 12:06:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: simplify use_dma logic" to the spi tree
In-Reply-To:  <20181031105711.19575-10-esmil@mailme.dk>
Message-Id: <20181105120625.CA85A1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: simplify use_dma logic

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

From eff0275e5253604429aedc42b008c5fcaa6cc597 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:06 +0100
Subject: [PATCH] spi: rockchip: simplify use_dma logic

We only need to know if we're using dma when setting
up the transfer, so just use a local variable for
that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 45a1479c1a29..ba60cbcd45c2 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -184,8 +184,6 @@ struct rockchip_spi {
 	void *rx_end;
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
-
-	bool use_dma;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -450,7 +448,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs,
-		struct spi_device *spi, struct spi_transfer *xfer)
+		struct spi_device *spi, struct spi_transfer *xfer,
+		bool use_dma)
 {
 	u32 div = 0;
 	u32 dmacr = 0;
@@ -471,7 +470,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
-	if (rs->use_dma) {
+	if (use_dma) {
 		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
 		if (xfer->rx_buf)
@@ -537,6 +536,7 @@ static int rockchip_spi_transfer_one(
 		struct spi_transfer *xfer)
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
+	bool use_dma;
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
 		(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
@@ -559,15 +559,11 @@ static int rockchip_spi_transfer_one(
 	rs->rx = xfer->rx_buf;
 	rs->rx_end = rs->rx + xfer->len;
 
-	/* we need prepare dma before spi was enabled */
-	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = true;
-	else
-		rs->use_dma = false;
+	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
-	rockchip_spi_config(rs, spi, xfer);
+	rockchip_spi_config(rs, spi, xfer, use_dma);
 
-	if (rs->use_dma)
+	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, master, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
-- 
2.19.0.rc2

