Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbeCVNDe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:03:34 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46885 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754920AbeCVM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:59:44 -0400
X-Google-Smtp-Source: AG47ELu5XupfVZibCE2PL8Ek0RRq9WMOo4zD49T6gmcpA6MV5rr+2hBZcdcdeqNN4al7y2h5UMyCZQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 1/7] gpio: 104-idio-16: Implement get_multiple callback
Date: Thu, 22 Mar 2018 08:59:37 -0400
Message-Id: <1699105253cb33680bb27ca61e6fc9fb0bd2aaf8.1521723192.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES I/O 104-IDIO-16 series of devices provides 16
optically-isolated digital inputs accessed via two 8-bit ports. Since
eight input lines are acquired on a single port input read, the
104-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
get_multiple callback. This patch implements the
idio_16_gpio_get_multiple function which serves as the respective
get_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idio-16.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 2f16638a0589..96700308c1e3 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -90,6 +90,20 @@ static int idio_16_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(inb(idio16gpio->base + 5) & (mask>>8));
 }
 
+static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+
+	*bits = 0;
+	if (*mask & GENMASK(23, 16))
+		*bits |= (unsigned long)inb(idio16gpio->base + 1) << 16;
+	if (*mask & GENMASK(31, 24))
+		*bits |= (unsigned long)inb(idio16gpio->base + 5) << 24;
+
+	return 0;
+}
+
 static void idio_16_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
@@ -244,6 +258,7 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 	idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
 	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
 	idio16gpio->chip.get = idio_16_gpio_get;
+	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
 	idio16gpio->base = base[id];
-- 
2.16.2
