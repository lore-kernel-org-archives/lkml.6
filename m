Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeCLUub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:50:31 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41450 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932525AbeCLUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:50:28 -0400
X-Google-Smtp-Source: AG47ELtpTFTklStmBgf3l3e0V5g0af3jZbnc1iH4Pxf77ORAgS8oQ/IQRm4qZeETuW21jGWTviKqoQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 7/8] gpio: gpio-mm: Implement get_multiple callback
Date: Mon, 12 Mar 2018 16:50:22 -0400
Message-Id: <909f0d3dac7a9f24cfd92f05f4d1e84f569162b1.1520886945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520886945.git.vilhelm.gray@gmail.com>
References: <cover.1520886945.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 11ade5b288f8..5bacfa1f2c02 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -171,6 +171,46 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
+	unsigned int i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bit_word_offset;
+	unsigned int bits_mask;
+	const unsigned long reg_mask = GENMASK(gpio_reg_size, 0);
+	unsigned int port;
+	unsigned int in_port;
+	unsigned long port_state;
+
+	/* clear bits array to a clean slate */
+	for (i = 0; i < chip->ngpio; i += BITS_PER_LONG)
+		bits[i / BITS_PER_LONG] = 0;
+
+	/* get bits are evaluated a gpio register size at a time */
+	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
+		bit_word_offset = i % BITS_PER_LONG;
+		bits_mask = mask[BIT_WORD(i)] & (reg_mask << bit_word_offset);
+		if (!bits_mask) {
+			/* no get bits in this register so skip to next one */
+			continue;
+		}
+
+		/* compute input port offset */
+		port = i / gpio_reg_size;
+		in_port = (port > 2) ? port + 1 : port;
+
+		/* get input bits */
+		port_state = inb(gpiommgpio->base + in_port);
+
+		/* store acquired bits */
+		bits[BIT_WORD(i)] |= port_state << bit_word_offset;
+	}
+
+	return 0;
+}
+
 static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
@@ -268,6 +308,7 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	gpiommgpio->chip.direction_input = gpiomm_gpio_direction_input;
 	gpiommgpio->chip.direction_output = gpiomm_gpio_direction_output;
 	gpiommgpio->chip.get = gpiomm_gpio_get;
+	gpiommgpio->chip.get_multiple = gpiomm_gpio_get_multiple;
 	gpiommgpio->chip.set = gpiomm_gpio_set;
 	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
 	gpiommgpio->base = base[id];
-- 
2.16.2
