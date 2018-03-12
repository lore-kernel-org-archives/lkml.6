Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeCLUum (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:50:42 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44822 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeCLUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:50:39 -0400
X-Google-Smtp-Source: AG47ELthYQSyemYEzqpO/VfzcCJeAKez45uxiVOf8s1SxyzQhHVEqpJ3+JFjWGu8WgoMT7hMMnoinw==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 8/8] gpio: ws16c48: Implement get_multiple callback
Date: Mon, 12 Mar 2018 16:50:32 -0400
Message-Id: <1776078694b1f68535fd9d0051dcaa992413ea60.1520886945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520886945.git.vilhelm.gray@gmail.com>
References: <cover.1520886945.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-ws16c48.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 746648244bf3..6d911f8e92c1 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -129,6 +129,44 @@ static int ws16c48_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
+	unsigned int i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int bit_word_offset;
+	unsigned int bits_mask;
+	const unsigned long reg_mask = GENMASK(gpio_reg_size, 0);
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
+		in_port = i / gpio_reg_size;
+
+		/* get input bits */
+		port_state = inb(ws16c48gpio->base + in_port);
+
+		/* store acquired bits */
+		bits[BIT_WORD(i)] |= port_state << bit_word_offset;
+	}
+
+	return 0;
+}
+
 static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
@@ -383,6 +421,7 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 	ws16c48gpio->chip.direction_input = ws16c48_gpio_direction_input;
 	ws16c48gpio->chip.direction_output = ws16c48_gpio_direction_output;
 	ws16c48gpio->chip.get = ws16c48_gpio_get;
+	ws16c48gpio->chip.get_multiple = ws16c48_gpio_get_multiple;
 	ws16c48gpio->chip.set = ws16c48_gpio_set;
 	ws16c48gpio->chip.set_multiple = ws16c48_gpio_set_multiple;
 	ws16c48gpio->base = base[id];
-- 
2.16.2
