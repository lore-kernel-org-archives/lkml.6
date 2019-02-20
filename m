Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC42086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBTLsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:48:14 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47588 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfBTLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:48:12 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A803F3A5085;
        Wed, 20 Feb 2019 11:26:25 +0000 (UTC)
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C143F200007;
        Wed, 20 Feb 2019 11:26:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/7] clk: at91: master: Add sam9x60 support
Date:   Wed, 20 Feb 2019 12:26:02 +0100
Message-Id: <20190220112605.23095-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sam9x60 cpu clock is located at a different offset but is otherwise
similar to the master clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-master.c | 8 +++++---
 drivers/clk/at91/pmc.h        | 1 +
 include/linux/clk/at91_pmc.h  | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index eb53b4a8fab6..12b5bf4cc7bb 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -29,6 +29,7 @@ struct clk_master {
 	struct regmap *regmap;
 	const struct clk_master_layout *layout;
 	const struct clk_master_characteristics *characteristics;
+	u32 mckr;
 };
 
 static inline bool clk_master_ready(struct regmap *regmap)
@@ -69,7 +70,7 @@ static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
 						master->characteristics;
 	unsigned int mckr;
 
-	regmap_read(master->regmap, AT91_PMC_MCKR, &mckr);
+	regmap_read(master->regmap, master->layout->offset, &mckr);
 	mckr &= layout->mask;
 
 	pres = (mckr >> layout->pres_shift) & MASTER_PRES_MASK;
@@ -95,7 +96,7 @@ static u8 clk_master_get_parent(struct clk_hw *hw)
 	struct clk_master *master = to_clk_master(hw);
 	unsigned int mckr;
 
-	regmap_read(master->regmap, AT91_PMC_MCKR, &mckr);
+	regmap_read(master->regmap, master->layout->offset, &mckr);
 
 	return mckr & AT91_PMC_CSS;
 }
@@ -147,13 +148,14 @@ at91_clk_register_master(struct regmap *regmap,
 	return hw;
 }
 
-
 const struct clk_master_layout at91rm9200_master_layout = {
 	.mask = 0x31F,
 	.pres_shift = 2,
+	.offset = AT91_PMC_MCKR,
 };
 
 const struct clk_master_layout at91sam9x5_master_layout = {
 	.mask = 0x373,
 	.pres_shift = 4,
+	.offset = AT91_PMC_MCKR,
 };
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 44345e4ab1c9..4a30c20f17f1 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -38,6 +38,7 @@ struct clk_range {
 #define CLK_RANGE(MIN, MAX) {.min = MIN, .max = MAX,}
 
 struct clk_master_layout {
+	u32 offset;
 	u32 mask;
 	u8 pres_shift;
 };
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 31f00ebf1315..0c53f26ae3d3 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -74,6 +74,8 @@
 #define			AT91_PMC_USBDIV_4		(2 << 28)
 #define		AT91_PMC_USB96M		(1     << 28)		/* Divider by 2 Enable (PLLB only) */
 
+#define AT91_PMC_CPU_CKR	0x28			/* CPU Clock Register */
+
 #define	AT91_PMC_MCKR		0x30			/* Master Clock Register */
 #define		AT91_PMC_CSS		(3 <<  0)		/* Master Clock Selection */
 #define			AT91_PMC_CSS_SLOW		(0 << 0)
-- 
2.20.1

