Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B6A21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="n9F9aySa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B6A21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbeKPF4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:56:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKPF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fkSlF70mk5fRSD9CTzIjKxlQva6cknf1ctrCOgORPds=; b=n9F9aySaJqw8
        o/N6s94ZoHzNH/qZuyOz779McFz1kKTe0ch1Rt/3cbQJpeIwC/5VBsnXJtHaVaSyrvF3PeDz/B6Pj
        V7EPkkyTY0Iraxsdvkf3EastTmWOLqS3HwremJ4GjuGgxu0TZHOpSXJdmt7hBRYoU3/KguDM2uCBt
        m/RHE=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNbY-0006Fi-SP; Thu, 15 Nov 2018 19:47:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 114BF44007C; Thu, 15 Nov 2018 19:47:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s2mps11: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: 
Message-Id: <20181115194707.114BF44007C@finisterre.ee.mobilebroadband>
Date:   Thu, 15 Nov 2018 19:47:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Pass descriptor instead of GPIO number

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

From 1c984942f0a480ed41635528234b8bc672f6bac7 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 Nov 2018 09:01:17 +0100
Subject: [PATCH] regulator: s2mps11: Pass descriptor instead of GPIO number

Instead of passing a global GPIO number for the enable GPIO, pass
a descriptor looked up with the standard devm_gpiod_get_optional()
call.

This regulator supports passing platform data, but enable/sleep
regulators are looked up from the device tree exclusively, so
we can need not touch other files.

Tested on Odroid XU3 (with s2mps11 although not using any GPIOs
for regulators, so at least default paths are not broken).

Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 5bb6f4ca48db..6fec45897194 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -5,7 +5,7 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -14,7 +14,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/of_gpio.h>
 #include <linux/mfd/samsung/core.h>
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps13.h>
@@ -44,7 +43,7 @@ struct s2mps11_info {
 	 * Array (size: number of regulators) with GPIO-s for external
 	 * sleep control.
 	 */
-	int *ext_control_gpio;
+	struct gpio_desc **ext_control_gpiod;
 };
 
 static int get_ramp_delay(int ramp_delay)
@@ -511,7 +510,7 @@ static int s2mps14_regulator_enable(struct regulator_dev *rdev)
 	case S2MPS14X:
 		if (test_bit(rdev_get_id(rdev), s2mps11->suspend_state))
 			val = S2MPS14_ENABLE_SUSPEND;
-		else if (gpio_is_valid(s2mps11->ext_control_gpio[rdev_get_id(rdev)]))
+		else if (s2mps11->ext_control_gpiod[rdev_get_id(rdev)])
 			val = S2MPS14_ENABLE_EXT_CONTROL;
 		else
 			val = rdev->desc->enable_mask;
@@ -805,7 +804,7 @@ static int s2mps14_pmic_enable_ext_control(struct s2mps11_info *s2mps11,
 static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
 		struct of_regulator_match *rdata, struct s2mps11_info *s2mps11)
 {
-	int *gpio = s2mps11->ext_control_gpio;
+	struct gpio_desc **gpio = s2mps11->ext_control_gpiod;
 	unsigned int i;
 	unsigned int valid_regulators[3] = { S2MPS14_LDO10, S2MPS14_LDO11,
 		S2MPS14_LDO12 };
@@ -816,11 +815,20 @@ static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
 		if (!rdata[reg].init_data || !rdata[reg].of_node)
 			continue;
 
-		gpio[reg] = of_get_named_gpio(rdata[reg].of_node,
-				"samsung,ext-control-gpios", 0);
-		if (gpio_is_valid(gpio[reg]))
-			dev_dbg(&pdev->dev, "Using GPIO %d for ext-control over %d/%s\n",
-					gpio[reg], reg, rdata[reg].name);
+		gpio[reg] = devm_gpiod_get_from_of_node(&pdev->dev,
+				rdata[reg].of_node,
+				"samsung,ext-control-gpios",
+				0,
+				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+				"s2mps11-regulator");
+		if (IS_ERR(gpio[reg])) {
+			dev_err(&pdev->dev, "Failed to get control GPIO for %d/%s\n",
+				reg, rdata[reg].name);
+			continue;
+		}
+		if (gpio[reg])
+			dev_dbg(&pdev->dev, "Using GPIO for ext-control over %d/%s\n",
+				reg, rdata[reg].name);
 	}
 }
 
@@ -1126,17 +1134,11 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s2mps11->ext_control_gpio = devm_kmalloc_array(&pdev->dev,
-			rdev_num, sizeof(*s2mps11->ext_control_gpio),
+	s2mps11->ext_control_gpiod = devm_kmalloc_array(&pdev->dev,
+			rdev_num, sizeof(*s2mps11->ext_control_gpiod),
 			GFP_KERNEL);
-	if (!s2mps11->ext_control_gpio)
+	if (!s2mps11->ext_control_gpiod)
 		return -ENOMEM;
-	/*
-	 * 0 is a valid GPIO so initialize all GPIO-s to negative value
-	 * to indicate that external control won't be used for this regulator.
-	 */
-	for (i = 0; i < rdev_num; i++)
-		s2mps11->ext_control_gpio[i] = -EINVAL;
 
 	if (!iodev->dev->of_node) {
 		if (iodev->pdata) {
@@ -1166,8 +1168,6 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.regmap = iodev->regmap_pmic;
 	config.driver_data = s2mps11;
-	config.ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
-	config.ena_gpio_initialized = true;
 	for (i = 0; i < rdev_num; i++) {
 		struct regulator_dev *regulator;
 
@@ -1178,7 +1178,7 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			config.init_data = rdata[i].init_data;
 			config.of_node = rdata[i].of_node;
 		}
-		config.ena_gpio = s2mps11->ext_control_gpio[i];
+		config.ena_gpiod = s2mps11->ext_control_gpiod[i];
 
 		regulator = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
@@ -1189,7 +1189,7 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (gpio_is_valid(s2mps11->ext_control_gpio[i])) {
+		if (s2mps11->ext_control_gpiod[i]) {
 			ret = s2mps14_pmic_enable_ext_control(s2mps11,
 					regulator);
 			if (ret < 0) {
-- 
2.19.1

