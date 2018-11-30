Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A596BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E6320663
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E6320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeK3UH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:07:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38598 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeK3UH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:07:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so3536071lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zH6dPdDHou18kI4qIcZNzOQmvwidhGDbw0QZwLCEp40=;
        b=Zy3EiJSVJLH6O22yIaPT4mVr8cAIt/U/mSJSPsVivIxjVV6ltMf51KXTgv50AvHu4u
         +kHbgpFFAobcR5pxzDexs4dLqiX/0aGXSNQJafGX7ODQDzi0sWHHcvhbwYc7xYQWCLUi
         Teps44QAR0BtZmaUWRLfq6mLPgb89bLM5QM21miIdIC8Dr61FqP9azbZk+phb3OIxOUc
         dOQcikQV7Fg/vXFSSzjKkjnhxuKpMsDGI3Xgy11oKLnFoZOuh+onfAbcepCVXav3bcH6
         a/CH14pcQsxD2cNHuNHmRMmpSujUV7WvatXkFgvXOe4x5jFjT5S1ctZpi2M8zRXx75IH
         So9w==
X-Gm-Message-State: AA+aEWas3OFkLN6chWfrERmnWMUYsP05soMyQ1QhTvqHcV3Y7UXljZYs
        sJ4nuK1OScT+zK/mOguu9OLggCT8
X-Google-Smtp-Source: AFSGD/XsWbjmt3LeARu47LPDgYVm4iPR/gVo7yEqER0MAC6Niwe2Z/LUzgAyiyHtc/f1Rz+w02SfJw==
X-Received: by 2002:a19:c014:: with SMTP id q20mr2906108lff.16.1543568356641;
        Fri, 30 Nov 2018 00:59:16 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id m10-v6sm677403ljj.34.2018.11.30.00.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 00:59:16 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:59:08 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181130085908.GA24983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All.

Sorry for lenghty email. But I tried to explain this in details.

