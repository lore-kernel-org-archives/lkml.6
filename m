Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F7EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906672054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WG+lBtuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906672054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeH2TGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:06:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeH2TGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OxbIuPZfUy35SIgoOaIMpO1fn7+evcytPWvkSNefY8U=; b=WG+lBtuwC9Pl
        XMERYIh7I/XnD6ObFVJiqs2U0g0cDhFFMQJ6v0J9CSqvYNkIrOhVcj+cbIVCbEBfA3IQrtx0qAaFH
        zuKCqrzThbGAoL+lXgRKqh04Iat400uVQ/vG0J94bi/Ok9jxOuanQ5KYRHxr1pcwGfCIkMrKxt44h
        tdBmo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fv25q-0000QA-Ez; Wed, 29 Aug 2018 15:09:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 30C5B112486B; Wed, 29 Aug 2018 16:09:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw-mmio: add MSCC Jaguar2 support" to the spi tree
In-Reply-To:  <20180829124548.4703-1-alexandre.belloni@bootlin.com>
Message-Id: <20180829150914.30C5B112486B@debutante.sirena.org.uk>
Date:   Wed, 29 Aug 2018 16:09:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw-mmio: add MSCC Jaguar2 support

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

From be17ee0da35a5fe75813adb8e2c110c5541c8456 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 29 Aug 2018 14:45:48 +0200
Subject: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support

Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
layout than the Ocelot one. Handle that while keeping most of the code
common.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index e80f60ed6fdf..351f49976161 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -34,8 +34,8 @@ struct dw_spi_mmio {
 };
 
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
-#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
 #define OCELOT_IF_SI_OWNER_OFFSET		4
+#define JAGUAR2_IF_SI_OWNER_OFFSET		6
 #define MSCC_IF_SI_OWNER_SISL			0
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2
@@ -76,7 +76,8 @@ static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
 }
 
 static int dw_spi_mscc_init(struct platform_device *pdev,
-			    struct dw_spi_mmio *dwsmmio)
+			    struct dw_spi_mmio *dwsmmio,
+			    const char *cpu_syscon, u32 if_si_owner_offset)
 {
 	struct dw_spi_mscc *dwsmscc;
 	struct resource *res;
@@ -92,7 +93,7 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 		return PTR_ERR(dwsmscc->spi_mst);
 	}
 
-	dwsmscc->syscon = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
+	dwsmscc->syscon = syscon_regmap_lookup_by_compatible(cpu_syscon);
 	if (IS_ERR(dwsmscc->syscon))
 		return PTR_ERR(dwsmscc->syscon);
 
@@ -101,8 +102,8 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 
 	/* Select the owner of the SI interface */
 	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   OCELOT_IF_SI_OWNER_MASK,
-			   MSCC_IF_SI_OWNER_SIMC << OCELOT_IF_SI_OWNER_OFFSET);
+			   0x3 << if_si_owner_offset,
+			   MSCC_IF_SI_OWNER_SIMC << if_si_owner_offset);
 
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
 	dwsmmio->priv = dwsmscc;
@@ -110,6 +111,20 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_mscc_ocelot_init(struct platform_device *pdev,
+				   struct dw_spi_mmio *dwsmmio)
+{
+	return dw_spi_mscc_init(pdev, dwsmmio, "mscc,ocelot-cpu-syscon",
+				OCELOT_IF_SI_OWNER_OFFSET);
+}
+
+static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
+				    struct dw_spi_mmio *dwsmmio)
+{
+	return dw_spi_mscc_init(pdev, dwsmmio, "mscc,jaguar2-cpu-syscon",
+				JAGUAR2_IF_SI_OWNER_OFFSET);
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -212,7 +227,8 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
-	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
+	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
+	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.18.0

