Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743B92086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfBTLsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:48:13 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47574 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBTLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:48:11 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 1250C3A3AA3;
        Wed, 20 Feb 2019 11:26:18 +0000 (UTC)
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 10E4C200016;
        Wed, 20 Feb 2019 11:26:14 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/7] clk: at91: allow configuring peripheral PCR layout
Date:   Wed, 20 Feb 2019 12:25:59 +0100
Message-Id: <20190220112605.23095-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCR register actually changed layout for each SoC. By chance, this
didn't have impact on sama5d[2-4] support but since sama5d3, PID is seven
bits wide and sama5d4 and sama5d2 don't have DIV.

For the DT backward compatibility, keep the layout as is.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/at91sam9x5.c     |  9 ++++++
 drivers/clk/at91/clk-peripheral.c | 46 ++++++++++++++++---------------
 drivers/clk/at91/dt-compat.c      |  9 ++++++
 drivers/clk/at91/pmc.h            | 12 ++++++++
 drivers/clk/at91/sama5d2.c        |  9 ++++++
 drivers/clk/at91/sama5d4.c        |  8 ++++++
 include/linux/clk/at91_pmc.h      |  3 --
 7 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 3487e03d4bc6..f5cfcbd85f10 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -49,6 +49,13 @@ static const struct {
 	{ .n = "pck1",  .p = "prog1",    .id = 9 },
 };
 
