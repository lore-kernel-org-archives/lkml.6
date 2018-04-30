Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeD3I0C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:26:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37582 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeD3IZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:34 -0400
X-Google-Smtp-Source: AB8JxZoUibvfkBFyO35v3F8Bq8axvRw0Fennzf2kC7+tSUzr1yx6D+AJmd1jqqebM7GAvKbAFgulpQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/12] ARM: davinci: aemif: stop using pdev->id as nand chipselect
Date: Mon, 30 Apr 2018 10:24:53 +0200
Message-Id: <20180430082453.8091-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All platforms now use the core_chipsel field in platform_data. Stop
using pdev->id in the aemif code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/aemif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
index ff8b7e76b6e9..e4ab3f3a2a1f 100644
--- a/arch/arm/mach-davinci/aemif.c
+++ b/arch/arm/mach-davinci/aemif.c
@@ -189,7 +189,7 @@ int davinci_aemif_setup(struct platform_device *pdev)
 	 * Setup Async configuration register in case we did not boot
 	 * from NAND and so bootloader did not bother to set it up.
 	 */
-	val = davinci_aemif_readl(base, A1CR_OFFSET + pdev->id * 4);
+	val = davinci_aemif_readl(base, A1CR_OFFSET + pdata->core_chipsel * 4);
 	/*
 	 * Extended Wait is not valid and Select Strobe mode is not
 	 * used
@@ -198,13 +198,13 @@ int davinci_aemif_setup(struct platform_device *pdev)
 	if (pdata->options & NAND_BUSWIDTH_16)
 		val |= 0x1;
 
-	davinci_aemif_writel(base, A1CR_OFFSET + pdev->id * 4, val);
+	davinci_aemif_writel(base, A1CR_OFFSET + pdata->core_chipsel * 4, val);
 
 	clkrate = clk_get_rate(clk);
 
 	if (pdata->timing)
-		ret = davinci_aemif_setup_timing(pdata->timing, base, pdev->id,
-						 clkrate);
+		ret = davinci_aemif_setup_timing(pdata->timing, base,
+						 pdata->core_chipsel, clkrate);
 
 	if (ret < 0)
 		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
-- 
2.17.0
