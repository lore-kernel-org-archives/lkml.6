Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4657420866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbfAPJcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:32:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51008 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403878AbfAPJcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:32:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 175D6207A3; Wed, 16 Jan 2019 10:32:16 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id D7E75206A6;
        Wed, 16 Jan 2019 10:32:05 +0100 (CET)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/2] gpio: pca953x: reduce indentation level in pca953x_irq_setup()
Date:   Wed, 16 Jan 2019 10:31:57 +0100
Message-Id: <20190116093158.2850-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current design of pca953x_irq_setup() is:

 if (all conditions to support IRQ are met) {
   lots of code to support IRQs, which goes to a serious indentation
   level.
 }

 return 0;

It makes more sense to handle this like this:

 if (!all conditions to support IRQ are met)
   return 0;

 handle IRQ support

This commit does just this change, reducing by one tab the indentation
level of the IRQ setup code. Thanks to this reduced indentation level,
we are less restricted by the 80-column limit, and we can have more
function arguments on the same line.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/gpio/gpio-pca953x.c | 84 ++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 0dc96419efe3..4f91ce497dd1 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -702,53 +702,53 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 	int reg_direction[MAX_BANK];
 	int ret, i;
 
-	if (client->irq && irq_base != -1
-			&& (chip->driver_data & PCA_INT)) {
-		ret = pca953x_read_regs(chip,
-					chip->regs->input, chip->irq_stat);
-		if (ret)
-			return ret;
+	if (!client->irq)
+		return 0;
 
-		/*
-		 * There is no way to know which GPIO line generated the
-		 * interrupt.  We have to rely on the previous read for
-		 * this purpose.
-		 */
-		regmap_bulk_read(chip->regmap, chip->regs->direction,
-				 reg_direction, NBANK(chip));
-		for (i = 0; i < NBANK(chip); i++)
-			chip->irq_stat[i] &= reg_direction[i];
-		mutex_init(&chip->irq_lock);
-
-		ret = devm_request_threaded_irq(&client->dev,
-					client->irq,
-					   NULL,
-					   pca953x_irq_handler,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
-						   IRQF_SHARED,
-					   dev_name(&client->dev), chip);
-		if (ret) {
-			dev_err(&client->dev, "failed to request irq %d\n",
-				client->irq);
-			return ret;
-		}
+	if (irq_base == -1)
+		return 0;
 
-		ret =  gpiochip_irqchip_add_nested(&chip->gpio_chip,
-						   &pca953x_irq_chip,
-						   irq_base,
-						   handle_simple_irq,
-						   IRQ_TYPE_NONE);
-		if (ret) {
-			dev_err(&client->dev,
-				"could not connect irqchip to gpiochip\n");
-			return ret;
-		}
+	if (!(chip->driver_data & PCA_INT))
+		return 0;
 
-		gpiochip_set_nested_irqchip(&chip->gpio_chip,
-					    &pca953x_irq_chip,
-					    client->irq);
+	ret = pca953x_read_regs(chip, chip->regs->input, chip->irq_stat);
+	if (ret)
+		return ret;
+
+	/*
+	 * There is no way to know which GPIO line generated the
+	 * interrupt.  We have to rely on the previous read for
+	 * this purpose.
+	 */
+	regmap_bulk_read(chip->regmap, chip->regs->direction, reg_direction,
+			 NBANK(chip));
+	for (i = 0; i < NBANK(chip); i++)
+		chip->irq_stat[i] &= reg_direction[i];
+	mutex_init(&chip->irq_lock);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, pca953x_irq_handler,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT |
+					IRQF_SHARED,
+					dev_name(&client->dev), chip);
+	if (ret) {
+		dev_err(&client->dev, "failed to request irq %d\n",
+			client->irq);
+		return ret;
+	}
+
+	ret =  gpiochip_irqchip_add_nested(&chip->gpio_chip, &pca953x_irq_chip,
+					   irq_base, handle_simple_irq,
+					   IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(&client->dev,
+			"could not connect irqchip to gpiochip\n");
+		return ret;
 	}
 
+	gpiochip_set_nested_irqchip(&chip->gpio_chip, &pca953x_irq_chip,
+				    client->irq);
+
 	return 0;
 }
 
-- 
2.20.1

