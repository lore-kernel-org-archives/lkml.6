Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E33C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DBF2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLRL7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:59:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44316 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeLRL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:59:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so12030696lfe.11;
        Tue, 18 Dec 2018 03:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tEx+wOHGp4C+JC9RfSOGKcVVPwoVJY1Qduj4YgZ7m2I=;
        b=OKriy/J6c5kT7C24H0w+jfaVgK292oj7Lz9MOwvOJStDTkaH8+AVUgvlOBZNDT2DFs
         egOFXQkcj3x8C+ukNjRIkIwwIdjhx5Khv2IACXkM/BTbddUf5/Cc+NK/4oV8JBJsKAzF
         hyjvpeAOFkIrVfUrno/X4IOaB4Wg/WIZO0AwdJKZW+2akofMM6/qeL2z2yiVlaEtLQw5
         jGM2Xtmvg2fe97IT9ZShAH91Q3HsQXFW/f7VwKRSrx1t6I4bsuK4MvHXD+R6+/EHxalF
         DFbCsHvMIE5YJ+cAJjktB8VPlmAuFf1KnLD0ZGf3xj2W9qqN4R31Xphb1jA6Y5746DpD
         8QDg==
X-Gm-Message-State: AA+aEWYP6gbcaZWdgxrWgY/GKKKNPrlRqFJOsjuuAqJ72dkTL4t4Gz2L
        uXawctAYaqpnrhHFCehB5SU=
X-Google-Smtp-Source: AFSGD/Whp1o1ktOZUWkg16CFEJ/ljgE8KTqtrERmhcMDPiV1Mcp46kwgXlX1k6ZvTTUtUKA7ux5WIA==
X-Received: by 2002:a19:9781:: with SMTP id z123mr10553250lfd.80.1545134390578;
        Tue, 18 Dec 2018 03:59:50 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2956203ljc.5.2018.12.18.03.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 03:59:49 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:59:31 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, vladimir_zapolskiy@mentor.com
Subject: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq support
Message-ID: <20181218115931.GA21253@localhost.localdomain>
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

Version 3 of this patch is intended to be functionally identical to v2.
This patch is rebased on top of a tree which contains changes:
"regmap: irq: handle HW using separate rising/falling edge interrupts"
from Bartosz Golaszewski and the change
"regmap: regmap-irq: Remove default irq type setting from core"
(proposed here):
https://lore.kernel.org/lkml/20181218105813.GA6957@localhost.localdomain/

There should not be direct dependency to "regmap: regmap-irq: Remove
default irq type setting from core" though. Patch was also tested to
apply cleany on regmap-tree.

Same statement regarding testing applies - gpio-max77620 are only
tested to compile. All real testing would be _HIGHLY_ appreciated.

 drivers/base/regmap/regmap-irq.c | 35 ++++++++++-----
 drivers/gpio/gpio-max77620.c     | 96 ++++++++++++++++++++++++++--------------
 include/linux/regmap.h           | 27 ++++++++---
 3 files changed, 110 insertions(+), 48 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 8b216b2e2c19..31d23c9a5ae7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -199,7 +199,7 @@ static void regmap_irq_enable(struct irq_data *data)
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
 	unsigned int mask, type;
 
-	type = irq_data->type_falling_mask | irq_data->type_rising_mask;
+	type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
 
 	/*
 	 * The type_in_mask flag means that the underlying hardware uses
@@ -234,27 +234,42 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
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
 		break;
 
+	case IRQ_TYPE_LEVEL_HIGH:
+		d->type_buf[reg] |= t->type_level_high_val;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		d->type_buf[reg] |= t->type_level_low_val;
+		break;
 	default:
 		return -EINVAL;
 	}
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
index b7aa50cfb306..a904f87151e8 100644
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
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
