Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF09C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B828222B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PzKIvlSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfBKN7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:23 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:34766 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:21 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 89F5425BE79;
        Tue, 12 Feb 2019 00:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549893553; bh=SopA4wFcFM+0m5qxji6WDpdsh4CwaqY6GpPQhwBTL+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzKIvlSIwHA86hh+Loho74G3GloQEN0JKnf1/UFN7rMNZM9ym+5SzEkLBTISkhrN4
         QxtF8K9dRYpgZYYlgUStU2h0LNtymuZ8TwwwUktBh/7Fdqi3Q+fbpHpFBuBh4RC2cT
         yS060eYMtyt29AGwhwGQmH7A4BFt3YqyoWWbCCA0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 87C4C940069; Mon, 11 Feb 2019 14:59:11 +0100 (CET)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 1/6] clk: renesas: rcar-gen3: Parameterise Z and Z2 clock fixed divisor
Date:   Mon, 11 Feb 2019 14:58:53 +0100
Message-Id: <20190211135858.23635-2-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211135858.23635-1-horms+renesas@verge.net.au>
References: <20190211135858.23635-1-horms+renesas@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Parameterise Z and Z2 clock fixed divisor to allow clocks with a fixed
divisor other than 2, the value used by all such clocks supported to date.

This is in preparation for supporting the Z2 clock on the R-Car E3
(r8a77990) SoC which has a fixed divisor of 4.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[simon: squashed several patches; rewrote changelog; added r8a774a1 change]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3: Retain original whitespace alignment

v2: New patch
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c |  4 ++--
 drivers/clk/renesas/r8a7795-cpg-mssr.c  |  5 +++--
 drivers/clk/renesas/r8a7796-cpg-mssr.c  |  5 +++--
 drivers/clk/renesas/r8a77965-cpg-mssr.c |  2 +-
 drivers/clk/renesas/rcar-gen3-cpg.c     | 24 +++++++++++++++---------
 drivers/clk/renesas/rcar-gen3-cpg.h     |  4 ++++
 6 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 10e852518870..103253bee055 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -71,8 +71,8 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	DEF_GEN3_OSC(".r",      CLK_RINT,          CLK_EXTAL,      32),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",           R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
