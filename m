Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755081AbeCVNAZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:00:25 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43021 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755000AbeCVNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:00:20 -0400
X-Google-Smtp-Source: AG47ELs81hXB30MCHhOkOqx43oyKZzI2v6Lvrgbo3lWSM05yjRt2k8dE0A8LCK4vROsm2E1cUspEuA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 4/7] gpio: 104-dio-48e: Implement get_multiple callback
Date: Thu, 22 Mar 2018 09:00:11 -0400
Message-Id: <35b31cc749162ce549d4d1a82f2d23889590d413.1521723192.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-dio-48e.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index bab3b94c5cbc..31e22c93e844 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -14,6 +14,7 @@
  * This driver supports the following ACCES devices: 104-DIO-48E and
  * 104-DIO-24E.
  */
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -182,6 +183,51 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
+	size_t i;
+	const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bits_offset;
+	size_t word_index;
+	unsigned int word_offset;
+	unsigned long word_mask;
+	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
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
+		port_state = inb(dio48egpio->base + ports[i]);
+
+		/* store acquired bits at respective bits array offset */
+		bits[word_index] |= port_state << word_offset;
+	}
+
+	return 0;
+}
+
 static void dio48e_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
@@ -384,6 +430,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	dio48egpio->chip.direction_input = dio48e_gpio_direction_input;
 	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
 	dio48egpio->chip.get = dio48e_gpio_get;
+	dio48egpio->chip.get_multiple = dio48e_gpio_get_multiple;
 	dio48egpio->chip.set = dio48e_gpio_set;
 	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
 	dio48egpio->base = base[id];
-- 
2.16.2
