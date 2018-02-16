Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161807AbeBPRMm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:12:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161754AbeBPRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:12:26 -0500
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Support passing an initialized GPIO enable descriptor" to the regulator tree
In-Reply-To: <20180212131717.27193-2-linus.walleij@linaro.org>
Message-Id: <E1emjYe-00085Z-7c@debutante>
Date: Fri, 16 Feb 2018 17:12:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Support passing an initialized GPIO enable descriptor

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

>From e45e290a882e2c0dc8ebb7dd21c66a8209d8e3a5 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Feb 2018 14:16:57 +0100
Subject: [PATCH] regulator: core: Support passing an initialized GPIO enable
 descriptor

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.1
