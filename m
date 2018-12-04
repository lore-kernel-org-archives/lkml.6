Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CFE20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CFE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeLDR6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:58:32 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:55568 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:58:32 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 5012CB0059;
        Tue,  4 Dec 2018 19:58:30 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: add MMC configuration for Palm Tungsten E
Date:   Tue,  4 Dec 2018 19:58:12 +0200
Message-Id: <20181204175812.2678-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial MMC configuration for Palm Tungsten E to allow using a proper
rootfs on the device. This still assumes the bootloader enabling the MMC,
and that the card is always present and writeable.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-palmte.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 2dc5deb19803..d4d8a32e57eb 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -43,6 +43,7 @@
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
+#include "mmc.h"
 #include "common.h"
 
 #define PALMTE_USBDETECT_GPIO	0
@@ -208,6 +209,33 @@ static void __init palmte_misc_gpio_setup(void)
 	gpio_direction_input(PALMTE_USB_OR_DC_GPIO);
 }
 
+#if IS_ENABLED(CONFIG_MMC_OMAP)
+
+static struct omap_mmc_platform_data _palmte_mmc_config = {
+	.nr_slots			= 1,
+	.slots[0]			= {
+		.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
+		.name			= "mmcblk",
+	},
+};
+
+static struct omap_mmc_platform_data *palmte_mmc_config[OMAP15XX_NR_MMC] = {
+	[0] = &_palmte_mmc_config,
+};
+
+static void palmte_mmc_init(void)
+{
+	omap1_init_mmc(palmte_mmc_config, OMAP15XX_NR_MMC);
+}
+
+#else /* CONFIG_MMC_OMAP */
+
+static void palmte_mmc_init(void)
+{
+}
+
+#endif /* CONFIG_MMC_OMAP */
+
 static void __init omap_palmte_init(void)
 {
 	/* mux pins for uarts */
@@ -228,6 +256,7 @@ static void __init omap_palmte_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	omapfb_set_lcd_config(&palmte_lcd_config);
+	palmte_mmc_init();
 }
 
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
-- 
2.17.0

