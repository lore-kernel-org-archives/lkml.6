Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34D3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9562083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfBEPYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:24:48 -0500
Received: from mail.steuer-voss.de ([85.183.69.95]:60572 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfBEPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:24:48 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 10:24:47 EST
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id BBD9D4CF0C; Tue,  5 Feb 2019 16:17:02 +0100 (CET)
Message-Id: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nv@vosn.de>
To:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Wed, 25 Jul 2018 10:43:57 +0200
Subject: [PATCH 1/2] drivers/gpio/gpio-adp5588.c: add device tree support
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make platform data optional and add DT id table.
Switch to dynamically mapped GPIOs and IRQs if not provided
via platform data.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/gpio/gpio-adp5588.c | 151 ++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 83 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index da9781a2ef4a..0a8cfccba818 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of_device.h>
 
 #include <linux/platform_data/adp5588.h>
 
@@ -33,8 +34,6 @@ struct adp5588_gpio {
 	struct mutex lock;	/* protect cached dir, dat_out */
 	/* protect serialized access to the interrupt controller bus */
 	struct mutex irq_lock;
-	unsigned gpio_start;
-	unsigned irq_base;
 	uint8_t dat_out[3];
 	uint8_t dir[3];
 	uint8_t int_lvl[3];
@@ -148,16 +147,11 @@ static int adp5588_gpio_direction_output(struct gpio_chip *chip,
 }
 
 #ifdef CONFIG_GPIO_ADP5588_IRQ
-static int adp5588_gpio_to_irq(struct gpio_chip *chip, unsigned off)
-{
-	struct adp5588_gpio *dev = gpiochip_get_data(chip);
-
-	return dev->irq_base + off;
-}
 
 static void adp5588_irq_bus_lock(struct irq_data *d)
 {
-	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_gpio *dev = gpiochip_get_data(gc);
 
 	mutex_lock(&dev->irq_lock);
 }
@@ -172,7 +166,8 @@ static void adp5588_irq_bus_lock(struct irq_data *d)
 
 static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
 {
-	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_gpio *dev = gpiochip_get_data(gc);
 	int i;
 
 	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
@@ -203,24 +198,25 @@ static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
 
 static void adp5588_irq_mask(struct irq_data *d)
 {
-	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
-	unsigned gpio = d->irq - dev->irq_base;
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_gpio *dev = gpiochip_get_data(gc);
 
-	dev->irq_mask[ADP5588_BANK(gpio)] &= ~ADP5588_BIT(gpio);
+	dev->irq_mask[ADP5588_BANK(d->hwirq)] &= ~ADP5588_BIT(d->hwirq);
 }
 
 static void adp5588_irq_unmask(struct irq_data *d)
 {
-	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
-	unsigned gpio = d->irq - dev->irq_base;
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_gpio *dev = gpiochip_get_data(gc);
 
-	dev->irq_mask[ADP5588_BANK(gpio)] |= ADP5588_BIT(gpio);
+	dev->irq_mask[ADP5588_BANK(d->hwirq)] |= ADP5588_BIT(d->hwirq);
 }
 
 static int adp5588_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
-	uint16_t gpio = d->irq - dev->irq_base;
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_gpio *dev = gpiochip_get_data(gc);
+	uint16_t gpio = d->hwirq;
 	unsigned bank, bit;
 
 	if ((type & IRQ_TYPE_EDGE_BOTH)) {
@@ -281,10 +277,11 @@ static irqreturn_t adp5588_irq_handler(int irq, void *devid)
 
 			while (pending) {
 				if (pending & (1 << bit)) {
-					handle_nested_irq(dev->irq_base +
-							  (bank << 3) + bit);
+					handle_nested_irq(
+						irq_find_mapping(
+						   dev->gpio_chip.irq.domain,
+						   (bank << 3) + bit));
 					pending &= ~(1 << bit);
-
 				}
 				bit++;
 			}
@@ -299,53 +296,43 @@ static irqreturn_t adp5588_irq_handler(int irq, void *devid)
 static int adp5588_irq_setup(struct adp5588_gpio *dev)
 {
 	struct i2c_client *client = dev->client;
+	int ret;
 	struct adp5588_gpio_platform_data *pdata =
 			dev_get_platdata(&client->dev);
-	unsigned gpio;
-	int ret;
+	int irq_base = pdata ? pdata->irq_base : 0;
 
 	adp5588_gpio_write(client, CFG, ADP5588_AUTO_INC);
 	adp5588_gpio_write(client, INT_STAT, -1); /* status is W1C */
 	adp5588_gpio_read_intstat(client, dev->irq_stat); /* read to clear */
 
-	dev->irq_base = pdata->irq_base;
 	mutex_init(&dev->irq_lock);
 
-	for (gpio = 0; gpio < dev->gpio_chip.ngpio; gpio++) {
-		int irq = gpio + dev->irq_base;
-		irq_set_chip_data(irq, dev);
-		irq_set_chip_and_handler(irq, &adp5588_irq_chip,
-					 handle_level_irq);
-		irq_set_nested_thread(irq, 1);
-		irq_modify_status(irq, IRQ_NOREQUEST, IRQ_NOPROBE);
-	}
-
-	ret = request_threaded_irq(client->irq,
-				   NULL,
-				   adp5588_irq_handler,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   dev_name(&client->dev), dev);
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, adp5588_irq_handler, IRQF_ONESHOT
+					| IRQF_TRIGGER_FALLING | IRQF_SHARED,
+					dev_name(&client->dev), dev);
 	if (ret) {
 		dev_err(&client->dev, "failed to request irq %d\n",
 			client->irq);
-		goto out;
+		return ret;
 	}
+	ret = gpiochip_irqchip_add_nested(&dev->gpio_chip,
+					  &adp5588_irq_chip, irq_base,
+					  handle_simple_irq,
+					  IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(&client->dev,
+			"could not connect irqchip to gpiochip\n");
+		return ret;
+	}
+	gpiochip_set_nested_irqchip(&dev->gpio_chip,
+				    &adp5588_irq_chip,
+				    client->irq);
 
-	dev->gpio_chip.to_irq = adp5588_gpio_to_irq;
 	adp5588_gpio_write(client, CFG,
 		ADP5588_AUTO_INC | ADP5588_INT_CFG | ADP5588_GPI_INT);
 
 	return 0;
-
-out:
-	dev->irq_base = 0;
-	return ret;
-}
-
-static void adp5588_irq_teardown(struct adp5588_gpio *dev)
-{
-	if (dev->irq_base)
-		free_irq(dev->client->irq, dev);
 }
 
 #else
@@ -357,24 +344,16 @@ static int adp5588_irq_setup(struct adp5588_gpio *dev)
 	return 0;
 }
 
-static void adp5588_irq_teardown(struct adp5588_gpio *dev)
-{
-}
 #endif /* CONFIG_GPIO_ADP5588_IRQ */
 
-static int adp5588_gpio_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
+static int adp5588_gpio_probe(struct i2c_client *client)
 {
 	struct adp5588_gpio_platform_data *pdata =
 			dev_get_platdata(&client->dev);
 	struct adp5588_gpio *dev;
 	struct gpio_chip *gc;
 	int ret, i, revid;
-
-	if (!pdata) {
-		dev_err(&client->dev, "missing platform data\n");
-		return -ENODEV;
-	}
+	unsigned int pullup_dis_mask = 0;
 
 	if (!i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -394,18 +373,24 @@ static int adp5588_gpio_probe(struct i2c_client *client,
 	gc->get = adp5588_gpio_get_value;
 	gc->set = adp5588_gpio_set_value;
 	gc->can_sleep = true;
+	gc->base = -1;
+	gc->parent = &client->dev;
+
+	if (pdata) {
+		gc->base = pdata->gpio_start;
+		gc->names = pdata->names;
+		pullup_dis_mask = pdata->pullup_dis_mask;
+	}
 
-	gc->base = pdata->gpio_start;
 	gc->ngpio = ADP5588_MAXGPIO;
 	gc->label = client->name;
 	gc->owner = THIS_MODULE;
-	gc->names = pdata->names;
 
 	mutex_init(&dev->lock);
 
 	ret = adp5588_gpio_read(dev->client, DEV_ID);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	revid = ret & ADP5588_DEVICE_ID_MASK;
 
@@ -414,30 +399,27 @@ static int adp5588_gpio_probe(struct i2c_client *client,
 		dev->dir[i] = adp5588_gpio_read(client, GPIO_DIR1 + i);
 		ret |= adp5588_gpio_write(client, KP_GPIO1 + i, 0);
 		ret |= adp5588_gpio_write(client, GPIO_PULL1 + i,
-				(pdata->pullup_dis_mask >> (8 * i)) & 0xFF);
+				(pullup_dis_mask >> (8 * i)) & 0xFF);
 		ret |= adp5588_gpio_write(client, GPIO_INT_EN1 + i, 0);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
-	if (pdata->irq_base) {
+	if (client->irq) {
 		if (WA_DELAYED_READOUT_REVID(revid)) {
 			dev_warn(&client->dev, "GPIO int not supported\n");
 		} else {
 			ret = adp5588_irq_setup(dev);
 			if (ret)
-				goto err;
+				return ret;
 		}
 	}
 
 	ret = devm_gpiochip_add_data(&client->dev, &dev->gpio_chip, dev);
 	if (ret)
-		goto err_irq;
+		return ret;
 
-	dev_info(&client->dev, "IRQ Base: %d Rev.: %d\n",
-			pdata->irq_base, revid);
-
-	if (pdata->setup) {
+	if (pdata && pdata->setup) {
 		ret = pdata->setup(client, gc->base, gc->ngpio, pdata->context);
 		if (ret < 0)
 			dev_warn(&client->dev, "setup failed, %d\n", ret);
@@ -446,11 +428,6 @@ static int adp5588_gpio_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, dev);
 
 	return 0;
-
-err_irq:
-	adp5588_irq_teardown(dev);
-err:
-	return ret;
 }
 
 static int adp5588_gpio_remove(struct i2c_client *client)
@@ -460,7 +437,7 @@ static int adp5588_gpio_remove(struct i2c_client *client)
 	struct adp5588_gpio *dev = i2c_get_clientdata(client);
 	int ret;
 
-	if (pdata->teardown) {
+	if (pdata && pdata->teardown) {
 		ret = pdata->teardown(client,
 				      dev->gpio_chip.base, dev->gpio_chip.ngpio,
 				      pdata->context);
@@ -470,7 +447,7 @@ static int adp5588_gpio_remove(struct i2c_client *client)
 		}
 	}
 
-	if (dev->irq_base)
+	if (dev->client->irq)
 		free_irq(dev->client->irq, dev);
 
 	return 0;
@@ -480,14 +457,22 @@ static const struct i2c_device_id adp5588_gpio_id[] = {
 	{DRV_NAME, 0},
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, adp5588_gpio_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id adp5588_gpio_of_id[] = {
+	{ .compatible = "adi," DRV_NAME, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, adp5588_gpio_of_id);
+#endif
+
 static struct i2c_driver adp5588_gpio_driver = {
 	.driver = {
-		   .name = DRV_NAME,
-		   },
-	.probe = adp5588_gpio_probe,
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(adp5588_gpio_of_id),
+	},
+	.probe_new = adp5588_gpio_probe,
 	.remove = adp5588_gpio_remove,
 	.id_table = adp5588_gpio_id,
 };
-- 
2.17.1

