Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA00BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6805A27E08
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UteO7VRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6805A27E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936012AbeF2LdX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935520AbeF2LdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:33:20 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94CC27E08;
        Fri, 29 Jun 2018 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530272000;
        bh=U/NOwqW3QEw5IMUMjam+l+Wpuvj8muXySQlXGHb+Tik=;
        h=From:To:Cc:Subject:Date:From;
        b=UteO7VRy55O36LE/suvzLTt18KaP3vhtNuBzcbVPE3J0eMpxb+EUt8WdKW6G7cdE0
         ofNw9yJ11NfAPZlDPQEaVXLSHJ1va2nPsg/v14Mj4krPZCpYMIdufXm1w59y24S3mG
         uZY9Pyn1sBVqeXO/ni9o5eEgEi8fcDs4GysqsZxw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe
Date:   Fri, 29 Jun 2018 13:33:09 +0200
Message-Id: <1530271989-9022-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.7.4

