Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbeBLIxx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:53:53 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41104 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933171AbeBLIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:53:22 -0500
X-Google-Smtp-Source: AH8x2277VFgHPb0nPJDjDrBkE6D2B1L1T0WltwG/UZTgxFrLMpiwv0f0VgmKoEW/HVMP2AFvq3a5bA==
From: Linus Walleij <linus.walleij@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mike Lockwood <lockwood@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] extcon: gpio: Move platform data into state container
Date: Mon, 12 Feb 2018 09:53:13 +0100
Message-Id: <20180212085314.23014-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212085314.23014-1-linus.walleij@linaro.org>
References: <20180212085314.23014-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the platform data settings from the platform data
struct and into the state container, saving some unnecessary
references and simplifying things a bit.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/extcon/extcon-gpio.c | 56 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
index 5f88f36cc54e..1d180f717fdf 100644
--- a/drivers/extcon/extcon-gpio.c
+++ b/drivers/extcon/extcon-gpio.c
@@ -29,7 +29,13 @@
 #include <linux/workqueue.h>
 
 /**
- * struct gpio_extcon_pdata - A simple GPIO-controlled extcon device.
+ * struct gpio_extcon_data - A simple GPIO-controlled extcon device state container.
+ * @edev:		Extcon device.
+ * @irq:		Interrupt line for the external connector.
+ * @work:		Work fired by the interrupt.
+ * @debounce_jiffies:	Number of jiffies to wait for the GPIO to stabilize, from the debounce
+ *			value.
+ * @id_gpiod:		GPIO descriptor for this external connector.
  * @extcon_id:		The unique id of specific external connector.
  * @gpio:		Corresponding GPIO.
  * @gpio_active_low:	Boolean describing whether gpio active state is 1 or 0
@@ -40,23 +46,18 @@
  * @check_on_resume:	Boolean describing whether to check the state of gpio
  *			while resuming from sleep.
  */
-struct gpio_extcon_pdata {
-	unsigned int extcon_id;
-	unsigned gpio;
-	bool gpio_active_low;
-	unsigned long debounce;
-	unsigned long irq_flags;
-	bool check_on_resume;
-};
-
 struct gpio_extcon_data {
 	struct extcon_dev *edev;
 	int irq;
 	struct delayed_work work;
 	unsigned long debounce_jiffies;
-
 	struct gpio_desc *id_gpiod;
-	struct gpio_extcon_pdata *pdata;
+	unsigned int extcon_id;
+	unsigned gpio;
+	bool gpio_active_low;
+	unsigned long debounce;
+	unsigned long irq_flags;
+	bool check_on_resume;
 };
 
 static void gpio_extcon_work(struct work_struct *work)
@@ -67,10 +68,10 @@ static void gpio_extcon_work(struct work_struct *work)
 			     work);
 
 	state = gpiod_get_value_cansleep(data->id_gpiod);
-	if (data->pdata->gpio_active_low)
+	if (data->gpio_active_low)
 		state = !state;
 
-	extcon_set_state_sync(data->edev, data->pdata->extcon_id, state);
+	extcon_set_state_sync(data->edev, data->extcon_id, state);
 }
 
 static irqreturn_t gpio_irq_handler(int irq, void *dev_id)
@@ -84,24 +85,23 @@ static irqreturn_t gpio_irq_handler(int irq, void *dev_id)
 
 static int gpio_extcon_init(struct device *dev, struct gpio_extcon_data *data)
 {
-	struct gpio_extcon_pdata *pdata = data->pdata;
 	int ret;
 
-	ret = devm_gpio_request_one(dev, pdata->gpio, GPIOF_DIR_IN,
+	ret = devm_gpio_request_one(dev, data->gpio, GPIOF_DIR_IN,
 				dev_name(dev));
 	if (ret < 0)
 		return ret;
 
-	data->id_gpiod = gpio_to_desc(pdata->gpio);
+	data->id_gpiod = gpio_to_desc(data->gpio);
 	if (!data->id_gpiod)
 		return -EINVAL;
 
-	if (pdata->debounce) {
+	if (data->debounce) {
 		ret = gpiod_set_debounce(data->id_gpiod,
-					pdata->debounce * 1000);
+					 data->debounce * 1000);
 		if (ret < 0)
 			data->debounce_jiffies =
-				msecs_to_jiffies(pdata->debounce);
+				msecs_to_jiffies(data->debounce);
 	}
 
 	data->irq = gpiod_to_irq(data->id_gpiod);
@@ -113,20 +113,16 @@ static int gpio_extcon_init(struct device *dev, struct gpio_extcon_data *data)
 
 static int gpio_extcon_probe(struct platform_device *pdev)
 {
-	struct gpio_extcon_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct gpio_extcon_data *data;
 	int ret;
 
-	if (!pdata)
-		return -EBUSY;
-	if (!pdata->irq_flags || pdata->extcon_id > EXTCON_NONE)
-		return -EINVAL;
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct gpio_extcon_data),
 				   GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	data->pdata = pdata;
+
+	if (!data->irq_flags || data->extcon_id > EXTCON_NONE)
+		return -EINVAL;
 
 	/* Initialize the gpio */
 	ret = gpio_extcon_init(&pdev->dev, data);
@@ -134,7 +130,7 @@ static int gpio_extcon_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Allocate the memory of extcon devie and register extcon device */
-	data->edev = devm_extcon_dev_allocate(&pdev->dev, &pdata->extcon_id);
+	data->edev = devm_extcon_dev_allocate(&pdev->dev, &data->extcon_id);
 	if (IS_ERR(data->edev)) {
 		dev_err(&pdev->dev, "failed to allocate extcon device\n");
 		return -ENOMEM;
@@ -151,7 +147,7 @@ static int gpio_extcon_probe(struct platform_device *pdev)
 	 * is attached or detached.
 	 */
 	ret = devm_request_any_context_irq(&pdev->dev, data->irq,
-					gpio_irq_handler, pdata->irq_flags,
+					gpio_irq_handler, data->irq_flags,
 					pdev->name, data);
 	if (ret < 0)
 		return ret;
@@ -178,7 +174,7 @@ static int gpio_extcon_resume(struct device *dev)
 	struct gpio_extcon_data *data;
 
 	data = dev_get_drvdata(dev);
-	if (data->pdata->check_on_resume)
+	if (data->check_on_resume)
 		queue_delayed_work(system_power_efficient_wq,
 			&data->work, data->debounce_jiffies);
 
-- 
2.14.3
