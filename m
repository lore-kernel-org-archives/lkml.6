Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeCWQfD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:35:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45541 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeCWQe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:34:58 -0400
X-Google-Smtp-Source: AG47ELskd6GPdfVEai96i1NCFmZKy0XqNCO1P8XlWuxYakj7ELOBtjBkFhje14MzbOEwrrSBagHUCQ==
From: Stephen Boyd <swboyd@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/5] gpiolib: Extract mask allocation into subroutine
Date: Fri, 23 Mar 2018 09:34:50 -0700
Message-Id: <20180323163453.96495-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to use similar code to allocate and set all the bits in a
mask for valid gpios to use. Extract the code from the irqchip version
so it can be reused.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d66de67ef307..cc0e1519da45 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -337,6 +337,20 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 	return 0;
 }
 
+static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
+{
+	unsigned long *p;
+
+	p = kcalloc(BITS_TO_LONGS(chip->ngpio), sizeof(long), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	/* Assume by default all GPIOs are valid */
+	bitmap_fill(p, chip->ngpio);
+
+	return p;
+}
+
 /*
  * GPIO line handle management
  */
@@ -1506,14 +1520,10 @@ static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gpiochip)
 	if (!gpiochip->irq.need_valid_mask)
 		return 0;
 
-	gpiochip->irq.valid_mask = kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
-					   sizeof(long), GFP_KERNEL);
+	gpiochip->irq.valid_mask = gpiochip_allocate_mask(gpiochip);
 	if (!gpiochip->irq.valid_mask)
 		return -ENOMEM;
 
-	/* Assume by default all GPIOs are valid */
-	bitmap_fill(gpiochip->irq.valid_mask, gpiochip->ngpio);
-
 	return 0;
 }
 
-- 
Sent by a computer through tubes
