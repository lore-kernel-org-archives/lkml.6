Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeBPTMu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:12:50 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44186 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeBPTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:12:46 -0500
X-Google-Smtp-Source: AH8x224dqs0Oijke1r4+8MWPuBfyxLKpbV8ynM7yZ6wCSziSMMPxjo0dEC5avQaS5/uRh5rOkZlbcQ==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pinctrl/amd: add get_direction handler
Date: Fri, 16 Feb 2018 12:12:43 -0700
Message-Id: <20180216191243.129130-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On boot, gpiochip_add_data() initializes the FLAG_IS_OUT bit in
desc->flags iff its gpio_chip does not have ->direction_input() handler,
else it is initialized to 0, which implies the GPIO is an "input".

Later, the sysfs "direction" handler will use gpiod_get_direction() to
get the current direction, but if no ->get_direction() handler is
installed, the result will just be the current (initial) value of flags,
which will always be OUT irregardless of the initial register value.

Add a get_direction() handler to pinctrl-amd to fix this and always
provide the correct value for direction.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 61d830c2bc17..281b700fe7e9 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -40,6 +40,19 @@
 #include "pinctrl-utils.h"
 #include "pinctrl-amd.h"
 
+static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
+{
+	unsigned long flags;
+	u32 pin_reg;
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+	pin_reg = readl(gpio_dev->base + offset * 4);
+	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+
+	return !(pin_reg & BIT(OUTPUT_ENABLE_OFF));
+}
+
 static int amd_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	unsigned long flags;
@@ -845,6 +858,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 #endif
 
 	gpio_dev->pdev = pdev;
+	gpio_dev->gc.get_direction	= amd_gpio_get_direction;
 	gpio_dev->gc.direction_input	= amd_gpio_direction_input;
 	gpio_dev->gc.direction_output	= amd_gpio_direction_output;
 	gpio_dev->gc.get			= amd_gpio_get_value;
-- 
2.16.1.291.g4437f3f132-goog
