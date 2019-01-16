Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFFBC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4677820840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbfAPJcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:32:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51013 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403890AbfAPJcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:32:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 66E9F2078F; Wed, 16 Jan 2019 10:32:16 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 36D9920758;
        Wed, 16 Jan 2019 10:32:06 +0100 (CET)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2] gpio: pca953x: use a per instance irq_chip structure
Date:   Wed, 16 Jan 2019 10:31:58 +0100
Message-Id: <20190116093158.2850-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116093158.2850-1-thomas.petazzoni@bootlin.com>
References: <20190116093158.2850-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a system has two PCA953x GPIO expanders, the kernel complains with:

gpio gpiochip2: (0-0021): detected irqchip that is shared with multiple gpiochips: please fix the driver.

Indeed, there is a single instance of "struct irq_chip" that gets
re-used for both PCA953x instance. This commit moves the "struct
irq_chip" to be part of the "struct pca953x_chip", so that we have one
"struct irq_chip" per PCA953X instance.

As part of this, the name of the irq_chip is also made different on a
per-instance basis, now using the dev_name() of the I2C device. This
changes what is visible in /proc/interrupts.

Before:

 47:          0          0   pca953x  10 Edge      e0100000.sdhci cd
 48:          0          0   pca953x   6 Edge      e0101000.sdhci cd

After:

 47:          0          0    0-0020  10 Edge      e0100000.sdhci cd
 48:          2          0    0-0020   6 Edge      e0101000.sdhci cd

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/gpio/gpio-pca953x.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4f91ce497dd1..de52f63863db 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -150,6 +150,7 @@ struct pca953x_chip {
 	u8 irq_stat[MAX_BANK];
 	u8 irq_trig_raise[MAX_BANK];
 	u8 irq_trig_fall[MAX_BANK];
+	struct irq_chip irq_chip;
 #endif
 
 	struct i2c_client *client;
@@ -594,16 +595,6 @@ static void pca953x_irq_shutdown(struct irq_data *d)
 	chip->irq_trig_fall[d->hwirq / BANK_SZ] &= ~mask;
 }
 
-static struct irq_chip pca953x_irq_chip = {
-	.name			= "pca953x",
-	.irq_mask		= pca953x_irq_mask,
-	.irq_unmask		= pca953x_irq_unmask,
-	.irq_bus_lock		= pca953x_irq_bus_lock,
-	.irq_bus_sync_unlock	= pca953x_irq_bus_sync_unlock,
-	.irq_set_type		= pca953x_irq_set_type,
-	.irq_shutdown		= pca953x_irq_shutdown,
-};
-
 static bool pca953x_irq_pending(struct pca953x_chip *chip, u8 *pending)
 {
 	u8 cur_stat[MAX_BANK];
@@ -699,6 +690,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 			     int irq_base)
 {
 	struct i2c_client *client = chip->client;
+	struct irq_chip *irq_chip = &chip->irq_chip;
 	int reg_direction[MAX_BANK];
 	int ret, i;
 
@@ -737,7 +729,15 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 		return ret;
 	}
 
-	ret =  gpiochip_irqchip_add_nested(&chip->gpio_chip, &pca953x_irq_chip,
+	irq_chip->name = dev_name(&chip->client->dev);
+	irq_chip->irq_mask = pca953x_irq_mask;
+	irq_chip->irq_unmask = pca953x_irq_unmask;
+	irq_chip->irq_bus_lock = pca953x_irq_bus_lock;
+	irq_chip->irq_bus_sync_unlock = pca953x_irq_bus_sync_unlock;
+	irq_chip->irq_set_type = pca953x_irq_set_type;
+	irq_chip->irq_shutdown = pca953x_irq_shutdown;
+
+	ret =  gpiochip_irqchip_add_nested(&chip->gpio_chip, irq_chip,
 					   irq_base, handle_simple_irq,
 					   IRQ_TYPE_NONE);
 	if (ret) {
@@ -746,8 +746,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 		return ret;
 	}
 
-	gpiochip_set_nested_irqchip(&chip->gpio_chip, &pca953x_irq_chip,
-				    client->irq);
+	gpiochip_set_nested_irqchip(&chip->gpio_chip, irq_chip, client->irq);
 
 	return 0;
 }
-- 
2.20.1

