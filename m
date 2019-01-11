Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F630C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE13D2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbfAKPRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:17:00 -0500
Received: from smtp1.goneo.de ([85.220.129.30]:47332 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbfAKPQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:16:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 62BB223F4D5;
        Fri, 11 Jan 2019 16:16:55 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mjhIMb_oz8za; Fri, 11 Jan 2019 16:16:54 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 4AF0523F0D5;
        Fri, 11 Jan 2019 16:16:54 +0100 (CET)
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] pinctrl: mcp23s08: Allocate irq_chip dynamic
Date:   Fri, 11 Jan 2019 17:25:16 +0100
Message-Id: <20190111162516.28197-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the irq_chip definition static shares it with multiple instances
of the mcp23s08 gpiochip in the system. This is bad and now we get this
warning from gpiolib core:

"detected irqchip that is shared with multiple gpiochips: please fix the
driver."

Hence, move the irq_chip definition from being driver static into the
struct mcp23s08. So a unique irq_chip is used for each gpiochip
instance.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index b03481ef99a1..3b1785e56174 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -68,6 +68,7 @@ struct mcp23s08 {
 	struct mutex		lock;
 
 	struct gpio_chip	chip;
+	struct irq_chip		irq_chip;
 
 	struct regmap		*regmap;
 	struct device		*dev;
@@ -607,15 +608,6 @@ static void mcp23s08_irq_bus_unlock(struct irq_data *data)
 	mutex_unlock(&mcp->lock);
 }
 
-static struct irq_chip mcp23s08_irq_chip = {
-	.name = "gpio-mcp23xxx",
-	.irq_mask = mcp23s08_irq_mask,
-	.irq_unmask = mcp23s08_irq_unmask,
-	.irq_set_type = mcp23s08_irq_set_type,
-	.irq_bus_lock = mcp23s08_irq_bus_lock,
-	.irq_bus_sync_unlock = mcp23s08_irq_bus_unlock,
-};
-
 static int mcp23s08_irq_setup(struct mcp23s08 *mcp)
 {
 	struct gpio_chip *chip = &mcp->chip;
@@ -645,7 +637,7 @@ static int mcp23s08_irqchip_setup(struct mcp23s08 *mcp)
 	int err;
 
 	err =  gpiochip_irqchip_add_nested(chip,
-					   &mcp23s08_irq_chip,
+					   &mcp->irq_chip,
 					   0,
 					   handle_simple_irq,
 					   IRQ_TYPE_NONE);
@@ -656,7 +648,7 @@ static int mcp23s08_irqchip_setup(struct mcp23s08 *mcp)
 	}
 
 	gpiochip_set_nested_irqchip(chip,
-				    &mcp23s08_irq_chip,
+				    &mcp->irq_chip,
 				    mcp->irq);
 
 	return 0;
@@ -1042,6 +1034,13 @@ static int mcp230xx_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	mcp->irq = client->irq;
+	mcp->irq_chip.name = dev_name(&client->dev);
+	mcp->irq_chip.irq_mask = mcp23s08_irq_mask;
+	mcp->irq_chip.irq_unmask = mcp23s08_irq_unmask;
+	mcp->irq_chip.irq_set_type = mcp23s08_irq_set_type;
+	mcp->irq_chip.irq_bus_lock = mcp23s08_irq_bus_lock;
+	mcp->irq_chip.irq_bus_sync_unlock = mcp23s08_irq_bus_unlock;
+
 	status = mcp23s08_probe_one(mcp, &client->dev, client, client->addr,
 				    id->driver_data, pdata->base, 0);
 	if (status)
@@ -1152,6 +1151,13 @@ static int mcp23s08_probe(struct spi_device *spi)
 		chips--;
 		data->mcp[addr] = &data->chip[chips];
 		data->mcp[addr]->irq = spi->irq;
+		data->mcp[addr]->irq_chip.name = dev_name(&spi->dev);
+		data->mcp[addr]->irq_chip.irq_mask = mcp23s08_irq_mask;
+		data->mcp[addr]->irq_chip.irq_unmask = mcp23s08_irq_unmask;
+		data->mcp[addr]->irq_chip.irq_set_type = mcp23s08_irq_set_type;
+		data->mcp[addr]->irq_chip.irq_bus_lock = mcp23s08_irq_bus_lock;
+		data->mcp[addr]->irq_chip.irq_bus_sync_unlock =
+			mcp23s08_irq_bus_unlock;
 		status = mcp23s08_probe_one(data->mcp[addr], &spi->dev, spi,
 					    0x40 | (addr << 1), type,
 					    pdata->base, addr);
-- 
2.20.1

