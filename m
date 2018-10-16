Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2808C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4620881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJPWNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48224 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbeJPWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EBB2820DEE; Tue, 16 Oct 2018 16:22:30 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5EFC20DF8;
        Tue, 16 Oct 2018 16:22:04 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 15/22] clk: at91: move DT compatibility code to its own file
Date:   Tue, 16 Oct 2018 16:21:53 +0200
Message-Id: <20181016142200.19741-16-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all the DT backward compatibility code to its own file so it can be
deleted later.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile           |   2 +-
 drivers/clk/at91/clk-audio-pll.c    |  70 --
 drivers/clk/at91/clk-generated.c    |  65 --
 drivers/clk/at91/clk-h32mx.c        |  22 -
 drivers/clk/at91/clk-i2s-mux.c      |  38 --
 drivers/clk/at91/clk-main.c         | 104 ---
 drivers/clk/at91/clk-master.c       |  82 ---
 drivers/clk/at91/clk-peripheral.c   |  77 ---
 drivers/clk/at91/clk-pll.c          | 163 -----
 drivers/clk/at91/clk-plldiv.c       |  25 -
 drivers/clk/at91/clk-programmable.c |  67 --
 drivers/clk/at91/clk-slow.c         |  30 -
 drivers/clk/at91/clk-smd.c          |  32 -
 drivers/clk/at91/clk-system.c       |  37 --
 drivers/clk/at91/clk-usb.c          |  88 ---
 drivers/clk/at91/clk-utmi.c         |  43 --
 drivers/clk/at91/dt-compat.c        | 961 ++++++++++++++++++++++++++++
 17 files changed, 962 insertions(+), 944 deletions(-)
 create mode 100644 drivers/clk/at91/dt-compat.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 0752def6271a..c75df1cad60e 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -3,7 +3,7 @@
 # Makefile for at91 specific clk
 #
 
-obj-y += pmc.o sckc.o
+obj-y += pmc.o sckc.o dt-compat.o
 obj-y += clk-slow.o clk-main.o clk-pll.o clk-plldiv.o clk-master.o
 obj-y += clk-system.o clk-peripheral.o clk-programmable.o
 
diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
index f326023a50a3..96e3c6405351 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -474,26 +474,6 @@ at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
 	return &frac_ck->hw;
 }
 
-static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *name = np->name;
-	const char *parent_name;
-	struct regmap *regmap;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
 struct clk_hw * __init
 at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
 				const char *parent_name)
@@ -525,26 +505,6 @@ at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
 	return &apad_ck->hw;
 }
 
-static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *name = np->name;
-	const char *parent_name;
-	struct regmap *regmap;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	hw = at91_clk_register_audio_pll_pad(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
 struct clk_hw * __init
 at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
 				const char *parent_name)
@@ -575,33 +535,3 @@ at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
 
 	return &apmc_ck->hw;
 }
-
-static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *name = np->name;
-	const char *parent_name;
-	struct regmap *regmap;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	hw = at91_clk_register_audio_pll_pmc(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
-CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_frac_setup,
-	       "atmel,sama5d2-clk-audio-pll-frac",
-	       of_sama5d2_clk_audio_pll_frac_setup);
-CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
-	       "atmel,sama5d2-clk-audio-pll-pad",
-	       of_sama5d2_clk_audio_pll_pad_setup);
-CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pmc_setup,
-	       "atmel,sama5d2-clk-audio-pll-pmc",
-	       of_sama5d2_clk_audio_pll_pmc_setup);
diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 0fe4d7f04225..66e7f7baf958 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -20,15 +20,8 @@
 
 #include "pmc.h"
 
-#define PERIPHERAL_MAX		64
-#define PERIPHERAL_ID_MIN	2
-
-#define GENERATED_SOURCE_MAX	6
 #define GENERATED_MAX_DIV	255
 
-#define GCK_ID_I2S0		54
-#define GCK_ID_I2S1		55
-#define GCK_ID_CLASSD		59
 #define GCK_INDEX_DT_AUDIO_PLL	5
 
 struct clk_generated {
@@ -318,61 +311,3 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 
 	return hw;
 }
-
-static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
-{
-	int num;
-	u32 id;
-	const char *name;
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[GENERATED_SOURCE_MAX];
-	struct device_node *gcknp;
-	struct clk_range range = CLK_RANGE(0, 0);
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > GENERATED_SOURCE_MAX)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	num = of_get_child_count(np);
-	if (!num || num > PERIPHERAL_MAX)
-		return;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	for_each_child_of_node(np, gcknp) {
-		bool pll_audio = false;
-
-		if (of_property_read_u32(gcknp, "reg", &id))
-			continue;
-
-		if (id < PERIPHERAL_ID_MIN || id >= PERIPHERAL_MAX)
-			continue;
-
-		if (of_property_read_string(np, "clock-output-names", &name))
-			name = gcknp->name;
-
-		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
-				      &range);
-
-		if (of_device_is_compatible(np, "atmel,sama5d2-clk-generated") &&
-		    (id == GCK_ID_I2S0 || id == GCK_ID_I2S1 ||
-		     id == GCK_ID_CLASSD))
-			pll_audio = true;
-
-		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
-						  parent_names, num_parents,
-						  id, pll_audio, &range);
-		if (IS_ERR(hw))
-			continue;
-
-		of_clk_add_hw_provider(gcknp, of_clk_hw_simple_get, hw);
-	}
-}
-CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
-	       of_sama5d2_clk_generated_setup);
diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index a3274648b6c0..f0a2c6baab37 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -115,25 +115,3 @@ at91_clk_register_h32mx(struct regmap *regmap, const char *name,
 
 	return &h32mxclk->hw;
 }
-
-static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *name = np->name;
-	const char *parent_name;
-	struct regmap *regmap;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	hw = at91_clk_register_h32mx(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
-	       of_sama5d4_clk_h32mx_setup);
diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
index ed9e96938589..dfdffa5409e6 100644
--- a/drivers/clk/at91/clk-i2s-mux.c
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -14,8 +14,6 @@
 
 #include <soc/at91/atmel-sfr.h>
 
