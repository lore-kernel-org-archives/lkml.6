Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeCQPvr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 11:51:47 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46421 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbeCQPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 11:51:43 -0400
X-Google-Smtp-Source: AG47ELvSbGZ/HeLo+V4avajzMrvlSL39vw5Qe0/FapRZ/6Db7ZMa7ZnBi+fA4vzyY2mE4QQXZtwAQA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 6/8] gpio: 104-idi-48: Implement get_multiple callback
Date: Sat, 17 Mar 2018 11:51:37 -0400
Message-Id: <950454628c8beac8a3f6a3163fb04141d41d00a3.1521301345.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521301345.git.vilhelm.gray@gmail.com>
References: <cover.1521301345.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES I/O 104-IDI-48 series of devices provides 48
optically-isolated inputs accessed via six 8-bit ports. Since eight
input lines are acquired on a single port input read, the 104-IDI-48
GPIO driver may improve multiple input reads by utilizing a get_multiple
callback. This patch implements the idi_48_gpio_get_multiple function
which serves as the respective get_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index add859d59766..2c230415eeba 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -14,6 +14,7 @@
  * This driver supports the following ACCES devices: 104-IDI-48A,
  * 104-IDI-48AC, 104-IDI-48B, and 104-IDI-48BC.
  */
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -88,6 +89,51 @@ static int idi_48_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
+	size_t i;
+	const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bits_offset;
+	size_t word_index;
+	unsigned int word_offset;
+	unsigned long word_mask;
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
+		port_state = inb(idi48gpio->base + ports[i]);
+
+		/* store acquired bits at respective bits array offset */
+		bits[word_index] |= port_state << word_offset;
+	}
+
+	return 0;
+}
+
 static void idi_48_irq_ack(struct irq_data *data)
 {
 }
@@ -256,6 +302,7 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	idi48gpio->chip.get_direction = idi_48_gpio_get_direction;
 	idi48gpio->chip.direction_input = idi_48_gpio_direction_input;
 	idi48gpio->chip.get = idi_48_gpio_get;
+	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
 	idi48gpio->base = base[id];
 
 	raw_spin_lock_init(&idi48gpio->lock);
-- 
2.16.2
