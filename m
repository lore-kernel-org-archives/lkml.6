Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbeBVN2d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:28:33 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:50707 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753750AbeBVN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:28:31 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        Niklas Cassel <niklass@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@axis.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: artpec-6: Add smaller groups for uarts
Date: Thu, 22 Feb 2018 14:27:05 +0100
Message-Id: <20180222132705.18314-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Nilsson <jesper.nilsson@axis.com>

Add group configuration for uarts that are cut down
variants, the standard being full, i.e. all signals,
flow control, i.e. rx/tx and cts/rts, and rx/tx only.

This allows us to be more precise in which pins we're
actually using.

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pinctrl/pinctrl-artpec6.c | 66 +++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
index e33781cd0a05..d89dc43c5757 100644
--- a/drivers/pinctrl/pinctrl-artpec6.c
+++ b/drivers/pinctrl/pinctrl-artpec6.c
@@ -277,37 +277,61 @@ static const struct artpec6_pin_group artpec6_pin_groups[] = {
 		.config = ARTPEC6_CONFIG_3,
 	},
 	{
-		.name = "uart0grp0",
+		.name = "uart0grp0",	/* All pins. */
 		.pins = uart0_pins0,
 		.num_pins = ARRAY_SIZE(uart0_pins0),
 		.config = ARTPEC6_CONFIG_1,
 	},
 	{
-		.name = "uart0grp1",
+		.name = "uart0grp1",	/* RX/TX and RTS/CTS */
 		.pins = uart0_pins1,
 		.num_pins = ARRAY_SIZE(uart0_pins1),
 		.config = ARTPEC6_CONFIG_1,
 	},
 	{
-		.name = "uart1grp0",
+		.name = "uart0grp2",	/* Only RX/TX pins. */
+		.pins = uart0_pins1,
+		.num_pins = ARRAY_SIZE(uart0_pins1) - 2,
+		.config = ARTPEC6_CONFIG_1,
+	},
+	{
+		.name = "uart1grp0",	/* RX/TX and RTS/CTS */
 		.pins = uart1_pins0,
 		.num_pins = ARRAY_SIZE(uart1_pins0),
 		.config = ARTPEC6_CONFIG_2,
 	},
 	{
-		.name = "uart2grp0",
+		.name = "uart1grp1",	/* Only RX/TX pins. */
+		.pins = uart1_pins0,
+		.num_pins = 2,
+		.config = ARTPEC6_CONFIG_2,
+	},
+	{
+		.name = "uart2grp0",	/* Full pinout */
 		.pins = uart2_pins0,
 		.num_pins = ARRAY_SIZE(uart2_pins0),
 		.config = ARTPEC6_CONFIG_1,
 	},
 	{
-		.name = "uart2grp1",
+		.name = "uart2grp1",	/* RX/TX and RTS/CTS */
 		.pins = uart2_pins1,
 		.num_pins = ARRAY_SIZE(uart2_pins1),
 		.config = ARTPEC6_CONFIG_1,
 	},
 	{
-		.name = "uart3grp0",
+		.name = "uart2grp2",	/* Only RX/TX */
+		.pins = uart2_pins1,
+		.num_pins = 2,
+		.config = ARTPEC6_CONFIG_1,
+	},
+	{
+		.name = "uart3grp0",	/* RX/TX and CTS/RTS */
+		.pins = uart3_pins0,
+		.num_pins = ARRAY_SIZE(uart3_pins0),
+		.config = ARTPEC6_CONFIG_0,
+	},
+	{
+		.name = "uart3grp1",	/* Only RX/TX */
 		.pins = uart3_pins0,
 		.num_pins = ARRAY_SIZE(uart3_pins0),
 		.config = ARTPEC6_CONFIG_0,
@@ -319,13 +343,19 @@ static const struct artpec6_pin_group artpec6_pin_groups[] = {
 		.config = ARTPEC6_CONFIG_2,
 	},
 	{
-		.name = "uart5grp0",
+		.name = "uart5grp0",	/* TX/RX and RTS/CTS */
 		.pins = uart5_pins0,
 		.num_pins = ARRAY_SIZE(uart5_pins0),
 		.config = ARTPEC6_CONFIG_2,
 	},
 	{
-		.name = "uart5nocts",
+		.name = "uart5grp1",	/* Only TX/RX */
+		.pins = uart5_pins0,
+		.num_pins = 2,
+		.config = ARTPEC6_CONFIG_2,
+	},
+	{
+		.name = "uart5nocts",	/* TX/RX/RTS */
 		.pins = uart5_pins0,
 		.num_pins = ARRAY_SIZE(uart5_pins0) - 1,
 		.config = ARTPEC6_CONFIG_2,
@@ -457,8 +487,9 @@ static const char * const gpiogrps[] = {
 	"cpuclkoutgrp0", "udlclkoutgrp0", "i2c1grp0", "i2c2grp0",
 	"i2c3grp0", "i2s0grp0", "i2s1grp0", "i2srefclkgrp0",
 	"spi0grp0", "spi1grp0", "pciedebuggrp0", "uart0grp0",
-	"uart0grp1", "uart1grp0", "uart2grp0", "uart2grp1",
-	"uart4grp0", "uart5grp0",
+	"uart0grp1", "uart0grp2", "uart1grp0", "uart1grp1",
+	"uart2grp0", "uart2grp1", "uart2grp2", "uart4grp0", "uart5grp0",
+	"uart5grp1", "uart5nocts",
 };
 static const char * const cpuclkoutgrps[] = { "cpuclkoutgrp0" };
 static const char * const udlclkoutgrps[] = { "udlclkoutgrp0" };
@@ -471,12 +502,15 @@ static const char * const i2srefclkgrps[] = { "i2srefclkgrp0" };
 static const char * const spi0grps[]	  = { "spi0grp0" };
 static const char * const spi1grps[]	  = { "spi1grp0" };
 static const char * const pciedebuggrps[] = { "pciedebuggrp0" };
-static const char * const uart0grps[]	  = { "uart0grp0", "uart0grp1" };
-static const char * const uart1grps[]	  = { "uart1grp0" };
-static const char * const uart2grps[]	  = { "uart2grp0", "uart2grp1" };
+static const char * const uart0grps[]	  = { "uart0grp0", "uart0grp1",
+					      "uart0grp2" };
+static const char * const uart1grps[]	  = { "uart1grp0", "uart1grp1" };
+static const char * const uart2grps[]	  = { "uart2grp0", "uart2grp1",
+					      "uart2grp2" };
 static const char * const uart3grps[]	  = { "uart3grp0" };
-static const char * const uart4grps[]	  = { "uart4grp0" };
-static const char * const uart5grps[]	  = { "uart5grp0", "uart5nocts" };
+static const char * const uart4grps[]	  = { "uart4grp0", "uart4grp1" };
+static const char * const uart5grps[]	  = { "uart5grp0", "uart5grp1",
+					      "uart5nocts" };
 static const char * const nandgrps[]	  = { "nandgrp0" };
 static const char * const sdio0grps[]	  = { "sdio0grp0" };
 static const char * const sdio1grps[]	  = { "sdio1grp0" };
@@ -601,7 +635,7 @@ static int artpec6_pmx_get_functions_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *artpec6_pmx_get_fname(struct pinctrl_dev *pctldev,
-				  unsigned int function)
+					 unsigned int function)
 {
 	return artpec6_pmx_functions[function].name;
 }
-- 
2.14.2