+static const struct clk_pcr_layout at91sam9x5_pcr_layout = {
+	.offset = 0x10c,
+	.cmd = BIT(12),
+	.pid_mask = GENMASK(5, 0),
+	.div_mask = GENMASK(17, 16),
+};
+
 struct pck {
 	char *n;
 	u8 id;
@@ -242,6 +249,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	for (i = 0; i < ARRAY_SIZE(at91sam9x5_periphck); i++) {
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 &at91sam9x5_pcr_layout,
 							 at91sam9x5_periphck[i].n,
 							 "masterck",
 							 at91sam9x5_periphck[i].id,
@@ -254,6 +262,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	for (i = 0; extra_pcks[i].id; i++) {
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 &at91sam9x5_pcr_layout,
 							 extra_pcks[i].n,
 							 "masterck",
 							 extra_pcks[i].id,
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 65c1defa78e4..6b7748b9588a 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -23,9 +24,6 @@ DEFINE_SPINLOCK(pmc_pcr_lock);
 #define PERIPHERAL_ID_MAX	31
 #define PERIPHERAL_MASK(id)	(1 << ((id) & PERIPHERAL_ID_MAX))
 
-#define PERIPHERAL_RSHIFT_MASK	0x3
-#define PERIPHERAL_RSHIFT(val)	(((val) >> 16) & PERIPHERAL_RSHIFT_MASK)
-
 #define PERIPHERAL_MAX_SHIFT	3
 
 struct clk_peripheral {
@@ -43,6 +41,7 @@ struct clk_sam9x5_peripheral {
 	spinlock_t *lock;
 	u32 id;
 	u32 div;
+	const struct clk_pcr_layout *layout;
 	bool auto_div;
 };
 
@@ -169,13 +168,13 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
 		return 0;
 
 	spin_lock_irqsave(periph->lock, flags);
-	regmap_write(periph->regmap, AT91_PMC_PCR,
-		     (periph->id & AT91_PMC_PCR_PID_MASK));
-	regmap_update_bits(periph->regmap, AT91_PMC_PCR,
-			   AT91_PMC_PCR_DIV_MASK | AT91_PMC_PCR_CMD |
+	regmap_write(periph->regmap, periph->layout->offset,
+		     (periph->id & periph->layout->pid_mask));
+	regmap_update_bits(periph->regmap, periph->layout->offset,
+			   periph->layout->div_mask | periph->layout->cmd |
 			   AT91_PMC_PCR_EN,
-			   AT91_PMC_PCR_DIV(periph->div) |
-			   AT91_PMC_PCR_CMD |
+			   field_prep(periph->layout->div_mask, periph->div) |
+			   periph->layout->cmd |
 			   AT91_PMC_PCR_EN);
 	spin_unlock_irqrestore(periph->lock, flags);
 
@@ -191,11 +190,11 @@ static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
 		return;
 
 	spin_lock_irqsave(periph->lock, flags);
-	regmap_write(periph->regmap, AT91_PMC_PCR,
-		     (periph->id & AT91_PMC_PCR_PID_MASK));
-	regmap_update_bits(periph->regmap, AT91_PMC_PCR,
-			   AT91_PMC_PCR_EN | AT91_PMC_PCR_CMD,
-			   AT91_PMC_PCR_CMD);
+	regmap_write(periph->regmap, periph->layout->offset,
+		     (periph->id & periph->layout->pid_mask));
+	regmap_update_bits(periph->regmap, periph->layout->offset,
+			   AT91_PMC_PCR_EN | periph->layout->cmd,
+			   periph->layout->cmd);
 	spin_unlock_irqrestore(periph->lock, flags);
 }
 
@@ -209,9 +208,9 @@ static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
 		return 1;
 
 	spin_lock_irqsave(periph->lock, flags);
-	regmap_write(periph->regmap, AT91_PMC_PCR,
-		     (periph->id & AT91_PMC_PCR_PID_MASK));
-	regmap_read(periph->regmap, AT91_PMC_PCR, &status);
+	regmap_write(periph->regmap, periph->layout->offset,
+		     (periph->id & periph->layout->pid_mask));
+	regmap_read(periph->regmap, periph->layout->offset, &status);
 	spin_unlock_irqrestore(periph->lock, flags);
 
 	return status & AT91_PMC_PCR_EN ? 1 : 0;
@@ -229,13 +228,13 @@ clk_sam9x5_peripheral_recalc_rate(struct clk_hw *hw,
 		return parent_rate;
 
 	spin_lock_irqsave(periph->lock, flags);
-	regmap_write(periph->regmap, AT91_PMC_PCR,
-		     (periph->id & AT91_PMC_PCR_PID_MASK));
-	regmap_read(periph->regmap, AT91_PMC_PCR, &status);
+	regmap_write(periph->regmap, periph->layout->offset,
+		     (periph->id & periph->layout->pid_mask));
+	regmap_read(periph->regmap, periph->layout->offset, &status);
 	spin_unlock_irqrestore(periph->lock, flags);
 
 	if (status & AT91_PMC_PCR_EN) {
-		periph->div = PERIPHERAL_RSHIFT(status);
+		periph->div = field_get(periph->layout->div_mask, status);
 		periph->auto_div = false;
 	} else {
 		clk_sam9x5_peripheral_autodiv(periph);
@@ -328,6 +327,7 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
+				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
 				    u32 id, const struct clk_range *range)
 {
@@ -354,7 +354,9 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 	periph->div = 0;
 	periph->regmap = regmap;
 	periph->lock = lock;
-	periph->auto_div = true;
+	if (layout->div_mask)
+		periph->auto_div = true;
+	periph->layout = layout;
 	periph->range = *range;
 
 	hw = &periph->hw;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index b95bb4e2a927..aa09072f36db 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -93,6 +93,14 @@ CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pmc_setup,
 	       of_sama5d2_clk_audio_pll_pmc_setup);
 #endif /* CONFIG_HAVE_AT91_AUDIO_PLL */
 
+static const struct clk_pcr_layout dt_pcr_layout = {
+	.offset = 0x10c,
+	.cmd = BIT(12),
+	.pid_mask = GENMASK(5, 0),
+	.div_mask = GENMASK(17, 16),
+	.gckcss_mask = GENMASK(10, 8),
+};
+
 #ifdef CONFIG_HAVE_AT91_GENERATED_CLK
 #define GENERATED_SOURCE_MAX	6
 
@@ -448,6 +456,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 
 			hw = at91_clk_register_sam9x5_peripheral(regmap,
 								 &pmc_pcr_lock,
+								 &dt_pcr_layout,
 								 name,
 								 parent_name,
 								 id, &range);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 672a79bda88c..616c04588093 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -80,6 +80,17 @@ extern const struct clk_programmable_layout at91rm9200_programmable_layout;
 extern const struct clk_programmable_layout at91sam9g45_programmable_layout;
 extern const struct clk_programmable_layout at91sam9x5_programmable_layout;
 
+struct clk_pcr_layout {
+	u32 offset;
+	u32 cmd;
+	u32 div_mask;
+	u32 gckcss_mask;
+	u32 pid_mask;
+};
+
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
 #define ndck(a, s) (a[s - 1].id + 1)
 #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
 struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
@@ -143,6 +154,7 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 			     const char *parent_name, u32 id);
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
+				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
 				    u32 id, const struct clk_range *range);
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index cd0ef7274fdb..f3f1ce2013d4 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -28,6 +28,13 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.out = plla_out,
 };
 
+static const struct clk_pcr_layout sama5d2_pcr_layout = {
+	.offset = 0x10c,
+	.cmd = BIT(12),
+	.gckcss_mask = GENMASK(10, 8),
+	.pid_mask = GENMASK(6, 0),
+};
+
 static const struct {
 	char *n;
 	char *p;
@@ -265,6 +272,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d2_periphck); i++) {
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 &sama5d2_pcr_layout,
 							 sama5d2_periphck[i].n,
 							 "masterck",
 							 sama5d2_periphck[i].id,
@@ -277,6 +285,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d2_periph32ck); i++) {
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 &sama5d2_pcr_layout,
 							 sama5d2_periph32ck[i].n,
 							 "h32mxck",
 							 sama5d2_periph32ck[i].id,
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index b645a9d59cdb..840edca77821 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -28,6 +28,12 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.out = plla_out,
 };
 
