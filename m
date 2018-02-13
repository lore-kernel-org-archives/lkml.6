Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeBMGIV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:08:21 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:44962 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeBMGIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:08:20 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: Handle deferred probing in of_find_gpio() properly
Date: Tue, 13 Feb 2018 14:08:14 +0800
Message-Id: <20180213060814.18165-1-wens@csie.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_named_gpiod_flags() used directly in of_find_gpio() or indirectly
through of_find_spi_gpio() or of_find_regulator_gpio() can return
-EPROBE_DEFER. This gets overwritten by the subsequent of_find_*_gpio()
calls.

This patch fixes this by trying of_find_spi_gpio() or
of_find_regulator_gpio() only if deferred probing was not requested by
the previous of_get_named_gpiod_flags() call.

Fixes: 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO properties")
Fixes: c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Linus,

Fresh fix for 4.16. I'm probably not the only one finding devices using
gpios not working anymore. In my case it was pwrseq-mmc-simple probing
before pinctrl/gpio, not being able to get the gpio, and then just
consider the gpio missing instead of deferring. This in turn caused my
SDIO WiFi to not work.

---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 564bb7a31da4..edad176a210a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -246,11 +246,11 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	}
 
 	/* Special handling for SPI GPIOs if used */
-	if (IS_ERR(desc))
+	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
 		desc = of_find_spi_gpio(dev, con_id, &of_flags);
 
 	/* Special handling for regulator GPIOs if used */
-	if (IS_ERR(desc))
+	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
 		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
 
 	if (IS_ERR(desc))
-- 
2.16.1
