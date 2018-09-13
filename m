Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A2C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2CA20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2CA20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIMRzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:55:23 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46906 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:55:23 -0400
X-IronPort-AV: E=Sophos;i="5.53,369,1531810800"; 
   d="scan'208";a="20621715"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Sep 2018 05:46:04 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Thu, 13 Sep 2018
 05:46:03 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <plagnioj@jcrosoft.com>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <hverkuil@xs4all.nl>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] pinctrl: at91: don't use the same irqchip with multiple gpiochips
Date:   Thu, 13 Sep 2018 14:42:13 +0200
Message-ID: <20180913124213.32065-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharing the same irqchip with multiple gpiochips is not a good
practice. For instance, when installing hooks, we change the state
of the irqchip. The initial state of the irqchip for the second
gpiochip to register is then disrupted.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
Hi,

This patch fixes the issue encountered in linux-next because of
"gpiolib: override irq_enable/disable". As discussed [1], the gpiolib
can do some extra checks but sharing the same irqchip with multiple
gpiochips is seen as a bad practice.

[1] https://www.spinics.net/lists/arm-kernel/msg676097.html

 drivers/pinctrl/pinctrl-at91.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index cfd8239f2727..911ea0fe2a41 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1574,16 +1574,6 @@ void at91_pinctrl_gpio_resume(void)
 #define gpio_irq_set_wake	NULL
 #endif /* CONFIG_PM */
 
-static struct irq_chip gpio_irqchip = {
-	.name		= "GPIO",
-	.irq_ack	= gpio_irq_ack,
-	.irq_disable	= gpio_irq_mask,
-	.irq_mask	= gpio_irq_mask,
-	.irq_unmask	= gpio_irq_unmask,
-	/* .irq_set_type is set dynamically */
-	.irq_set_wake	= gpio_irq_set_wake,
-};
-
 static void gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -1624,12 +1614,22 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	struct gpio_chip	*gpiochip_prev = NULL;
 	struct at91_gpio_chip   *prev = NULL;
 	struct irq_data		*d = irq_get_irq_data(at91_gpio->pioc_virq);
+	struct irq_chip		*gpio_irqchip;
 	int ret, i;
 
+	gpio_irqchip = devm_kzalloc(&pdev->dev, sizeof(*gpio_irqchip), GFP_KERNEL);
+	if (!gpio_irqchip)
+		return -ENOMEM;
+
 	at91_gpio->pioc_hwirq = irqd_to_hwirq(d);
 
-	/* Setup proper .irq_set_type function */
-	gpio_irqchip.irq_set_type = at91_gpio->ops->irq_type;
+	gpio_irqchip->name = "GPIO";
+	gpio_irqchip->irq_ack = gpio_irq_ack;
+	gpio_irqchip->irq_disable = gpio_irq_mask;
+	gpio_irqchip->irq_mask = gpio_irq_mask;
+	gpio_irqchip->irq_unmask = gpio_irq_unmask;
+	gpio_irqchip->irq_set_wake = gpio_irq_set_wake,
+	gpio_irqchip->irq_set_type = at91_gpio->ops->irq_type;
 
 	/* Disable irqs of this PIO controller */
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
@@ -1640,7 +1640,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	 * interrupt.
 	 */
 	ret = gpiochip_irqchip_add(&at91_gpio->chip,
-				   &gpio_irqchip,
+				   gpio_irqchip,
 				   0,
 				   handle_edge_irq,
 				   IRQ_TYPE_NONE);
@@ -1658,7 +1658,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	if (!gpiochip_prev) {
 		/* Then register the chain on the parent IRQ */
 		gpiochip_set_chained_irqchip(&at91_gpio->chip,
-					     &gpio_irqchip,
+					     gpio_irqchip,
 					     at91_gpio->pioc_virq,
 					     gpio_irq_handler);
 		return 0;
-- 
2.12.2