-#define	I2S_BUS_NR	2
-
 struct clk_i2s_mux {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -78,39 +76,3 @@ at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 
 	return &i2s_ck->hw;
 }
-
-static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
-{
-	struct regmap *regmap_sfr;
-	u8 bus_id;
-	const char *parent_names[2];
-	struct device_node *i2s_mux_np;
-	struct clk_hw *hw;
-	int ret;
-
-	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
-	if (IS_ERR(regmap_sfr))
-		return;
-
-	for_each_child_of_node(np, i2s_mux_np) {
-		if (of_property_read_u8(i2s_mux_np, "reg", &bus_id))
-			continue;
-
-		if (bus_id > I2S_BUS_NR)
-			continue;
-
-		ret = of_clk_parent_fill(i2s_mux_np, parent_names, 2);
-		if (ret != 2)
-			continue;
-
-		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
-					       parent_names, 2, bus_id);
-		if (IS_ERR(hw))
-			continue;
-
-		of_clk_add_hw_provider(i2s_mux_np, of_clk_hw_simple_get, hw);
-	}
-}
-
-CLK_OF_DECLARE(sama5d2_clk_i2s_mux, "atmel,sama5d2-clk-i2s-mux",
-	       of_sama5d2_clk_i2s_mux_setup);
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 82184009137d..7ac0facdb28b 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -12,7 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/delay.h>
-#include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
@@ -171,31 +170,6 @@ at91_clk_register_main_osc(struct regmap *regmap,
 	return hw;
 }
 
-static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *name = np->name;
-	const char *parent_name;
-	struct regmap *regmap;
-	bool bypass;
-
-	of_property_read_string(np, "clock-output-names", &name);
-	bypass = of_property_read_bool(np, "atmel,osc-bypass");
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91rm9200_clk_main_osc, "atmel,at91rm9200-clk-main-osc",
-	       of_at91rm9200_clk_main_osc_setup);
-
 static bool clk_main_rc_osc_ready(struct regmap *regmap)
 {
 	unsigned int status;
@@ -313,32 +287,6 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 	return hw;
 }
 
-static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	u32 frequency = 0;
-	u32 accuracy = 0;
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	of_property_read_string(np, "clock-output-names", &name);
-	of_property_read_u32(np, "clock-frequency", &frequency);
-	of_property_read_u32(np, "clock-accuracy", &accuracy);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91_clk_register_main_rc_osc(regmap, name, frequency, accuracy);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_main_rc_osc, "atmel,at91sam9x5-clk-main-rc-osc",
-	       of_at91sam9x5_clk_main_rc_osc_setup);
-
-
 static int clk_main_probe_frequency(struct regmap *regmap)
 {
 	unsigned long prep_time, timeout;
@@ -442,29 +390,6 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 	return hw;
 }
 
-static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91_clk_register_rm9200_main(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91rm9200_clk_main, "atmel,at91rm9200-clk-main",
-	       of_at91rm9200_clk_main_setup);
-
 static inline bool clk_sam9x5_main_ready(struct regmap *regmap)
 {
 	unsigned int status;
@@ -583,32 +508,3 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 
 	return hw;
 }
-
-static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_names[2];
-	unsigned int num_parents;
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > 2)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names,
-					    num_parents);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
-	       of_at91sam9x5_clk_main_setup);
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 088044bb6ea2..eb53b4a8fab6 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -17,8 +17,6 @@
 
 #include "pmc.h"
 
-#define MASTER_SOURCE_MAX	4
-
 #define MASTER_PRES_MASK	0x7
 #define MASTER_PRES_MAX		MASTER_PRES_MASK
 #define MASTER_DIV_SHIFT	8
@@ -159,83 +157,3 @@ const struct clk_master_layout at91sam9x5_master_layout = {
 	.mask = 0x373,
 	.pres_shift = 4,
 };
-
-
-static struct clk_master_characteristics * __init
-of_at91_clk_master_get_characteristics(struct device_node *np)
-{
-	struct clk_master_characteristics *characteristics;
-
-	characteristics = kzalloc(sizeof(*characteristics), GFP_KERNEL);
-	if (!characteristics)
-		return NULL;
-
-	if (of_at91_get_clk_range(np, "atmel,clk-output-range", &characteristics->output))
-		goto out_free_characteristics;
-
-	of_property_read_u32_array(np, "atmel,clk-divisors",
-				   characteristics->divisors, 4);
-
-	characteristics->have_div3_pres =
-		of_property_read_bool(np, "atmel,master-clk-have-div3-pres");
-
-	return characteristics;
-
-out_free_characteristics:
-	kfree(characteristics);
-	return NULL;
-}
-
-static void __init
-of_at91_clk_master_setup(struct device_node *np,
-			 const struct clk_master_layout *layout)
-{
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[MASTER_SOURCE_MAX];
-	const char *name = np->name;
-	struct clk_master_characteristics *characteristics;
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > MASTER_SOURCE_MAX)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	characteristics = of_at91_clk_master_get_characteristics(np);
-	if (!characteristics)
-		return;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91_clk_register_master(regmap, name, num_parents,
-				       parent_names, layout,
-				       characteristics);
-	if (IS_ERR(hw))
-		goto out_free_characteristics;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-	return;
-
-out_free_characteristics:
-	kfree(characteristics);
-}
-
-static void __init of_at91rm9200_clk_master_setup(struct device_node *np)
-{
-	of_at91_clk_master_setup(np, &at91rm9200_master_layout);
-}
-CLK_OF_DECLARE(at91rm9200_clk_master, "atmel,at91rm9200-clk-master",
-	       of_at91rm9200_clk_master_setup);
-
-static void __init of_at91sam9x5_clk_master_setup(struct device_node *np)
-{
-	of_at91_clk_master_setup(np, &at91sam9x5_master_layout);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_master, "atmel,at91sam9x5-clk-master",
-	       of_at91sam9x5_clk_master_setup);
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index cb41d06a2481..65c1defa78e4 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -19,11 +19,6 @@
 
 DEFINE_SPINLOCK(pmc_pcr_lock);
 
