Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E361FC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9D82175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBGQ3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:29:20 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39143 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBGQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:29:19 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BD5091BF208;
        Thu,  7 Feb 2019 16:29:15 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 5/5] gpio: pca953x: add ->set_config implementation
Date:   Thu,  7 Feb 2019 17:28:59 +0100
Message-Id: <20190207162859.26252-6-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a minimal implementation of the ->set_config() hook,
with support for the PIN_CONFIG_BIAS_PULL_UP and
PIN_CONFIG_BIAS_PULL_DOWN configurations.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/gpio/gpio-pca953x.c | 66 +++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 83d45f00e4d0..1e5579acd275 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -179,6 +179,8 @@ static int pca953x_bank_shift(struct pca953x_chip *chip)
 #define PCA957x_BANK_OUTPUT	BIT(5)
 
 #define PCAL9xxx_BANK_IN_LATCH	BIT(8 + 2)
+#define PCAL9xxx_BANK_PULL_EN	BIT(8 + 3)
+#define PCAL9xxx_BANK_PULL_SEL	BIT(8 + 4)
 #define PCAL9xxx_BANK_IRQ_MASK	BIT(8 + 5)
 #define PCAL9xxx_BANK_IRQ_STAT	BIT(8 + 6)
 
@@ -200,6 +202,8 @@ static int pca953x_bank_shift(struct pca953x_chip *chip)
  * - Extended set, above 0x40, often chip specific.
  *   - PCAL6524/PCAL9555A with custom PCAL IRQ handling:
  *     Input latch register		0x40 + 2 * bank_size	RW
+ *     Pull-up/pull-down enable reg	0x40 + 3 * bank_size    RW
+ *     Pull-up/pull-down select reg	0x40 + 4 * bank_size    RW
  *     Interrupt mask register		0x40 + 5 * bank_size	RW
  *     Interrupt status register	0x40 + 6 * bank_size	R
  *
@@ -248,7 +252,8 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 	}
 
 	if (chip->driver_data & PCA_PCAL) {
-		bank |= PCAL9xxx_BANK_IN_LATCH | PCAL9xxx_BANK_IRQ_MASK |
+		bank |= PCAL9xxx_BANK_IN_LATCH | PCAL9xxx_BANK_PULL_EN |
+			PCAL9xxx_BANK_PULL_SEL | PCAL9xxx_BANK_IRQ_MASK |
 			PCAL9xxx_BANK_IRQ_STAT;
 	}
 
@@ -269,7 +274,8 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
 	}
 
 	if (chip->driver_data & PCA_PCAL)
-		bank |= PCAL9xxx_BANK_IN_LATCH | PCAL9xxx_BANK_IRQ_MASK;
+		bank |= PCAL9xxx_BANK_IN_LATCH | PCAL9xxx_BANK_PULL_EN |
+			PCAL9xxx_BANK_PULL_SEL | PCAL9xxx_BANK_IRQ_MASK;
 
 	return pca953x_check_register(chip, reg, bank);
 }
@@ -474,6 +480,61 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 	mutex_unlock(&chip->i2c_lock);
 }
 
+static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
+					 unsigned int offset,
+					 unsigned long config)
+{
+	u8 pull_en_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_EN, offset,
+					     true, false);
+	u8 pull_sel_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_SEL, offset,
+					      true, false);
+	u8 bit = BIT(offset % BANK_SZ);
+	int ret;
+
+	/*
+	 * pull-up/pull-down configuration requires PCAL extended
+	 * registers
+	 */
+	if (!(chip->driver_data & PCA_PCAL))
+		return -ENOTSUPP;
+
+	mutex_lock(&chip->i2c_lock);
+
+	/* Disable pull-up/pull-down */
+	ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
+	if (ret)
+		goto exit;
+
+	/* Configure pull-up/pull-down */
+	if (config == PIN_CONFIG_BIAS_PULL_UP)
+		ret = regmap_write_bits(chip->regmap, pull_sel_reg, bit, bit);
+	else if (config == PIN_CONFIG_BIAS_PULL_DOWN)
+		ret = regmap_write_bits(chip->regmap, pull_sel_reg, bit, 0);
+	if (ret)
+		goto exit;
+
+	/* Enable pull-up/pull-down */
+	ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
+
+exit:
+	mutex_unlock(&chip->i2c_lock);
+	return ret;
+}
+
+static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
+				   unsigned long config)
+{
+	struct pca953x_chip *chip = gpiochip_get_data(gc);
+
+	switch (config) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return pca953x_gpio_set_pull_up_down(chip, offset, config);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
 static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
 	struct gpio_chip *gc;
@@ -486,6 +547,7 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 	gc->set = pca953x_gpio_set_value;
 	gc->get_direction = pca953x_gpio_get_direction;
 	gc->set_multiple = pca953x_gpio_set_multiple;
+	gc->set_config = pca953x_gpio_set_config;
 	gc->can_sleep = true;
 
 	gc->base = chip->gpio_start;
-- 
2.20.1

