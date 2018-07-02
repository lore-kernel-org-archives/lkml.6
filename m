Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78904C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2721925C00
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nuwyT8/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2721925C00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965245AbeGBKMp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:12:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965175AbeGBKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=larZ7jxOKickW4zLUhXRfgsVq/i738sEaq4GB62MHgw=; b=nuwyT8/xCFAG
        6W4fGI9YCb3/uruOZTDNnNjO+5wHV8We3mJ5Ee6gVJAuz4+T9GIl4g2J1KAEDoCyQ8zJeLK1WtEkg
        HpxDKB1McgG53zcLAPUftDmcaZ9isxE+zb+yoF6dc7/D8WAppf7+itjuFaX2BC5Lg77WykGksXKil
        oIEfg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvol-00045a-2P; Mon, 02 Jul 2018 10:12:23 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvok-0006lt-LT; Mon, 02 Jul 2018 11:12:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>, stable@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe" to the spi tree
In-Reply-To:  <1530271989-9022-1-git-send-email-krzk@kernel.org>
Message-Id: <E1fZvok-0006lt-LT@debutante>
Date:   Mon, 02 Jul 2018 11:12:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

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

From d8ffee2f551a627ffb7b216e2da322cb9a037f77 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 29 Jun 2018 13:33:09 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Registers of DSPI should not be accessed before enabling its clock.  On
Toradex Colibri VF50 on Iris carrier board this could be seen during
bootup as imprecise abort:

    Unhandled fault: imprecise external abort (0x1c06) at 0x00000000
    Internal error: : 1c06 [#1] ARM
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper Not tainted 4.14.39-dirty #97
    Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
    Backtrace:
    [<804166a8>] (regmap_write) from [<80466b5c>] (dspi_probe+0x1f0/0x8dc)
    [<8046696c>] (dspi_probe) from [<8040107c>] (platform_drv_probe+0x54/0xb8)
    [<80401028>] (platform_drv_probe) from [<803ff53c>] (driver_probe_device+0x280/0x2f8)
    [<803ff2bc>] (driver_probe_device) from [<803ff674>] (__driver_attach+0xc0/0xc4)
    [<803ff5b4>] (__driver_attach) from [<803fd818>] (bus_for_each_dev+0x70/0xa4)
    [<803fd7a8>] (bus_for_each_dev) from [<803fee74>] (driver_attach+0x24/0x28)
    [<803fee50>] (driver_attach) from [<803fe980>] (bus_add_driver+0x1a0/0x218)
    [<803fe7e0>] (bus_add_driver) from [<803fffe8>] (driver_register+0x80/0x100)
    [<803fff68>] (driver_register) from [<80400fdc>] (__platform_driver_register+0x48/0x50)
    [<80400f94>] (__platform_driver_register) from [<8091cf7c>] (fsl_dspi_driver_init+0x1c/0x20)
    [<8091cf60>] (fsl_dspi_driver_init) from [<8010195c>] (do_one_initcall+0x4c/0x174)
    [<80101910>] (do_one_initcall) from [<80900e8c>] (kernel_init_freeable+0x144/0x1d8)
    [<80900d48>] (kernel_init_freeable) from [<805ff6a8>] (kernel_init+0x10/0x114)
    [<805ff698>] (kernel_init) from [<80107be8>] (ret_from_fork+0x14/0x2c)

Cc: <stable@vger.kernel.org>
Fixes: 5ee67b587a2b ("spi: dspi: clear SPI_SR before enable interrupt")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ff7456be9d6d..89a1e7a4fe5d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1071,30 +1071,30 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
+	if (IS_ERR(dspi->clk)) {
+		ret = PTR_ERR(dspi->clk);
+		dev_err(&pdev->dev, "unable to get clock\n");
+		goto out_master_put;
+	}
+	ret = clk_prepare_enable(dspi->clk);
+	if (ret)
+		goto out_master_put;
+
 	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
 		dev_err(&pdev->dev, "can't get platform irq\n");
 		ret = dspi->irq;
-		goto out_master_put;
+		goto out_clk_put;
 	}
 
 	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt, 0,
 			pdev->name, dspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
-		goto out_master_put;
-	}
-
-	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
-	if (IS_ERR(dspi->clk)) {
-		ret = PTR_ERR(dspi->clk);
-		dev_err(&pdev->dev, "unable to get clock\n");
-		goto out_master_put;
+		goto out_clk_put;
 	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto out_master_put;
 
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 		ret = dspi_request_dma(dspi, res->start);
-- 
2.18.0.rc2