-#define PERIPHERAL_MAX		64
-
-#define PERIPHERAL_AT91RM9200	0
-#define PERIPHERAL_AT91SAM9X5	1
-
 #define PERIPHERAL_ID_MIN	2
 #define PERIPHERAL_ID_MAX	31
 #define PERIPHERAL_MASK(id)	(1 << ((id) & PERIPHERAL_ID_MAX))
@@ -374,75 +369,3 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 
 	return hw;
 }
-
-static void __init
-of_at91_clk_periph_setup(struct device_node *np, u8 type)
-{
-	int num;
-	u32 id;
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name;
-	struct device_node *periphclknp;
-	struct regmap *regmap;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
-		return;
-
-	num = of_get_child_count(np);
-	if (!num || num > PERIPHERAL_MAX)
-		return;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	for_each_child_of_node(np, periphclknp) {
-		if (of_property_read_u32(periphclknp, "reg", &id))
-			continue;
-
-		if (id >= PERIPHERAL_MAX)
-			continue;
-
-		if (of_property_read_string(np, "clock-output-names", &name))
-			name = periphclknp->name;
-
-		if (type == PERIPHERAL_AT91RM9200) {
-			hw = at91_clk_register_peripheral(regmap, name,
-							   parent_name, id);
-		} else {
-			struct clk_range range = CLK_RANGE(0, 0);
-
-			of_at91_get_clk_range(periphclknp,
-					      "atmel,clk-output-range",
-					      &range);
-
-			hw = at91_clk_register_sam9x5_peripheral(regmap,
-								  &pmc_pcr_lock,
-								  name,
-								  parent_name,
-								  id, &range);
-		}
-
-		if (IS_ERR(hw))
-			continue;
-
-		of_clk_add_hw_provider(periphclknp, of_clk_hw_simple_get, hw);
-	}
-}
-
-static void __init of_at91rm9200_clk_periph_setup(struct device_node *np)
-{
-	of_at91_clk_periph_setup(np, PERIPHERAL_AT91RM9200);
-}
-CLK_OF_DECLARE(at91rm9200_clk_periph, "atmel,at91rm9200-clk-peripheral",
-	       of_at91rm9200_clk_periph_setup);
-
-static void __init of_at91sam9x5_clk_periph_setup(struct device_node *np)
-{
-	of_at91_clk_periph_setup(np, PERIPHERAL_AT91SAM9X5);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_periph, "atmel,at91sam9x5-clk-peripheral",
-	       of_at91sam9x5_clk_periph_setup);
-
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 31fff0b9d5c2..f19eed31595a 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -340,166 +340,3 @@ const struct clk_pll_layout sama5d3_pll_layout = {
 	.mul_shift = 18,
 	.mul_mask = 0x7F,
 };
-
-
-static struct clk_pll_characteristics * __init
-of_at91_clk_pll_get_characteristics(struct device_node *np)
-{
-	int i;
-	int offset;
-	u32 tmp;
-	int num_output;
-	u32 num_cells;
-	struct clk_range input;
-	struct clk_range *output;
-	u8 *out = NULL;
-	u16 *icpll = NULL;
-	struct clk_pll_characteristics *characteristics;
-
-	if (of_at91_get_clk_range(np, "atmel,clk-input-range", &input))
-		return NULL;
-
-	if (of_property_read_u32(np, "#atmel,pll-clk-output-range-cells",
-				 &num_cells))
-		return NULL;
-
-	if (num_cells < 2 || num_cells > 4)
-		return NULL;
-
-	if (!of_get_property(np, "atmel,pll-clk-output-ranges", &tmp))
-		return NULL;
-	num_output = tmp / (sizeof(u32) * num_cells);
-
-	characteristics = kzalloc(sizeof(*characteristics), GFP_KERNEL);
-	if (!characteristics)
-		return NULL;
-
-	output = kcalloc(num_output, sizeof(*output), GFP_KERNEL);
-	if (!output)
-		goto out_free_characteristics;
-
-	if (num_cells > 2) {
-		out = kcalloc(num_output, sizeof(*out), GFP_KERNEL);
-		if (!out)
-			goto out_free_output;
-	}
-
-	if (num_cells > 3) {
-		icpll = kcalloc(num_output, sizeof(*icpll), GFP_KERNEL);
-		if (!icpll)
-			goto out_free_output;
-	}
-
-	for (i = 0; i < num_output; i++) {
-		offset = i * num_cells;
-		if (of_property_read_u32_index(np,
-					       "atmel,pll-clk-output-ranges",
-					       offset, &tmp))
-			goto out_free_output;
-		output[i].min = tmp;
-		if (of_property_read_u32_index(np,
-					       "atmel,pll-clk-output-ranges",
-					       offset + 1, &tmp))
-			goto out_free_output;
-		output[i].max = tmp;
-
-		if (num_cells == 2)
-			continue;
-
-		if (of_property_read_u32_index(np,
-					       "atmel,pll-clk-output-ranges",
-					       offset + 2, &tmp))
-			goto out_free_output;
-		out[i] = tmp;
-
-		if (num_cells == 3)
-			continue;
-
-		if (of_property_read_u32_index(np,
-					       "atmel,pll-clk-output-ranges",
-					       offset + 3, &tmp))
-			goto out_free_output;
-		icpll[i] = tmp;
-	}
-
-	characteristics->input = input;
-	characteristics->num_output = num_output;
-	characteristics->output = output;
-	characteristics->out = out;
-	characteristics->icpll = icpll;
-	return characteristics;
-
-out_free_output:
-	kfree(icpll);
-	kfree(out);
-	kfree(output);
-out_free_characteristics:
-	kfree(characteristics);
-	return NULL;
-}
-
-static void __init
-of_at91_clk_pll_setup(struct device_node *np,
-		      const struct clk_pll_layout *layout)
-{
-	u32 id;
-	struct clk_hw *hw;
-	struct regmap *regmap;
-	const char *parent_name;
-	const char *name = np->name;
-	struct clk_pll_characteristics *characteristics;
-
-	if (of_property_read_u32(np, "reg", &id))
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	characteristics = of_at91_clk_pll_get_characteristics(np);
-	if (!characteristics)
-		return;
-
-	hw = at91_clk_register_pll(regmap, name, parent_name, id, layout,
-				    characteristics);
-	if (IS_ERR(hw))
-		goto out_free_characteristics;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-	return;
-
-out_free_characteristics:
-	kfree(characteristics);
-}
-
-static void __init of_at91rm9200_clk_pll_setup(struct device_node *np)
-{
-	of_at91_clk_pll_setup(np, &at91rm9200_pll_layout);
-}
-CLK_OF_DECLARE(at91rm9200_clk_pll, "atmel,at91rm9200-clk-pll",
-	       of_at91rm9200_clk_pll_setup);
-
-static void __init of_at91sam9g45_clk_pll_setup(struct device_node *np)
-{
-	of_at91_clk_pll_setup(np, &at91sam9g45_pll_layout);
-}
-CLK_OF_DECLARE(at91sam9g45_clk_pll, "atmel,at91sam9g45-clk-pll",
-	       of_at91sam9g45_clk_pll_setup);
-
-static void __init of_at91sam9g20_clk_pllb_setup(struct device_node *np)
-{
-	of_at91_clk_pll_setup(np, &at91sam9g20_pllb_layout);
-}
-CLK_OF_DECLARE(at91sam9g20_clk_pllb, "atmel,at91sam9g20-clk-pllb",
-	       of_at91sam9g20_clk_pllb_setup);
-
-static void __init of_sama5d3_clk_pll_setup(struct device_node *np)
-{
-	of_at91_clk_pll_setup(np, &sama5d3_pll_layout);
-}
-CLK_OF_DECLARE(sama5d3_clk_pll, "atmel,sama5d3-clk-pll",
-	       of_sama5d3_clk_pll_setup);
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index de803a2b27d3..e8c4f8b02f28 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -106,28 +106,3 @@ at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 
 	return hw;
 }
