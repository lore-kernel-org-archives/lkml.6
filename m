Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF13AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A90120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfBHLwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:52:22 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39747 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfBHLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:52:07 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E9BB660007;
        Fri,  8 Feb 2019 11:52:04 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hoan Tran <hotran@apm.com>
Subject: [PATCH 2/3] gpio: dwapb: drop ->irq_{request,release}_resources hooks
Date:   Fri,  8 Feb 2019 12:52:00 +0100
Message-Id: <20190208115201.7518-3-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208115201.7518-1-thomas.petazzoni@bootlin.com>
References: <20190208115201.7518-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those hooks implement the exact same behavior as the default hooks by
gpiolib, so there is no point in having a duplicated definition in
gpio-dwapb.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Hoan Tran <hotran@apm.com>
---
Note: this commit was only build tested.
---
 drivers/gpio/gpio-dwapb.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 044888fd96a1..93eba2c6f328 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -250,31 +250,6 @@ static void dwapb_irq_disable(struct irq_data *d)
 	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
-static int dwapb_irq_reqres(struct irq_data *d)
-{
-	struct irq_chip_generic *igc = irq_data_get_irq_chip_data(d);
-	struct dwapb_gpio *gpio = igc->private;
-	struct gpio_chip *gc = &gpio->ports[0].gc;
-	int ret;
-
-	ret = gpiochip_lock_as_irq(gc, irqd_to_hwirq(d));
-	if (ret) {
-		dev_err(gpio->dev, "unable to lock HW IRQ %lu for IRQ\n",
-			irqd_to_hwirq(d));
-		return ret;
-	}
-	return 0;
-}
-
-static void dwapb_irq_relres(struct irq_data *d)
-{
-	struct irq_chip_generic *igc = irq_data_get_irq_chip_data(d);
-	struct dwapb_gpio *gpio = igc->private;
-	struct gpio_chip *gc = &gpio->ports[0].gc;
-
-	gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
-}
-
 static int dwapb_irq_set_type(struct irq_data *d, u32 type)
 {
 	struct irq_chip_generic *igc = irq_data_get_irq_chip_data(d);
@@ -428,8 +403,6 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 		ct->chip.irq_set_type = dwapb_irq_set_type;
 		ct->chip.irq_enable = dwapb_irq_enable;
 		ct->chip.irq_disable = dwapb_irq_disable;
-		ct->chip.irq_request_resources = dwapb_irq_reqres;
-		ct->chip.irq_release_resources = dwapb_irq_relres;
 #ifdef CONFIG_PM_SLEEP
 		ct->chip.irq_set_wake = dwapb_irq_set_wake;
 #endif
-- 
2.20.1

