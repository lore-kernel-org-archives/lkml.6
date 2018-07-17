Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C70ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5047B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5047B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGQXDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:03:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59069 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbeGQXDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AFE0E207B4; Wed, 18 Jul 2018 00:28:17 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7C59E207E8;
        Wed, 18 Jul 2018 00:28:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 04/16] clk: at91: audio-pll: separate registration from DT parsing
Date:   Wed, 18 Jul 2018 00:27:45 +0200
Message-Id: <20180717222757.10253-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate registration out of of_sama5d2_clk_audio_pll*_setup to allow other
code to use it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-audio-pll.c | 147 +++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
index b3eaf654fac9..f326023a50a3 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -444,85 +444,156 @@ static const struct clk_ops audio_pll_pmc_ops = {
 	.set_rate = clk_audio_pll_pmc_set_rate,
 };
 
-static int of_sama5d2_clk_audio_pll_setup(struct device_node *np,
-					  struct clk_init_data *init,
-					  struct clk_hw *hw,
-					  struct regmap **clk_audio_regmap)
+struct clk_hw * __init
+at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
+				 const char *parent_name)
 {
-	struct regmap *regmap;
-	const char *parent_names[1];
+	struct clk_audio_frac *frac_ck;
+	struct clk_init_data init = {};
 	int ret;
 
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	frac_ck = kzalloc(sizeof(*frac_ck), GFP_KERNEL);
+	if (!frac_ck)
+		return ERR_PTR(-ENOMEM);
 
-	init->name = np->name;
-	of_clk_parent_fill(np, parent_names, 1);
-	init->parent_names = parent_names;
-	init->num_parents = 1;
+	init.name = name;
+	init.ops = &audio_pll_frac_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
 
-	hw->init = init;
-	*clk_audio_regmap = regmap;
+	frac_ck->hw.init = &init;
+	frac_ck->regmap = regmap;
 
-	ret = clk_hw_register(NULL, hw);
-	if (ret)
-		return ret;
+	ret = clk_hw_register(NULL, &frac_ck->hw);
+	if (ret) {
+		kfree(frac_ck);
+		return ERR_PTR(ret);
+	}
 
-	return of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	return &frac_ck->hw;
 }
 
 static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
 {
-	struct clk_audio_frac *frac_ck;
-	struct clk_init_data init = {};
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
 
-	frac_ck = kzalloc(sizeof(*frac_ck), GFP_KERNEL);
-	if (!frac_ck)
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
 		return;
 
-	init.ops = &audio_pll_frac_ops;
-	init.flags = CLK_SET_RATE_GATE;
+	parent_name = of_clk_get_parent_name(np, 0);
 
-	if (of_sama5d2_clk_audio_pll_setup(np, &init, &frac_ck->hw,
-					   &frac_ck->regmap))
-		kfree(frac_ck);
+	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
-static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
+struct clk_hw * __init
+at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
+				const char *parent_name)
 {
 	struct clk_audio_pad *apad_ck;
-	struct clk_init_data init = {};
+	struct clk_init_data init;
+	int ret;
 
 	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
 	if (!apad_ck)
-		return;
+		return ERR_PTR(-ENOMEM);
 
+	init.name = name;
 	init.ops = &audio_pll_pad_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		CLK_SET_RATE_PARENT;
 
-	if (of_sama5d2_clk_audio_pll_setup(np, &init, &apad_ck->hw,
-					   &apad_ck->regmap))
+	apad_ck->hw.init = &init;
+	apad_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &apad_ck->hw);
+	if (ret) {
 		kfree(apad_ck);
+		return ERR_PTR(ret);
+	}
+
+	return &apad_ck->hw;
 }
 
-static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
+static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	hw = at91_clk_register_audio_pll_pad(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+
+struct clk_hw * __init
+at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
+				const char *parent_name)
 {
 	struct clk_audio_pmc *apmc_ck;
-	struct clk_init_data init = {};
+	struct clk_init_data init;
+	int ret;
 
 	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
 	if (!apmc_ck)
-		return;
+		return ERR_PTR(-ENOMEM);
 
+	init.name = name;
 	init.ops = &audio_pll_pmc_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		CLK_SET_RATE_PARENT;
 
-	if (of_sama5d2_clk_audio_pll_setup(np, &init, &apmc_ck->hw,
-					   &apmc_ck->regmap))
+	apmc_ck->hw.init = &init;
+	apmc_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &apmc_ck->hw);
+	if (ret) {
 		kfree(apmc_ck);
+		return ERR_PTR(ret);
+	}
+
+	return &apmc_ck->hw;
+}
+
+static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	hw = at91_clk_register_audio_pll_pmc(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_frac_setup,
-- 
2.18.0