Surprizingly I didn't find an example how to handle this properly/easily.
Thus I am wondering if following changes to regmap-irq make any sense
or is there some better way (which I just didn't spot) to handle this.

I am working with another PMIC from ROHM. The PMIC
has several 'sub blocks' like RTC, GPIO, charger, regulators, ...
each of which can generate interrupts to processor. PMIC irq is
connected via single GPIO line to the processor irq controller
and registers are accessed via i2c.

IRQ handling is implemented so that each sub block has own
status/ack/mask registers and then there is one main status
register. When any of the sub blocks gets unmasked IRQ,
corresponding 'main status register' bit is set in main status
register.

			Main
			+---------------+   inactive
			|0|0|0|0|0|0|0|0| ------------- IRQ_L to processor
			+---------------+
Sub status
+---------------+ +---------------+ +---------------+ +---------------+
|0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0|
+---------------+ +---------------+ +---------------+ +---------------+
Sub mask
+---------------+ +---------------+ +---------------+ +---------------+
|0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0|
+---------------+ +---------------+ +---------------+ +---------------+


			Main
			+---------------+   active
			|0|0|0|0|0|0|1|0| ------------- IRQ_L to processor
			+---------------+
Sub status/ack     			     X
+---------------+ +---------------+ +---------------+ +---------------+
|0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|1|0|0|0| |0|0|0|0|0|0|0|0|
+---------------+ +---------------+ +---------------+ +---------------+
Sub mask
+---------------+ +---------------+ +---------------+ +---------------+
|0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0| |0|0|0|0|0|0|0|0|
+---------------+ +---------------+ +---------------+ +---------------+

Usually I would model this by using chained/nested IRQ chips for this
setup. One chip would handle the main register and be parent for
the secondary chip(s) which would handle the sub-irqs. I really liked to
use regmap-irq for this as it already provides all the code. Problem I
am struggling with is that the GPIO sub-block has 4 GPIO pins for other
devices to use for IRQs. And I would like to provide access to them via
the pmic device-tree node by marking the pmic node as
interrupt-controller. Eg, I would like to do:

pmic: bd70528@4b { 
	compatible = "rohm,bd70528";
	interrupt-parent = <&gpio1>;
	interrupts = <29 8>;
	interrupt-controller;
	#interrupt-cells = <2>;

	/* Snip... */
	};

deviceX {
		interrupt-parent = <&pmic>;
		interrupts = <GPIO_1 2>;
		/* ... */
	};

deviceY {
		interrupt-parent = <&pmic>;
		interrupts = <GPIO_2 2>;
		/* ... */
	};

Problem I faced is that I don't know how to create two regmap-irq chips for
the same i2c decvice - because the regmap-irq gets the DT node from regmnap
- and thus both of the irq chips would have same DT node. My assumption is
that the DT - xlate functionality for this setup would not be quite correct,
right? I guess the "main irq" interrupts would be hookable via DT? But
the devices are interested in "sub IRQs". So I thought that the correct
solution would be to model the interrupts from this PMIC as just one
irq-chip. So I wonder if addin this "main IRQ register" support for
regmap-irq makes sense? Additionally this ROHM PMIC GPIO supports
configuring IRQ pins as level triggered. So I thought we could add
support for setting the type to level_low or level_high. This change
would require adding 'supported_types' information to all drivers which
are currently using regmap-irq for supporting type-setting - but quick
grep for drivers allow me to think that it is currently only the 
gpio-max77620 which uses the type setting in-tree.

So the patch below is not properly tested but it should explain what I
am plannig. Can you plese tell me if this makes sense or not? If this
sounds like acceptable patch - then I will test this a bit further and
create a real patch out of it.

Best Regards:
	Matti Vaittinen


There is bunch of devices with multiple logical blocks which
can generate interrupts. It's not a rare case that the interrupt
reason registers are arranged so that there is own status/ack/mask
register for each logical block. In soem devices there is also a
'main interrupt register(s)' which can indicate what sub blocks
have interrupts pending.

When sucn a device is connected via slow bus like i2c the main
part of interrupt handling latency can be caused by bus accesses.
On systems where it is expected that only on (or few) sub blocks
have active interrupts we can reduce the latency by only reading
the main register and those sub registers which have active
interrupts. Support this with regmap-irq for simple cases where
main register does not require acking or masking.

additionally support level active interrupts with regmap-irq

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/base/regmap/regmap-irq.c | 118 +++++++++++++++++++++++++++++++++++++--
 include/linux/regmap.h           |  34 +++++++++++
 2 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8ed7e51..b6971123268d 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -35,6 +35,7 @@ struct regmap_irq_chip_data {
 	int wake_count;
 
 	void *status_reg_buf;
+	unsigned int *main_status_buf;
 	unsigned int *status_buf;
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
@@ -214,11 +215,17 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
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
@@ -233,6 +240,13 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
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
@@ -269,6 +283,33 @@ static const struct irq_chip regmap_irq_chip = {
 	.irq_set_wake		= regmap_irq_set_wake,
 };
 
+static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
+					   unsigned int b)
+{
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	struct regmap_irq_sub_irq_map *subreg;
+	int i, ret = 0;
+
+	if (!chip->sub_reg_offsets) {
+		/* Assume linear mapping */
+		ret = regmap_read(map, chip->status_base +
+				  (b * map->reg_stride * data->irq_reg_stride),
+				   &data->status_buf[b]);
+	} else {
+		subreg = &chip->sub_reg_offsets[b];
+		for (i = 0; i < subreg->num_regs; i++) {
+			unsigned int offset = subreg->offset[i];
+
+			ret = regmap_read(map, chip->status_base + offset,
+					  &data->status_buf[offset]);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
+}
+
 static irqreturn_t regmap_irq_thread(int irq, void *d)
 {
 	struct regmap_irq_chip_data *data = d;
@@ -292,11 +333,65 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	}
 
 	/*
-	 * Read in the statuses, using a single bulk read if possible
-	 * in order to reduce the I/O overheads.
+	 * Read only registers with active IRQs if the chip has 'main status
+	 * register'. Else read in the statuses, using a single bulk read if
+	 * possible in order to reduce the I/O overheads.
 	 */
-	if (!map->use_single_read && map->reg_stride == 1 &&
-	    data->irq_reg_stride == 1) {
+
+	if (chip->num_main_regs) {
+		unsigned int max_main_bits;
+		unsigned long size;
+
+		size = chip->num_regs * sizeof(unsigned int);
+
+		max_main_bits = (chip->num_main_status_bits) ?
+				 chip->num_main_status_bits : chip->num_regs;
+		/* Clear the status buf as we don't read all status regs */
+		memset(data->status_buf, 0, size);
+
+		/* We could support bulk read for main status registers
+		 * but I don't expect to see devices with really many main
+		 * status registers so let's only support single reads for the
+		 * sake of simplicity. and add bulk reads only if needed
+		 */
+		for (i = 0; i < chip->num_main_regs; i++) {
+			ret = regmap_read(map, chip->main_status +
+				  (i * map->reg_stride
+				   * data->irq_reg_stride),
+				  &data->main_status_buf[i]);
+			if (ret) {
+				dev_err(map->dev,
+					"Failed to read IRQ status %d\n",
+					ret);
+				goto exit;
+			}
+		}
+
+		/* Read sub registers with active IRQs */
+		for (i = 0; i < chip->num_main_regs; i++) {
+			unsigned int b;
+			const unsigned long mreg = data->main_status_buf[i];
+
+			for_each_set_bit(b, &mreg, map->format.val_bytes * 8) {
+				if (i * map->format.val_bytes * 8 + b >
+				    max_main_bits)
+					break;
+				ret = read_sub_irq_data(data, b);
+
+				if (ret != 0) {
+					dev_err(map->dev,
+						"Failed to read IRQ status %d\n",
+						ret);
+					if (chip->runtime_pm)
+						pm_runtime_put(map->dev);
+					goto exit;
+				}
+			}
+
+		}
+	} else if (!map->use_single_read && map->reg_stride == 1 &&
+		   data->irq_reg_stride == 1) {
+
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
 		u32 *buf32 = data->status_reg_buf;
@@ -457,6 +552,15 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	if (!d)
 		return -ENOMEM;
 
+	if (chip->num_main_regs) {
+		d->main_status_buf = kcalloc(chip->num_main_regs,
+					     sizeof(unsigned int),
+					     GFP_KERNEL);
+
+		if (!d->main_status_buf)
+			goto err_alloc;
+	}
+
 	d->status_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
 				GFP_KERNEL);
 	if (!d->status_buf)
@@ -602,6 +706,8 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 	if (chip->num_type_reg) {
 		for (i = 0; i < chip->num_irqs; i++) {
+			if (!chip->irqs[i].types_supported)
+				continue;
 			reg = chip->irqs[i].type_reg_offset / map->reg_stride;
 			d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
 					chip->irqs[i].type_falling_mask;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a367d59c301d..57dfd3e462db 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1098,6 +1098,7 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
  * @type_reg_offset: Offset register for the irq type setting.
  * @type_rising_mask: Mask bit to configure RISING type irq.
  * @type_falling_mask: Mask bit to configure FALLING type irq.
+ * @types_supported: logical OR of IRQ_TYPE_* flags indicating supported types
  */
 struct regmap_irq {
 	unsigned int reg_offset;
@@ -1105,16 +1106,44 @@ struct regmap_irq {
 	unsigned int type_reg_offset;
 	unsigned int type_rising_mask;
 	unsigned int type_falling_mask;
+	unsigned int type_level_low_mask;
+	unsigned int type_level_high_mask;
+	unsigned int types_supported;
 };
 
 #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
 	[_irq] = { .reg_offset = (_off), .mask = (_mask) }
 
+struct regmap_irq_sub_irq_map {
+	unsigned int num_regs;
+	unsigned int *offset;
+};
+
+#define REGMAP_IRQ_MAIN_REG_OFFSET(arr)				\
+	{ .num_regs = ARRAY_SIZE((arr)), .offset = &(arr)[0] }
+
 /**
  * struct regmap_irq_chip - Description of a generic regmap irq_chip.
  *
  * @name:        Descriptive name for IRQ controller.
  *
+ * @main_status: Base main status register address. For chips which have
+ *		 interrupts arranged in separate sub-irq blocks with own IRQ
+ *		 registers and which have a main IRQ registers indicating
+ *		 sub-irq blocks with unhandled interrupts. For such chips fill
+ *		 sub-irq register information in status_base, mask_base and
+ *		 ack_base.
+ * @sub_reg_offsets: arrays of mappings from main register bits to sub irq
+ *		 registers. First item in array describes the registers
+ *		 for first main status bit. Second array for second bit etc.
+ *		 Offset is given as sub register status offset to status_base.
+ *		 Should contain num_regs arrays. Can be provided for chips with
+ *		 more complex mapping than 1.st bit to 1.st sub-reg, 2.nd bit to
+ *		 2.nd sub-reg, ...
+ * @num_main_regs: Number of 'main' irq registers.
+ * @num_main_status_bits: Should be given to chips where number of meaningfull
+ *		 main status bits differs from num_regs.
+ *
  * @status_base: Base status register address.
  * @mask_base:   Base mask register address.
  * @mask_writeonly: Base mask register is write only.
@@ -1154,6 +1183,10 @@ struct regmap_irq {
 struct regmap_irq_chip {
 	const char *name;
 
+	unsigned int main_status;
+	unsigned int num_main_status_bits;
+	struct regmap_irq_sub_irq_map *sub_reg_offsets;
+
 	unsigned int status_base;
 	unsigned int mask_base;
 	unsigned int unmask_base;
@@ -1170,6 +1203,7 @@ struct regmap_irq_chip {
 	bool runtime_pm:1;
 	bool type_invert:1;
 
+	int num_main_regs;
 	int num_regs;
 
 	const struct regmap_irq *irqs;
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
