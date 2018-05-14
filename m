Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeENIKE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:10:04 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32830 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeENIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:20 -0400
X-Google-Smtp-Source: AB8JxZoGzgurVAjNs1Y47qc7W/RY/+hNVXjnxCHMhX9Xnjy3+ZG2UR2YEqL3MUeFahZAFjKFVx+C6A==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 14/19 v3] regulator: core: Only support passing enable GPIO descriptors
Date: Mon, 14 May 2018 10:06:35 +0200
Message-Id: <20180514080640.12515-15-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we changed all providers to pass descriptors into the core
for enable GPIOs instead of a global GPIO number, delete the support
for passing GPIO numbers in, and we get a cleanup and size reduction
in the core, and from a GPIO point of view we use the modern, cleaner
interface.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/core.c         | 32 ++++++--------------------------
 include/linux/regulator/driver.h | 10 +---------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d4803460a557..8d56f9b906b0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -23,7 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
@@ -1935,35 +1934,19 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 {
 	struct regulator_enable_gpio *pin;
 	struct gpio_desc *gpiod;
-	int ret;
 
-	if (config->ena_gpiod)
-		gpiod = config->ena_gpiod;
-	else
-		gpiod = gpio_to_desc(config->ena_gpio);
+	gpiod = config->ena_gpiod;
 
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
 		if (pin->gpiod == gpiod) {
-			rdev_dbg(rdev, "GPIO %d is already used\n",
-				config->ena_gpio);
+			rdev_dbg(rdev, "GPIO is already used\n");
 			goto update_ena_gpio_to_rdev;
 		}
 	}
 
-	if (!config->ena_gpiod) {
-		ret = gpio_request_one(config->ena_gpio,
-				       GPIOF_DIR_OUT | config->ena_gpio_flags,
-				       rdev_get_name(rdev));
-		if (ret)
-			return ret;
-	}
-
 	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
-	if (pin == NULL) {
-		if (!config->ena_gpiod)
-			gpio_free(config->ena_gpio);
+	if (pin == NULL)
 		return -ENOMEM;
-	}
 
 	pin->gpiod = gpiod;
 	pin->ena_gpio_invert = config->ena_gpio_invert;
@@ -1987,7 +1970,6 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
@@ -4160,15 +4142,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 			goto clean;
 	}
 
-	if (config->ena_gpiod ||
-	    ((config->ena_gpio || config->ena_gpio_initialized) &&
-	     gpio_is_valid(config->ena_gpio))) {
+	if (config->ena_gpiod) {
 		mutex_lock(&regulator_list_mutex);
 		ret = regulator_ena_gpio_request(rdev, config);
 		mutex_unlock(&regulator_list_mutex);
 		if (ret != 0) {
-			rdev_err(rdev, "Failed to request enable GPIO%d: %d\n",
-				 config->ena_gpio, ret);
+			rdev_err(rdev, "Failed to request enable GPIO: %d\n",
+				 ret);
 			goto clean;
 		}
 	}
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4fc96cb8e5d7..8900c230c899 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -384,13 +384,8 @@ struct regulator_desc {
  *           NULL).
  * @regmap: regmap to use for core regmap helpers if dev_get_regmap() is
  *          insufficient.
- * @ena_gpio_initialized: GPIO controlling regulator enable was properly
- *                        initialized, meaning that >= 0 is a valid gpio
- *                        identifier and < 0 is a non existent gpio.
- * @ena_gpio: GPIO controlling regulator enable.
- * @ena_gpiod: GPIO descriptor controlling regulator enable.
+ * @ena_gpiod: GPIO controlling regulator enable.
  * @ena_gpio_invert: Sense for GPIO enable control.
- * @ena_gpio_flags: Flags to use when calling gpio_request_one()
  */
 struct regulator_config {
 	struct device *dev;
@@ -399,11 +394,8 @@ struct regulator_config {
 	struct device_node *of_node;
 	struct regmap *regmap;
 
-	bool ena_gpio_initialized;
-	int ena_gpio;
 	struct gpio_desc *ena_gpiod;
 	unsigned int ena_gpio_invert:1;
-	unsigned int ena_gpio_flags;
 };
 
 /*
-- 
2.17.0
