Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A8EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB6D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLEHvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:51:01 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41841 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeLEHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:50:59 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gURvu-0005iC-Oa from Jiada_Wang@mentor.com ; Tue, 04 Dec 2018 23:49:22 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 4 Dec 2018 23:49:19 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <vladimir_zapolskiy@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
Date:   Wed, 5 Dec 2018 16:49:32 +0900
Message-ID: <20181205074932.28098-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are AVB Counter Clocks in ADG, each clock has 12bits integral
and 8 bits fractional dividers which operates with S0D1ϕ clock.

This patch registers 8 AVB Counter Clocks when clock-cells of
rcar_sound node is 2,

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/adg.c  | 316 +++++++++++++++++++++++++++++++++++++--
 sound/soc/sh/rcar/gen.c  |   9 ++
 sound/soc/sh/rcar/rsnd.h |   9 ++
 3 files changed, 325 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 6768a66588eb..0708be1f38d9 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -5,6 +5,7 @@
 //  Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
 #include <linux/clk-provider.h>
+#include <linux/of_address.h>
 #include "rsnd.h"
 
 #define CLKA	0
@@ -21,13 +22,30 @@
 
 #define BRRx_MASK(x) (0x3FF & x)
 
+#define AVB_CLK_NUM		8
+#define AVB_MAX_RATE		25000000
+#define AVB_DIV_EN_COM		BIT(31)
+#define AVB_MAX_DIV		0x3ffc0
+
 static struct rsnd_mod_ops adg_ops = {
 	.name = "adg",
 };
 
+struct clk_avb {
+	struct clk_hw hw;
+	unsigned int idx;
+	struct rsnd_adg *adg;
+	/* lock reg access */
+	spinlock_t *lock;
+};
+
+#define hw_to_avb(_hw) container_of(_hw, struct clk_avb, hw)
+
 struct rsnd_adg {
 	struct clk *clk[CLKMAX];
 	struct clk *clkout[CLKOUTMAX];
+	struct clk *clkavb[AVB_CLK_NUM];
+	struct clk *clkadg;
 	struct clk_onecell_data onecell;
 	struct rsnd_mod mod;
 	u32 flags;
@@ -37,6 +55,7 @@ struct rsnd_adg {
 
 	int rbga_rate_for_441khz; /* RBGA */
 	int rbgb_rate_for_48khz;  /* RBGB */
+	spinlock_t avb_lock;
 };
 
 #define LRCLK_ASYNC	(1 << 0)
@@ -408,6 +427,248 @@ void rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	}
 }
 
