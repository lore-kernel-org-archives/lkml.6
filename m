Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F99C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AD12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJPWNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48169 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeJPWNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 02EB8209DA; Tue, 16 Oct 2018 16:22:21 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2661520DB5;
        Tue, 16 Oct 2018 16:22:02 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 06/22] clk: at91: allow clock registration from C code
Date:   Tue, 16 Oct 2018 16:21:44 +0200
Message-Id: <20181016142200.19741-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove static keyword to allow functions to be used from other units. Also
move some struct and function declarations to pmc.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-generated.c    |   2 +-
 drivers/clk/at91/clk-i2s-mux.c      |   2 +-
 drivers/clk/at91/clk-main.c         |   8 +-
 drivers/clk/at91/clk-master.c       |  17 +---
 drivers/clk/at91/clk-peripheral.c   |   4 +-
 drivers/clk/at91/clk-pll.c          |  24 +----
 drivers/clk/at91/clk-plldiv.c       |   2 +-
 drivers/clk/at91/clk-programmable.c |  14 +--
 drivers/clk/at91/clk-slow.c         |   2 +-
 drivers/clk/at91/clk-smd.c          |   2 +-
 drivers/clk/at91/clk-system.c       |   2 +-
 drivers/clk/at91/clk-usb.c          |   6 +-
 drivers/clk/at91/clk-utmi.c         |   2 +-
 drivers/clk/at91/pmc.h              | 142 ++++++++++++++++++++++++++++
 14 files changed, 170 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 6dfee6e588c4..0fe4d7f04225 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -277,7 +277,7 @@ static void clk_generated_startup(struct clk_generated *gck)
 					>> AT91_PMC_PCR_GCKDIV_OFFSET;
 }
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const char *name, const char **parent_names,
 			    u8 num_parents, u8 id, bool pll_audio,
diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
index f0c3c3079f04..ed9e96938589 100644
--- a/drivers/clk/at91/clk-i2s-mux.c
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -48,7 +48,7 @@ static const struct clk_ops clk_i2s_mux_ops = {
 	.determine_rate = __clk_mux_determine_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 			  const char * const *parent_names,
 			  unsigned int num_parents, u8 bus_id)
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index c813c27f2e58..82184009137d 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -128,7 +128,7 @@ static const struct clk_ops main_osc_ops = {
 	.is_prepared = clk_main_osc_is_prepared,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_main_osc(struct regmap *regmap,
 			   const char *name,
 			   const char *parent_name,
@@ -275,7 +275,7 @@ static const struct clk_ops main_rc_osc_ops = {
 	.recalc_accuracy = clk_main_rc_osc_recalc_accuracy,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_main_rc_osc(struct regmap *regmap,
 			      const char *name,
 			      u32 frequency, u32 accuracy)
@@ -403,7 +403,7 @@ static const struct clk_ops rm9200_main_ops = {
 	.recalc_rate = clk_rm9200_main_recalc_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
 			      const char *parent_name)
@@ -541,7 +541,7 @@ static const struct clk_ops sam9x5_main_ops = {
 	.get_parent = clk_sam9x5_main_get_parent,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap,
 			      const char *name,
 			      const char **parent_names,
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index e9cba9fc26d7..088044bb6ea2 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -24,17 +24,6 @@
 #define MASTER_DIV_SHIFT	8
 #define MASTER_DIV_MASK		0x3
 
-struct clk_master_characteristics {
-	struct clk_range output;
-	u32 divisors[4];
-	u8 have_div3_pres;
-};
-
-struct clk_master_layout {
-	u32 mask;
-	u8 pres_shift;
-};
-
 #define to_clk_master(hw) container_of(hw, struct clk_master, hw)
 
 struct clk_master {
@@ -120,7 +109,7 @@ static const struct clk_ops master_ops = {
 	.get_parent = clk_master_get_parent,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_master(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
@@ -161,12 +150,12 @@ at91_clk_register_master(struct regmap *regmap,
 }
 
 
-static const struct clk_master_layout at91rm9200_master_layout = {
+const struct clk_master_layout at91rm9200_master_layout = {
 	.mask = 0x31F,
 	.pres_shift = 2,
 };
 
-static const struct clk_master_layout at91sam9x5_master_layout = {
+const struct clk_master_layout at91sam9x5_master_layout = {
 	.mask = 0x373,
 	.pres_shift = 4,
 };
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 770118369230..cb41d06a2481 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -104,7 +104,7 @@ static const struct clk_ops peripheral_ops = {
 	.is_enabled = clk_peripheral_is_enabled,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 			     const char *parent_name, u32 id)
 {
@@ -331,7 +331,7 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 	.set_rate = clk_sam9x5_peripheral_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const char *name, const char *parent_name,
 				    u32 id, const struct clk_range *range)
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 72b6091eb7b9..31fff0b9d5c2 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -34,20 +34,6 @@
 #define PLL_OUT_SHIFT		14
 #define PLL_MAX_ID		1
 
-struct clk_pll_characteristics {
-	struct clk_range input;
-	int num_output;
-	struct clk_range *output;
-	u16 *icpll;
-	u8 *out;
-};
-
-struct clk_pll_layout {
-	u32 pllr_mask;
-	u16 mul_mask;
-	u8 mul_shift;
-};
-
 #define to_clk_pll(hw) container_of(hw, struct clk_pll, hw)
 
 struct clk_pll {
@@ -285,7 +271,7 @@ static const struct clk_ops pll_ops = {
 	.set_rate = clk_pll_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_pll(struct regmap *regmap, const char *name,
 		      const char *parent_name, u8 id,
 		      const struct clk_pll_layout *layout,
@@ -331,25 +317,25 @@ at91_clk_register_pll(struct regmap *regmap, const char *name,
 }
 
 
-static const struct clk_pll_layout at91rm9200_pll_layout = {
+const struct clk_pll_layout at91rm9200_pll_layout = {
 	.pllr_mask = 0x7FFFFFF,
 	.mul_shift = 16,
 	.mul_mask = 0x7FF,
 };
 
-static const struct clk_pll_layout at91sam9g45_pll_layout = {
+const struct clk_pll_layout at91sam9g45_pll_layout = {
 	.pllr_mask = 0xFFFFFF,
 	.mul_shift = 16,
 	.mul_mask = 0xFF,
 };
 
-static const struct clk_pll_layout at91sam9g20_pllb_layout = {
+const struct clk_pll_layout at91sam9g20_pllb_layout = {
 	.pllr_mask = 0x3FFFFF,
 	.mul_shift = 16,
 	.mul_mask = 0x3F,
 };
 
-static const struct clk_pll_layout sama5d3_pll_layout = {
+const struct clk_pll_layout sama5d3_pll_layout = {
 	.pllr_mask = 0x1FFFFFF,
 	.mul_shift = 18,
 	.mul_mask = 0x7F,
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index b4afaf22f3fd..de803a2b27d3 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -75,7 +75,7 @@ static const struct clk_ops plldiv_ops = {
 	.set_rate = clk_plldiv_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 			 const char *parent_name)
 {
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 0e6aab1252fc..df302bfa8259 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -25,12 +25,6 @@
 #define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & PROG_PRES_MASK)
 #define PROG_MAX_RM9200_CSS	3
 
-struct clk_programmable_layout {
-	u8 pres_shift;
-	u8 css_mask;
-	u8 have_slck_mck;
-};
-
 struct clk_programmable {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -170,7 +164,7 @@ static const struct clk_ops programmable_ops = {
 	.set_rate = clk_programmable_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap,
 			       const char *name, const char **parent_names,
 			       u8 num_parents, u8 id,
@@ -211,19 +205,19 @@ at91_clk_register_programmable(struct regmap *regmap,
 	return hw;
 }
 
-static const struct clk_programmable_layout at91rm9200_programmable_layout = {
+const struct clk_programmable_layout at91rm9200_programmable_layout = {
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 0,
 };
 
-static const struct clk_programmable_layout at91sam9g45_programmable_layout = {
+const struct clk_programmable_layout at91sam9g45_programmable_layout = {
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 1,
 };
 
-static const struct clk_programmable_layout at91sam9x5_programmable_layout = {
+const struct clk_programmable_layout at91sam9x5_programmable_layout = {
 	.pres_shift = 4,
 	.css_mask = 0x7,
 	.have_slck_mck = 0,
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 560a8b9abf93..a890132db68f 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -40,7 +40,7 @@ static const struct clk_ops sam9260_slow_ops = {
 	.get_parent = clk_sam9260_slow_get_parent,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 965c662b90a5..bbf5dc91777f 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -111,7 +111,7 @@ static const struct clk_ops at91sam9x5_smd_ops = {
 	.set_rate = at91sam9x5_clk_smd_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 86a36809765d..1ac0144a38c0 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -88,7 +88,7 @@ static const struct clk_ops system_ops = {
 	.is_prepared = clk_system_is_prepared,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
 			 const char *parent_name, u8 id)
 {
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 791770a563fc..a728320877dd 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -192,7 +192,7 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 	.set_rate = at91sam9x5_clk_usb_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
@@ -225,7 +225,7 @@ at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 	return hw;
 }
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name)
 {
@@ -342,7 +342,7 @@ static const struct clk_ops at91rm9200_usb_ops = {
 	.set_rate = at91rm9200_clk_usb_set_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char *parent_name, const u32 *divisors)
 {
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index cd8d689138ff..6c69b6ac71e1 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -125,7 +125,7 @@ static const struct clk_ops utmi_ops = {
 	.recalc_rate = clk_utmi_recalc_rate,
 };
 
-static struct clk_hw * __init
+struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 		       const char *name, const char *parent_name)
 {
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index d22b1fa9ecdc..3dc50267a458 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -26,9 +26,151 @@ struct clk_range {
 
 #define CLK_RANGE(MIN, MAX) {.min = MIN, .max = MAX,}
 
+struct clk_master_layout {
+	u32 mask;
+	u8 pres_shift;
+};
+
+extern const struct clk_master_layout at91rm9200_master_layout;
+extern const struct clk_master_layout at91sam9x5_master_layout;
+
+struct clk_master_characteristics {
+	struct clk_range output;
+	u32 divisors[4];
+	u8 have_div3_pres;
+};
+
+struct clk_pll_layout {
+	u32 pllr_mask;
+	u16 mul_mask;
+	u8 mul_shift;
+};
+
+extern const struct clk_pll_layout at91rm9200_pll_layout;
+extern const struct clk_pll_layout at91sam9g45_pll_layout;
+extern const struct clk_pll_layout at91sam9g20_pllb_layout;
+extern const struct clk_pll_layout sama5d3_pll_layout;
+
+struct clk_pll_characteristics {
+	struct clk_range input;
+	int num_output;
+	struct clk_range *output;
+	u16 *icpll;
+	u8 *out;
+};
+
+struct clk_programmable_layout {
+	u8 pres_shift;
+	u8 css_mask;
+	u8 have_slck_mck;
+};
+
+extern const struct clk_programmable_layout at91rm9200_programmable_layout;
+extern const struct clk_programmable_layout at91sam9g45_programmable_layout;
+extern const struct clk_programmable_layout at91sam9x5_programmable_layout;
+
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
 
+struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data);
+
+struct clk_hw * __init
+at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
+				 const char *parent_name);
+
+struct clk_hw * __init
+at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
+				const char *parent_name);
+
+struct clk_hw * __init
+at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
+				const char *parent_name);
+
+struct clk_hw * __init
+at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
+			    const char *name, const char **parent_names,
+			    u8 num_parents, u8 id, bool pll_audio,
+			    const struct clk_range *range);
+
+struct clk_hw * __init
+at91_clk_register_h32mx(struct regmap *regmap, const char *name,
+			const char *parent_name);
+
+struct clk_hw * __init
+at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
+			  const char * const *parent_names,
+			  unsigned int num_parents, u8 bus_id);
+
+struct clk_hw * __init
+at91_clk_register_main_rc_osc(struct regmap *regmap, const char *name,
+			      u32 frequency, u32 accuracy);
+struct clk_hw * __init
+at91_clk_register_main_osc(struct regmap *regmap, const char *name,
+			   const char *parent_name, bool bypass);
+struct clk_hw * __init
+at91_clk_register_rm9200_main(struct regmap *regmap,
+			      const char *name,
+			      const char *parent_name);
+struct clk_hw * __init
+at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
+			      const char **parent_names, int num_parents);
+
+struct clk_hw * __init
+at91_clk_register_master(struct regmap *regmap, const char *name,
+			 int num_parents, const char **parent_names,
+			 const struct clk_master_layout *layout,
+			 const struct clk_master_characteristics *characteristics);
+
+struct clk_hw * __init
+at91_clk_register_peripheral(struct regmap *regmap, const char *name,
+			     const char *parent_name, u32 id);
+struct clk_hw * __init
+at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
+				    const char *name, const char *parent_name,
+				    u32 id, const struct clk_range *range);
+
+struct clk_hw * __init
+at91_clk_register_pll(struct regmap *regmap, const char *name,
+		      const char *parent_name, u8 id,
+		      const struct clk_pll_layout *layout,
+		      const struct clk_pll_characteristics *characteristics);
+struct clk_hw * __init
+at91_clk_register_plldiv(struct regmap *regmap, const char *name,
+			 const char *parent_name);
+
+struct clk_hw * __init
+at91_clk_register_programmable(struct regmap *regmap, const char *name,
+			       const char **parent_names, u8 num_parents, u8 id,
+			       const struct clk_programmable_layout *layout);
+
+struct clk_hw * __init
+at91_clk_register_sam9260_slow(struct regmap *regmap,
+			       const char *name,
+			       const char **parent_names,
+			       int num_parents);
+
+struct clk_hw * __init
+at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
+			    const char **parent_names, u8 num_parents);
+
+struct clk_hw * __init
+at91_clk_register_system(struct regmap *regmap, const char *name,
+			 const char *parent_name, u8 id);
+
+struct clk_hw * __init
+at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
+			    const char **parent_names, u8 num_parents);
+struct clk_hw * __init
+at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
+			     const char *parent_name);
+struct clk_hw * __init
+at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
+			    const char *parent_name, const u32 *divisors);
+
+struct clk_hw * __init
+at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
+		       const char *name, const char *parent_name);
+
 #ifdef CONFIG_PM
 void pmc_register_id(u8 id);
 void pmc_register_pck(u8 pck);
-- 
2.19.1

