Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeCOPqx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:46:53 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34208 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeCOPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:46:50 -0400
X-Google-Smtp-Source: AG47ELuBn0ZBQ3W4j2J2hNT7rlueH2OwmX7kV54j7AsyXFPOCfY9FMRUB+yD7Od1Q3U0o7X+KPJepQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 1/8] iio: stx104: Implement get_multiple callback
Date: Thu, 15 Mar 2018 11:46:37 -0400
Message-Id: <14a09900bf4642495ebe4072b9eb02769dbc4c5e.1521128287.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521128287.git.vilhelm.gray@gmail.com>
References: <cover.1521128287.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apex Embedded Systems STX104 series of devices provides 4 TTL
compatible lines of inputs accessed via a single 4-bit port. Since four
input lines are acquired on a single port input read, the STX104 GPIO
driver may improve multiple input reads by utilizing a get_multiple
callback. This patch implements the stx104_gpio_get_multiple function
which serves as the respective get_multiple callback.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/adc/stx104.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 17b021f33180..0662ca199eb0 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -233,6 +233,16 @@ static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(inb(stx104gpio->base) & BIT(offset));
 }
 
+static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+
+	*bits = inb(stx104gpio->base);
+
+	return 0;
+}
+
 static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
@@ -342,6 +352,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
 	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
 	stx104gpio->chip.get = stx104_gpio_get;
+	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
 	stx104gpio->base = base[id] + 3;
-- 
2.16.2
