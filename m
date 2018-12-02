Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926ABC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614042081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614042081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbeLBKI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 05:08:27 -0500
Received: from www.osadl.org ([62.245.132.105]:33725 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbeLBKI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 05:08:27 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB2A7Hk7023591;
        Sun, 2 Dec 2018 11:07:17 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] pinctrl: sx150x: handle failure case of devm_kstrdup
Date:   Sun,  2 Dec 2018 11:04:17 +0100
Message-Id: <1543745057-31616-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kstrdup() may return NULL if internal allocation failed.
Thus using  label, name  is unsafe without checking. Therefor
in the unlikely case of allocation failure, sx150x_probe() simply
returns -ENOMEM.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
---

Problem located with an experimental coccinelle script

Patch was compile tested with: lpc32xx_defconfig (implies PINCTRL_SX150X=y)
Note that while lpc32xx_defconfig contains PINCTRL_SX150X=y after make
lpc32xx_defconfig it is *not* set - seems to be a missing entry in
drivers/pincrtl/Kconfig - so PINCRTL and PINCTRL_SX150X had to be
manually enabled.

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 drivers/pinctrl/pinctrl-sx150x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index cbf58a1..4d87d75 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1166,7 +1166,6 @@ static int sx150x_probe(struct i2c_client *client,
 	}
 
 	/* Register GPIO controller */
-	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
 	pctl->gpio.base = -1;
 	pctl->gpio.ngpio = pctl->data->npins;
 	pctl->gpio.get_direction = sx150x_gpio_get_direction;
@@ -1180,6 +1179,10 @@ static int sx150x_probe(struct i2c_client *client,
 	pctl->gpio.of_node = dev->of_node;
 #endif
 	pctl->gpio.can_sleep = true;
+	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
+	if (!pctl->gpio.label)
+		return -ENOMEM;
+
 	/*
 	 * Setting multiple pins is not safe when all pins are not
 	 * handled by the same regmap register. The oscio pin (present
@@ -1200,13 +1203,15 @@ static int sx150x_probe(struct i2c_client *client,
 
 	/* Add Interrupt support if an irq is specified */
 	if (client->irq > 0) {
-		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
-						   GFP_KERNEL);
 		pctl->irq_chip.irq_mask = sx150x_irq_mask;
 		pctl->irq_chip.irq_unmask = sx150x_irq_unmask;
 		pctl->irq_chip.irq_set_type = sx150x_irq_set_type;
 		pctl->irq_chip.irq_bus_lock = sx150x_irq_bus_lock;
 		pctl->irq_chip.irq_bus_sync_unlock = sx150x_irq_bus_sync_unlock;
+		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
+						   GFP_KERNEL);
+		if (!pctl->irq_chip.name)
+			return -ENOMEM;
 
 		pctl->irq.masked = ~0;
 		pctl->irq.sense = 0;
-- 
2.1.4

