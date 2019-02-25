Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB7CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEBB20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfBYR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:28:03 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50141 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfBYR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:28:03 -0500
Received: from localhost (alyon-652-1-170-85.w109-212.abo.wanadoo.fr [109.212.201.85])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 785A1240002;
        Mon, 25 Feb 2019 17:27:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Wieloch <matthias.wieloch@few-bauer.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] clk: at91: fix programmable clock for sama5d2
Date:   Mon, 25 Feb 2019 18:27:50 +0100
Message-Id: <20190225172750.25816-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Wieloch <matthias.wieloch@few-bauer.de>

The prescaler formula of the programmable clock has changed for sama5d2. Update
the driver accordingly. A new compatibility string is needed for this driver,
now.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[nicolas.ferre@microchip.com: adapt the prescaler range,
		fix clk_programmable_recalc_rate, split patch]
Signed-off-by: Matthias Wieloch <matthias.wieloch@few-bauer.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-programmable.c | 57 ++++++++++++++++++++++-------
 drivers/clk/at91/pmc.h              |  2 +
 drivers/clk/at91/sama5d2.c          | 10 ++++-
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 5bc68b9c5498..c3174a6bbd48 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -20,8 +20,7 @@
 #define PROG_ID_MAX		7
 
 #define PROG_STATUS_MASK(id)	(1 << ((id) + 8))
-#define PROG_PRES_MASK		0x7
-#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & PROG_PRES_MASK)
+#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & layout->pres_mask)
 #define PROG_MAX_RM9200_CSS	3
 
 struct clk_programmable {
@@ -37,20 +36,29 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
 	struct clk_programmable *prog = to_clk_programmable(hw);
+	const struct clk_programmable_layout *layout = prog->layout;
 	unsigned int pckr;
+	unsigned long rate;
 
 	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
 
-	return parent_rate >> PROG_PRES(prog->layout, pckr);
+	if (layout->is_pres_direct)
+		rate = parent_rate / (PROG_PRES(layout, pckr) + 1);
+	else
+		rate = parent_rate >> PROG_PRES(layout, pckr);
+
+	return rate;
 }
 
 static int clk_programmable_determine_rate(struct clk_hw *hw,
 					   struct clk_rate_request *req)
 {
+	struct clk_programmable *prog = to_clk_programmable(hw);
+	const struct clk_programmable_layout *layout = prog->layout;
 	struct clk_hw *parent;
 	long best_rate = -EINVAL;
 	unsigned long parent_rate;
-	unsigned long tmp_rate;
+	unsigned long tmp_rate = 0;
 	int shift;
 	int i;
 
@@ -60,10 +68,18 @@ static int clk_programmable_determine_rate(struct clk_hw *hw,
 			continue;
 
 		parent_rate = clk_hw_get_rate(parent);
-		for (shift = 0; shift < PROG_PRES_MASK; shift++) {
-			tmp_rate = parent_rate >> shift;
-			if (tmp_rate <= req->rate)
-				break;
+		if (layout->is_pres_direct) {
+			for (shift = 0; shift <= layout->pres_mask; shift++) {
+				tmp_rate = parent_rate / (shift + 1);
+				if (tmp_rate <= req->rate)
+					break;
+			}
+		} else {
+			for (shift = 0; shift < layout->pres_mask; shift++) {
+				tmp_rate = parent_rate >> shift;
+				if (tmp_rate <= req->rate)
+					break;
+			}
 		}
 
 		if (tmp_rate > req->rate)
@@ -140,16 +156,23 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!div)
 		return -EINVAL;
 
-	shift = fls(div) - 1;
+	if (layout->is_pres_direct) {
+		shift = div - 1;
 
-	if (div != (1 << shift))
-		return -EINVAL;
+		if (shift > layout->pres_mask)
+			return -EINVAL;
+	} else {
+		shift = fls(div) - 1;
 
-	if (shift >= PROG_PRES_MASK)
-		return -EINVAL;
+		if (div != (1 << shift))
+			return -EINVAL;
+
+		if (shift >= layout->pres_mask)
+			return -EINVAL;
+	}
 
 	regmap_update_bits(prog->regmap, AT91_PMC_PCKR(prog->id),
-			   PROG_PRES_MASK << layout->pres_shift,
+			   layout->pres_mask << layout->pres_shift,
 			   shift << layout->pres_shift);
 
 	return 0;
@@ -205,19 +228,25 @@ at91_clk_register_programmable(struct regmap *regmap,
 }
 
 const struct clk_programmable_layout at91rm9200_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 0,
+	.is_pres_direct = 0,
 };
 
 const struct clk_programmable_layout at91sam9g45_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 1,
+	.is_pres_direct = 0,
 };
 
 const struct clk_programmable_layout at91sam9x5_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 4,
 	.css_mask = 0x7,
 	.have_slck_mck = 0,
+	.is_pres_direct = 0,
 };
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 672a79bda88c..a0e5ce9c9b9e 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -71,9 +71,11 @@ struct clk_pll_characteristics {
 };
 
 struct clk_programmable_layout {
+	u8 pres_mask;
 	u8 pres_shift;
 	u8 css_mask;
 	u8 have_slck_mck;
+	u8 is_pres_direct;
 };
 
 extern const struct clk_programmable_layout at91rm9200_programmable_layout;
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index d69ad96fe988..31d6226b297a 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -125,6 +125,14 @@ static const struct {
 	  .pll = true },
 };
 
+static const struct clk_programmable_layout sama5d2_programmable_layout = {
+	.pres_mask = 0xff,
+	.pres_shift = 4,
+	.css_mask = 0x7,
+	.have_slck_mck = 0,
+	.is_pres_direct = 1,
+};
+
 static void __init sama5d2_pmc_setup(struct device_node *np)
 {
 	struct clk_range range = CLK_RANGE(0, 0);
@@ -248,7 +256,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9x5_programmable_layout);
+						    &sama5d2_programmable_layout);
 		if (IS_ERR(hw))
 			goto err_free;
 	}
-- 
2.20.1

