Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419A206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBTL0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:26:25 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57629 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfBTL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:26:23 -0500
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4FB70240009;
        Wed, 20 Feb 2019 11:26:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/7] clk: at91: usb: Add sam9x60 support
Date:   Wed, 20 Feb 2019 12:26:01 +0100
Message-Id: <20190220112605.23095-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sam9x60 USB clock supports four different parents, ensure they can be
selected.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-usb.c | 33 +++++++++++++++++++++++++++------
 drivers/clk/at91/pmc.h     |  3 +++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 79ee1c760f2a..ebc37ee33518 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -23,9 +23,13 @@
 #define RM9200_USB_DIV_SHIFT	28
 #define RM9200_USB_DIV_TAB_SIZE	4
 
+#define SAM9X5_USBS_MASK	GENMASK(0, 0)
+#define SAM9X60_USBS_MASK	GENMASK(1, 0)
+
 struct at91sam9x5_clk_usb {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	u32 usbs_mask;
 };
 
 #define to_at91sam9x5_clk_usb(hw) \
@@ -111,8 +115,7 @@ static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
 	if (index > 1)
 		return -EINVAL;
 
-	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_USBS,
-			   index ? AT91_PMC_USBS : 0);
+	regmap_update_bits(usb->regmap, AT91_PMC_USB, usb->usbs_mask, index);
 
 	return 0;
 }
@@ -124,7 +127,7 @@ static u8 at91sam9x5_clk_usb_get_parent(struct clk_hw *hw)
 
 	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
 
-	return usbr & AT91_PMC_USBS;
+	return usbr & usb->usbs_mask;
 }
 
 static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -190,9 +193,10 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 	.set_rate = at91sam9x5_clk_usb_set_rate,
 };
 
-struct clk_hw * __init
-at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents)
+static struct clk_hw * __init
+_at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
+			     const char **parent_names, u8 num_parents,
+			     u32 usbs_mask)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
@@ -212,6 +216,7 @@ at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 	usb->hw.init = &init;
 	usb->regmap = regmap;
+	usb->usbs_mask = SAM9X5_USBS_MASK;
 
 	hw = &usb->hw;
 	ret = clk_hw_register(NULL, &usb->hw);
@@ -223,6 +228,22 @@ at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 	return hw;
 }
 
+struct clk_hw * __init
+at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
+			    const char **parent_names, u8 num_parents)
+{
+	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					    num_parents, SAM9X5_USBS_MASK);
+}
+
+struct clk_hw * __init
+sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
+			 const char **parent_names, u8 num_parents)
+{
+	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					    num_parents, SAM9X60_USBS_MASK);
+}
+
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name)
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4027306b904c..44345e4ab1c9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -194,6 +194,9 @@ struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name);
 struct clk_hw * __init
+sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
+			 const char **parent_names, u8 num_parents);
+struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char *parent_name, const u32 *divisors);
 
-- 
2.20.1

