Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeCLQph (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:45:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33495 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeCLQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:45:34 -0400
X-Google-Smtp-Source: AG47ELvpB0A3aEXuYePqGCl+PrPuJIyIGT6373N+yDFFhMXvwkJT2kJ1p3Tbk2vplz4Oj5Oa4AtdsA==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pinctrl/amd: poll InterruptEnable bits in enable_irq
Date: Mon, 12 Mar 2018 10:45:30 -0600
Message-Id: <20180312164530.215524-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain cases interrupt enablement will be delayed relative to when
the InterruptEnable bits are written.  One example of this is when
a GPIO's "debounce" logice is first enabled.  After enabling debounce,
there is a 900 us "warm up" period during which InterruptEnable[0]
(bit 11) will read as 0 despite being written 1.  During this time
InterruptSts will not be updated, nor will interrupts be delivered, even
if the GPIO's interrupt configuration has been written to the register.

To work around this delay, poll the InterruptEnable bits after setting
them to ensure interrupts have truly been enabled in hardware before
returning from the irq_enable handler.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index dae184c4b962..af8ef485fbe7 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -348,12 +348,21 @@ static void amd_gpio_irq_enable(struct irq_data *d)
 	unsigned long flags;
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+	u32 mask = BIT(INTERRUPT_ENABLE_OFF) | BIT(INTERRUPT_MASK_OFF);
 
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 	pin_reg = readl(gpio_dev->base + (d->hwirq)*4);
 	pin_reg |= BIT(INTERRUPT_ENABLE_OFF);
 	pin_reg |= BIT(INTERRUPT_MASK_OFF);
 	writel(pin_reg, gpio_dev->base + (d->hwirq)*4);
+	/*
+	 * When debounce logic is enabled it takes ~900 us before interrupts
+	 * can be enabled.  During this "debounce warm up" period the
+	 * "INTERRUPT_ENABLE" bit will read as 0. Poll the bit here until it
+	 * reads back as 1, signaling that interrupts are now enabled.
+	 */
+	while ((readl(gpio_dev->base + (d->hwirq)*4) & mask) != mask)
+		continue;
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 }
 
-- 
2.16.2.660.g709887971b-goog
