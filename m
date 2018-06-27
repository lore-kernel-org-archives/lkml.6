Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78821C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AFD24056
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LSCrnSbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AFD24056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964959AbeF0LzG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:55:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35984 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbeF0LzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:55:03 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 07:55:03 EDT
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] pinctrl: Add API function pinctrl_gpio_get_direction
Date:   Wed, 27 Jun 2018 13:49:01 +0200
Message-Id: <20180627114904.10890-3-paul@crapouillou.net>
In-Reply-To: <20180627114904.10890-1-paul@crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530100163; bh=d0skFGD9Ti74xKWE/T+DdvWx6QJ2f7QuM36W0LUIUvk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LSCrnSboywf3pEJA/NkGchL3UW1eEqkCDPANbZXxCsY74W645P/XM7UvVEV7Vx5XICMFxz8dFUV6yk7LoVRXptHa34qo+Dg7UWTa53nEkiqzYPFU5vXwy6ZcfwCjVhq5CAWIO8+Yjmnlxo+Ny0lXyD9gQHke84Ckds+N3CwTmGw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can be used to retrieve the direction (input/output) of a
given GPIO.

It should *ONLY* be used from gpiolib-based GPIO drivers, as part of their
gpio_get_direction() semantics, platforms and individual drivers shall
*NOT* touch pin control GPIO calls.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/core.c           | 31 +++++++++++++++++++++++++++++++
 include/linux/pinctrl/consumer.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e5a303002021..7fee8347fb51 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -849,6 +849,37 @@ int pinctrl_gpio_direction_output(unsigned gpio)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
 
 /**
+ * pinctrl_gpio_get_direction() - Get the direction (input/output) of a GPIO pin
+ * @gpio: the GPIO pin number from the GPIO subsystem number space
+ *
+ * This function should *ONLY* be used from gpiolib-based GPIO drivers,
+ * as part of their gpio_get_direction() semantics, platforms and individual
+ * drivers shall *NOT* touch pin control GPIO calls.
+ */
+int pinctrl_gpio_get_direction(unsigned int gpio)
+{
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_gpio_range *range;
+	int ret;
+	int pin;
+
+	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
+	if (ret)
+		return ret;
+
+	mutex_lock(&pctldev->mutex);
+
+	/* Convert to the pin controllers number space */
+	pin = gpio_to_pin(range, gpio);
+	ret = pinmux_gpio_get_direction(pctldev, range, pin);
+
+	mutex_unlock(&pctldev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_get_direction);
+
+/**
  * pinctrl_gpio_set_config() - Apply config to given GPIO pin
  * @gpio: the GPIO pin number from the GPIO subsystem number space
  * @config: the configuration to apply to the GPIO
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 0412cc9833e9..5f945c329f1c 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -29,6 +29,7 @@ extern int pinctrl_gpio_request(unsigned gpio);
 extern void pinctrl_gpio_free(unsigned gpio);
 extern int pinctrl_gpio_direction_input(unsigned gpio);
 extern int pinctrl_gpio_direction_output(unsigned gpio);
+extern int pinctrl_gpio_get_direction(unsigned gpio);
 extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 
 extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
-- 
2.11.0

