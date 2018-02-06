Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeBFHdI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:33:08 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:45304 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:32:58 -0500
X-IronPort-AV: E=Sophos;i="5.44,434,1505804400";
   d="scan'208";a="8520094"
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <b.zolnierkie@samsung.com>, <andy.shevchenko@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH V2] video: fbdev: atmel_lcdfb: convert to use GPIO descriptors
Date: Tue, 6 Feb 2018 08:31:22 +0100
Message-ID: <20180206073122.3618-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GPIO descriptors instead of relying on the old method.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes
- V2:
  - remove of_gpio.h.
  - move gpiod declaration to preserve reversed tree style.
  - use devm_gpiod_get_index instead of devm_gpiod_get_index_optional
  since all errors are treated in the same way.

 drivers/video/fbdev/atmel_lcdfb.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 3dee267d7c75..076d24afbd72 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -18,10 +18,10 @@
 #include <linux/delay.h>
 #include <linux/backlight.h>
 #include <linux/gfp.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <video/of_display_timing.h>
 #include <linux/regulator/consumer.h>
 #include <video/videomode.h>
@@ -61,8 +61,7 @@ struct atmel_lcdfb_info {
 };
 
 struct atmel_lcdfb_power_ctrl_gpio {
-	int gpio;
-	int active_low;
+	struct gpio_desc *gpiod;
 
 	struct list_head list;
 };
@@ -1018,7 +1017,7 @@ static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pdata, int
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 
 	list_for_each_entry(og, &pdata->pwr_gpios, list)
-		gpio_set_value(og->gpio, on);
+		gpiod_set_value(og->gpiod, on);
 }
 
 static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
@@ -1031,11 +1030,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct device_node *display_np;
 	struct device_node *timings_np;
 	struct display_timings *timings;
-	enum of_gpio_flags flags;
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 	bool is_gpio_power = false;
+	struct gpio_desc *gpiod;
 	int ret = -ENOENT;
-	int i, gpio;
+	int i;
 
 	sinfo->config = (struct atmel_lcdfb_config*)
 		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
@@ -1072,28 +1071,22 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 
 	INIT_LIST_HEAD(&pdata->pwr_gpios);
 	ret = -ENOMEM;
-	for (i = 0; i < of_gpio_named_count(display_np, "atmel,power-control-gpio"); i++) {
-		gpio = of_get_named_gpio_flags(display_np, "atmel,power-control-gpio",
-					       i, &flags);
-		if (gpio < 0)
+	for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
+		gpiod = devm_gpiod_get_index(dev, "atmel,power-control",
+					     i, GPIOD_ASIS);
+		if (IS_ERR(gpiod))
 			continue;
 
 		og = devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
 		if (!og)
 			goto put_display_node;
 
-		og->gpio = gpio;
-		og->active_low = flags & OF_GPIO_ACTIVE_LOW;
+		og->gpiod = gpiod;
 		is_gpio_power = true;
-		ret = devm_gpio_request(dev, gpio, "lcd-power-control-gpio");
-		if (ret) {
-			dev_err(dev, "request gpio %d failed\n", gpio);
-			goto put_display_node;
-		}
 
-		ret = gpio_direction_output(gpio, og->active_low);
+		ret = gpiod_direction_output(gpiod, gpiod_is_active_low(gpiod));
 		if (ret) {
-			dev_err(dev, "set direction output gpio %d failed\n", gpio);
+			dev_err(dev, "set direction output gpio atmel,power-control[%d] failed\n", i);
 			goto put_display_node;
 		}
 		list_add(&og->list, &pdata->pwr_gpios);
-- 
2.12.2
