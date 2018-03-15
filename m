Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeCOPxi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:53:38 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38202 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeCOPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:53:35 -0400
X-Google-Smtp-Source: AG47ELs6v6MGwjA1Q/KpaSCSCAogQFwMCR+a7vDTD93kkv7A7h2vY8u1OrGSh18LpI8kQT6QRZpKOQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 7/8] gpio: gpio-mm: Implement get_multiple callback
Date: Thu, 15 Mar 2018 11:53:28 -0400
Message-Id: <cd5458f1d3fedd67b01110a2919106be86c60ea4.1521128287.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521128287.git.vilhelm.gray@gmail.com>
References: <cover.1521128287.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Diamond Systems GPIO-MM series of devices contain two 82C55A
devices, which each feature three 8-bit ports of I/O. Since eight input
lines are acquired on a single port input read, the GPIO-MM GPIO driver
may improve multiple input reads by utilizing a get_multiple callback.
This patch implements the gpiomm_gpio_get_multiple function which serves
as the respective get_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-gpio-mm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 11ade5b288f8..d9be9ebe41cf 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -171,6 +171,51 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
+	size_t i;
+	const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bits_offset;
+	size_t word_index;
+	unsigned int word_offset;
+	unsigned long mask_word;
+	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
+	unsigned long port_state;
+
+	/* clear bits array to a clean slate */
+	bitmap_zero(bits, chip->ngpio);
+
+	/* get bits are evaluated a gpio port register at a time */
+	for (i = 0; i < ARRAY_SIZE(ports); i++) {
+		/* gpio offset in bits array */
+		bits_offset = i * gpio_reg_size;
+
+		/* word index for bits array */
+		word_index = BIT_WORD(bits_offset);
+
+		/* gpio offset within current word of bits array */
+		word_offset = bits_offset % BITS_PER_LONG;
+
+		/* mask of get bits for current gpio within current word */
+		word_mask = mask[word_index] & (port_mask << word_offset);
+		if (!word_mask) {
+			/* no get bits in this port so skip to next one */
+			continue;
+		}
+
+		/* read bits from current gpio port */
+		port_state = inb(gpiommgpio->base + ports[i]);
+
+		/* store acquired bits at respective bits array offset */
+		bits[word_index] |= port_state << word_offset;
+	}
+
+	return 0;
+}
+
 static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
@@ -268,6 +313,7 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	gpiommgpio->chip.direction_input = gpiomm_gpio_direction_input;
 	gpiommgpio->chip.direction_output = gpiomm_gpio_direction_output;
 	gpiommgpio->chip.get = gpiomm_gpio_get;
+	gpiommgpio->chip.get_multiple = gpiomm_gpio_get_multiple;
 	gpiommgpio->chip.set = gpiomm_gpio_set;
 	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
 	gpiommgpio->base = base[id];
-- 
2.16.2
