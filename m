Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755191AbeCVNBK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:01:10 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36374 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755179AbeCVNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:01:06 -0400
X-Google-Smtp-Source: AG47ELvDE+twJ8tOB1v8zj8epLHwillkJrqq7HVmfB/KKIDbf7sTj0qsODg+Y03KpkZRlcJ9PZ1l8A==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 7/7] gpio: ws16c48: Implement get_multiple callback
Date: Thu, 22 Mar 2018 09:00:59 -0400
Message-Id: <259a3a67b82d2973f4c03a7c3c8a560b3054f7a9.1521723192.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WinSystems WS16C48 device provides 48 lines of digital I/O accessed
via six 8-bit ports. Since eight input lines are acquired on a single
port input read, the WS16C48 GPIO driver may improve multiple input
reads by utilizing a get_multiple callback. This patch implements the
ws16c48_gpio_get_multiple function which serves as the respective
get_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-ws16c48.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 746648244bf3..c7028eb0b8e1 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -11,6 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  */
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -129,6 +130,51 @@ static int ws16c48_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
+	const unsigned int gpio_reg_size = 8;
+	size_t i;
+	const size_t num_ports = chip->ngpio / gpio_reg_size;
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
+	for (i = 0; i < num_ports; i++) {
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
+		port_state = inb(ws16c48gpio->base + i);
+
+		/* store acquired bits at respective bits array offset */
+		bits[word_index] |= port_state << word_offset;
+	}
+
+	return 0;
+}
+
 static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
@@ -383,6 +429,7 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 	ws16c48gpio->chip.direction_input = ws16c48_gpio_direction_input;
 	ws16c48gpio->chip.direction_output = ws16c48_gpio_direction_output;
 	ws16c48gpio->chip.get = ws16c48_gpio_get;
+	ws16c48gpio->chip.get_multiple = ws16c48_gpio_get_multiple;
 	ws16c48gpio->chip.set = ws16c48_gpio_set;
 	ws16c48gpio->chip.set_multiple = ws16c48_gpio_set_multiple;
 	ws16c48gpio->base = base[id];
-- 
2.16.2
