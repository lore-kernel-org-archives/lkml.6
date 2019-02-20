Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04264C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB64C206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfBTL0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:26:23 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39489 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:26:22 -0500
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 00B49240004;
        Wed, 20 Feb 2019 11:26:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/7] clk: at91: allow configuring generated PCR layout
Date:   Wed, 20 Feb 2019 12:26:00 +0100
Message-Id: <20190220112605.23095-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCR register layout for GCLKCSS is changing for the future SoCs, allow
configuring it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-generated.c | 48 +++++++++++++++++---------------
 drivers/clk/at91/dt-compat.c     |  3 +-
 drivers/clk/at91/pmc.h           |  1 +
 drivers/clk/at91/sama5d2.c       |  1 +
 include/linux/clk/at91_pmc.h     |  7 +----
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 66e7f7baf958..5f18847965c1 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -31,6 +32,7 @@ struct clk_generated {
 	spinlock_t *lock;
 	u32 id;
 	u32 gckdiv;
+	const struct clk_pcr_layout *layout;
 	u8 parent_id;
 	bool audio_pll_allowed;
 };
@@ -47,14 +49,14 @@ static int clk_generated_enable(struct clk_hw *hw)
 		 __func__, gck->gckdiv, gck->parent_id);
 
 	spin_lock_irqsave(gck->lock, flags);
-	regmap_write(gck->regmap, AT91_PMC_PCR,
-		     (gck->id & AT91_PMC_PCR_PID_MASK));
-	regmap_update_bits(gck->regmap, AT91_PMC_PCR,
-			   AT91_PMC_PCR_GCKDIV_MASK | AT91_PMC_PCR_GCKCSS_MASK |
-			   AT91_PMC_PCR_CMD | AT91_PMC_PCR_GCKEN,
-			   AT91_PMC_PCR_GCKCSS(gck->parent_id) |
-			   AT91_PMC_PCR_CMD |
-			   AT91_PMC_PCR_GCKDIV(gck->gckdiv) |
+	regmap_write(gck->regmap, gck->layout->offset,
+		     (gck->id & gck->layout->pid_mask));
+	regmap_update_bits(gck->regmap, gck->layout->offset,
+			   AT91_PMC_PCR_GCKDIV_MASK | gck->layout->gckcss_mask |
+			   gck->layout->cmd | AT91_PMC_PCR_GCKEN,
+			   field_prep(gck->layout->gckcss_mask, gck->parent_id) |
+			   gck->layout->cmd |
+			   FIELD_PREP(AT91_PMC_PCR_GCKDIV_MASK, gck->gckdiv) |
 			   AT91_PMC_PCR_GCKEN);
 	spin_unlock_irqrestore(gck->lock, flags);
 	return 0;
@@ -66,11 +68,11 @@ static void clk_generated_disable(struct clk_hw *hw)
 	unsigned long flags;
 
 	spin_lock_irqsave(gck->lock, flags);
-	regmap_write(gck->regmap, AT91_PMC_PCR,
-		     (gck->id & AT91_PMC_PCR_PID_MASK));
-	regmap_update_bits(gck->regmap, AT91_PMC_PCR,
-			   AT91_PMC_PCR_CMD | AT91_PMC_PCR_GCKEN,
-			   AT91_PMC_PCR_CMD);
+	regmap_write(gck->regmap, gck->layout->offset,
+		     (gck->id & gck->layout->pid_mask));
+	regmap_update_bits(gck->regmap, gck->layout->offset,
+			   gck->layout->cmd | AT91_PMC_PCR_GCKEN,
+			   gck->layout->cmd);
 	spin_unlock_irqrestore(gck->lock, flags);
 }
 
@@ -81,9 +83,9 @@ static int clk_generated_is_enabled(struct clk_hw *hw)
 	unsigned int status;
 
 	spin_lock_irqsave(gck->lock, flags);
-	regmap_write(gck->regmap, AT91_PMC_PCR,
-		     (gck->id & AT91_PMC_PCR_PID_MASK));
-	regmap_read(gck->regmap, AT91_PMC_PCR, &status);
+	regmap_write(gck->regmap, gck->layout->offset,
+		     (gck->id & gck->layout->pid_mask));
+	regmap_read(gck->regmap, gck->layout->offset, &status);
 	spin_unlock_irqrestore(gck->lock, flags);
 
 	return status & AT91_PMC_PCR_GCKEN ? 1 : 0;