+static const struct clk_pcr_layout sama5d4_pcr_layout = {
+	.offset = 0x10c,
+	.cmd = BIT(12),
+	.pid_mask = GENMASK(6, 0),
+};
+
 static const struct {
 	char *n;
 	char *p;
@@ -232,6 +238,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d4_periphck); i++) {
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 &sama5d4_pcr_layout,
 							 sama5d4_periphck[i].n,
 							 "masterck",
 							 sama5d4_periphck[i].id,
@@ -244,6 +251,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d4_periph32ck); i++) {
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 &sama5d4_pcr_layout,
 							 sama5d4_periph32ck[i].n,
 							 "h32mxck",
 							 sama5d4_periph32ck[i].id,
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 931ab05f771d..b97b8dcbffe6 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -191,9 +191,6 @@
 #define		AT91_PMC_PCR_GCKCSS_MASK	(0x7  << AT91_PMC_PCR_GCKCSS_OFFSET)
 #define		AT91_PMC_PCR_GCKCSS(n)		((n)  << AT91_PMC_PCR_GCKCSS_OFFSET)	/* GCK Clock Source Selection */
 #define		AT91_PMC_PCR_CMD		(0x1  <<  12)				/* Command (read=0, write=1) */
-#define		AT91_PMC_PCR_DIV_OFFSET		16
-#define		AT91_PMC_PCR_DIV_MASK		(0x3  << AT91_PMC_PCR_DIV_OFFSET)
-#define		AT91_PMC_PCR_DIV(n)		((n)  << AT91_PMC_PCR_DIV_OFFSET)	/* Divisor Value */
 #define		AT91_PMC_PCR_GCKDIV_OFFSET	20
 #define		AT91_PMC_PCR_GCKDIV_MASK	(0xff  << AT91_PMC_PCR_GCKDIV_OFFSET)
 #define		AT91_PMC_PCR_GCKDIV(n)		((n)  << AT91_PMC_PCR_GCKDIV_OFFSET)	/* Generated Clock Divisor Value */
-- 
2.20.1

