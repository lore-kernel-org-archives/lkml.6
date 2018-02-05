Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeBEItl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:49:41 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24923 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeBEIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:49:34 -0500
X-IronPort-AV: E=Sophos;i="5.44,434,1505804400";
   d="scan'208";a="8484705"
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <b.zolnierkie@samsung.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO descriptors
Date: Mon, 5 Feb 2018 09:47:55 +0100
Message-ID: <20180205084755.6011-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GPIO descriptors instead of relying on the old method.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 3dee267d7c75..ef3d4198014f 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/backlight.h>
 #include <linux/gfp.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -61,8 +62,7 @@ struct atmel_lcdfb_info {
 };
 
 struct atmel_lcdfb_power_ctrl_gpio {
-	int gpio;
-	int active_low;
+	struct gpio_desc *gpiod;
 
 	struct list_head list;
 };
@@ -1018,7 +1018,7 @@ static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pdata, int
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 
 	list_for_each_entry(og, &pdata->pwr_gpios, list)
-		gpio_set_value(og->gpio, on);
+		gpiod_set_value(og->gpiod, on);
 }
 
 static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
@@ -1031,11 +1031,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct device_node *display_np;
 	struct device_node *timings_np;
 	struct display_timings *timings;
-	enum of_gpio_flags flags;
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 	bool is_gpio_power = false;
 	int ret = -ENOENT;
-	int i, gpio;
+	int i;
+	struct gpio_desc *gpiod;
 
 	sinfo->config = (struct atmel_lcdfb_config*)
 		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
@@ -1072,28 +1072,22 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 
 	INIT_LIST_HEAD(&pdata->pwr_gpios);
 	ret = -ENOMEM;
-	for (i = 0; i < of_gpio_named_count(display_np, "atmel,power-control-gpio"); i++) {
-		gpio = of_get_named_gpio_flags(display_np, "atmel,power-control-gpio",
-					       i, &flags);
-		if (gpio < 0)
+	for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
+		gpiod = devm_gpiod_get_index_optional(dev,
+				"atmel,power-control", i, GPIOD_ASIS);
+		if (!gpiod)
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
