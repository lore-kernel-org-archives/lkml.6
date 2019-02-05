Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25740C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F03217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfBEPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:24:49 -0500
Received: from mail.steuer-voss.de ([85.183.69.95]:60574 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfBEPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:24:48 -0500
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id D90784BBDF; Tue,  5 Feb 2019 16:17:02 +0100 (CET)
Message-Id: <3230ace6f820fccadb51097ae9ba9f5ee247d79b.1549379326.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
References: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nv@vosn.de>
To:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Tue, 5 Feb 2019 14:31:11 +0100
Subject: [PATCH 2/2] drivers/gpio/gpio-adp5588.c: switch to events system
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interupts were generated using GPIN interrupts of
ADP5588. These interrupts have two important limitations:
1. Interrupts can only be generated for either rising or
   falling edges but not both.
2. Interrupts are reasserted as long as the interrupt condition
   persists (i.e. high or low level on that GPIN). This generates
   lots of interrupts unless the event is very short.

To overcome this, ADP5588 provides an event system which queues
up to 10 events in a buffer. GPIN events are queued whenever the
GPIN is asserted or deasserted. This makes it possible to support
generating GPIN interrupts for both edges and to generate only one
interrupt per state change.
Thus it is possible to chain the gpio-keys driver for some GPIOs.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/gpio/gpio-adp5588.c | 85 ++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 53 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 0a8cfccba818..6583a3787035 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -36,12 +36,11 @@ struct adp5588_gpio {
 	struct mutex irq_lock;
 	uint8_t dat_out[3];
 	uint8_t dir[3];
-	uint8_t int_lvl[3];
+	uint8_t int_lvl_low[3];
+	uint8_t int_lvl_high[3];
 	uint8_t int_en[3];
 	uint8_t irq_mask[3];
-	uint8_t irq_stat[3];
 	uint8_t int_input_en[3];
-	uint8_t int_lvl_cached[3];
 };
 
 static int adp5588_gpio_read(struct i2c_client *client, u8 reg)
@@ -180,15 +179,9 @@ static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
 			mutex_unlock(&dev->lock);
 		}
 
-		if (dev->int_lvl_cached[i] != dev->int_lvl[i]) {
-			dev->int_lvl_cached[i] = dev->int_lvl[i];
-			adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + i,
-					   dev->int_lvl[i]);
-		}
-
 		if (dev->int_en[i] ^ dev->irq_mask[i]) {
 			dev->int_en[i] = dev->irq_mask[i];
-			adp5588_gpio_write(dev->client, GPIO_INT_EN1 + i,
+			adp5588_gpio_write(dev->client, GPI_EM1 + i,
 					   dev->int_en[i]);
 		}
 	}
@@ -219,21 +212,17 @@ static int adp5588_irq_set_type(struct irq_data *d, unsigned int type)
 	uint16_t gpio = d->hwirq;
 	unsigned bank, bit;
 
-	if ((type & IRQ_TYPE_EDGE_BOTH)) {
-		dev_err(&dev->client->dev, "irq %d: unsupported type %d\n",
-			d->irq, type);
-		return -EINVAL;
-	}
-
 	bank = ADP5588_BANK(gpio);
 	bit = ADP5588_BIT(gpio);
 
-	if (type & IRQ_TYPE_LEVEL_HIGH)
-		dev->int_lvl[bank] |= bit;
-	else if (type & IRQ_TYPE_LEVEL_LOW)
-		dev->int_lvl[bank] &= ~bit;
-	else
-		return -EINVAL;
+	dev->int_lvl_low[bank] &= ~bit;
+	dev->int_lvl_high[bank] &= ~bit;
+
+	if (type & IRQ_TYPE_EDGE_BOTH || type & IRQ_TYPE_LEVEL_HIGH)
+		dev->int_lvl_high[bank] |= bit;
+
+	if (type & IRQ_TYPE_EDGE_BOTH || type & IRQ_TYPE_LEVEL_LOW)
+		dev->int_lvl_low[bank] |= bit;
 
 	dev->int_input_en[bank] |= bit;
 
@@ -249,41 +238,32 @@ static struct irq_chip adp5588_irq_chip = {
 	.irq_set_type		= adp5588_irq_set_type,
 };
 
-static int adp5588_gpio_read_intstat(struct i2c_client *client, u8 *buf)
-{
-	int ret = i2c_smbus_read_i2c_block_data(client, GPIO_INT_STAT1, 3, buf);
-
-	if (ret < 0)
-		dev_err(&client->dev, "Read INT_STAT Error\n");
-
-	return ret;
-}
-
 static irqreturn_t adp5588_irq_handler(int irq, void *devid)
 {
 	struct adp5588_gpio *dev = devid;
-	unsigned status, bank, bit, pending;
-	int ret;
-	status = adp5588_gpio_read(dev->client, INT_STAT);
+	int status = adp5588_gpio_read(dev->client, INT_STAT);
 
-	if (status & ADP5588_GPI_INT) {
-		ret = adp5588_gpio_read_intstat(dev->client, dev->irq_stat);
-		if (ret < 0)
-			memset(dev->irq_stat, 0, ARRAY_SIZE(dev->irq_stat));
+	if (status & ADP5588_KE_INT) {
+		int ev_cnt = adp5588_gpio_read(dev->client, KEY_LCK_EC_STAT);
 
-		for (bank = 0, bit = 0; bank <= ADP5588_BANK(ADP5588_MAXGPIO);
-			bank++, bit = 0) {
-			pending = dev->irq_stat[bank] & dev->irq_mask[bank];
+		if (ev_cnt > 0) {
+			int i;
 
-			while (pending) {
-				if (pending & (1 << bit)) {
-					handle_nested_irq(
-						irq_find_mapping(
-						   dev->gpio_chip.irq.domain,
-						   (bank << 3) + bit));
-					pending &= ~(1 << bit);
-				}
-				bit++;
+			for (i = 0; i < (ev_cnt & ADP5588_KEC); i++) {
+				int key = adp5588_gpio_read(dev->client,
+							    Key_EVENTA + i);
+				/* GPIN events begin at 97,
+				 * bit 7 indicates logic level
+				 */
+				int gpio = (key & 0x7f) - 97;
+				int lvl = key & (1 << 7);
+				int bank = ADP5588_BANK(gpio);
+				int bit = ADP5588_BIT(gpio);
+
+				if ((lvl && dev->int_lvl_high[bank] & bit) ||
+				    (!lvl && dev->int_lvl_low[bank] & bit))
+					handle_nested_irq(irq_find_mapping(
+					      dev->gpio_chip.irq.domain, gpio));
 			}
 		}
 	}
@@ -303,7 +283,6 @@ static int adp5588_irq_setup(struct adp5588_gpio *dev)
 
 	adp5588_gpio_write(client, CFG, ADP5588_AUTO_INC);
 	adp5588_gpio_write(client, INT_STAT, -1); /* status is W1C */
-	adp5588_gpio_read_intstat(client, dev->irq_stat); /* read to clear */
 
 	mutex_init(&dev->irq_lock);
 
@@ -330,7 +309,7 @@ static int adp5588_irq_setup(struct adp5588_gpio *dev)
 				    client->irq);
 
 	adp5588_gpio_write(client, CFG,
-		ADP5588_AUTO_INC | ADP5588_INT_CFG | ADP5588_GPI_INT);
+		ADP5588_AUTO_INC | ADP5588_INT_CFG | ADP5588_KE_IEN);
 
 	return 0;
 }
-- 
2.17.1

