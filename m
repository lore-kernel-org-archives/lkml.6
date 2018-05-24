Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968489AbeEXTOW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:14:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56172 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967742AbeEXTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:14:13 -0400
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: max8952: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: <20180212131717.27193-12-linus.walleij@linaro.org>
Message-Id: <E1fLvgf-0005bO-56@debutante>
Date: Thu, 24 May 2018 20:14:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8952: Pass descriptor instead of GPIO number

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

>From d7a261c2d1f233260c48651b4e68987ce1206139 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 10:06:29 +0200
Subject: [PATCH] regulator: max8952: Pass descriptor instead of GPIO number

Instead of passing a global GPIO number for the enable GPIO, pass
a descriptor looked up with the standard devm_gpiod_get_optional()
call.

All users of this regulator use device tree so the transition is
pretty smooth.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8952.c       | 18 +++++++++++++-----
 include/linux/regulator/max8952.h |  1 -
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 1096546c05e9..f1e77ed5dfec 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -27,6 +27,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/max8952.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
@@ -148,7 +149,6 @@ static struct max8952_platform_data *max8952_parse_dt(struct device *dev)
 
 	pd->gpio_vid0 = of_get_named_gpio(np, "max8952,vid-gpios", 0);
 	pd->gpio_vid1 = of_get_named_gpio(np, "max8952,vid-gpios", 1);
-	pd->gpio_en = of_get_named_gpio(np, "max8952,en-gpio", 0);
 
 	if (of_property_read_u32(np, "max8952,default-mode", &pd->default_mode))
 		dev_warn(dev, "Default mode not specified, assuming 0\n");
@@ -197,6 +197,8 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	struct regulator_config config = { };
 	struct max8952_data *max8952;
 	struct regulator_dev *rdev;
+	struct gpio_desc *gpiod;
+	enum gpiod_flags gflags;
 
 	int ret = 0, err = 0;
 
@@ -224,11 +226,17 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	config.driver_data = max8952;
 	config.of_node = client->dev.of_node;
 
-	config.ena_gpio = pdata->gpio_en;
-	if (client->dev.of_node)
-		config.ena_gpio_initialized = true;
 	if (pdata->reg_data->constraints.boot_on)
-		config.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+		gflags = GPIOD_OUT_HIGH;
+	else
+		gflags = GPIOD_OUT_LOW;
+	gpiod = devm_gpiod_get_optional(&client->dev,
+					"max8952,en",
+					gflags);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+	if (gpiod)
+		config.ena_gpiod = gpiod;
 
 	rdev = devm_regulator_register(&client->dev, &regulator, &config);
 	if (IS_ERR(rdev)) {
diff --git a/include/linux/regulator/max8952.h b/include/linux/regulator/max8952.h
index 4dbb63a1d4ab..686c42c041b5 100644
--- a/include/linux/regulator/max8952.h
+++ b/include/linux/regulator/max8952.h
@@ -120,7 +120,6 @@ enum {
 struct max8952_platform_data {
 	int gpio_vid0;
 	int gpio_vid1;
-	int gpio_en;
 
 	u32 default_mode;
 	u32 dvs_mode[MAX8952_NUM_DVS_MODE]; /* MAX8952_DVS_MODEx_XXXXmV */
-- 
2.17.0