-
-static void __init
-of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91_clk_register_plldiv(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_plldiv, "atmel,at91sam9x5-clk-plldiv",
-	       of_at91sam9x5_clk_plldiv_setup);
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index df302bfa8259..5bc68b9c5498 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -17,7 +17,6 @@
 
 #include "pmc.h"
 
-#define PROG_SOURCE_MAX		5
 #define PROG_ID_MAX		7
 
 #define PROG_STATUS_MASK(id)	(1 << ((id) + 8))
@@ -222,69 +221,3 @@ const struct clk_programmable_layout at91sam9x5_programmable_layout = {
 	.css_mask = 0x7,
 	.have_slck_mck = 0,
 };
-
-static void __init
-of_at91_clk_prog_setup(struct device_node *np,
-		       const struct clk_programmable_layout *layout)
-{
-	int num;
-	u32 id;
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[PROG_SOURCE_MAX];
-	const char *name;
-	struct device_node *progclknp;
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > PROG_SOURCE_MAX)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	num = of_get_child_count(np);
-	if (!num || num > (PROG_ID_MAX + 1))
-		return;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	for_each_child_of_node(np, progclknp) {
-		if (of_property_read_u32(progclknp, "reg", &id))
-			continue;
-
-		if (of_property_read_string(np, "clock-output-names", &name))
-			name = progclknp->name;
-
-		hw = at91_clk_register_programmable(regmap, name,
-						     parent_names, num_parents,
-						     id, layout);
-		if (IS_ERR(hw))
-			continue;
-
-		of_clk_add_hw_provider(progclknp, of_clk_hw_simple_get, hw);
-	}
-}
-
-
-static void __init of_at91rm9200_clk_prog_setup(struct device_node *np)
-{
-	of_at91_clk_prog_setup(np, &at91rm9200_programmable_layout);
-}
-CLK_OF_DECLARE(at91rm9200_clk_prog, "atmel,at91rm9200-clk-programmable",
-	       of_at91rm9200_clk_prog_setup);
-
-static void __init of_at91sam9g45_clk_prog_setup(struct device_node *np)
-{
-	of_at91_clk_prog_setup(np, &at91sam9g45_programmable_layout);
-}
-CLK_OF_DECLARE(at91sam9g45_clk_prog, "atmel,at91sam9g45-clk-programmable",
-	       of_at91sam9g45_clk_prog_setup);
-
-static void __init of_at91sam9x5_clk_prog_setup(struct device_node *np)
-{
-	of_at91_clk_prog_setup(np, &at91sam9x5_programmable_layout);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_prog, "atmel,at91sam9x5-clk-programmable",
-	       of_at91sam9x5_clk_prog_setup);
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index a890132db68f..cbb146912f7a 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -79,33 +79,3 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 
 	return hw;
 }
-
-static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_names[2];
-	unsigned int num_parents;
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents != 2)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names,
-					     num_parents);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-
-CLK_OF_DECLARE(at91sam9260_clk_slow, "atmel,at91sam9260-clk-slow",
-	       of_at91sam9260_clk_slow_setup);
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index bbf5dc91777f..75679fd8a9c7 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -17,8 +17,6 @@
 
 #include "pmc.h"
 
-#define SMD_SOURCE_MAX		2
-
 #define SMD_DIV_SHIFT		8
 #define SMD_MAX_DIV		0xf
 
@@ -142,33 +140,3 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 	return hw;
 }
-
-static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[SMD_SOURCE_MAX];
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > SMD_SOURCE_MAX)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91sam9x5_clk_register_smd(regmap, name, parent_names,
-					  num_parents);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_smd, "atmel,at91sam9x5-clk-smd",
-	       of_at91sam9x5_clk_smd_setup);
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 1ac0144a38c0..47bfca933403 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -123,40 +123,3 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 	return hw;
 }
-
-static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
-{
-	int num;
-	u32 id;
-	struct clk_hw *hw;
-	const char *name;
-	struct device_node *sysclknp;
-	const char *parent_name;
-	struct regmap *regmap;
-
-	num = of_get_child_count(np);
-	if (num > (SYSTEM_MAX_ID + 1))
-		return;
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	for_each_child_of_node(np, sysclknp) {
-		if (of_property_read_u32(sysclknp, "reg", &id))
-			continue;
-
-		if (of_property_read_string(np, "clock-output-names", &name))
-			name = sysclknp->name;
-
-		parent_name = of_clk_get_parent_name(sysclknp, 0);
-
-		hw = at91_clk_register_system(regmap, name, parent_name, id);
-		if (IS_ERR(hw))
-			continue;
-
-		of_clk_add_hw_provider(sysclknp, of_clk_hw_simple_get, hw);
-	}
-}
-CLK_OF_DECLARE(at91rm9200_clk_sys, "atmel,at91rm9200-clk-system",
-	       of_at91rm9200_clk_sys_setup);
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index a728320877dd..79ee1c760f2a 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -17,8 +17,6 @@
 
 #include "pmc.h"
 
