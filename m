Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D85C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0DE2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbfAKOXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:23:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37369 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388142AbfAKOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:28 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054L-7E; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002wG-3Y; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 03/11] MIPS: ath79: pass PLL base to clock init functions
Date:   Fri, 11 Jan 2019 15:22:32 +0100
Message-Id: <20190111142240.10908-4-o.rempel@pengutronix.de>
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

Preparation for passing the mapped base via DT

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index e02b819b2f5d..984b3cdebd22 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -80,7 +80,7 @@ static struct clk * __init ath79_set_ff_clk(int type, const char *parent,
 	return clk;
 }
 
-static void __init ar71xx_clocks_init(void)
+static void __init ar71xx_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
 	unsigned long cpu_rate;
@@ -92,7 +92,7 @@ static void __init ar71xx_clocks_init(void)
 
 	ref_rate = AR71XX_BASE_FREQ;
 
-	pll = ath79_pll_rr(AR71XX_PLL_REG_CPU_CONFIG);
+	pll = __raw_readl(pll_base + AR71XX_PLL_REG_CPU_CONFIG);
 
 	div = ((pll >> AR71XX_PLL_FB_SHIFT) & AR71XX_PLL_FB_MASK) + 1;
 	freq = div * ref_rate;
@@ -130,13 +130,13 @@ static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", mult, div * ahb_div);
 }
 
-static void __init ar724x_clocks_init(void)
+static void __init ar724x_clocks_init(void __iomem *pll_base)
 {
 	struct clk *ref_clk;
 
 	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
 
-	ar724x_clk_init(ref_clk, ath79_pll_base);
+	ar724x_clk_init(ref_clk, pll_base);
 }
 
 static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
@@ -197,7 +197,7 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 			 ref_div * out_div * ahb_div);
 }
 
-static void __init ar933x_clocks_init(void)
+static void __init ar933x_clocks_init(void __iomem *pll_base)
 {
 	struct clk *ref_clk;
 	unsigned long ref_rate;
@@ -234,7 +234,7 @@ static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
 	return ret;
 }
 
-static void __init ar934x_clocks_init(void)
+static void __init ar934x_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
 	unsigned long cpu_rate;
