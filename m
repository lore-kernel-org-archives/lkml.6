Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D9ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4A52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4A52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeGQXE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:04:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59079 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbeGQXDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B9754207E8; Wed, 18 Jul 2018 00:28:26 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C091A20876;
        Wed, 18 Jul 2018 00:28:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 05/16] clk: at91: generated: set audio_pll_allowed in at91_clk_register_generated()
Date:   Wed, 18 Jul 2018 00:27:46 +0200
Message-Id: <20180717222757.10253-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set gck->audio_pll_allowed in at91_clk_register_generated. This makes it
easier to do it from code that is not parsing device tree.

Also, this fixes an issue where the resulting clk_hw can be dereferenced
before being tested for error.

Fixes: 1a1a36d72e3d ("clk: at91: clk-generated: make gclk determine audio_pll rate")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-generated.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index e709a12269c0..6dfee6e588c4 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -280,7 +280,7 @@ static void clk_generated_startup(struct clk_generated *gck)
 static struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const char *name, const char **parent_names,
-			    u8 num_parents, u8 id,
+			    u8 num_parents, u8 id, bool pll_audio,
 			    const struct clk_range *range)
 {
 	struct clk_generated *gck;
@@ -304,6 +304,7 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	gck->regmap = regmap;
 	gck->lock = lock;
 	gck->range = *range;
+	gck->audio_pll_allowed = pll_audio;
 
 	clk_generated_startup(gck);
 	hw = &gck->hw;
@@ -329,7 +330,6 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 	struct device_node *gcknp;
 	struct clk_range range = CLK_RANGE(0, 0);
 	struct regmap *regmap;
-	struct clk_generated *gck;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > GENERATED_SOURCE_MAX)
@@ -346,6 +346,8 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		return;
 
 	for_each_child_of_node(np, gcknp) {
+		bool pll_audio = false;
+
 		if (of_property_read_u32(gcknp, "reg", &id))
 			continue;
 
@@ -358,23 +360,14 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
 				      &range);
 
+		if (of_device_is_compatible(np, "atmel,sama5d2-clk-generated") &&
+		    (id == GCK_ID_I2S0 || id == GCK_ID_I2S1 ||
+		     id == GCK_ID_CLASSD))
+			pll_audio = true;
+
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
 						  parent_names, num_parents,
-						  id, &range);
-
-		gck = to_clk_generated(hw);
-
-		if (of_device_is_compatible(np,
-					    "atmel,sama5d2-clk-generated")) {
-			if (gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
-			    gck->id == GCK_ID_CLASSD)
-				gck->audio_pll_allowed = true;
-			else
-				gck->audio_pll_allowed = false;
-		} else {
-			gck->audio_pll_allowed = false;
-		}
-
+						  id, pll_audio, &range);
 		if (IS_ERR(hw))
 			continue;
 
-- 
2.18.0