-	DEF_BASE("z2",          R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
+	DEF_GEN3_Z("z",		R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0, 2),
+	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2),
 	DEF_FIXED("ztr",        R8A774A1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774A1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774A1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 86842c9fd314..d4cf1c91533e 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -3,6 +3,7 @@
  * r8a7795 Clock Pulse Generator / Module Standby and Software Reset
  *
  * Copyright (C) 2015 Glider bvba
+ * Copyright (C) 2018 Renesas Electronics Corp.
  *
  * Based on clk-rcar-gen3.c
  *
@@ -73,8 +74,8 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 	DEF_GEN3_OSC(".r",      CLK_RINT,          CLK_EXTAL,      32),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",           R8A7795_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
-	DEF_BASE("z2",          R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
+	DEF_GEN3_Z("z",         R8A7795_CLK_Z,	   CLK_TYPE_GEN3_Z,  CLK_PLL0, 2),
+	DEF_GEN3_Z("z2",        R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2),
 	DEF_FIXED("ztr",        R8A7795_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7795_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7795_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 12c455859f2c..77254f2b4519 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -3,6 +3,7 @@
  * r8a7796 Clock Pulse Generator / Module Standby and Software Reset
  *
  * Copyright (C) 2016 Glider bvba
+ * Copyright (C) 2018 Renesas Electronics Corp.
  *
  * Based on r8a7795-cpg-mssr.c
  *
@@ -73,8 +74,8 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	DEF_GEN3_OSC(".r",      CLK_RINT,          CLK_EXTAL,      32),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",           R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
-	DEF_BASE("z2",          R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
+	DEF_GEN3_Z("z",         R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2),
+	DEF_GEN3_Z("z2",        R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2),
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7796_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7796_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index eb1cca58a1e1..f8f73558c1ec 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -71,7 +71,7 @@ static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
 	DEF_GEN3_OSC(".r",	CLK_RINT,		CLK_EXTAL,	32),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",		R8A77965_CLK_Z,		CLK_TYPE_GEN3_Z, CLK_PLL0),
+	DEF_GEN3_Z("z",		R8A77965_CLK_Z,		CLK_TYPE_GEN3_Z,  CLK_PLL0, 2),
 	DEF_FIXED("ztr",	R8A77965_CLK_ZTR,	CLK_PLL1_DIV2,	6, 1),
 	DEF_FIXED("ztrd2",	R8A77965_CLK_ZTRD2,	CLK_PLL1_DIV2,	12, 1),
 	DEF_FIXED("zt",		R8A77965_CLK_ZT,	CLK_PLL1_DIV2,	4, 1),
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index be2ccbd6d623..5923028064a5 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -81,6 +81,7 @@ struct cpg_z_clk {
 	void __iomem *reg;
 	void __iomem *kick_reg;
 	unsigned long mask;
+	unsigned int fixed_div;
 };
 
 #define to_z_clk(_hw)	container_of(_hw, struct cpg_z_clk, hw)
@@ -95,17 +96,18 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 	val = readl(zclk->reg) & zclk->mask;
 	mult = 32 - (val >> __ffs(zclk->mask));
 
-	/* Factor of 2 is for fixed divider */
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, 32 * 2);
+	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult,
+				     32 * zclk->fixed_div);
 }
 
 static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *parent_rate)
 {
-	/* Factor of 2 is for fixed divider */
-	unsigned long prate = *parent_rate / 2;
+	struct cpg_z_clk *zclk = to_z_clk(hw);
+	unsigned long prate;
 	unsigned int mult;
 
+	prate = *parent_rate / zclk->fixed_div;;
 	mult = div_u64(rate * 32ULL, prate);
 	mult = clamp(mult, 1U, 32U);
 
@@ -120,8 +122,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int i;
 	u32 val, kick;
 
-	/* Factor of 2 is for fixed divider */
-	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * 2, parent_rate);
+	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * zclk->fixed_div,
+				     parent_rate);
 	mult = clamp(mult, 1U, 32U);
 
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
@@ -167,7 +169,8 @@ static const struct clk_ops cpg_z_clk_ops = {
 static struct clk * __init cpg_z_clk_register(const char *name,
 					      const char *parent_name,
 					      void __iomem *reg,
-					      unsigned long mask)
+					      unsigned long mask,
+					      unsigned int div)
 {
 	struct clk_init_data init;
 	struct cpg_z_clk *zclk;
@@ -187,6 +190,7 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	zclk->kick_reg = reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
 	zclk->mask = mask;
+	zclk->fixed_div = div; /* PLLVCO x 1/div x SYS-CPU divider */
 
 	clk = clk_register(NULL, &zclk->hw);
 	if (IS_ERR(clk))
@@ -565,11 +569,13 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 
 	case CLK_TYPE_GEN3_Z:
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
-					  base, CPG_FRQCRC_ZFC_MASK);
+					  base, CPG_FRQCRC_ZFC_MASK,
+					  core->div);
 
 	case CLK_TYPE_GEN3_Z2:
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
-					  base, CPG_FRQCRC_Z2FC_MASK);
+					  base, CPG_FRQCRC_Z2FC_MASK,
+					  core->div);
 
 	case CLK_TYPE_GEN3_OSC:
 		/*
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index f4fb6cf16688..60038e245e8b 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -3,6 +3,7 @@
  * R-Car Gen3 Clock Pulse Generator
  *
  * Copyright (C) 2015-2018 Glider bvba
+ * Copyright (C) 2018 Renesas Electronics Corp.
  *
  */
 
@@ -48,6 +49,9 @@ enum rcar_gen3_clk_types {
 	DEF_BASE(_name, _id, CLK_TYPE_GEN3_RCKSEL,	\
 		 (_parent0) << 16 | (_parent1),	.div = (_div0) << 16 | (_div1))
 
+#define DEF_GEN3_Z(_name, _id, _type, _parent, _div)	\
+	DEF_BASE(_name, _id, _type, _parent, .div = _div)
+
 struct rcar_gen3_cpg_pll_config {
 	u8 extal_div;
 	u8 pll1_mult;
-- 
2.11.0

