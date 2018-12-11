Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68167C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E022084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGuckx6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E022084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLKV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:26:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33871 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeLKV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:26:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so11933077lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2lg+HYTDvmXcVEMhNUeoqjV4EvN8ZqyoGB2eJbspRs=;
        b=iGuckx6txHtsaiwQQZ5C4lF/BZhSERdfg4+S+RK8H5bGBo6hCO/ns8u80Ih9r2rW8X
         3DiLL1DGOJipgvvb9mTGNcS7TpQyFPILJWuvvIn1aogfys9TMXoLUpho73c9dbqbvQb6
         mO/FqYPeA97QAXSvWuVNmYzdLiiOTll/f/UP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2lg+HYTDvmXcVEMhNUeoqjV4EvN8ZqyoGB2eJbspRs=;
        b=B8k7IEI4T9FE7KrTkj6zfI3JNUIk2UNCTKXHKj/Lpgj7uuq8pL+oMmO0cN4d/tG7DL
         uvbBRtcO6+njezHBU0FTZ4GqVAznXfHIo9Cskg+MZApL+wJrs9I0A3hyU2Fq1AnJSypH
         TJyO/8IOmRSHxzOwwhertMG2giL/gU5qK/zNT6WrynUkUkyFrxLxF6T+KK21nnT2LRk8
         wE1T4VVlNOm5z+1Gyi+oW2WXwQYBk9fFzdF3kg8C7/+da/EaWQIjlmJsSoDBsXvkq6tR
         x/9Q7FLYZago6aYN0z50B8XiUHenMmK/g365cdAlgnWgOig/yjZxEu3pTo3FXTB/xojc
         yRSg==
X-Gm-Message-State: AA+aEWZim4UpBKX+VSooWOopYaUFHPDFfNpRASNBb2/RC2P2+Iho6rMd
        Fkjpg750JnM4QO4bmws5EVP9jg==
X-Google-Smtp-Source: AFSGD/USe/Q7oQU07jrGZni+qqwdRgbddhN+zqH43q+lB8fFA2r7mhrFO+K5cdpk1tMXbEIPBm7Nrw==
X-Received: by 2002:a19:a086:: with SMTP id j128mr9744614lfe.93.1544563608855;
        Tue, 11 Dec 2018 13:26:48 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id y11-v6sm2873870ljc.85.2018.12.11.13.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:26:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5 v8] regulator: core: Only support passing enable GPIO descriptors
Date:   Tue, 11 Dec 2018 22:24:28 +0100
Message-Id: <20181211212428.28327-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211212428.28327-1-linus.walleij@linaro.org>
References: <20181211212428.28327-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
ChangeLog v7->v8:
- Rebase on recent fixes on the for-4.21 branch.
ChangeLog v6->v7:
- Resend with the rest.
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
index 8f3aa151bb72..dc639548076e 100644
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
@@ -2221,35 +2220,19 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
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
@@ -2272,7 +2255,6 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
@@ -4966,15 +4948,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
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
 		/* The regulator core took over the GPIO descriptor */
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 389bcaf7900f..e511e9d1cc86 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -401,13 +401,7 @@ struct regulator_desc {
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
@@ -416,11 +410,7 @@ struct regulator_config {
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
2.19.2

