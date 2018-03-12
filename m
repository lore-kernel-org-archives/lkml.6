Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeCLUuU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:50:20 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33751 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932525AbeCLUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:50:03 -0400
X-Google-Smtp-Source: AG47ELtnJPQ6lhzCwMOioBNx3IPmPuApnCVGXxvR4iyx0UezJoypKUCgfGNoW3keprl0o3e1OOqyRA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 6/8] gpio: 104-idi-48: Implement get_multiple callback
Date: Mon, 12 Mar 2018 16:49:57 -0400
Message-Id: <cbb3ce81a8f2ba0bf65f2778b59a2713555bfa07.1520886945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520886945.git.vilhelm.gray@gmail.com>
References: <cover.1520886945.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index add859d59766..d82139c3117a 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -88,6 +88,46 @@ static int idi_48_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
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
+		port_state = inb(idi48gpio->base + in_port);
+
+		/* store acquired bits */
+		bits[BIT_WORD(i)] |= port_state << bit_word_offset;
+	}
+
+	return 0;
+}
+
 static void idi_48_irq_ack(struct irq_data *data)
 {
 }
@@ -256,6 +296,7 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	idi48gpio->chip.get_direction = idi_48_gpio_get_direction;
 	idi48gpio->chip.direction_input = idi_48_gpio_direction_input;
 	idi48gpio->chip.get = idi_48_gpio_get;
+	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
 	idi48gpio->base = base[id];
 
 	raw_spin_lock_init(&idi48gpio->lock);
-- 
2.16.2
