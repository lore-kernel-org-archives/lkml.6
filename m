Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeCQPul (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 11:50:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42499 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753700AbeCQPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 11:50:38 -0400
X-Google-Smtp-Source: AG47ELtq1NX14NNt/O4Ouc7whGD8UYOWo7L0QmBzzCLergSwugqiA2zyaMt7nW5lKAiYQQrA+8Q6uw==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 3/8] gpio: pci-idio-16: Implement get_multiple callback
Date: Sat, 17 Mar 2018 11:50:31 -0400
Message-Id: <6ca4bf0ed930c057bdbcd07bab34ed0a474dd78d.1521301345.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521301345.git.vilhelm.gray@gmail.com>
References: <cover.1521301345.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES I/O PCI-IDIO-16 series of devices provides 16
optically-isolated digital inputs accessed via two 8-bit ports. Since
eight input lines are acquired on a single port input read, the
PCI-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
get_multiple callback. This patch implements the
idio_16_gpio_get_multiple function which serves as the respective
get_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pci-idio-16.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 57d1b7fbf07b..f273cf776cac 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -11,6 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  */
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -103,6 +104,54 @@ static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(ioread8(&idio16gpio->reg->in8_15) & (mask >> 24));
 }
 
+static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	size_t i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bits_offset;
+	size_t word_index;
+	unsigned int word_offset;
+	unsigned long word_mask;
+	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
+	unsigned long port_state;
+	u8 __iomem ports[] = {
+		idio16gpio->reg->out0_7, idio16gpio->reg->out8_15,
+		idio16gpio->reg->in0_7, idio16gpio->reg->in8_15
+	};
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
+		port_state = ioread8(ports + i);
+
+		/* store acquired bits at respective bits array offset */
+		bits[word_index] |= port_state << word_offset;
+	}
+
+	return 0;
+}
+
 static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
@@ -299,6 +348,7 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
 	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
 	idio16gpio->chip.get = idio_16_gpio_get;
+	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
 
-- 
2.16.2
