Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeE3Odg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:33:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeE3Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:33:30 -0400
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77686: Fix shared GPIOs" to the regulator tree
In-Reply-To: 
Message-Id: <E1fO2AJ-0004Xw-H3@debutante>
Date: Wed, 30 May 2018 15:33:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77686: Fix shared GPIOs

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d1dae72fab2c377ff463742eefd8ac0f9e99b7b9 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 May 2018 15:13:42 +0100
Subject: [PATCH] regulator: max77686: Fix shared GPIOs

This reverts commit c89c00e2b8f0 "regulator: max77686: Pass descriptor
instead of GPIO number" as it has problems with shared GPIOs similar to
that on s2mps11.

Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77686-regulator.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index 37f98a8350f0..c301f3733475 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -25,7 +25,8 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -89,7 +90,6 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
-	struct device *dev;
 	DECLARE_BITMAP(gpio_enabled, MAX77686_REGULATORS);
 
 	/* Array indexed by regulator id */
@@ -269,20 +269,16 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
-								np,
-								"maxim,ena",
-								0,
-								GPIOD_OUT_HIGH,
-								"max77686-regulator");
-		if (IS_ERR(config->ena_gpiod))
-			config->ena_gpiod = NULL;
+		config->ena_gpio = of_get_named_gpio(np,
+					"maxim,ena-gpios", 0);
+		config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
+		config->ena_gpio_initialized = true;
 		break;
 	default:
 		return 0;
 	}
 
-	if (config->ena_gpiod) {
+	if (gpio_is_valid(config->ena_gpio)) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
 		return regmap_update_bits(config->regmap, desc->enable_reg,
@@ -525,7 +521,6 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	if (!max77686)
 		return -ENOMEM;
 
-	max77686->dev = &pdev->dev;
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77686;
-- 
2.17.0
