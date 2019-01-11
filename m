Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04977C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95E520874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfAKOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:24:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56047 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbfAKOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:24 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054J-7B; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002vw-1e; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 01/11] MIPS: ath79: add helpers for setting clocks and expose the ref clock
Date:   Fri, 11 Jan 2019 15:22:30 +0100
Message-Id: <20190111142240.10908-2-o.rempel@pengutronix.de>
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

Preparation for transitioning the legacy clock setup code over
to OF.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c               | 128 +++++++++++++-------------
 include/dt-bindings/clock/ath79-clk.h |   3 +-
 2 files changed, 68 insertions(+), 63 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index cf9158e3c2d9..50bc3b01a4c4 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -37,20 +37,46 @@ static struct clk_onecell_data clk_data = {
 	.clk_num = ARRAY_SIZE(clks),
 };
 
-static struct clk *__init ath79_add_sys_clkdev(
-	const char *id, unsigned long rate)
+static const char * const clk_names[ATH79_CLK_END] = {
+	[ATH79_CLK_CPU] = "cpu",
+	[ATH79_CLK_DDR] = "ddr",
+	[ATH79_CLK_AHB] = "ahb",
+	[ATH79_CLK_REF] = "ref",
+};
+
+static const char * __init ath79_clk_name(int type)
 {
-	struct clk *clk;
-	int err;
+	BUG_ON(type >= ARRAY_SIZE(clk_names) || !clk_names[type]);
+	return clk_names[type];
+}
 
-	clk = clk_register_fixed_rate(NULL, id, NULL, 0, rate);
+static void __init __ath79_set_clk(int type, const char *name, struct clk *clk)
+{
 	if (IS_ERR(clk))
-		panic("failed to allocate %s clock structure", id);
+		panic("failed to allocate %s clock structure", clk_names[type]);
 
-	err = clk_register_clkdev(clk, id, NULL);
-	if (err)
-		panic("unable to register %s clock device", id);
+	clks[type] = clk;
+	clk_register_clkdev(clk, name, NULL);
+}
 
+static struct clk * __init ath79_set_clk(int type, unsigned long rate)
+{
+	const char *name = ath79_clk_name(type);
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, name, NULL, 0, rate);
+	__ath79_set_clk(type, name, clk);
+	return clk;
+}
+
+static struct clk * __init ath79_set_ff_clk(int type, const char *parent,
+					    unsigned int mult, unsigned int div)
+{
+	const char *name = ath79_clk_name(type);
+	struct clk *clk;
+
+	clk = clk_register_fixed_factor(NULL, name, parent, 0, mult, div);
+	__ath79_set_clk(type, name, clk);
 	return clk;
 }
 
@@ -80,27 +106,15 @@ static void __init ar71xx_clocks_init(void)
 	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
-static struct clk * __init ath79_reg_ffclk(const char *name,
-		const char *parent_name, unsigned int mult, unsigned int div)
-{
-	struct clk *clk;
-
-	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, mult, div);
-	if (IS_ERR(clk))
-		panic("failed to allocate %s clock structure", name);
-
-	return clk;
-}
-
 static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 {
 	u32 pll;
@@ -114,24 +128,19 @@ static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	ddr_div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
 	ahb_div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
 
-	clks[ATH79_CLK_CPU] = ath79_reg_ffclk("cpu", "ref", mult, div);
-	clks[ATH79_CLK_DDR] = ath79_reg_ffclk("ddr", "ref", mult, div * ddr_div);
-	clks[ATH79_CLK_AHB] = ath79_reg_ffclk("ahb", "ref", mult, div * ahb_div);
+	ath79_set_ff_clk(ATH79_CLK_CPU, "ref", mult, div);
+	ath79_set_ff_clk(ATH79_CLK_DDR, "ref", mult, div * ddr_div);
+	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", mult, div * ahb_div);
 }
 
 static void __init ar724x_clocks_init(void)
 {
 	struct clk *ref_clk;
 
-	ref_clk = ath79_add_sys_clkdev("ref", AR724X_BASE_FREQ);
+	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
 
 	ar724x_clk_init(ref_clk, ath79_pll_base);
 
-	/* just make happy plat_time_init() from arch/mips/ath79/setup.c */
-	clk_register_clkdev(clks[ATH79_CLK_CPU], "cpu", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_DDR], "ddr", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_AHB], "ahb", NULL);
-
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
@@ -186,12 +195,12 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
 	}
 
-	clks[ATH79_CLK_CPU] = ath79_reg_ffclk("cpu", "ref",
-					ninit_mul, ref_div * out_div * cpu_div);
-	clks[ATH79_CLK_DDR] = ath79_reg_ffclk("ddr", "ref",
-					ninit_mul, ref_div * out_div * ddr_div);
-	clks[ATH79_CLK_AHB] = ath79_reg_ffclk("ahb", "ref",
-					ninit_mul, ref_div * out_div * ahb_div);
+	ath79_set_ff_clk(ATH79_CLK_CPU, "ref", ninit_mul,
+			 ref_div * out_div * cpu_div);
+	ath79_set_ff_clk(ATH79_CLK_DDR, "ref", ninit_mul,
+			 ref_div * out_div * ddr_div);
+	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", ninit_mul,
+			 ref_div * out_div * ahb_div);
 }
 
 static void __init ar933x_clocks_init(void)
@@ -206,15 +215,10 @@ static void __init ar933x_clocks_init(void)
 	else
 		ref_rate = (25 * 1000 * 1000);
 
-	ref_clk = ath79_add_sys_clkdev("ref", ref_rate);
+	ref_clk = ath79_set_clk(ATH79_CLK_REF, ref_rate);
 
 	ar9330_clk_init(ref_clk, ath79_pll_base);
 
-	/* just make happy plat_time_init() from arch/mips/ath79/setup.c */
-	clk_register_clkdev(clks[ATH79_CLK_CPU], "cpu", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_DDR], "ddr", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_AHB], "ahb", NULL);
-
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
 }
@@ -344,10 +348,10 @@ static void __init ar934x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -431,10 +435,10 @@ static void __init qca953x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -516,10 +520,10 @@ static void __init qca955x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -620,10 +624,10 @@ static void __init qca956x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
diff --git a/include/dt-bindings/clock/ath79-clk.h b/include/dt-bindings/clock/ath79-clk.h
index 27359ad83904..262d7c5eb248 100644
--- a/include/dt-bindings/clock/ath79-clk.h
+++ b/include/dt-bindings/clock/ath79-clk.h
@@ -13,7 +13,8 @@
 #define ATH79_CLK_CPU		0
 #define ATH79_CLK_DDR		1
 #define ATH79_CLK_AHB		2
+#define ATH79_CLK_REF		3
 
-#define ATH79_CLK_END		3
+#define ATH79_CLK_END		4
 
 #endif /* __DT_BINDINGS_ATH79_CLK_H */
-- 
2.20.1

