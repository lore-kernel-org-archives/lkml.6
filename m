Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935229AbeBLNRi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:17:38 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42458 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935210AbeBLNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:17:31 -0500
X-Google-Smtp-Source: AH8x224M5HXasnN1XbGu+oodEdDqgKUhQYfNZ4vtHr7/cqSnvSsmpVKQJJr4ahouEly6IczvNy2LIA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/21] regulator: core: Support passing an initialized GPIO enable descriptor
Date: Mon, 12 Feb 2018 14:16:57 +0100
Message-Id: <20180212131717.27193-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212131717.27193-1-linus.walleij@linaro.org>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently passing a GPIO number from the global GPIO numberspace
into the regulator core for handling enable GPIOs. This is not good
since it ties into the global GPIO numberspace and uses gpio_to_desc()
to overcome this.

Start supporting passing an already initialized GPIO descriptor to the
core instead: leaf drivers pick their descriptors, associated directly
with the device node (or from ACPI or from a board descriptor table)
and use that directly without any roundtrip over the global GPIO
numberspace.

This looks messy since it adds a bunch of extra code in the core, but
at the end of the patch series we will delete the handling of the GPIO
number and only deal with descriptors so things end up neat.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/core.c         | 25 ++++++++++++++++---------
 include/linux/regulator/driver.h |  3 +++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd4708c58480..4549b93b0ff9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1937,7 +1937,10 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 	struct gpio_desc *gpiod;
 	int ret;
 
-	gpiod = gpio_to_desc(config->ena_gpio);
+	if (config->ena_gpiod)
+		gpiod = config->ena_gpiod;
+	else
+		gpiod = gpio_to_desc(config->ena_gpio);
 
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
 		if (pin->gpiod == gpiod) {
@@ -1947,15 +1950,18 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		}
 	}
 
-	ret = gpio_request_one(config->ena_gpio,
-				GPIOF_DIR_OUT | config->ena_gpio_flags,
-				rdev_get_name(rdev));
-	if (ret)
-		return ret;
+	if (!config->ena_gpiod) {
+		ret = gpio_request_one(config->ena_gpio,
+				       GPIOF_DIR_OUT | config->ena_gpio_flags,
+				       rdev_get_name(rdev));
+		if (ret)
+			return ret;
+	}
 
 	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
 	if (pin == NULL) {
-		gpio_free(config->ena_gpio);
+		if (!config->ena_gpiod)
+			gpio_free(config->ena_gpio);
 		return -ENOMEM;
 	}
 
@@ -4154,8 +4160,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 			goto clean;
 	}
 
-	if ((config->ena_gpio || config->ena_gpio_initialized) &&
-	    gpio_is_valid(config->ena_gpio)) {
+	if (config->ena_gpiod ||
+	    ((config->ena_gpio || config->ena_gpio_initialized) &&
+	     gpio_is_valid(config->ena_gpio))) {
 		mutex_lock(&regulator_list_mutex);
 		ret = regulator_ena_gpio_request(rdev, config);
 		mutex_unlock(&regulator_list_mutex);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4c00486b7a78..4fc96cb8e5d7 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -19,6 +19,7 @@
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
 
+struct gpio_desc;
 struct regmap;
 struct regulator_dev;
 struct regulator_config;
@@ -387,6 +388,7 @@ struct regulator_desc {
  *                        initialized, meaning that >= 0 is a valid gpio
  *                        identifier and < 0 is a non existent gpio.
  * @ena_gpio: GPIO controlling regulator enable.
+ * @ena_gpiod: GPIO descriptor controlling regulator enable.
  * @ena_gpio_invert: Sense for GPIO enable control.
  * @ena_gpio_flags: Flags to use when calling gpio_request_one()
  */
@@ -399,6 +401,7 @@ struct regulator_config {
 
 	bool ena_gpio_initialized;
 	int ena_gpio;
+	struct gpio_desc *ena_gpiod;
 	unsigned int ena_gpio_invert:1;
 	unsigned int ena_gpio_flags;
 };
-- 
2.14.3
