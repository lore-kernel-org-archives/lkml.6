Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F402064A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F402064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeLCOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:19:28 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:48430 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLCOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:19:27 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 7SJ91z00P3XaVaC01SJ9h2; Mon, 03 Dec 2018 15:18:14 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gTp33-0003pp-0E; Mon, 03 Dec 2018 15:18:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gTp32-00063R-U8; Mon, 03 Dec 2018 15:18:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] dmaengine: sh: Remove R-Mobile APE6 support
Date:   Mon,  3 Dec 2018 15:18:06 +0100
Message-Id: <20181203141806.23232-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas R-Mobile APE6 support is currently unused:
  - DMA slaves were never enabled in r8a73a4.dtsi,
  - The driver relies on legacy filter matching and describing all
    slaves and MID/RIDs in a table, unlike modern DMA engine drivers for
    similar hardware like rcar-dmac,
  - The driver doesn't seem to work well.

Remove the driver, it can be resurrected from git history when needed.

As this was the last user of SH_DMAE_BASE on Renesas ARM SoCs, the
sh-dma-engine driver core is now used on SuperH only.

Note that the DT bindings are still present, as r8a73a4.dtsi uses them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Rebase against slave-dma/topic/sh,

v2:
  - Add Reviewed-by,
  - Drop RFC.

---
 drivers/dma/sh/Kconfig         | 11 +----
 drivers/dma/sh/Makefile        |  1 -
 drivers/dma/sh/shdma-r8a73a4.c | 74 ----------------------------------
 drivers/dma/sh/shdma.h         |  7 ----
 drivers/dma/sh/shdmac.c        |  7 ----
 5 files changed, 1 insertion(+), 99 deletions(-)
 delete mode 100644 drivers/dma/sh/shdma-r8a73a4.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 1c4675425a1eeb15..4d6b02b3b1f18e6f 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -13,7 +13,7 @@ config RENESAS_DMA
 
 config SH_DMAE_BASE
 	bool "Renesas SuperH DMA Engine support"
-	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on SUPERH || COMPILE_TEST
 	depends on !SUPERH || SH_DMA
 	depends on !SH_DMA_API
 	default y
@@ -31,15 +31,6 @@ config SH_DMAE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
 
-if SH_DMAE
-
-config SH_DMAE_R8A73A4
-	def_bool y
-	depends on ARCH_R8A73A4
-	depends on OF
-
-endif
-
 config RCAR_DMAC
 	tristate "Renesas R-Car Gen2 DMA Controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 7d7c9491ade1216d..42110dd57a56fda8 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
 #
 
 shdma-y := shdmac.o
-shdma-$(CONFIG_SH_DMAE_R8A73A4) += shdma-r8a73a4.o
 shdma-objs := $(shdma-y)
 obj-$(CONFIG_SH_DMAE) += shdma.o
 
diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
deleted file mode 100644
index ddc9a35783534bdd..0000000000000000
--- a/drivers/dma/sh/shdma-r8a73a4.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Renesas SuperH DMA Engine support for r8a73a4 (APE6) SoCs
- *
- * Copyright (C) 2013 Renesas Electronics, Inc.
- */
-#include <linux/sh_dma.h>
-
-#include "shdma-arm.h"
-
-static const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
-
-static const struct sh_dmae_slave_config dma_slaves[] = {
-	{
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xd1,		/* MMC0 Tx */
-	}, {
-		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xd2,		/* MMC0 Rx */
-	}, {
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xe1,		/* MMC1 Tx */
-	}, {
-		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xe2,		/* MMC1 Rx */
-	},
-};
-
-#define DMAE_CHANNEL(a, b)				\
-	{						\
-		.offset         = (a) - 0x20,		\
-		.dmars          = (a) - 0x20 + 0x40,	\
-		.chclr_bit	= (b),			\
-		.chclr_offset	= 0x80 - 0x20,		\
-	}
-
-static const struct sh_dmae_channel dma_channels[] = {
-	DMAE_CHANNEL(0x8000, 0),
-	DMAE_CHANNEL(0x8080, 1),
-	DMAE_CHANNEL(0x8100, 2),
-	DMAE_CHANNEL(0x8180, 3),
-	DMAE_CHANNEL(0x8200, 4),
-	DMAE_CHANNEL(0x8280, 5),
-	DMAE_CHANNEL(0x8300, 6),
-	DMAE_CHANNEL(0x8380, 7),
-	DMAE_CHANNEL(0x8400, 8),
-	DMAE_CHANNEL(0x8480, 9),
-	DMAE_CHANNEL(0x8500, 10),
-	DMAE_CHANNEL(0x8580, 11),
-	DMAE_CHANNEL(0x8600, 12),
-	DMAE_CHANNEL(0x8680, 13),
-	DMAE_CHANNEL(0x8700, 14),
-	DMAE_CHANNEL(0x8780, 15),
-	DMAE_CHANNEL(0x8800, 16),
-	DMAE_CHANNEL(0x8880, 17),
-	DMAE_CHANNEL(0x8900, 18),
-	DMAE_CHANNEL(0x8980, 19),
-};
-
-const struct sh_dmae_pdata r8a73a4_dma_pdata = {
-	.slave		= dma_slaves,
-	.slave_num	= ARRAY_SIZE(dma_slaves),
-	.channel	= dma_channels,
-	.channel_num	= ARRAY_SIZE(dma_channels),
-	.ts_low_shift	= TS_LOW_SHIFT,
-	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
-	.ts_high_shift	= TS_HI_SHIFT,
-	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
-	.ts_shift	= dma_ts_shift,
-	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
-	.dmaor_init     = DMAOR_DME,
-	.chclr_present	= 1,
-	.chclr_bitwise	= 1,
-};
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index bfb69909bd192759..9c121a4b33ad829c 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -58,11 +58,4 @@ struct sh_dmae_desc {
 #define to_sh_dev(chan) container_of(chan->shdma_chan.dma_chan.device,\
 				     struct sh_dmae_device, shdma_dev.dma_dev)
 
-#ifdef CONFIG_SH_DMAE_R8A73A4
-extern const struct sh_dmae_pdata r8a73a4_dma_pdata;
-#define r8a73a4_shdma_devid (&r8a73a4_dma_pdata)
-#else
-#define r8a73a4_shdma_devid NULL
-#endif
-
 #endif	/* __DMA_SHDMA_H */
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 7971ea2753877486..5aafe548ca5f3082 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -665,12 +665,6 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 	.get_partial = sh_dmae_get_partial,
 };
 
-static const struct of_device_id sh_dmae_of_match[] = {
-	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
-	{}
-};
-MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
-
 static int sh_dmae_probe(struct platform_device *pdev)
 {
 	const enum dma_slave_buswidth widths =
@@ -915,7 +909,6 @@ static struct platform_driver sh_dmae_driver = {
 	.driver		= {
 		.pm	= &sh_dmae_pm,
 		.name	= SH_DMAE_DRV_NAME,
-		.of_match_table = sh_dmae_of_match,
 	},
 	.remove		= sh_dmae_remove,
 };
-- 
2.17.1

