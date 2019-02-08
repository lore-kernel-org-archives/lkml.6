Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B9C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D00520857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfBHLwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:52:11 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41121 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfBHLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:52:08 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 08111240006;
        Fri,  8 Feb 2019 11:52:05 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/3] gpio: em: drop ->irq_{request,release}_resources hooks
Date:   Fri,  8 Feb 2019 12:52:01 +0100
Message-Id: <20190208115201.7518-4-thomas.petazzoni@bootlin.com>
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
---
Note: this commit was only build tested.
---
 drivers/gpio/gpio-em.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 982e699a5b81..e27c56854ee7 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -98,29 +98,6 @@ static void em_gio_irq_enable(struct irq_data *d)
 	em_gio_write(p, GIO_IEN, BIT(irqd_to_hwirq(d)));
 }
 
-static int em_gio_irq_reqres(struct irq_data *d)
-{
-	struct em_gio_priv *p = irq_data_get_irq_chip_data(d);
-	int ret;
-
-	ret = gpiochip_lock_as_irq(&p->gpio_chip, irqd_to_hwirq(d));
-	if (ret) {
-		dev_err(p->gpio_chip.parent,
-			"unable to lock HW IRQ %lu for IRQ\n",
-			irqd_to_hwirq(d));
-		return ret;
-	}
-	return 0;
-}
-
-static void em_gio_irq_relres(struct irq_data *d)
-{
-	struct em_gio_priv *p = irq_data_get_irq_chip_data(d);
-
-	gpiochip_unlock_as_irq(&p->gpio_chip, irqd_to_hwirq(d));
-}
-
-
 #define GIO_ASYNC(x) (x + 8)
 
 static unsigned char em_gio_sense_table[IRQ_TYPE_SENSE_MASK + 1] = {
@@ -344,8 +321,6 @@ static int em_gio_probe(struct platform_device *pdev)
 	irq_chip->irq_mask = em_gio_irq_disable;
 	irq_chip->irq_unmask = em_gio_irq_enable;
 	irq_chip->irq_set_type = em_gio_irq_set_type;
-	irq_chip->irq_request_resources = em_gio_irq_reqres;
-	irq_chip->irq_release_resources = em_gio_irq_relres;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
 	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node, ngpios, 0,
-- 
2.20.1

