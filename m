Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2E02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2E02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeLJIOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:14:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38837 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:14:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so8746739lja.5;
        Mon, 10 Dec 2018 00:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DD+nds5xuVaDxIOLRKqYvoqa2VG2LjeQ+mc0IVpPRlE=;
        b=VQxdRAKsQ+kVZjELguZZvr2kSV8hGbKU3PdEo0lYoPTuPjziU9n5xXeew1eqyNdS+H
         lm9wWzfO4oEb2VinMVvR9UzFpXkMANGJS6zVgVRZz7nNVT2tmhFCMg3xqZe1h1FY8pWi
         PfbwDeS5jvByKtVmaRtiW/Bwp3OB/+zDqNc+JVtrDwBvZ0+vcI7CXcT425QQz8BuFnNi
         eZdRghMqITPOfrrwwTf9EqC/8no5/pnIIt8KSdjs3U5IvUTLMyShdgAiNt3kqv2CNuE1
         WuCKqMxklkpmy1nxCJCM/0F6/pgWmF9Yx1i6Y4TS8TzYYYghqObcDV0cq4tFaFlaePwm
         fHCg==
X-Gm-Message-State: AA+aEWY9MAWf7QcvR4sO5mB93rlU52yyfdDkhM64wvrUpxjEq6CEV1M4
        Xm3PhiIuIgX+LIZqBJE1/lHbOpMk
X-Google-Smtp-Source: AFSGD/W3Y0vkaJvJjQUxlRn9HjYqA68MIuMJvugcyka5+hTgWHEV+QdR6QG32buSYaNp14oK+44etQ==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr6960261ljj.102.1544429690337;
        Mon, 10 Dec 2018 00:14:50 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x18-v6sm2115868lji.27.2018.12.10.00.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 00:14:49 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:14:37 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support
Message-ID: <20181210081437.GA32228@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add level active IRQ support to regmap-irq irqchip. Change breaks
existing regmap-irq type setting. Convert the existing drivers which
use regmap-irq with trigger type setting (gpio-max77620) to work
with this new approach. So we do not magically support level-active
IRQs on gpio-max77620 - but add support to the regmap-irq for chips
which support them =)

We do not support distinguishing situation where HW supports rising
and falling edge detection but not both. Separating this would require
inventing yet another flags for IRQ types.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
I did both the regmap-irq and max77620 changes in same commit because
I'd rather not cause spot where max77620 breaks. Besides the changes in
max77620 driver are trivial. Please let me know if this is not Ok.

Reason why I submit this patch now - even though my driver which would
use level active type setting with regmap-irq is not yet ready for
being submited - is that I'd like to minimize amount of existing drivers
we need to patch. And if we add level active irq support like this then
we must patch all existing drivers using type setting with regmap-irq.
So doing this now when only max77620 uses type setting may be easier
than postponing this to the future.

And finally - I don't have max77620 so I have only done _wery_ limited
testing. So I would really appreciate if someone had time to review this
thoroughly - and even happier if someone had possibility to try this out
with the max77620.

 drivers/base/regmap/regmap-irq.c | 19 +++++++++++++++++--
 drivers/gpio/gpio-max77620.c     |  8 ++++++++
 include/linux/regmap.h           |  6 ++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8ed7e51..5e7e10e4c1dc 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -214,11 +214,17 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
 	int reg = irq_data->type_reg_offset / map->reg_stride;
 
-	if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
+	if ((irq_data->types_supported & type) != type)
+		return -ENOTSUPP;
+
+	if (!(irq_data->type_rising_mask | irq_data->type_falling_mask |
+	      irq_data->type_level_high_mask | irq_data->type_level_low_mask))
 		return 0;
 
 	d->type_buf[reg] &= ~(irq_data->type_falling_mask |
-					irq_data->type_rising_mask);
+			      irq_data->type_rising_mask |
+			      irq_data->type_level_low_mask |
+			      irq_data->type_level_high_mask);
 	switch (type) {
 	case IRQ_TYPE_EDGE_FALLING:
 		d->type_buf[reg] |= irq_data->type_falling_mask;
@@ -233,6 +239,13 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 					irq_data->type_rising_mask);
 		break;
 
+	case IRQ_TYPE_LEVEL_HIGH:
+		d->type_buf[reg] |= irq_data->type_level_high_mask;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		d->type_buf[reg] |= irq_data->type_level_low_mask;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -602,6 +615,8 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 	if (chip->num_type_reg) {
 		for (i = 0; i < chip->num_irqs; i++) {
+			if (!chip->irqs[i].types_supported)
+				continue;
 			reg = chip->irqs[i].type_reg_offset / map->reg_stride;
 			d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
 					chip->irqs[i].type_falling_mask;
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 538bce4b5b42..e3b761b526c3 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -30,6 +30,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 0,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[1] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE1,
@@ -37,6 +38,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 1,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[2] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE2,
@@ -44,6 +46,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 2,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[3] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE3,
@@ -51,6 +54,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 3,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[4] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE4,
@@ -58,6 +62,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 4,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[5] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE5,
@@ -65,6 +70,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 5,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[6] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE6,
@@ -72,6 +78,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 6,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 	[7] = {
 		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE7,
@@ -79,6 +86,7 @@ static const struct regmap_irq max77620_gpio_irqs[] = {
 		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
 		.type_reg_offset = 7,
+		.types_supported = IRQ_TYPE_EDGE_BOTH;
 	},
 };
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a367d59c301d..91c431ad98c3 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1098,6 +1098,9 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
  * @type_reg_offset: Offset register for the irq type setting.
  * @type_rising_mask: Mask bit to configure RISING type irq.
  * @type_falling_mask: Mask bit to configure FALLING type irq.
+ * @type_level_low_mask: Mask bit to configure LEVEL_LOW type irq.
+ * @type_level_high_mask: Mask bit to configure LEVEL_HIGH type irq.
+ * @types_supported: logical OR of IRQ_TYPE_* flags indicating supported types.
  */
 struct regmap_irq {
 	unsigned int reg_offset;
@@ -1105,6 +1108,9 @@ struct regmap_irq {
 	unsigned int type_reg_offset;
 	unsigned int type_rising_mask;
 	unsigned int type_falling_mask;
+	unsigned int type_level_low_mask;
+	unsigned int type_level_high_mask;
+	unsigned int types_supported;
 };
 
 #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