@@ -259,19 +261,18 @@ static void clk_generated_startup(struct clk_generated *gck)
 	unsigned long flags;
 
 	spin_lock_irqsave(gck->lock, flags);
-	regmap_write(gck->regmap, AT91_PMC_PCR,
-		     (gck->id & AT91_PMC_PCR_PID_MASK));
-	regmap_read(gck->regmap, AT91_PMC_PCR, &tmp);
+	regmap_write(gck->regmap, gck->layout->offset,
+		     (gck->id & gck->layout->pid_mask));
+	regmap_read(gck->regmap, gck->layout->offset, &tmp);
 	spin_unlock_irqrestore(gck->lock, flags);
 
-	gck->parent_id = (tmp & AT91_PMC_PCR_GCKCSS_MASK)
-					>> AT91_PMC_PCR_GCKCSS_OFFSET;
-	gck->gckdiv = (tmp & AT91_PMC_PCR_GCKDIV_MASK)
-					>> AT91_PMC_PCR_GCKDIV_OFFSET;
+	gck->parent_id = field_get(gck->layout->gckcss_mask, tmp);
+	gck->gckdiv = FIELD_GET(AT91_PMC_PCR_GCKDIV_MASK, tmp);
 }
 
 struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
+			    const struct clk_pcr_layout *layout,
 			    const char *name, const char **parent_names,
 			    u8 num_parents, u8 id, bool pll_audio,
 			    const struct clk_range *range)
@@ -298,6 +299,7 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	gck->lock = lock;
 	gck->range = *range;
 	gck->audio_pll_allowed = pll_audio;
+	gck->layout = layout;
 
 	clk_generated_startup(gck);
 	hw = &gck->hw;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index aa09072f36db..aa1754eac59f 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -154,7 +154,8 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		     id == GCK_ID_CLASSD))
 			pll_audio = true;
 
-		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
+		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
+						 &dt_pcr_layout, name,
 						 parent_names, num_parents,
 						 id, pll_audio, &range);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 616c04588093..4027306b904c 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -116,6 +116,7 @@ at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
+			    const struct clk_pcr_layout *layout,
 			    const char *name, const char **parent_names,
 			    u8 num_parents, u8 id, bool pll_audio,
 			    const struct clk_range *range);
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index f3f1ce2013d4..8f301a517b9d 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -304,6 +304,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	parent_names[5] = "audiopll_pmcck";
 	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
+						 &sama5d2_pcr_layout,
 						 sama5d2_gck[i].n,
 						 parent_names, 6,
 						 sama5d2_gck[i].id,
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index b97b8dcbffe6..31f00ebf1315 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -187,13 +187,8 @@
 
 #define AT91_PMC_PCR		0x10c			/* Peripheral Control Register [some SAM9 and SAMA5] */
 #define		AT91_PMC_PCR_PID_MASK		0x3f
-#define		AT91_PMC_PCR_GCKCSS_OFFSET	8
-#define		AT91_PMC_PCR_GCKCSS_MASK	(0x7  << AT91_PMC_PCR_GCKCSS_OFFSET)
-#define		AT91_PMC_PCR_GCKCSS(n)		((n)  << AT91_PMC_PCR_GCKCSS_OFFSET)	/* GCK Clock Source Selection */
 #define		AT91_PMC_PCR_CMD		(0x1  <<  12)				/* Command (read=0, write=1) */
-#define		AT91_PMC_PCR_GCKDIV_OFFSET	20
-#define		AT91_PMC_PCR_GCKDIV_MASK	(0xff  << AT91_PMC_PCR_GCKDIV_OFFSET)
-#define		AT91_PMC_PCR_GCKDIV(n)		((n)  << AT91_PMC_PCR_GCKDIV_OFFSET)	/* Generated Clock Divisor Value */
+#define		AT91_PMC_PCR_GCKDIV_MASK	GENMASK(27, 20)
 #define		AT91_PMC_PCR_EN			(0x1  <<  28)				/* Enable */
 #define		AT91_PMC_PCR_GCKEN		(0x1  <<  29)				/* GCK Enable */
 
-- 
2.20.1

