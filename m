Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010E82081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010E82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLKOGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:06:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47071 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeLKOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:06:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so13019730ljh.13;
        Tue, 11 Dec 2018 06:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IB4yxfsjwzI74jbIIzVBNFow2r9PN3pYY1Qjb3RH2Wc=;
        b=KtaRC/emXgerk5ldnQq+En8yh2J0Phnw1REZDT4SnlWc5NumfAViBh2K/dUjW5Edek
         xA5ijRV49qnetxJX9HCOgKcVRljlJJ5S4QWMVyEvZKf8XVQXpGW30o6cCTGhys03d9rK
         P4e+88qkrqew3uWl2PBGvXp9s2tmViVZX2mUgeuVFs6eCX9zPrg4H/Jc/958DIEbSKko
         z9TCQNZuFkb7LyIBMvOYOMzdB1jMXKSsHreIse038uAw9U4hCRGUsfLCchcBIvmZIfGW
         ItGxf+ZPst9PUSv42jxcuSzrBxZ8/UPc4rJPLUKMCp/QpCuA4deNhCm1+cjO/sUb8xHw
         YlCw==
X-Gm-Message-State: AA+aEWbUOPx2tL4CI5uVFpld99Xz7Nf2c1Nizq8Qft3K4t4R8608lIOA
        vu1cNqXHXdBzHbBukei/x4c=
X-Google-Smtp-Source: AFSGD/W/c0SRWd2jO67pfyAAWKhM1h9YmfBNnGG0vXXl6h9oRR7LSfHU0KbYoTp/+io54AAi3LNJ5g==
X-Received: by 2002:a2e:6594:: with SMTP id e20-v6mr10720433ljf.123.1544537164255;
        Tue, 11 Dec 2018 06:06:04 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x21sm2654611lfe.6.2018.12.11.06.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 06:06:03 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:05:55 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, vladimir_zapolskiy@mentor.com
Subject: [RFC PATCH v2] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181211140555.GA5872@localhost.localdomain>
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
inventing yet another flags for IRQ types. We use the existing
functionality which does logical OR for riding and falling edge values
if both edges are requested to be detected. This may not work on all
HWs.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
One specific question hit me while doing this. Why does the regmap-irq
core do default trigger type configuration? I did leave this in the
patch - but to me it is strange. For me it would be unexpected that the
HW default trigger level is changed by common code. I would understand
if change was done by some board specific code, or code specific to a
chip - but 'core' doing this seems wrong to me. Should it be removed?

And I still don't have max77620 so I have only done _wery_ limited
testing. I would _really_ appreciate if someone had time to review this
thoroughly - and even happier if someone had possibility to try this out
with the max77620.

 drivers/base/regmap/regmap-irq.c | 61 +++++++++++++++----------
 drivers/gpio/gpio-max77620.c     | 96 ++++++++++++++++++++++++++--------------
 include/linux/regmap.h           | 29 ++++++++----
 3 files changed, 122 insertions(+), 64 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8ed7e51..eacbb807d1c6 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -162,12 +162,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 			continue;
 		reg = d->chip->type_base +
 			(i * map->reg_stride * d->type_reg_stride);
-		if (d->chip->type_invert)
-			ret = regmap_irq_update_bits(d, reg,
-				d->type_buf_def[i], ~d->type_buf[i]);
-		else
-			ret = regmap_irq_update_bits(d, reg,
-				d->type_buf_def[i], d->type_buf[i]);
+		ret = regmap_irq_update_bits(d, reg, d->type_buf_def[i],
+					     d->type_buf[i]);
 		if (ret != 0)
 			dev_err(d->map->dev, "Failed to sync type in %x\n",
 				reg);
@@ -212,27 +208,42 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
-	int reg = irq_data->type_reg_offset / map->reg_stride;
+	int reg;
+	const struct regmap_irq_type *t = &irq_data->type;
 
-	if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
-		return 0;
+	if ((t->types_supported & type) != type)
+		return -ENOTSUPP;
+
+	reg = t->type_reg_offset / map->reg_stride;
 
