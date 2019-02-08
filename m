Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D176C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E893C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfBHLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:52:08 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56665 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:52:05 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 72F651C0006;
        Fri,  8 Feb 2019 11:52:03 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/3] gpio: bcm-kona: drop ->irq_{request,release}_resources hooks
Date:   Fri,  8 Feb 2019 12:51:59 +0100
Message-Id: <20190208115201.7518-2-thomas.petazzoni@bootlin.com>
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
gpio-bcm-kona.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
---
Note: this commit was only build tested.
---
 drivers/gpio/gpio-bcm-kona.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index c5536a509b59..0ae806edabc2 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -484,28 +484,12 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int bcm_kona_gpio_irq_reqres(struct irq_data *d)
-{
-	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
-
-	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, d->hwirq);
-}
-
-static void bcm_kona_gpio_irq_relres(struct irq_data *d)
-{
-	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
-
-	gpiochip_relres_irq(&kona_gpio->gpio_chip, d->hwirq);
-}
-
 static struct irq_chip bcm_gpio_irq_chip = {
 	.name = "bcm-kona-gpio",
 	.irq_ack = bcm_kona_gpio_irq_ack,
 	.irq_mask = bcm_kona_gpio_irq_mask,
 	.irq_unmask = bcm_kona_gpio_irq_unmask,
 	.irq_set_type = bcm_kona_gpio_irq_set_type,
-	.irq_request_resources = bcm_kona_gpio_irq_reqres,
-	.irq_release_resources = bcm_kona_gpio_irq_relres,
 };
 
 static struct of_device_id const bcm_kona_gpio_of_match[] = {
-- 
2.20.1

