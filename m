Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74503C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6EA20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KmUYYljo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6EA20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeKEV0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:26:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeKEV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mIBRuY6R59xSLIH+ecT3OCqw2NUx1YMcGtIqjnuPT/M=; b=KmUYYljoARGc
        CDmDgmlwUPo0QzTAFVU7+lK8XQNPBK2/3Bsnp0tf3vrCtjEtw8IUbYxB9GLI0lYGvGmgUfftxLYSH
        8Xnk+q7ds0u5IGw0t2EswmXCa7Nzr+sRWuPKqKk5iqhl/i+S9b6YAiJqr96A26SQJBnSwwwM85aRE
        aruQ4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdeI-0008Nb-Ea; Mon, 05 Nov 2018 12:06:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2BE051124D98; Mon,  5 Nov 2018 12:06:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: remove master pointer from dev data" to the spi tree
In-Reply-To:  <20181031105711.19575-9-esmil@mailme.dk>
Message-Id: <20181105120630.2BE051124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: remove master pointer from dev data

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

From d790c342e689ea77a5cf72d5b993299911ee5276 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:05 +0100
Subject: [PATCH] spi: rockchip: remove master pointer from dev data

In almost all cases we already have a pointer to the
spi master structure where we have the driver data.

The only exceptions are the dma callbacks which are
easily fixed by passing them the master and using
spi_master_get_devdata to retrieve the driver data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index f3fe6d4cf6f6..45a1479c1a29 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -159,7 +159,6 @@
 
 struct rockchip_spi {
 	struct device *dev;
-	struct spi_master *master;
 
 	struct clk *spiclk;
 	struct clk *apb_pclk;
@@ -350,19 +349,21 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 
 static void rockchip_spi_dma_rxcb(void *data)
 {
-	struct rockchip_spi *rs = data;
+	struct spi_master *master = data;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
 	if (state & TXDMA)
 		return;
 
 	spi_enable_chip(rs, false);
-	spi_finalize_current_transfer(rs->master);
+	spi_finalize_current_transfer(master);
 }
 
 static void rockchip_spi_dma_txcb(void *data)
 {
-	struct rockchip_spi *rs = data;
+	struct spi_master *master = data;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	int state = atomic_fetch_andnot(TXDMA, &rs->state);
 
 	if (state & RXDMA)
@@ -372,7 +373,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	wait_for_idle(rs);
 
 	spi_enable_chip(rs, false);
-	spi_finalize_current_transfer(rs->master);
+	spi_finalize_current_transfer(master);
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
@@ -401,7 +402,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			return -EINVAL;
 
 		rxdesc->callback = rockchip_spi_dma_rxcb;
-		rxdesc->callback_param = rs;
+		rxdesc->callback_param = master;
 	}
 
 	txdesc = NULL;
@@ -426,7 +427,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 		}
 
 		txdesc->callback = rockchip_spi_dma_txcb;
-		txdesc->callback_param = rs;
+		txdesc->callback_param = master;
 	}
 
 	/* rx must be started before tx due to spi instinct */
@@ -633,7 +634,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
-	rs->master = master;
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
 
@@ -746,9 +746,8 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	ret = spi_master_suspend(rs->master);
+	ret = spi_master_suspend(master);
 	if (ret < 0)
 		return ret;
 
@@ -773,7 +772,7 @@ static int rockchip_spi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = spi_master_resume(rs->master);
+	ret = spi_master_resume(master);
 	if (ret < 0) {
 		clk_disable_unprepare(rs->spiclk);
 		clk_disable_unprepare(rs->apb_pclk);
-- 
2.19.0.rc2

