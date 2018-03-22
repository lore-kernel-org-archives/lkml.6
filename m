Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755288AbeCVNCj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:02:39 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39510 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755010AbeCVNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:00:07 -0400
X-Google-Smtp-Source: AG47ELsbIcXxBJ7r2oM2En28ebEkDOlDebSJjD2sQMtsMDDsVsIG3jfwHo1o1jD76yAFy8vwCEGnJg==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 3/7] gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks
Date: Thu, 22 Mar 2018 09:00:00 -0400
Message-Id: <bd4594307521c93f952db774da466a54c434704a.1521723192.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES I/O PCIe-IDIO-24 series of devices provides 24
optically-isolated digital I/O accessed via six 8-bit ports. Since eight
input lines are acquired on a single port input read -- and similarly
eight output lines are set on a single port output write -- the
PCIe-IDIO-24 GPIO driver may improve multiple I/O reads/writes by
utilizing a get_multiple/set_multiple callbacks. This patch implements
the idio_24_gpio_get_multiple function which serves as the respective
get_multiple callback, and implements the idio_24_gpio_set_multiple
function which serves as the respective set_multiple callback.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pcie-idio-24.c | 117 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index f666e2e69074..835607ecf658 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -15,6 +15,7 @@
  * This driver supports the following ACCES devices: PCIe-IDIO-24,
  * PCIe-IDI-24, PCIe-IDO-24, and PCIe-IDIO-12.
  */
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -193,6 +194,61 @@ static int idio_24_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(ioread8(&idio24gpio->reg->ttl_in0_7) & offset_mask);
 }
 
+static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
+	size_t i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bits_offset;
+	size_t word_index;
+	unsigned int word_offset;
+	unsigned long word_mask;
+	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned long port_state;
+	u8 __iomem ports[] = {
+		idio24gpio->reg->out0_7, idio24gpio->reg->out8_15,
+		idio24gpio->reg->out16_23, idio24gpio->reg->in0_7,
+		idio24gpio->reg->in8_15, idio24gpio->reg->in16_23,
+	};
+	const unsigned long out_mode_mask = BIT(1);
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
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (i < 6)
+			port_state = ioread8(ports + i);
+		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
+			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		else
+			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
+
+		/* store acquired bits at respective bits array offset */
+		bits[word_index] |= port_state << word_offset;
+	}
+
+	return 0;
+}
+
 static void idio_24_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
@@ -234,6 +290,65 @@ static void idio_24_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 }
 
+static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
+	size_t i;
+	unsigned long bits_offset;
+	unsigned long gpio_mask;
+	const unsigned int gpio_reg_size = 8;
+	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
+	unsigned long flags;
+	unsigned int out_state;
+	u8 __iomem ports[] = {
+		idio24gpio->reg->out0_7, idio24gpio->reg->out8_15,
+		idio24gpio->reg->out16_23
+	};
+	const unsigned long out_mode_mask = BIT(1);
+	const unsigned int ttl_offset = 48;
+	const size_t ttl_i = BIT_WORD(ttl_offset);
+	const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
+	const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
+	const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
+
+	/* set bits are processed a gpio port register at a time */
+	for (i = 0; i < ARRAY_SIZE(ports); i++) {
+		/* gpio offset in bits array */
+		bits_offset = i * gpio_reg_size;
+
+		/* check if any set bits for current port */
+		gpio_mask = (*mask >> bits_offset) & port_mask;
+		if (!gpio_mask) {
+			/* no set bits for this port so move on to next port */
+			continue;
+		}
+
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+
+		/* process output lines */
+		out_state = ioread8(ports + i) & ~gpio_mask;
+		out_state |= (*bits >> bits_offset) & gpio_mask;
+		iowrite8(out_state, ports + i);
+
+		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	}
+
+	/* check if setting TTL lines and if they are in output mode */
+	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
+		return;
+
+	/* handle TTL output */
+	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+
+	/* process output lines */
+	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
+	out_state |= ttl_bits;
+	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
+
+	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+}
+
 static void idio_24_irq_ack(struct irq_data *data)
 {
 }
@@ -397,7 +512,9 @@ static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio24gpio->chip.direction_input = idio_24_gpio_direction_input;
 	idio24gpio->chip.direction_output = idio_24_gpio_direction_output;
 	idio24gpio->chip.get = idio_24_gpio_get;
+	idio24gpio->chip.get_multiple = idio_24_gpio_get_multiple;
 	idio24gpio->chip.set = idio_24_gpio_set;
+	idio24gpio->chip.set_multiple = idio_24_gpio_set_multiple;
 
 	raw_spin_lock_init(&idio24gpio->lock);
 
-- 
2.16.2
