Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E24C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E782223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErkZv0Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E782223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeKOSIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:08:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42617 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:08:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so9856957lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izSJwDOoJ3L6HTUkifpUePhxXhaoXbjxzOD3sLoJ6W0=;
        b=ErkZv0EijwJK///fVYaUxEP9AoVIgf3fcwZqKCa41oSNU8hLv5qa/7wfYjdHv6kFpd
         Uvf2VrRobeVts/pueE3SCz3VyxOmKlrds2T56FQf2gI8ymQY/CwrPV/NbKpwS659cv/c
         Hptxir2aw76r7t9H6UT1I2bPdwxCfIqGM5euk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izSJwDOoJ3L6HTUkifpUePhxXhaoXbjxzOD3sLoJ6W0=;
        b=Kon3P7NsoyPngHQjuSmCVRTYfbgEs21cCevimWrmCwuqjA7PMuFAzB2O/B7SrEZTZB
         RN0+46bJ9zkKtOQlwTD4K1Cv5DqmKPRFDxpAB//IexHJmWZu3Sp3LEJ3ycw6IqMCmwHH
         uz1O++ZwvhspdQVDU+qArkjQIbVMFMBdHNufl7MSDtVM79YdlRuZUTJyLmalGvFJ+BbW
         IYCftloDb7fi1aYiLJhBzO+eXTZxnnGLAEEyVvflRvdHqdZh0dqWS0Hg3MaZxKqc6Mun
         kGS4PY97+ML0go9kXojymh9gHxk744rawm7a2wGGNAH+/RwT5a27U/QTcA5/vRT3XEPk
         pwtQ==
X-Gm-Message-State: AGRZ1gIKevNf3NP9XqFuEtwM3YJkFDRDPR07BZrL+ny1rbA5S5SZP49w
        E454H4fKnv38n7En00+AcgHFsw==
X-Google-Smtp-Source: AJdET5ckSAM6U/GKrDjF/OQpjwKEmG6zorcwkGrKG4fwOKBjLZOhriHpuyBZl6iLtMlZWIa9QW998w==
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr2725954lfe.4.1542268891912;
        Thu, 15 Nov 2018 00:01:31 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o25sm4003427lfd.29.2018.11.15.00.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:01:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/8 v6] regulator: s2mps11: Pass descriptor instead of GPIO number
Date:   Thu, 15 Nov 2018 09:01:17 +0100
Message-Id: <20181115080124.7789-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181115080124.7789-1-linus.walleij@linaro.org>
References: <20181115080124.7789-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
ChangeLog v5->v6:
- Tag on the nonexclusive bit as regulators can share a
  GPIO line.
ChangeLog v4->v5:
- Fold in a kzalloc() fix from Bartlomiej Zolnierkiewicz
ChangeLog v3->v4:
- Changed regulator name to "s2mps11-regulator"
- Collected Krzysztof's review and test tags.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
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
2.17.2

