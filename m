Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD9FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A7D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeIHCRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:17:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeIHCRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:17:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48F3BACC;
        Fri,  7 Sep 2018 21:34:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 05/63] spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe
Date:   Fri,  7 Sep 2018 23:09:36 +0200
Message-Id: <20180907211013.250081975@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit d8ffee2f551a627ffb7b216e2da322cb9a037f77 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-fsl-dspi.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -715,31 +715,31 @@ static int dspi_probe(struct platform_de
 		return PTR_ERR(dspi->regmap);
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
+		goto out_clk_put;
 	}
 
-	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
-	if (IS_ERR(dspi->clk)) {
-		ret = PTR_ERR(dspi->clk);
-		dev_err(&pdev->dev, "unable to get clock\n");
-		goto out_master_put;
-	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto out_master_put;
-
 	master->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
 