@@ -265,7 +265,7 @@ static void __init ar934x_clocks_init(void)
 			  AR934X_SRIF_DPLL1_REFDIV_MASK;
 		frac = 1 << 18;
 	} else {
-		pll = ath79_pll_rr(AR934X_PLL_CPU_CONFIG_REG);
+		pll = __raw_readl(pll_base + AR934X_PLL_CPU_CONFIG_REG);
 		out_div = (pll >> AR934X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 			AR934X_PLL_CPU_CONFIG_OUTDIV_MASK;
 		ref_div = (pll >> AR934X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
@@ -292,7 +292,7 @@ static void __init ar934x_clocks_init(void)
 			  AR934X_SRIF_DPLL1_REFDIV_MASK;
 		frac = 1 << 18;
 	} else {
-		pll = ath79_pll_rr(AR934X_PLL_DDR_CONFIG_REG);
+		pll = __raw_readl(pll_base + AR934X_PLL_DDR_CONFIG_REG);
 		out_div = (pll >> AR934X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
 			  AR934X_PLL_DDR_CONFIG_OUTDIV_MASK;
 		ref_div = (pll >> AR934X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
@@ -307,7 +307,7 @@ static void __init ar934x_clocks_init(void)
 	ddr_pll = ar934x_get_pll_freq(ref_rate, ref_div, nint,
 				      nfrac, frac, out_div);
 
-	clk_ctrl = ath79_pll_rr(AR934X_PLL_CPU_DDR_CLK_CTRL_REG);
+	clk_ctrl = __raw_readl(pll_base + AR934X_PLL_CPU_DDR_CLK_CTRL_REG);
 
 	postdiv = (clk_ctrl >> AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_SHIFT) &
 		  AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_MASK;
@@ -347,7 +347,7 @@ static void __init ar934x_clocks_init(void)
 	iounmap(dpll_base);
 }
 
-static void __init qca953x_clocks_init(void)
+static void __init qca953x_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
 	unsigned long cpu_rate;
@@ -363,7 +363,7 @@ static void __init qca953x_clocks_init(void)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
-	pll = ath79_pll_rr(QCA953X_PLL_CPU_CONFIG_REG);
+	pll = __raw_readl(pll_base + QCA953X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA953X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA953X_PLL_CPU_CONFIG_OUTDIV_MASK;
 	ref_div = (pll >> QCA953X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
@@ -377,7 +377,7 @@ static void __init qca953x_clocks_init(void)
 	cpu_pll += frac * (ref_rate >> 6) / ref_div;
 	cpu_pll /= (1 << out_div);
 
-	pll = ath79_pll_rr(QCA953X_PLL_DDR_CONFIG_REG);
+	pll = __raw_readl(pll_base + QCA953X_PLL_DDR_CONFIG_REG);
 	out_div = (pll >> QCA953X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
 		  QCA953X_PLL_DDR_CONFIG_OUTDIV_MASK;
 	ref_div = (pll >> QCA953X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
@@ -391,7 +391,7 @@ static void __init qca953x_clocks_init(void)
 	ddr_pll += frac * (ref_rate >> 6) / (ref_div << 4);
 	ddr_pll /= (1 << out_div);
 
-	clk_ctrl = ath79_pll_rr(QCA953X_PLL_CLK_CTRL_REG);
+	clk_ctrl = __raw_readl(pll_base + QCA953X_PLL_CLK_CTRL_REG);
 
 	postdiv = (clk_ctrl >> QCA953X_PLL_CLK_CTRL_CPU_POST_DIV_SHIFT) &
 		  QCA953X_PLL_CLK_CTRL_CPU_POST_DIV_MASK;
@@ -429,7 +429,7 @@ static void __init qca953x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 }
 
-static void __init qca955x_clocks_init(void)
+static void __init qca955x_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
 	unsigned long cpu_rate;
@@ -445,7 +445,7 @@ static void __init qca955x_clocks_init(void)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
-	pll = ath79_pll_rr(QCA955X_PLL_CPU_CONFIG_REG);
+	pll = __raw_readl(pll_base + QCA955X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA955X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA955X_PLL_CPU_CONFIG_OUTDIV_MASK;
 	ref_div = (pll >> QCA955X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
@@ -459,7 +459,7 @@ static void __init qca955x_clocks_init(void)
 	cpu_pll += frac * ref_rate / (ref_div * (1 << 6));
 	cpu_pll /= (1 << out_div);
 
-	pll = ath79_pll_rr(QCA955X_PLL_DDR_CONFIG_REG);
+	pll = __raw_readl(pll_base + QCA955X_PLL_DDR_CONFIG_REG);
 	out_div = (pll >> QCA955X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
 		  QCA955X_PLL_DDR_CONFIG_OUTDIV_MASK;
 	ref_div = (pll >> QCA955X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
@@ -473,7 +473,7 @@ static void __init qca955x_clocks_init(void)
 	ddr_pll += frac * ref_rate / (ref_div * (1 << 10));
 	ddr_pll /= (1 << out_div);
 
-	clk_ctrl = ath79_pll_rr(QCA955X_PLL_CLK_CTRL_REG);
+	clk_ctrl = __raw_readl(pll_base + QCA955X_PLL_CLK_CTRL_REG);
 
 	postdiv = (clk_ctrl >> QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_SHIFT) &
 		  QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_MASK;
@@ -511,7 +511,7 @@ static void __init qca955x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 }
 
-static void __init qca956x_clocks_init(void)
+static void __init qca956x_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
 	unsigned long cpu_rate;
@@ -537,13 +537,13 @@ static void __init qca956x_clocks_init(void)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
-	pll = ath79_pll_rr(QCA956X_PLL_CPU_CONFIG_REG);
+	pll = __raw_readl(pll_base + QCA956X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA956X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA956X_PLL_CPU_CONFIG_OUTDIV_MASK;
 	ref_div = (pll >> QCA956X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
 		  QCA956X_PLL_CPU_CONFIG_REFDIV_MASK;
 
-	pll = ath79_pll_rr(QCA956X_PLL_CPU_CONFIG1_REG);
+	pll = __raw_readl(pll_base + QCA956X_PLL_CPU_CONFIG1_REG);
 	nint = (pll >> QCA956X_PLL_CPU_CONFIG1_NINT_SHIFT) &
 	       QCA956X_PLL_CPU_CONFIG1_NINT_MASK;
 	hfrac = (pll >> QCA956X_PLL_CPU_CONFIG1_NFRAC_H_SHIFT) &
@@ -556,12 +556,12 @@ static void __init qca956x_clocks_init(void)
 	cpu_pll += (hfrac >> 13) * ref_rate / ref_div;
 	cpu_pll /= (1 << out_div);
 
-	pll = ath79_pll_rr(QCA956X_PLL_DDR_CONFIG_REG);
+	pll = __raw_readl(pll_base + QCA956X_PLL_DDR_CONFIG_REG);
 	out_div = (pll >> QCA956X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
 		  QCA956X_PLL_DDR_CONFIG_OUTDIV_MASK;
 	ref_div = (pll >> QCA956X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
 		  QCA956X_PLL_DDR_CONFIG_REFDIV_MASK;
-	pll = ath79_pll_rr(QCA956X_PLL_DDR_CONFIG1_REG);
+	pll = __raw_readl(pll_base + QCA956X_PLL_DDR_CONFIG1_REG);
 	nint = (pll >> QCA956X_PLL_DDR_CONFIG1_NINT_SHIFT) &
 	       QCA956X_PLL_DDR_CONFIG1_NINT_MASK;
 	hfrac = (pll >> QCA956X_PLL_DDR_CONFIG1_NFRAC_H_SHIFT) &
@@ -574,7 +574,7 @@ static void __init qca956x_clocks_init(void)
 	ddr_pll += (hfrac >> 13) * ref_rate / ref_div;
 	ddr_pll /= (1 << out_div);
 
-	clk_ctrl = ath79_pll_rr(QCA956X_PLL_CLK_CTRL_REG);
+	clk_ctrl = __raw_readl(pll_base + QCA956X_PLL_CLK_CTRL_REG);
 
 	postdiv = (clk_ctrl >> QCA956X_PLL_CLK_CTRL_CPU_POST_DIV_SHIFT) &
 		  QCA956X_PLL_CLK_CTRL_CPU_POST_DIV_MASK;
@@ -618,19 +618,19 @@ void __init ath79_clocks_init(void)
 	const char *uart;
 
 	if (soc_is_ar71xx())
-		ar71xx_clocks_init();
+		ar71xx_clocks_init(ath79_pll_base);
 	else if (soc_is_ar724x() || soc_is_ar913x())
-		ar724x_clocks_init();
+		ar724x_clocks_init(ath79_pll_base);
 	else if (soc_is_ar933x())
-		ar933x_clocks_init();
+		ar933x_clocks_init(ath79_pll_base);
 	else if (soc_is_ar934x())
-		ar934x_clocks_init();
+		ar934x_clocks_init(ath79_pll_base);
 	else if (soc_is_qca953x())
-		qca953x_clocks_init();
+		qca953x_clocks_init(ath79_pll_base);
 	else if (soc_is_qca955x())
-		qca955x_clocks_init();
+		qca955x_clocks_init(ath79_pll_base);
 	else if (soc_is_qca956x() || soc_is_tp9343())
-		qca956x_clocks_init();
+		qca956x_clocks_init(ath79_pll_base);
 	else
 		BUG();
 
-- 
2.20.1