-#define USB_SOURCE_MAX		2
-
 #define SAM9X5_USB_DIV_SHIFT	8
 #define SAM9X5_USB_MAX_DIV	0xf
 
@@ -374,89 +372,3 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 
 	return hw;
 }
-
-static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[USB_SOURCE_MAX];
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	num_parents = of_clk_get_parent_count(np);
-	if (num_parents == 0 || num_parents > USB_SOURCE_MAX)
-		return;
-
-	of_clk_parent_fill(np, parent_names, num_parents);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					 num_parents);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_usb, "atmel,at91sam9x5-clk-usb",
-	       of_at91sam9x5_clk_usb_setup);
-
-static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	struct regmap *regmap;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
-		return;
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
-	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91sam9n12_clk_usb, "atmel,at91sam9n12-clk-usb",
-	       of_at91sam9n12_clk_usb_setup);
-
-static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	u32 divisors[4] = {0, 0, 0, 0};
-	struct regmap *regmap;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
-		return;
-
-	of_property_read_u32_array(np, "atmel,clk-divisors", divisors, 4);
-	if (!divisors[0])
-		return;
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-}
-CLK_OF_DECLARE(at91rm9200_clk_usb, "atmel,at91rm9200-clk-usb",
-	       of_at91rm9200_clk_usb_setup);
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index 6c69b6ac71e1..9a970abf3489 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -157,46 +157,3 @@ at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 
 	return hw;
 }
