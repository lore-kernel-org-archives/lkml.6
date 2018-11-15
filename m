Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13BC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EFD2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFbx1fFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EFD2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbeKOSIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:08:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44278 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbeKOSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:08:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so13455390lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cRUDpkN83Jaf9IQM3ipsCZQ6aGbWpgr5owq1zz9T5U4=;
        b=QFbx1fFrDVQD4GDjnwzedh3woRcaXSa2om3SYgR/cbAfH69r6LuYSIqK1HGSaXoBgP
         tIyLfSAyc5i4oKExwD4+Kz4GmLcYDlgNsY69yStM6C77SX7/X9EdPxleqYsuQnM/SZNC
         bUlUQEgVfQSww1+6PTz64J75tM6KzljRR3xUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cRUDpkN83Jaf9IQM3ipsCZQ6aGbWpgr5owq1zz9T5U4=;
        b=QnciiBB8BCDVSxkeuuX6AJrDpOGCs7KJtMkOpgV2Ye7eZeA7AWxDbu3/6zrTS/oom+
         46YXOBwAJKACDZeKYbrlG9LVWAiDnWIRvc9Qh9r/pQz72l3bsY9MxKYqj7E7C0+iW/8P
         57ey47Xtm4KzTM8HaaQjJWyTb05TAmWJOSu8AfT7TPH5pRLuB2MjuPDJNedPQr5IZBjj
         RgwKzpgH4Zd63iG0PfTu2KSTCkpSpZ8irHSlHW3GwGsgTaw9UibgVjidolNqYSLBfdc3
         wmq/ilOqb456qyfV/XAdcFyVG/Y98kSgWPWLOLsKh13wDFV5smOOQf2B7k4JxIfKM8Ne
         5m7A==
X-Gm-Message-State: AGRZ1gJOJe1dDs+PnLYSj0CHLII9EQaYI0gBNj/PVAXzUDFfTGhYiVsL
        FyY19QpI/ZL+SKcPZTn2/bSsCQ==
X-Google-Smtp-Source: AJdET5c8AXSMtx9F25ZhjWng0p4BzmZ5at9ZdJm39wWOsDlQ14/I2hk990SYK30fhxpSIkBEXxr3vQ==
X-Received: by 2002:a19:d381:: with SMTP id k123mr2968044lfg.101.1542268910984;
        Thu, 15 Nov 2018 00:01:50 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o25sm4003427lfd.29.2018.11.15.00.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:01:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 8/8 v6] regulator: core: Only support passing enable GPIO descriptors
Date:   Thu, 15 Nov 2018 09:01:24 +0100
Message-Id: <20181115080124.7789-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181115080124.7789-1-linus.walleij@linaro.org>
References: <20181115080124.7789-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we changed all providers to pass descriptors into the core
for enable GPIOs instead of a global GPIO number, delete the support
for passing GPIO numbers in, and we get a cleanup and size reduction
in the core, and from a GPIO point of view we use the modern, cleaner
interface.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v6:
- Rebase on top of the other changes.
- Renumber to fit the rest of the series.
ChangeLog v3->v4:
- Also drop ena_gpio_invert from driver data
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/core.c         | 32 ++++++--------------------------
 include/linux/regulator/driver.h | 12 +-----------
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 109bd2bee868..0eb5c48f1162 100644
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
@@ -2015,35 +2014,19 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
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
 	list_add(&pin->list, &regulator_ena_gpio_list);
@@ -2066,7 +2049,6 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
@@ -4336,15 +4318,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
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
index a9c030192147..10ee158eac00 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -400,13 +400,7 @@ struct regulator_desc {
  *           NULL).
  * @regmap: regmap to use for core regmap helpers if dev_get_regmap() is
  *          insufficient.
- * @ena_gpio_initialized: GPIO controlling regulator enable was properly
- *                        initialized, meaning that >= 0 is a valid gpio
- *                        identifier and < 0 is a non existent gpio.
- * @ena_gpio: GPIO controlling regulator enable.
- * @ena_gpiod: GPIO descriptor controlling regulator enable.
- * @ena_gpio_invert: Sense for GPIO enable control.
- * @ena_gpio_flags: Flags to use when calling gpio_request_one()
+ * @ena_gpiod: GPIO controlling regulator enable.
  */
 struct regulator_config {
 	struct device *dev;
@@ -415,11 +409,7 @@ struct regulator_config {
 	struct device_node *of_node;
 	struct regmap *regmap;
 
-	bool ena_gpio_initialized;
-	int ena_gpio;
 	struct gpio_desc *ena_gpiod;
-	unsigned int ena_gpio_invert:1;
-	unsigned int ena_gpio_flags;
 };
 
 /*
-- 
2.17.2