-	d->type_buf[reg] &= ~(irq_data->type_falling_mask |
-					irq_data->type_rising_mask);
+	if (t->type_reg_mask)
+		d->type_buf[reg] &= ~t->type_reg_mask;
+	else
+		d->type_buf[reg] &= ~(t->type_falling_val |
+				      t->type_rising_val |
+				      t->type_level_low_val |
+				      t->type_level_high_val);
 	switch (type) {
 	case IRQ_TYPE_EDGE_FALLING:
-		d->type_buf[reg] |= irq_data->type_falling_mask;
+		d->type_buf[reg] |= t->type_falling_val;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
-		d->type_buf[reg] |= irq_data->type_rising_mask;
+		d->type_buf[reg] |= t->type_rising_val;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-		d->type_buf[reg] |= (irq_data->type_falling_mask |
-					irq_data->type_rising_mask);
+		d->type_buf[reg] |= (t->type_falling_val |
+					t->type_rising_val);
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		d->type_buf[reg] |= t->type_level_high_val;
 		break;
 
+	case IRQ_TYPE_LEVEL_LOW:
+		d->type_buf[reg] |= t->type_level_low_val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -602,9 +613,15 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 	if (chip->num_type_reg) {
 		for (i = 0; i < chip->num_irqs; i++) {
-			reg = chip->irqs[i].type_reg_offset / map->reg_stride;
-			d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
-					chip->irqs[i].type_falling_mask;
+			const struct regmap_irq_type *type;
+
+			type = &chip->irqs[i].type;
+			if (!type->types_supported)
+				continue;
+			reg = type->type_reg_offset / map->reg_stride;
+			/* Why we do this ? */
+			d->type_buf_def[reg] |= type->type_rising_val |
+					type->type_falling_val;
 		}
 		for (i = 0; i < chip->num_type_reg; ++i) {
 			if (!d->type_buf_def[i])
@@ -612,12 +629,8 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 			reg = chip->type_base +
 				(i * map->reg_stride * d->type_reg_stride);
-			if (chip->type_invert)
-				ret = regmap_irq_update_bits(d, reg,
-					d->type_buf_def[i], 0xFF);
-			else
-				ret = regmap_irq_update_bits(d, reg,
-					d->type_buf_def[i], 0x0);
+			ret = regmap_irq_update_bits(d, reg, d->type_buf_def[i],
+						     0x0);
 			if (ret != 0) {
 				dev_err(map->dev,
 					"Failed to set type in 0x%x: %x\n",
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 538bce4b5b42..65fa3a198ebd 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -25,60 +25,92 @@ struct max77620_gpio {
 
 static const struct regmap_irq max77620_gpio_irqs[] = {
 	[0] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE0,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 0,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE0,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 0,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[1] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE1,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 1,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE1,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 1,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[2] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE2,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 2,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE2,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 2,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[3] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE3,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 3,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE3,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 3,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[4] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE4,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 4,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE4,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 4,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[5] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE5,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 5,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE5,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 5,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[6] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE6,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 6,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE6,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 6,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[7] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE7,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 7,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE7,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 7,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 };
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a367d59c301d..6ade3ed822a2 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1089,22 +1089,37 @@ int regmap_fields_read(struct regmap_field *field, unsigned int id,
 int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 				   unsigned int mask, unsigned int val,
 				   bool *change, bool async, bool force);
+/**
+ * struct regmap_irq_type - IRQ type definitions.
+ *
+ * @type_reg_offset: Offset register for the irq type setting.
+ * @type_rising_val: Register value to configure RISING type irq.
+ * @type_falling_val: Register value to configure FALLING type irq.
+ * @type_level_low_val: Register value to configure LEVEL_LOW type irq.
+ * @type_level_high_val: Register value to configure LEVEL_HIGH type irq.
+ * @types_supported: logical OR of IRQ_TYPE_* flags indicating supported types.
+ */
+struct regmap_irq_type {
+	unsigned int type_reg_offset;
+	unsigned int type_reg_mask;
+	unsigned int type_rising_val;
+	unsigned int type_falling_val;
+	unsigned int type_level_low_val;
+	unsigned int type_level_high_val;
+	unsigned int types_supported;
+};
 
 /**
  * struct regmap_irq - Description of an IRQ for the generic regmap irq_chip.
  *
  * @reg_offset: Offset of the status/mask register within the bank
  * @mask:       Mask used to flag/control the register.
- * @type_reg_offset: Offset register for the irq type setting.
- * @type_rising_mask: Mask bit to configure RISING type irq.
- * @type_falling_mask: Mask bit to configure FALLING type irq.
+ * @type:	IRQ trigger type setting details if supported.
  */
 struct regmap_irq {
 	unsigned int reg_offset;
 	unsigned int mask;
-	unsigned int type_reg_offset;
-	unsigned int type_rising_mask;
-	unsigned int type_falling_mask;
+	struct regmap_irq_type type;
 };
 
 #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
@@ -1130,7 +1145,6 @@ struct regmap_irq {
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
- * @type_invert: Invert the type flags.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1168,7 +1182,6 @@ struct regmap_irq_chip {
 	bool ack_invert:1;
 	bool wake_invert:1;
 	bool runtime_pm:1;
-	bool type_invert:1;
 
 	int num_regs;
 
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