-
-static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
-{
-	struct clk_hw *hw;
-	const char *parent_name;
-	const char *name = np->name;
-	struct regmap *regmap_pmc, *regmap_sfr;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-
-	of_property_read_string(np, "clock-output-names", &name);
-
-	regmap_pmc = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap_pmc))
-		return;
-
-	/*
-	 * If the device supports different mainck rates, this value has to be
-	 * set in the UTMI Clock Trimming register.
-	 * - 9x5: mainck supports several rates but it is indicated that a
-	 *   12 MHz is needed in case of USB.
-	 * - sama5d3 and sama5d2: mainck supports several rates. Configuring
-	 *   the FREQ field of the UTMI Clock Trimming register is mandatory.
-	 * - sama5d4: mainck is at 12 MHz.
-	 *
-	 * We only need to retrieve sama5d3 or sama5d2 sfr regmap.
-	 */
-	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d3-sfr");
-	if (IS_ERR(regmap_sfr)) {
-		regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
-		if (IS_ERR(regmap_sfr))
-			regmap_sfr = NULL;
-	}
-
-	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_name);
-	if (IS_ERR(hw))
-		return;
-
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
-	return;
-}
-CLK_OF_DECLARE(at91sam9x5_clk_utmi, "atmel,at91sam9x5-clk-utmi",
-	       of_at91sam9x5_clk_utmi_setup);
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
new file mode 100644
index 000000000000..b95bb4e2a927
--- /dev/null
+++ b/drivers/clk/at91/dt-compat.c
@@ -0,0 +1,961 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clk-provider.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+#define MASTER_SOURCE_MAX	4
+
+#define PERIPHERAL_AT91RM9200	0
+#define PERIPHERAL_AT91SAM9X5	1
+
+#define PERIPHERAL_MAX		64
+
+#define PERIPHERAL_ID_MIN	2
+
+#define PROG_SOURCE_MAX		5
+#define PROG_ID_MAX		7
+
+#define SYSTEM_MAX_ID		31
+
+#ifdef CONFIG_HAVE_AT91_AUDIO_PLL
+static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
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
+	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_frac_setup,
+	       "atmel,sama5d2-clk-audio-pll-frac",
+	       of_sama5d2_clk_audio_pll_frac_setup);
+
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
+CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
+	       "atmel,sama5d2-clk-audio-pll-pad",
+	       of_sama5d2_clk_audio_pll_pad_setup);
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
+}
+CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pmc_setup,
+	       "atmel,sama5d2-clk-audio-pll-pmc",
+	       of_sama5d2_clk_audio_pll_pmc_setup);
+#endif /* CONFIG_HAVE_AT91_AUDIO_PLL */
+
+#ifdef CONFIG_HAVE_AT91_GENERATED_CLK
+#define GENERATED_SOURCE_MAX	6
+
+#define GCK_ID_I2S0		54
+#define GCK_ID_I2S1		55
+#define GCK_ID_CLASSD		59
+
+static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
+{
+	int num;
+	u32 id;
+	const char *name;
+	struct clk_hw *hw;
+	unsigned int num_parents;
+	const char *parent_names[GENERATED_SOURCE_MAX];
+	struct device_node *gcknp;
+	struct clk_range range = CLK_RANGE(0, 0);
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents == 0 || num_parents > GENERATED_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	num = of_get_child_count(np);
+	if (!num || num > PERIPHERAL_MAX)
+		return;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	for_each_child_of_node(np, gcknp) {
+		bool pll_audio = false;
+
+		if (of_property_read_u32(gcknp, "reg", &id))
+			continue;
+
+		if (id < PERIPHERAL_ID_MIN || id >= PERIPHERAL_MAX)
+			continue;
+
+		if (of_property_read_string(np, "clock-output-names", &name))
+			name = gcknp->name;
+
+		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
+				      &range);
+
+		if (of_device_is_compatible(np, "atmel,sama5d2-clk-generated") &&
+		    (id == GCK_ID_I2S0 || id == GCK_ID_I2S1 ||
+		     id == GCK_ID_CLASSD))
+			pll_audio = true;
+
+		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
+						 parent_names, num_parents,
+						 id, pll_audio, &range);
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(gcknp, of_clk_hw_simple_get, hw);
+	}
+}
+CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
+	       of_sama5d2_clk_generated_setup);
+#endif /* CONFIG_HAVE_AT91_GENERATED_CLK */
+
+#ifdef CONFIG_HAVE_AT91_H32MX
+static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
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
+	hw = at91_clk_register_h32mx(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
+	       of_sama5d4_clk_h32mx_setup);
+#endif /* CONFIG_HAVE_AT91_H32MX */
+
+#ifdef CONFIG_HAVE_AT91_I2S_MUX_CLK
+#define	I2S_BUS_NR	2
+
+static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
+{
+	struct regmap *regmap_sfr;
+	u8 bus_id;
+	const char *parent_names[2];
+	struct device_node *i2s_mux_np;
+	struct clk_hw *hw;
+	int ret;
+
+	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap_sfr))
+		return;
+
+	for_each_child_of_node(np, i2s_mux_np) {
+		if (of_property_read_u8(i2s_mux_np, "reg", &bus_id))
+			continue;
+
+		if (bus_id > I2S_BUS_NR)
+			continue;
+
+		ret = of_clk_parent_fill(i2s_mux_np, parent_names, 2);
+		if (ret != 2)
+			continue;
+
+		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
+					       parent_names, 2, bus_id);
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(i2s_mux_np, of_clk_hw_simple_get, hw);
+	}
+}
+CLK_OF_DECLARE(sama5d2_clk_i2s_mux, "atmel,sama5d2-clk-i2s-mux",
+	       of_sama5d2_clk_i2s_mux_setup);
+#endif /* CONFIG_HAVE_AT91_I2S_MUX_CLK */
+
+static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
+	bool bypass;
+
+	of_property_read_string(np, "clock-output-names", &name);
+	bypass = of_property_read_bool(np, "atmel,osc-bypass");
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91rm9200_clk_main_osc, "atmel,at91rm9200-clk-main-osc",
+	       of_at91rm9200_clk_main_osc_setup);
+
+static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	u32 frequency = 0;
+	u32 accuracy = 0;
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	of_property_read_string(np, "clock-output-names", &name);
+	of_property_read_u32(np, "clock-frequency", &frequency);
+	of_property_read_u32(np, "clock-accuracy", &accuracy);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91_clk_register_main_rc_osc(regmap, name, frequency, accuracy);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_main_rc_osc, "atmel,at91sam9x5-clk-main-rc-osc",
+	       of_at91sam9x5_clk_main_rc_osc_setup);
+
+static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_name;
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91_clk_register_rm9200_main(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91rm9200_clk_main, "atmel,at91rm9200-clk-main",
+	       of_at91rm9200_clk_main_setup);
+
+static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_names[2];
+	unsigned int num_parents;
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents == 0 || num_parents > 2)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names,
+					   num_parents);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
+	       of_at91sam9x5_clk_main_setup);
+
+static struct clk_master_characteristics * __init
+of_at91_clk_master_get_characteristics(struct device_node *np)
+{
+	struct clk_master_characteristics *characteristics;
+
+	characteristics = kzalloc(sizeof(*characteristics), GFP_KERNEL);
+	if (!characteristics)
+		return NULL;
+
+	if (of_at91_get_clk_range(np, "atmel,clk-output-range", &characteristics->output))
+		goto out_free_characteristics;
+
+	of_property_read_u32_array(np, "atmel,clk-divisors",
+				   characteristics->divisors, 4);
+
+	characteristics->have_div3_pres =
+		of_property_read_bool(np, "atmel,master-clk-have-div3-pres");
+
+	return characteristics;
+
+out_free_characteristics:
+	kfree(characteristics);
+	return NULL;
+}
+
+static void __init
+of_at91_clk_master_setup(struct device_node *np,
+			 const struct clk_master_layout *layout)
+{
+	struct clk_hw *hw;
+	unsigned int num_parents;
+	const char *parent_names[MASTER_SOURCE_MAX];
+	const char *name = np->name;
+	struct clk_master_characteristics *characteristics;
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents == 0 || num_parents > MASTER_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	characteristics = of_at91_clk_master_get_characteristics(np);
+	if (!characteristics)
+		return;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91_clk_register_master(regmap, name, num_parents,
+				      parent_names, layout,
+				      characteristics);
+	if (IS_ERR(hw))
+		goto out_free_characteristics;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	return;
+
+out_free_characteristics:
+	kfree(characteristics);
+}
+
+static void __init of_at91rm9200_clk_master_setup(struct device_node *np)
+{
+	of_at91_clk_master_setup(np, &at91rm9200_master_layout);
+}
+CLK_OF_DECLARE(at91rm9200_clk_master, "atmel,at91rm9200-clk-master",
+	       of_at91rm9200_clk_master_setup);
+
+static void __init of_at91sam9x5_clk_master_setup(struct device_node *np)
+{
+	of_at91_clk_master_setup(np, &at91sam9x5_master_layout);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_master, "atmel,at91sam9x5-clk-master",
+	       of_at91sam9x5_clk_master_setup);
+
+static void __init
+of_at91_clk_periph_setup(struct device_node *np, u8 type)
+{
+	int num;
+	u32 id;
+	struct clk_hw *hw;
+	const char *parent_name;
+	const char *name;
+	struct device_node *periphclknp;
+	struct regmap *regmap;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	num = of_get_child_count(np);
+	if (!num || num > PERIPHERAL_MAX)
+		return;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	for_each_child_of_node(np, periphclknp) {
+		if (of_property_read_u32(periphclknp, "reg", &id))
+			continue;
+
+		if (id >= PERIPHERAL_MAX)
+			continue;
+
+		if (of_property_read_string(np, "clock-output-names", &name))
+			name = periphclknp->name;
+
+		if (type == PERIPHERAL_AT91RM9200) {
+			hw = at91_clk_register_peripheral(regmap, name,
+							  parent_name, id);
+		} else {
+			struct clk_range range = CLK_RANGE(0, 0);
+
+			of_at91_get_clk_range(periphclknp,
+					      "atmel,clk-output-range",
+					      &range);
+
+			hw = at91_clk_register_sam9x5_peripheral(regmap,
+								 &pmc_pcr_lock,
+								 name,
+								 parent_name,
+								 id, &range);
+		}
+
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(periphclknp, of_clk_hw_simple_get, hw);
+	}
+}
+
+static void __init of_at91rm9200_clk_periph_setup(struct device_node *np)
+{
+	of_at91_clk_periph_setup(np, PERIPHERAL_AT91RM9200);
+}
+CLK_OF_DECLARE(at91rm9200_clk_periph, "atmel,at91rm9200-clk-peripheral",
+	       of_at91rm9200_clk_periph_setup);
+
+static void __init of_at91sam9x5_clk_periph_setup(struct device_node *np)
+{
+	of_at91_clk_periph_setup(np, PERIPHERAL_AT91SAM9X5);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_periph, "atmel,at91sam9x5-clk-peripheral",
+	       of_at91sam9x5_clk_periph_setup);
+
+static struct clk_pll_characteristics * __init
+of_at91_clk_pll_get_characteristics(struct device_node *np)
+{
+	int i;
+	int offset;
+	u32 tmp;
+	int num_output;
+	u32 num_cells;
+	struct clk_range input;
+	struct clk_range *output;
+	u8 *out = NULL;
+	u16 *icpll = NULL;
+	struct clk_pll_characteristics *characteristics;
+
+	if (of_at91_get_clk_range(np, "atmel,clk-input-range", &input))
+		return NULL;
+
+	if (of_property_read_u32(np, "#atmel,pll-clk-output-range-cells",
+				 &num_cells))
+		return NULL;
+
+	if (num_cells < 2 || num_cells > 4)
+		return NULL;
+
+	if (!of_get_property(np, "atmel,pll-clk-output-ranges", &tmp))
+		return NULL;
+	num_output = tmp / (sizeof(u32) * num_cells);
+
+	characteristics = kzalloc(sizeof(*characteristics), GFP_KERNEL);
+	if (!characteristics)
+		return NULL;
+
+	output = kcalloc(num_output, sizeof(*output), GFP_KERNEL);
+	if (!output)
+		goto out_free_characteristics;
+
+	if (num_cells > 2) {
+		out = kcalloc(num_output, sizeof(*out), GFP_KERNEL);
+		if (!out)
+			goto out_free_output;
+	}
+
+	if (num_cells > 3) {
+		icpll = kcalloc(num_output, sizeof(*icpll), GFP_KERNEL);
+		if (!icpll)
+			goto out_free_output;
+	}
+
+	for (i = 0; i < num_output; i++) {
+		offset = i * num_cells;
+		if (of_property_read_u32_index(np,
+					       "atmel,pll-clk-output-ranges",
+					       offset, &tmp))
+			goto out_free_output;
+		output[i].min = tmp;
+		if (of_property_read_u32_index(np,
+					       "atmel,pll-clk-output-ranges",
+					       offset + 1, &tmp))
+			goto out_free_output;
+		output[i].max = tmp;
+
+		if (num_cells == 2)
+			continue;
+
+		if (of_property_read_u32_index(np,
+					       "atmel,pll-clk-output-ranges",
+					       offset + 2, &tmp))
+			goto out_free_output;
+		out[i] = tmp;
+
+		if (num_cells == 3)
+			continue;
+
+		if (of_property_read_u32_index(np,
+					       "atmel,pll-clk-output-ranges",
+					       offset + 3, &tmp))
+			goto out_free_output;
+		icpll[i] = tmp;
+	}
+
+	characteristics->input = input;
+	characteristics->num_output = num_output;
+	characteristics->output = output;
+	characteristics->out = out;
+	characteristics->icpll = icpll;
+	return characteristics;
+
+out_free_output:
+	kfree(icpll);
+	kfree(out);
+	kfree(output);
+out_free_characteristics:
+	kfree(characteristics);
+	return NULL;
+}
+
+static void __init
+of_at91_clk_pll_setup(struct device_node *np,
+		      const struct clk_pll_layout *layout)
+{
+	u32 id;
+	struct clk_hw *hw;
+	struct regmap *regmap;
+	const char *parent_name;
+	const char *name = np->name;
+	struct clk_pll_characteristics *characteristics;
+
+	if (of_property_read_u32(np, "reg", &id))
+		return;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	characteristics = of_at91_clk_pll_get_characteristics(np);
+	if (!characteristics)
+		return;
+
+	hw = at91_clk_register_pll(regmap, name, parent_name, id, layout,
+				   characteristics);
+	if (IS_ERR(hw))
+		goto out_free_characteristics;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	return;
+
+out_free_characteristics:
+	kfree(characteristics);
+}
+
+static void __init of_at91rm9200_clk_pll_setup(struct device_node *np)
+{
+	of_at91_clk_pll_setup(np, &at91rm9200_pll_layout);
+}
+CLK_OF_DECLARE(at91rm9200_clk_pll, "atmel,at91rm9200-clk-pll",
+	       of_at91rm9200_clk_pll_setup);
+
+static void __init of_at91sam9g45_clk_pll_setup(struct device_node *np)
+{
+	of_at91_clk_pll_setup(np, &at91sam9g45_pll_layout);
+}
+CLK_OF_DECLARE(at91sam9g45_clk_pll, "atmel,at91sam9g45-clk-pll",
+	       of_at91sam9g45_clk_pll_setup);
+
+static void __init of_at91sam9g20_clk_pllb_setup(struct device_node *np)
+{
+	of_at91_clk_pll_setup(np, &at91sam9g20_pllb_layout);
+}
+CLK_OF_DECLARE(at91sam9g20_clk_pllb, "atmel,at91sam9g20-clk-pllb",
+	       of_at91sam9g20_clk_pllb_setup);
+
+static void __init of_sama5d3_clk_pll_setup(struct device_node *np)
+{
+	of_at91_clk_pll_setup(np, &sama5d3_pll_layout);
+}
+CLK_OF_DECLARE(sama5d3_clk_pll, "atmel,sama5d3-clk-pll",
+	       of_sama5d3_clk_pll_setup);
+
+static void __init
+of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_name;
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91_clk_register_plldiv(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_plldiv, "atmel,at91sam9x5-clk-plldiv",
+	       of_at91sam9x5_clk_plldiv_setup);
+
+static void __init
+of_at91_clk_prog_setup(struct device_node *np,
+		       const struct clk_programmable_layout *layout)
+{
+	int num;
+	u32 id;
+	struct clk_hw *hw;
+	unsigned int num_parents;
+	const char *parent_names[PROG_SOURCE_MAX];
+	const char *name;
+	struct device_node *progclknp;
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents == 0 || num_parents > PROG_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	num = of_get_child_count(np);
+	if (!num || num > (PROG_ID_MAX + 1))
+		return;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	for_each_child_of_node(np, progclknp) {
+		if (of_property_read_u32(progclknp, "reg", &id))
+			continue;
+
+		if (of_property_read_string(np, "clock-output-names", &name))
+			name = progclknp->name;
+
+		hw = at91_clk_register_programmable(regmap, name,
+						    parent_names, num_parents,
+						    id, layout);
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(progclknp, of_clk_hw_simple_get, hw);
+	}
+}
+
+static void __init of_at91rm9200_clk_prog_setup(struct device_node *np)
+{
+	of_at91_clk_prog_setup(np, &at91rm9200_programmable_layout);
+}
+CLK_OF_DECLARE(at91rm9200_clk_prog, "atmel,at91rm9200-clk-programmable",
+	       of_at91rm9200_clk_prog_setup);
+
+static void __init of_at91sam9g45_clk_prog_setup(struct device_node *np)
+{
+	of_at91_clk_prog_setup(np, &at91sam9g45_programmable_layout);
+}
+CLK_OF_DECLARE(at91sam9g45_clk_prog, "atmel,at91sam9g45-clk-programmable",
+	       of_at91sam9g45_clk_prog_setup);
+
+static void __init of_at91sam9x5_clk_prog_setup(struct device_node *np)
+{
+	of_at91_clk_prog_setup(np, &at91sam9x5_programmable_layout);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_prog, "atmel,at91sam9x5-clk-programmable",
+	       of_at91sam9x5_clk_prog_setup);
+
+static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_names[2];
+	unsigned int num_parents;
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents != 2)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names,
+					    num_parents);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9260_clk_slow, "atmel,at91sam9260-clk-slow",
+	       of_at91sam9260_clk_slow_setup);
+
+#ifdef CONFIG_HAVE_AT91_SMD
+#define SMD_SOURCE_MAX		2
+
+static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	unsigned int num_parents;
+	const char *parent_names[SMD_SOURCE_MAX];
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents == 0 || num_parents > SMD_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91sam9x5_clk_register_smd(regmap, name, parent_names,
+					 num_parents);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_smd, "atmel,at91sam9x5-clk-smd",
+	       of_at91sam9x5_clk_smd_setup);
+#endif /* CONFIG_HAVE_AT91_SMD */
+
+static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
+{
+	int num;
+	u32 id;
+	struct clk_hw *hw;
+	const char *name;
+	struct device_node *sysclknp;
+	const char *parent_name;
+	struct regmap *regmap;
+
+	num = of_get_child_count(np);
+	if (num > (SYSTEM_MAX_ID + 1))
+		return;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	for_each_child_of_node(np, sysclknp) {
+		if (of_property_read_u32(sysclknp, "reg", &id))
+			continue;
+
+		if (of_property_read_string(np, "clock-output-names", &name))
+			name = sysclknp->name;
+
+		parent_name = of_clk_get_parent_name(sysclknp, 0);
+
+		hw = at91_clk_register_system(regmap, name, parent_name, id);
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(sysclknp, of_clk_hw_simple_get, hw);
+	}
+}
+CLK_OF_DECLARE(at91rm9200_clk_sys, "atmel,at91rm9200-clk-system",
+	       of_at91rm9200_clk_sys_setup);
+
+#ifdef CONFIG_HAVE_AT91_USB_CLK
+#define USB_SOURCE_MAX		2
+
+static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	unsigned int num_parents;
+	const char *parent_names[USB_SOURCE_MAX];
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents == 0 || num_parents > USB_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					 num_parents);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_usb, "atmel,at91sam9x5-clk-usb",
+	       of_at91sam9x5_clk_usb_setup);
+
+static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_name;
+	const char *name = np->name;
+	struct regmap *regmap;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9n12_clk_usb, "atmel,at91sam9n12-clk-usb",
+	       of_at91sam9n12_clk_usb_setup);
+
+static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_name;
+	const char *name = np->name;
+	u32 divisors[4] = {0, 0, 0, 0};
+	struct regmap *regmap;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	of_property_read_u32_array(np, "atmel,clk-divisors", divisors, 4);
+	if (!divisors[0])
+		return;
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91rm9200_clk_usb, "atmel,at91rm9200-clk-usb",
+	       of_at91rm9200_clk_usb_setup);
+#endif /* CONFIG_HAVE_AT91_USB_CLK */
+
+#ifdef CONFIG_HAVE_AT91_UTMI
+static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *parent_name;
+	const char *name = np->name;
+	struct regmap *regmap_pmc, *regmap_sfr;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	of_property_read_string(np, "clock-output-names", &name);
+
+	regmap_pmc = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap_pmc))
+		return;
+
+	/*
+	 * If the device supports different mainck rates, this value has to be
+	 * set in the UTMI Clock Trimming register.
+	 * - 9x5: mainck supports several rates but it is indicated that a
+	 *   12 MHz is needed in case of USB.
+	 * - sama5d3 and sama5d2: mainck supports several rates. Configuring
+	 *   the FREQ field of the UTMI Clock Trimming register is mandatory.
+	 * - sama5d4: mainck is at 12 MHz.
+	 *
+	 * We only need to retrieve sama5d3 or sama5d2 sfr regmap.
+	 */
+	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d3-sfr");
+	if (IS_ERR(regmap_sfr)) {
+		regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+		if (IS_ERR(regmap_sfr))
+			regmap_sfr = NULL;
+	}
+
+	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+CLK_OF_DECLARE(at91sam9x5_clk_utmi, "atmel,at91sam9x5-clk-utmi",
+	       of_at91sam9x5_clk_utmi_setup);
+#endif /* CONFIG_HAVE_AT91_UTMI */
-- 
2.19.1

