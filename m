Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeETQcR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 12:32:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60782 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeETQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 12:32:09 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/6] clk: ingenic: jz4770: Change OTG from custom to standard gated clock
Date: Sun, 20 May 2018 16:31:14 +0000
Message-Id: <20180520163117.14125-3-paul@crapouillou.net>
In-Reply-To: <20180520163117.14125-1-paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have the means to express the specificities of the OTG clock with
the common CGU code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4770-cgu.c | 42 ++++----------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index c78d369b9403..226c8016f6b0 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -42,7 +42,6 @@
 
 /* bits within the OPCR register */
 #define OPCR_SPENDH		BIT(5)		/* UHC PHY suspend */
-#define OPCR_SPENDN		BIT(7)		/* OTG PHY suspend */
 
 /* bits within the USBPCR1 register */
 #define USBPCR1_UHC_POWER	BIT(5)		/* UHC PHY power down */
@@ -83,37 +82,6 @@ static const struct clk_ops jz4770_uhc_phy_ops = {
 	.is_enabled = jz4770_uhc_phy_is_enabled,
 };
 
-static int jz4770_otg_phy_enable(struct clk_hw *hw)
-{
-	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
-
-	writel(readl(reg_opcr) | OPCR_SPENDN, reg_opcr);
-
-	/* Wait for the clock to be stable */
-	udelay(50);
-	return 0;
-}
-
-static void jz4770_otg_phy_disable(struct clk_hw *hw)
-{
-	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
-
-	writel(readl(reg_opcr) & ~OPCR_SPENDN, reg_opcr);
-}
-
-static int jz4770_otg_phy_is_enabled(struct clk_hw *hw)
-{
-	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
-
-	return !!(readl(reg_opcr) & OPCR_SPENDN);
-}
-
-static const struct clk_ops jz4770_otg_phy_ops = {
-	.enable = jz4770_otg_phy_enable,
-	.disable = jz4770_otg_phy_disable,
-	.is_enabled = jz4770_otg_phy_is_enabled,
-};
-
 static const s8 pll_od_encoding[8] = {
 	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
 };
@@ -410,6 +378,11 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 		.parents = { JZ4770_CLK_MMC2_MUX, },
 		.gate = { CGU_REG_CLKGR0, 12 },
 	},
+	[JZ4770_CLK_OTG_PHY] = {
+		"usb_phy", CGU_CLK_GATE,
+		.parents = { JZ4770_CLK_OTG },
+		.gate = { CGU_REG_OPCR, 7, true, 50 },
+	},
 
 	/* Custom clocks */
 
@@ -418,11 +391,6 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 		.parents = { JZ4770_CLK_UHC, -1, -1, -1 },
 		.custom = { &jz4770_uhc_phy_ops },
 	},
-	[JZ4770_CLK_OTG_PHY] = {
-		"usb_phy", CGU_CLK_CUSTOM,
-		.parents = { JZ4770_CLK_OTG, -1, -1, -1 },
-		.custom = { &jz4770_otg_phy_ops },
-	},
 
 	[JZ4770_CLK_EXT512] = {
 		"ext/512", CGU_CLK_FIXDIV,
-- 
2.17.0
