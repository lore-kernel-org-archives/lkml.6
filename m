Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBUILP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:11:15 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:52533 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeBUILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:11:13 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: Keep returning EPROBE_DEFER when we should
Date: Wed, 21 Feb 2018 09:11:00 +0100
Message-Id: <20180221081100.17662-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commits c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
and 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO
properties") have introduced a regression in the way error codes from
of_get_named_gpiod_flags are handled.

Previously, those errors codes were returned immediately, but the two
commits mentioned above are now overwriting the error pointer, meaning that
whatever value has been returned will be dropped in favor of whatever the
two new functions will return.

This might not be a big deal except for EPROBE_DEFER, on which GPIOlib
customers will depend on, and that will now be returned as an hard error
which means that they will not probe anymore, instead of gently deferring
their probe.

Since EPROBE_DEFER basically means that we have found a valid property but
there was no GPIO controller registered to handle it, fix this issues by
returning it as soon as we encounter it.

Fixes: c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
Fixes: 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO properties")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpio/gpiolib-of.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 564bb7a31da4..c92847ff5d0a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -243,6 +243,19 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 						&of_flags);
 		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
 			break;
+
+		/*
+		 * -EPROBE_DEFER in our case means that we found a
+		 * valid GPIO property, but no controller has been
+		 * registered so far.
+		 *
+		 * This means we don't need to look any further for
+		 * alternate name conventions, and we should really
+		 * preserve the return code for our user to be able to
+		 * retry probing later.
+		 */
+		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
+			return desc;
 	}
 
 	/* Special handling for SPI GPIOs if used */
-- 
2.14.3
