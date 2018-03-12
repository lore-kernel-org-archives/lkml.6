Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeCLUtz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:49:55 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40901 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932247AbeCLUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:49:53 -0400
X-Google-Smtp-Source: AG47ELuYKkH72MRV7JkGWUa3t7w87w5H7bCgaCIfjJVfraq6BxH87lG6uZyX3+DsVrtvvoT8o8Vs4Q==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 5/8] gpio: 104-dio-48e: Implement get_multiple callback
Date: Mon, 12 Mar 2018 16:49:46 -0400
Message-Id: <5b8ac88568320f8a1b00f3ade7da51b1f3e1cdb3.1520886945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520886945.git.vilhelm.gray@gmail.com>
References: <cover.1520886945.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES I/O 104-DIO-48E series of devices contain two Programmable
Peripheral Interface (PPI) chips of type 82C55, which each feature three
8-bit ports of I/O. Since eight input lines are acquired on a single
port input read, the 104-DIO-48E GPIO driver may improve multiple input
reads by utilizing a get_multiple callback. This patch implements the
dio48e_gpio_get_multiple function which serves as the respective
get_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-dio-48e.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index bab3b94c5cbc..35ae2357d2ba 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -182,6 +182,46 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
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
+		port_state = inb(dio48egpio->base + in_port);
+
+		/* store acquired bits */
+		bits[BIT_WORD(i)] |= port_state << bit_word_offset;
+	}
+
+	return 0;
+}
+
 static void dio48e_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
@@ -384,6 +424,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	dio48egpio->chip.direction_input = dio48e_gpio_direction_input;
 	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
 	dio48egpio->chip.get = dio48e_gpio_get;
+	dio48egpio->chip.get_multiple = dio48e_gpio_get_multiple;
 	dio48egpio->chip.set = dio48e_gpio_set;
 	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
 	dio48egpio->base = base[id];
-- 
2.16.2
