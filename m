Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E071AC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B667E2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfBGQ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:29:16 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39605 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBGQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:29:14 -0500
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 902F4100013;
        Thu,  7 Feb 2019 16:29:10 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/5] gpio: rename gpio_set_drive_single_ended() to gpio_set_config()
Date:   Thu,  7 Feb 2019 17:28:56 +0100
Message-Id: <20190207162859.26252-3-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit simply renames gpio_set_drive_single_ended() to
gpio_set_config(), as the function is not specific to setting the GPIO
drive type, and will be used for other purposes in followup commits.

In addition, it moves the function above gpiod_direction_input(), as
it will be used from gpiod_direction_input().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/gpio/gpiolib.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 361a09c8138a..cf8a4402fef1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2555,6 +2555,14 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
+static int gpio_set_config(struct gpio_chip *gc, unsigned offset,
+			   enum pin_config_param mode)
+{
+	unsigned long config = { PIN_CONF_PACKED(mode, 0) };
+
+	return gc->set_config ? gc->set_config(gc, offset, config) : -ENOTSUPP;
+}
+
 /**
  * gpiod_direction_input - set the GPIO direction to input
  * @desc:	GPIO to set to input
@@ -2608,14 +2616,6 @@ int gpiod_direction_input(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_input);
 
-static int gpio_set_drive_single_ended(struct gpio_chip *gc, unsigned offset,
-				       enum pin_config_param mode)
-{
-	unsigned long config = { PIN_CONF_PACKED(mode, 0) };
-
-	return gc->set_config ? gc->set_config(gc, offset, config) : -ENOTSUPP;
-}
-
 static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
 	struct gpio_chip *gc = desc->gdev->chip;
@@ -2712,8 +2712,8 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 	gc = desc->gdev->chip;
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
 		/* First see if we can enable open drain in hardware */
-		ret = gpio_set_drive_single_ended(gc, gpio_chip_hwgpio(desc),
-						  PIN_CONFIG_DRIVE_OPEN_DRAIN);
+		ret = gpio_set_config(gc, gpio_chip_hwgpio(desc),
+				      PIN_CONFIG_DRIVE_OPEN_DRAIN);
 		if (!ret)
 			goto set_output_value;
 		/* Emulate open drain by not actively driving the line high */
@@ -2721,16 +2721,16 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 			return gpiod_direction_input(desc);
 	}
 	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
-		ret = gpio_set_drive_single_ended(gc, gpio_chip_hwgpio(desc),
-						  PIN_CONFIG_DRIVE_OPEN_SOURCE);
+		ret = gpio_set_config(gc, gpio_chip_hwgpio(desc),
+				      PIN_CONFIG_DRIVE_OPEN_SOURCE);
 		if (!ret)
 			goto set_output_value;
 		/* Emulate open source by not actively driving the line low */
 		if (!value)
 			return gpiod_direction_input(desc);
 	} else {
-		gpio_set_drive_single_ended(gc, gpio_chip_hwgpio(desc),
-					    PIN_CONFIG_DRIVE_PUSH_PULL);
+		gpio_set_config(gc, gpio_chip_hwgpio(desc),
+				PIN_CONFIG_DRIVE_PUSH_PULL);
 	}
 
 set_output_value:
-- 
2.20.1

