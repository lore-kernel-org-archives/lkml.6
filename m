Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCLUtQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:49:16 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33679 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeCLUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:49:14 -0400
X-Google-Smtp-Source: AG47ELu/N6NpQIyoXb8Vyf2fa4QOJVcP1SvFYUGEzszzoySL0bQRCzC3MTA758QoH/OOBeDYbru8OA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 3/8] gpio: pci-idio-16: Implement get_multiple callback
Date: Mon, 12 Mar 2018 16:49:07 -0400
Message-Id: <e6a13288c45f824ba23ee8d1410cf0bf9c55fe60.1520886945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520886945.git.vilhelm.gray@gmail.com>
References: <cover.1520886945.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 57d1b7fbf07b..8c5ec301c7ff 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -103,6 +103,53 @@ static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(ioread8(&idio16gpio->reg->in8_15) & (mask >> 24));
 }
 
+static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned int i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bit_word_offset;
+	unsigned int bits_mask;
+	const unsigned long reg_mask = GENMASK(gpio_reg_size, 0);
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
+		/* read bits from current gpio register */
+		switch (i / gpio_reg_size) {
+		case 0:
+			port_state = ioread8(&idio16gpio->reg->out0_7);
+			break;
+		case 1:
+			port_state = ioread8(&idio16gpio->reg->out8_15);
+			break;
+		case 2:
+			port_state = ioread8(&idio16gpio->reg->in0_7);
+			break;
+		case 3:
+			port_state = ioread8(&idio16gpio->reg->in8_15);
+			break;
+		}
+
+		/* store acquired bits */
+		bits[BIT_WORD(i)] |= port_state << bit_word_offset;
+	}
+
+	return 0;
+}
+
 static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
@@ -299,6 +346,7 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
 	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
 	idio16gpio->chip.get = idio_16_gpio_get;
+	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
 
-- 
2.16.2
