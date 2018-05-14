Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeENIHY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:07:24 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36047 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeENIHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:06 -0400
X-Google-Smtp-Source: AB8JxZqyYB5yPoYZH/PDKhiOR0h783OtdKXYr1FFkyNCIlZVKtAw9bgktmB+Qn+c+A8IGmhr6qcvRg==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 08/19 v3] regulator: max8952: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:29 +0200
Message-Id: <20180514080640.12515-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number for the enable GPIO, pass
a descriptor looked up with the standard devm_gpiod_get_optional()
call.

All users of this regulator use device tree so the transition is
pretty smooth.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
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
