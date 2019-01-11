Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60435C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E920874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfAKOY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:24:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47329 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfAKOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:23 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054M-7B; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002wR-4U; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 04/11] MIPS: ath79: make specifying the reference clock in DT optional
Date:   Fri, 11 Jan 2019 15:22:33 +0100
Message-Id: <20190111142240.10908-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111142240.10908-1-o.rempel@pengutronix.de>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

It can be autodetected for many SoCs using the strapping options.
If the clock is specified in DT, the autodetected value is ignored

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c | 84 ++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 984b3cdebd22..6262253622b3 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -80,6 +80,18 @@ static struct clk * __init ath79_set_ff_clk(int type, const char *parent,
 	return clk;
 }
 
+static unsigned long __init ath79_setup_ref_clk(unsigned long rate)
+{
+	struct clk *clk = clks[ATH79_CLK_REF];
+
+	if (clk)
+		rate = clk_get_rate(clk);
+	else
+		clk = ath79_set_clk(ATH79_CLK_REF, rate);
+
+	return rate;
+}
+
 static void __init ar71xx_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
@@ -90,7 +102,7 @@ static void __init ar71xx_clocks_init(void __iomem *pll_base)
 	u32 freq;
 	u32 div;
 
-	ref_rate = AR71XX_BASE_FREQ;
+	ref_rate = ath79_setup_ref_clk(AR71XX_BASE_FREQ);
 
 	pll = __raw_readl(pll_base + AR71XX_PLL_REG_CPU_CONFIG);
 
@@ -106,16 +118,17 @@ static void __init ar71xx_clocks_init(void __iomem *pll_base)
 	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 }
 
-static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
+static void __init ar724x_clocks_init(void __iomem *pll_base)
 {
-	u32 pll;
 	u32 mult, div, ddr_div, ahb_div;
+	u32 pll;
+
+	ath79_setup_ref_clk(AR71XX_BASE_FREQ);
 
 	pll = __raw_readl(pll_base + AR724X_PLL_REG_CPU_CONFIG);
 
@@ -130,17 +143,9 @@ static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", mult, div * ahb_div);
 }
 
-static void __init ar724x_clocks_init(void __iomem *pll_base)
-{
-	struct clk *ref_clk;
-
-	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
-
-	ar724x_clk_init(ref_clk, pll_base);
-}
-
-static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
+static void __init ar933x_clocks_init(void __iomem *pll_base)
 {
+	unsigned long ref_rate;
 	u32 clock_ctrl;
 	u32 ref_div;
 	u32 ninit_mul;
@@ -149,6 +154,15 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	u32 cpu_div;
 	u32 ddr_div;
 	u32 ahb_div;
+	u32 t;
+
+	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
+		ref_rate = (40 * 1000 * 1000);
+	else
+		ref_rate = (25 * 1000 * 1000);
+
+	ath79_setup_ref_clk(ref_rate);
 
 	clock_ctrl = __raw_readl(pll_base + AR933X_PLL_CLOCK_CTRL_REG);
 	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
@@ -197,23 +211,6 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 			 ref_div * out_div * ahb_div);
 }
 
-static void __init ar933x_clocks_init(void __iomem *pll_base)
-{
-	struct clk *ref_clk;
-	unsigned long ref_rate;
-	u32 t;
-
-	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
-	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
-		ref_rate = (40 * 1000 * 1000);
-	else
-		ref_rate = (25 * 1000 * 1000);
-
-	ref_clk = ath79_set_clk(ATH79_CLK_REF, ref_rate);
-
-	ar9330_clk_init(ref_clk, ath79_pll_base);
-}
-
 static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
 				      u32 frac, u32 out_div)
 {
@@ -253,6 +250,8 @@ static void __init ar934x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(dpll_base + AR934X_SRIF_CPU_DPLL2_REG);
 	if (pll & AR934X_SRIF_DPLL2_LOCAL_PLL) {
 		out_div = (pll >> AR934X_SRIF_DPLL2_OUTDIV_SHIFT) &
@@ -339,7 +338,6 @@ static void __init ar934x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -363,6 +361,8 @@ static void __init qca953x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(pll_base + QCA953X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA953X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA953X_PLL_CPU_CONFIG_OUTDIV_MASK;
@@ -423,7 +423,6 @@ static void __init qca953x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -445,6 +444,8 @@ static void __init qca955x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(pll_base + QCA955X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA955X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA955X_PLL_CPU_CONFIG_OUTDIV_MASK;
@@ -505,7 +506,6 @@ static void __init qca955x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -537,6 +537,8 @@ static void __init qca956x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(pll_base + QCA956X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA956X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA956X_PLL_CPU_CONFIG_OUTDIV_MASK;
@@ -606,7 +608,6 @@ static void __init qca956x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -682,10 +683,8 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 	void __iomem *pll_base;
 
 	ref_clk = of_clk_get(np, 0);
-	if (IS_ERR(ref_clk)) {
-		pr_err("%pOF: of_clk_get failed\n", np);
-		goto err;
-	}
+	if (!IS_ERR(ref_clk))
+		clks[ATH79_CLK_REF] = ref_clk;
 
 	pll_base = of_iomap(np, 0);
 	if (!pll_base) {
@@ -694,9 +693,9 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 	}
 
 	if (of_device_is_compatible(np, "qca,ar9130-pll"))
-		ar724x_clk_init(ref_clk, pll_base);
+		ar724x_clocks_init(pll_base);
 	else if (of_device_is_compatible(np, "qca,ar9330-pll"))
-		ar9330_clk_init(ref_clk, pll_base);
+		ar933x_clocks_init(pll_base);
 	else {
 		pr_err("%pOF: could not find any appropriate clk_init()\n", np);
 		goto err_iounmap;
@@ -714,9 +713,6 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 
 err_clk:
 	clk_put(ref_clk);
-
-err:
-	return;
 }
 CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt_ng);
 CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt_ng);
-- 
2.20.1

