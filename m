Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE5AC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1520819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="m+eBcnwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B1520819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbeKEV0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeKEV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7ENi49e5M9cIAlcFkxuQ1g5ThAkY+RnGkj47Kqm/Hg4=; b=m+eBcnwvfIlO
        sJ/Xr2oHiJOUDH3MO7rePWMcG/HZq5eFO62m3XR+oye3bxdUdJO8VZ2a2bY5eNUD/ODWBEAUNolDu
        3h5ljazrkvycj4yCojmFnPdL6OhaIjqyHq0glyqFnZtxLD6WKOhDezcLwaukcZ1dQ4h5wWxJJOYyB
        Aw8xE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdel-0008Oi-9B; Mon, 05 Nov 2018 12:06:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0191B1124D98; Mon,  5 Nov 2018 12:06:58 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: make spi_enable_chip take bool" to the spi tree
In-Reply-To:  <20181031105711.19575-2-esmil@mailme.dk>
Message-Id: <20181105120659.0191B1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: make spi_enable_chip take bool

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

From 30688e4e670d21126aa596df4523940e2f8d24de Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:56:58 +0100
Subject: [PATCH] spi: rockchip: make spi_enable_chip take bool

The spi_enable_chip function takes a boolean
argument. Change the type to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 51ef632bca52..7e54e1a69cc8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -208,9 +208,9 @@ struct rockchip_spi {
 	struct rockchip_spi_dma_data dma_tx;
 };
 
-static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
+static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 {
-	writel_relaxed((enable ? 1 : 0), rs->regs + ROCKCHIP_SPI_SSIENR);
+	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
 static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
@@ -339,7 +339,7 @@ static int rockchip_spi_unprepare_message(struct spi_master *master,
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	return 0;
 }
@@ -379,7 +379,7 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 {
 	int remain = 0;
 
-	spi_enable_chip(rs, 1);
+	spi_enable_chip(rs, true);
 
 	do {
 		if (rs->tx) {
@@ -399,7 +399,7 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 	if (rs->tx)
 		wait_for_idle(rs);
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	return 0;
 }
@@ -413,7 +413,7 @@ static void rockchip_spi_dma_rxcb(void *data)
 
 	rs->state &= ~RXBUSY;
 	if (!(rs->state & TXBUSY)) {
-		spi_enable_chip(rs, 0);
+		spi_enable_chip(rs, false);
 		spi_finalize_current_transfer(rs->master);
 	}
 
@@ -432,7 +432,7 @@ static void rockchip_spi_dma_txcb(void *data)
 
 	rs->state &= ~TXBUSY;
 	if (!(rs->state & RXBUSY)) {
-		spi_enable_chip(rs, 0);
+		spi_enable_chip(rs, false);
 		spi_finalize_current_transfer(rs->master);
 	}
 
@@ -503,7 +503,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
-	spi_enable_chip(rs, 1);
+	spi_enable_chip(rs, true);
 
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
@@ -705,7 +705,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_apbclk;
 	}
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	rs->type = SSI_MOTO_SPI;
 	rs->master = master;
-- 
2.19.0.rc2

