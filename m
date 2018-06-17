Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19913C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E36208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E36208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936816AbeFQRDw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 13:03:52 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:49633 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936756AbeFQRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 13:03:22 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d83 with ME
        id zt2e1x00N41oiFu03t3KVH; Sun, 17 Jun 2018 19:03:20 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 17 Jun 2018 19:03:20 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Pitre <nico@fluxnic.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v3 13/14] ARM: pxa: remove the DMA IO resources
Date:   Sun, 17 Jun 2018 19:02:16 +0200
Message-Id: <20180617170217.24177-14-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180617170217.24177-1-robert.jarzmik@free.fr>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the last driver using the former mechanism to acquire the DMA
requestor line has be converted to the dma_slave_map, remove all these
resources from the PXA devices.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/devices.c | 136 --------------------------------------------
 1 file changed, 136 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 1e8915fc340d..5a16ea74e28a 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -60,16 +60,6 @@ static struct resource pxamci_resources[] = {
 		.end	= IRQ_MMC,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= 21,
-		.end	= 21,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= 22,
-		.end	= 22,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static u64 pxamci_dmamask = 0xffffffffUL;
@@ -407,16 +397,6 @@ static struct resource pxa_ir_resources[] = {
 		.end	= 0x40700023,
 		.flags  = IORESOURCE_MEM,
 	},
-	[5] = {
-		.start  = 17,
-		.end	= 17,
-		.flags  = IORESOURCE_DMA,
-	},
-	[6] = {
-		.start  = 18,
-		.end	= 18,
-		.flags  = IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa_device_ficp = {
@@ -545,18 +525,6 @@ static struct resource pxa25x_resource_ssp[] = {
 		.end	= IRQ_SSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 13,
-		.end	= 13,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 14,
-		.end	= 14,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa25x_device_ssp = {
@@ -583,18 +551,6 @@ static struct resource pxa25x_resource_nssp[] = {
 		.end	= IRQ_NSSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 15,
-		.end	= 15,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 16,
-		.end	= 16,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa25x_device_nssp = {
@@ -621,18 +577,6 @@ static struct resource pxa25x_resource_assp[] = {
 		.end	= IRQ_ASSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 23,
-		.end	= 23,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 24,
-		.end	= 24,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa25x_device_assp = {
@@ -751,18 +695,6 @@ static struct resource pxa27x_resource_ssp1[] = {
 		.end	= IRQ_SSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 13,
-		.end	= 13,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 14,
-		.end	= 14,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa27x_device_ssp1 = {
@@ -789,18 +721,6 @@ static struct resource pxa27x_resource_ssp2[] = {
 		.end	= IRQ_SSP2,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 15,
-		.end	= 15,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 16,
-		.end	= 16,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa27x_device_ssp2 = {
@@ -827,18 +747,6 @@ static struct resource pxa27x_resource_ssp3[] = {
 		.end	= IRQ_SSP3,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 66,
-		.end	= 66,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 67,
-		.end	= 67,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa27x_device_ssp3 = {
@@ -895,16 +803,6 @@ static struct resource pxa3xx_resources_mci2[] = {
 		.end	= IRQ_MMC2,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= 93,
-		.end	= 93,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= 94,
-		.end	= 94,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa3xx_device_mci2 = {
@@ -934,16 +832,6 @@ static struct resource pxa3xx_resources_mci3[] = {
 		.end	= IRQ_MMC3,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= 100,
-		.end	= 100,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= 101,
-		.end	= 101,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa3xx_device_mci3 = {
@@ -1021,18 +909,6 @@ static struct resource pxa3xx_resources_nand[] = {
 		.end	= IRQ_NAND,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for Data DMA */
-		.start	= 97,
-		.end	= 97,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for Command DMA */
-		.start	= 99,
-		.end	= 99,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static u64 pxa3xx_nand_dma_mask = DMA_BIT_MASK(32);
@@ -1066,18 +942,6 @@ static struct resource pxa3xx_resource_ssp4[] = {
 		.end	= IRQ_SSP4,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 2,
-		.end	= 2,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 3,
-		.end	= 3,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 /*
-- 
2.11.0

