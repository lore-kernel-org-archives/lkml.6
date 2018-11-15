Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D530CC07208
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7122089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrTDnXkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7122089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeKOSIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:08:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33751 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeKOSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:08:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so16481827ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rq0isa9+uSFoYNz3NVzNiJqxPB2qDMbMU7T3rW8B1rk=;
        b=OrTDnXkAu6QGSbuDE3qVQIWSTXmbDS0mBFHBnk27vANuDuPV+yYun06I8r4ZUGj639
         yMi4BAycWNEZiFzEqbewAOktiTZxLfmyjCowPqnoUHqwb/Ref90xNaWsjVAOYzHHQbFA
         oCsWeuLr9KjppjPK+hEtskmA0dkepiUF3c/Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rq0isa9+uSFoYNz3NVzNiJqxPB2qDMbMU7T3rW8B1rk=;
        b=SMBKayUOoT3Xq0BSS6tngdvxJNffnJDlh1vk7IvEd/Y3ECLTCUXzxN16BZOoFaMZfa
         SsIMaXUxO4Ol62+y+GHV1xvOW0ST+3gUSy7GdlDjxRYs2N8nrj/xPOEGSG3/hHtXevK9
         xZdCp1HWbLPFg9AidBoKm3qHKliOwfJR5f6FoWlHKsK+9kPmDZJgFShdhXZI2kwYnfIk
         6SpyOqqf8tErlwboLhYmyjrQ8PSiLQztDDrYy2v8HZdfi9ueYbvpRYSxxaDQCQoMmulz
         LDDiP1Yj/2kZQ8yEGp7JRN8F9Rz2Lmlu/DjcazErLQVT2Y60pBIDwrBLt5gd9MWjTR4A
         8bBQ==
X-Gm-Message-State: AGRZ1gIMKrzIDsh6aQ3x8OMg1vMT4t/wRS0uBPdq3ed+tcGMCrJwK1hk
        e9umCi/vX21aNSSp8ddkZ57WjA==
X-Google-Smtp-Source: AJdET5c13Zw3npSG9xTjInt+3wALGj1XR8PCUaBc2aLQjy7gTjHmrFJlnaetemQw+aFYqJjET3v3BA==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr2130928ljh.152.1542268896584;
        Thu, 15 Nov 2018 00:01:36 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o25sm4003427lfd.29.2018.11.15.00.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:01:35 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/8 v6] regulator: max77686: Pass descriptor instead of GPIO number
Date:   Thu, 15 Nov 2018 09:01:19 +0100
Message-Id: <20181115080124.7789-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181115080124.7789-1-linus.walleij@linaro.org>
References: <20181115080124.7789-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number, pass a descriptor looked
up from the device tree configuration node.

Tested on Odroid U3 (with max77686 although not using any GPIOs
for regulators, so at least default paths are not broken).

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v6:
- Request regulator nonexclusive as expected by the regulator
  core.
- Adjust numbering to fit the rest of the series.
ChangeLog v3->v4:
- Collected Krzysztof's test tags.
ChangeLog v2->v3:
- Name the regulator "max77686-regulator"
- Set the regulator to NULL on erroneous lookup, restoring the
  old init data lookup behaviour.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/max77686-regulator.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index bee060937f56..f5cee1775905 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -11,8 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -76,6 +75,7 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
+	struct device *dev;
 	DECLARE_BITMAP(gpio_enabled, MAX77686_REGULATORS);
 
 	/* Array indexed by regulator id */
@@ -255,16 +255,20 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpio = of_get_named_gpio(np,
-					"maxim,ena-gpios", 0);
-		config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
-		config->ena_gpio_initialized = true;
+		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
+				np,
+				"maxim,ena",
+				0,
+				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+				"max77686-regulator");
+		if (IS_ERR(config->ena_gpiod))
+			config->ena_gpiod = NULL;
 		break;
 	default:
 		return 0;
 	}
 
-	if (gpio_is_valid(config->ena_gpio)) {
+	if (config->ena_gpiod) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
 		return regmap_update_bits(config->regmap, desc->enable_reg,
@@ -507,6 +511,7 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	if (!max77686)
 		return -ENOMEM;
 
+	max77686->dev = &pdev->dev;
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77686;
-- 
2.17.2

