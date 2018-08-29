Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27228C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3D02086E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3D02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeH2Qms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:42:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53934 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeH2Qms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:42:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B0DCC2072C; Wed, 29 Aug 2018 14:46:00 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7DFFF2072C;
        Wed, 29 Aug 2018 14:45:50 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
Date:   Wed, 29 Aug 2018 14:45:48 +0200
Message-Id: <20180829124548.4703-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
layout than the Ocelot one. Handle that while keeping most of the code
common.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Hi,

This is really unfortunate and I hope it will not be necessary to do the same
for every SoC in the line.

I didn't use a regmap_field because it is only accessed once at probe time.

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

