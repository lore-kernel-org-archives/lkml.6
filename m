Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7B72147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfBSRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:02:14 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50977 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:02:11 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F0FC61BF217;
        Tue, 19 Feb 2019 17:02:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/7] clk: at91: modernize sckc binding
Date:   Tue, 19 Feb 2019 18:01:55 +0100
Message-Id: <20190219170200.3608-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the need for child nodes in the sckc binding and register the whole
sckc tree (3 clocks in total) from the sckc node.

DT backward compatibility is kept by looking for properties in child nodes
when they are not present in the sckc node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 125 ++++++++++++----------------------------
 1 file changed, 36 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab6ecefc49ad..470aef586f57 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -152,28 +152,6 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init
-of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	u32 startup;
-	bool bypass;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	of_property_read_string(np, "clock-output-names", &name);
-	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
-	bypass = of_property_read_bool(np, "atmel,osc-bypass");
-
-	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
-					 bypass);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
 static unsigned long clk_slow_rc_osc_recalc_rate(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
@@ -266,28 +244,6 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init
-of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
-{
-	struct clk_hw *hw;
-	u32 frequency = 0;
-	u32 accuracy = 0;
-	u32 startup = 0;
-	const char *name = np->name;
-
-	of_property_read_string(np, "clock-output-names", &name);
-	of_property_read_u32(np, "clock-frequency", &frequency);
-	of_property_read_u32(np, "clock-accuracy", &accuracy);
-	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
-
-	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
-					    startup);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
 static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_sam9x5_slow *slowck = to_clk_sam9x5_slow(hw);
@@ -365,64 +321,55 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init
-of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
+static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 {
+	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
+	void __iomem *regbase = of_iomap(np, 0);
+	struct device_node *child = NULL;
+	const char *xtal_name;
 	struct clk_hw *hw;
-	const char *parent_names[2];
-	unsigned int num_parents;
-	const char *name = np->name;
+	bool bypass;
 
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > 2)
+	if (!regbase)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
-					    num_parents);
+	hw = at91_clk_register_slow_rc_osc(regbase, parent_names[0], 32768,
+					   50000000, 75);
 	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
+	xtal_name = of_clk_get_parent_name(np, 0);
+	if (!xtal_name) {
+		/* DT backward compatibility */
+		child = of_get_compatible_child(np, "atmel,at91sam9x5-clk-slow-osc");
+		if (!child)
+			return;
+
+		xtal_name = of_clk_get_parent_name(child, 0);
+		bypass = of_property_read_bool(child, "atmel,osc-bypass");
+
+		child =  of_get_compatible_child(np, "atmel,at91sam9x5-clk-slow");
+	} else {
+		bypass = of_property_read_bool(np, "atmel,osc-bypass");
+	}
 
-static const struct of_device_id sckc_clk_ids[] __initconst = {
-	/* Slow clock */
-	{
-		.compatible = "atmel,at91sam9x5-clk-slow-osc",
-		.data = of_at91sam9x5_clk_slow_osc_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-slow-rc-osc",
-		.data = of_at91sam9x5_clk_slow_rc_osc_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-slow",
-		.data = of_at91sam9x5_clk_slow_setup,
-	},
-	{ /*sentinel*/ }
-};
+	if (!xtal_name)
+		return;
 
-static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
-{
-	struct device_node *childnp;
-	void (*clk_setup)(struct device_node *, void __iomem *);
-	const struct of_device_id *clk_id;
-	void __iomem *regbase = of_iomap(np, 0);
+	hw = at91_clk_register_slow_osc(regbase, parent_names[1], xtal_name,
+					1200000, bypass);
+	if (IS_ERR(hw))
+		return;
 
-	if (!regbase)
+	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
+	if (IS_ERR(hw))
 		return;
 
-	for_each_child_of_node(np, childnp) {
-		clk_id = of_match_node(sckc_clk_ids, childnp);
-		if (!clk_id)
-			continue;
-		clk_setup = clk_id->data;
-		clk_setup(childnp, regbase);
-	}
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+
+	/* DT backward compatibility */
+	if (child)
+		of_clk_add_hw_provider(child, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
-- 
2.20.1