+static struct clk *rsnd_adg_clk_src_twocell_get(struct of_phandle_args *clkspec,
+						void *data)
+{
+	unsigned int clktype = clkspec->args[0];
+	unsigned int clkidx = clkspec->args[1];
+	struct rsnd_adg *adg = data;
+	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(adg_mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct clk *clk;
+
+	switch (clktype) {
+	case 0:
+		if (clkidx >= CLKOUTMAX) {
+			dev_err(dev, "Invalid fixed clock index %u\n", clkidx);
+			return ERR_PTR(-EINVAL);
+		}
+		clk = adg->clkout[clkidx];
+		break;
+	case 1:
+		if (clkidx >= AVB_CLK_NUM) {
+			dev_err(dev, "Invalid avb clock index %u\n", clkidx);
+			return ERR_PTR(-EINVAL);
+		}
+		clk = adg->clkavb[clkidx];
+		break;
+	default:
+		dev_err(dev, "Invalid ADG clock type %u\n", clktype);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+
+static void clk_avb_div_write(struct rsnd_adg *adg, u32 data, unsigned int idx)
+{
+	struct rsnd_mod *mod = rsnd_mod_get(adg);
+
+	switch (idx) {
+	case 0:
+		rsnd_mod_write(mod, AVB_CLK_DIV0, data);
+		break;
+	case 1:
+		rsnd_mod_write(mod, AVB_CLK_DIV1, data);
+		break;
+	case 2:
+		rsnd_mod_write(mod, AVB_CLK_DIV2, data);
+		break;
+	case 3:
+		rsnd_mod_write(mod, AVB_CLK_DIV3, data);
+		break;
+	case 4:
+		rsnd_mod_write(mod, AVB_CLK_DIV4, data);
+		break;
+	case 5:
+		rsnd_mod_write(mod, AVB_CLK_DIV5, data);
+		break;
+	case 6:
+		rsnd_mod_write(mod, AVB_CLK_DIV6, data);
+		break;
+	case 7:
+		rsnd_mod_write(mod, AVB_CLK_DIV7, data);
+		break;
+	}
+}
+
+static u32 clk_avb_div_read(struct rsnd_adg *adg, unsigned int idx)
+{
+	struct rsnd_mod *mod = rsnd_mod_get(adg);
+	u32 val = 0;
+
+	switch (idx) {
+	case 0:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV0);
+		break;
+	case 1:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV1);
+		break;
+	case 2:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV2);
+		break;
+	case 3:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV3);
+		break;
+	case 4:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV4);
+		break;
+	case 5:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV5);
+		break;
+	case 6:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV6);
+		break;
+	case 7:
+		val = rsnd_mod_read(mod, AVB_CLK_DIV7);
+		break;
+	}
+
+	return val;
+}
+
+static int clk_avb_is_enabled(struct clk_hw *hw)
+{
+	struct clk_avb *avb = hw_to_avb(hw);
+	struct rsnd_mod *mod = rsnd_mod_get(avb->adg);
+
+	return rsnd_mod_read(mod, AVB_CLK_CONFIG) & BIT(avb->idx);
+}
+
+static int clk_avb_enabledisable(struct clk_hw *hw, int enable)
+{
+	struct clk_avb *avb = hw_to_avb(hw);
+	u32 val;
+	struct rsnd_mod *mod = rsnd_mod_get(avb->adg);
+
+	spin_lock(avb->lock);
+
+	val = rsnd_mod_read(mod, AVB_CLK_CONFIG);
+	if (enable)
+		val |= BIT(avb->idx);
+	else
+		val &= ~BIT(avb->idx);
+	rsnd_mod_write(mod, AVB_CLK_CONFIG,  val);
+
+	spin_unlock(avb->lock);
+
+	return 0;
+}
+
+static int clk_avb_enable(struct clk_hw *hw)
+{
+	return clk_avb_enabledisable(hw, 1);
+}
+
+static void clk_avb_disable(struct clk_hw *hw)
+{
+	clk_avb_enabledisable(hw, 0);
+}
+
+static unsigned long clk_avb_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_avb *avb = hw_to_avb(hw);
+	u32 div;
+
+	div = clk_avb_div_read(avb->adg, avb->idx);
+	if (!div)
+		return parent_rate;
+
+	return parent_rate * 32 / div;
+}
+
+static unsigned int clk_avb_calc_div(unsigned long rate,
+				     unsigned long parent_rate)
+{
+	unsigned int div;
+
+	if (!rate)
+		rate = 1;
+
+	if (rate > AVB_MAX_RATE)
+		rate = AVB_MAX_RATE;
+
+	div = DIV_ROUND_CLOSEST(parent_rate * 32, rate);
+
+	if (div > AVB_MAX_DIV)
+		div = AVB_MAX_DIV;
+
+	return div;
+}
+
+static long clk_avb_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	unsigned int div = clk_avb_calc_div(rate, *parent_rate);
+
+	return (*parent_rate * 32) / div;
+}
+
+static int clk_avb_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_avb *avb = hw_to_avb(hw);
+	unsigned int div = clk_avb_calc_div(rate, parent_rate);
+	u32 val;
+
+	val = clk_avb_div_read(avb->adg, avb->idx);
+	clk_avb_div_write(avb->adg, val | div, avb->idx);
+
+	return 0;
+}
+
+static const struct clk_ops clk_avb_ops = {
+	.enable =	clk_avb_enable,
+	.disable =	clk_avb_disable,
+	.is_enabled =	clk_avb_is_enabled,
+	.recalc_rate =	clk_avb_recalc_rate,
+	.round_rate =	clk_avb_round_rate,
+	.set_rate =	clk_avb_set_rate,
+};
+
+static struct clk *clk_register_avb(struct device *dev, struct rsnd_adg *adg,
+				    unsigned int id, spinlock_t *lock)
+{
+	struct clk_init_data init;
+	struct clk_avb *avb;
+	struct clk *clk;
+	char name[8];
+	const char *parent_name;
+
+	if (IS_ERR(adg->clkadg))
+		return ERR_PTR(-ENODEV);
+
+	avb = devm_kzalloc(dev, sizeof(*avb), GFP_KERNEL);
+	if (!avb)
+		return ERR_PTR(-ENOMEM);
+
+	parent_name = __clk_get_name(adg->clkadg);
+
+	snprintf(name, sizeof(name), "%s%u", "avb", id);
+
+	avb->idx = id;
+	avb->lock = lock;
+	avb->adg = adg;
+
+	/* Register the clock. */
+	init.name = name;
+	init.ops = &clk_avb_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	avb->hw.init = &init;
+
+	/* init DIV to a valid state */
+	clk_avb_div_write(avb->adg, AVB_MAX_DIV, avb->idx);
+
+	clk = devm_clk_register(dev, &avb->hw);
+
+	return clk;
+}
+
 static void rsnd_adg_get_clkin(struct rsnd_priv *priv,
 			       struct rsnd_adg *adg)
 {
@@ -436,6 +697,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	unsigned long req_48kHz_rate, req_441kHz_rate;
 	int i, req_size;
 	const char *parent_clk_name = NULL;
+	struct rsnd_mod *mod = rsnd_mod_get(adg);
 	static const char * const clkout_name[] = {
 		[CLKOUT]  = "audio_clkout",
 		[CLKOUT1] = "audio_clkout1",
@@ -540,21 +802,23 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	 */
 
 	of_property_read_u32(np, "#clock-cells", &count);
-	/*
-	 * for clkout
-	 */
-	if (!count) {
+
+	switch (count) {
+	case 0:
+		/*
+		 * for clkout
+		 */
 		clk = clk_register_fixed_rate(dev, clkout_name[CLKOUT],
 					      parent_clk_name, 0, req_rate[0]);
 		if (!IS_ERR(clk)) {
 			adg->clkout[CLKOUT] = clk;
 			of_clk_add_provider(np, of_clk_src_simple_get, clk);
 		}
-	}
-	/*
-	 * for clkout0/1/2/3
-	 */
-	else {
+		break;
+	case 1:
+		/*
+		 * for clkout0/1/2/3
+		 */
 		for (i = 0; i < CLKOUTMAX; i++) {
 			clk = clk_register_fixed_rate(dev, clkout_name[i],
 						      parent_clk_name, 0,
@@ -566,6 +830,33 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 		adg->onecell.clk_num	= CLKOUTMAX;
 		of_clk_add_provider(np, of_clk_src_onecell_get,
 				    &adg->onecell);
+		break;
+	case 2:
+		/*
+		 * for clkout0/1/2/3 and avb clocks
+		 */
+		for (i = 0; i < CLKOUTMAX; i++) {
+			clk = clk_register_fixed_rate(dev, clkout_name[i],
+						      parent_clk_name, 0,
+						      req_rate[0]);
+			if (!IS_ERR(clk))
+				adg->clkout[i] = clk;
+		}
+
+		for (i = 0; i < AVB_CLK_NUM; i++) {
+			clk = clk_register_avb(dev, adg, i, &adg->avb_lock);
+			if (!IS_ERR(clk))
+				adg->clkavb[i] = clk;
+		}
+
+		of_clk_add_provider(np, rsnd_adg_clk_src_twocell_get, adg);
+
+		rsnd_mod_write(mod, AVB_CLK_CONFIG, AVB_DIV_EN_COM);
+
+		break;
+	default:
+		dev_err(dev, "Invalid clock-cell %d\n", count);
+		break;
 	}
 
 rsnd_adg_get_clkout_end:
@@ -606,17 +897,24 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 {
 	struct rsnd_adg *adg;
 	struct device *dev = rsnd_priv_to_dev(priv);
+	struct clk *clk;
 	int ret;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
 	if (!adg)
 		return -ENOMEM;
 
+	spin_lock_init(&adg->avb_lock);
+
 	ret = rsnd_mod_init(priv, &adg->mod, &adg_ops,
 		      NULL, 0, 0);
 	if (ret)
 		return ret;
 
+	clk = devm_clk_get(dev, "adg");
+	if (!IS_ERR(clk))
+		adg->clkadg = clk;
+
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
 	rsnd_adg_clk_dbg_info(priv, adg);
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index ca639404f2cd..1b000d03b76e 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -355,6 +355,15 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_S_REG(SRCOUT_TIMSEL3,	0x54),
 		RSND_GEN_S_REG(SRCOUT_TIMSEL4,	0x58),
 		RSND_GEN_S_REG(CMDOUT_TIMSEL,	0x5c),
+		RSND_GEN_S_REG(AVB_CLK_DIV0,	0x11c),
+		RSND_GEN_S_REG(AVB_CLK_DIV1,	0x120),
+		RSND_GEN_S_REG(AVB_CLK_DIV2,	0x124),
+		RSND_GEN_S_REG(AVB_CLK_DIV3,	0x128),
+		RSND_GEN_S_REG(AVB_CLK_DIV4,	0x12c),
+		RSND_GEN_S_REG(AVB_CLK_DIV5,	0x130),
+		RSND_GEN_S_REG(AVB_CLK_DIV6,	0x134),
+		RSND_GEN_S_REG(AVB_CLK_DIV7,	0x138),
+		RSND_GEN_S_REG(AVB_CLK_CONFIG,	0x13c),
 	};
 	static const struct rsnd_regmap_field_conf conf_ssi[] = {
 		RSND_GEN_M_REG(SSICR,		0x00,	0x40),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 3c57129af6d1..d31b8a65985f 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -148,6 +148,15 @@ enum rsnd_reg {
 	RSND_REG_AUDIO_CLK_SEL0,
 	RSND_REG_AUDIO_CLK_SEL1,
 	RSND_REG_AUDIO_CLK_SEL2,
+	RSND_REG_AVB_CLK_DIV0,
+	RSND_REG_AVB_CLK_DIV1,
+	RSND_REG_AVB_CLK_DIV2,
+	RSND_REG_AVB_CLK_DIV3,
+	RSND_REG_AVB_CLK_DIV4,
+	RSND_REG_AVB_CLK_DIV5,
+	RSND_REG_AVB_CLK_DIV6,
+	RSND_REG_AVB_CLK_DIV7,
+	RSND_REG_AVB_CLK_CONFIG,
 
 	/* SSIU */
 	RSND_REG_SSI_MODE,
-- 
2.19.2

