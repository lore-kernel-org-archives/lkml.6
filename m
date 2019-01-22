Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E890C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A1420870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfAVJmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:42:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36772 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfAVJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:42:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so17560870lfg.3;
        Tue, 22 Jan 2019 01:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSINoHx6fveobh07vmnKFZw8KNcssMPxyGVcKKiu5q8=;
        b=jFd3ZRbtWfBA6w0ulX50Gw1zF2VvX+sPtpaLz25CfKJVPvNDfffCrK1t1Ha7V9YCSe
         TsS6SEqta/mpj6nifMt32Irom78nEw8+J9/1vXOJhYnKO7gfFnYakcQU6ln4qr14tDaY
         IklHm4nwUvGjeTLbvfY8UdaleT05zukhN7qa9v+gHufm2PEKQIxdhOW5gSzZWYdFLcZk
         YTFRU2TV8LtBUh1bk1XZKjMxNYVRRg3TU5yiPF1X4kRGVedf4/1cYx9jo0eZiZA0qxBj
         syTkzzanZjweXNyMGzM2fg7Xxe8dO2LyTNuQGZ5YDE1RRriYy1kcTyg2eeQNMTE/Jroj
         L3dw==
X-Gm-Message-State: AJcUukcRf4NU+KpgQthCrcBp8NnI9iKSf/U3EESYxdVxtLDr2mDeqHZj
        sTEzMyqPO0u2N5eo23bxLMQ=
X-Google-Smtp-Source: ALg8bN6J7HtPWBbmKB4SjaNwfyxfN4BCtj0EVbChCHiVzaHFcztUD3B3WlpJLMSeqVgCNLYgX1FN5A==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr20857090lfi.57.1548150159497;
        Tue, 22 Jan 2019 01:42:39 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2738940ljv.1.2019.01.22.01.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:42:38 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:42:24 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 01/13] regmap: regmap-irq: Add main status register
 support
Message-ID: <a5a3cdb00b9181897fc675f4a6900064d9289fdc.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is bunch of devices with multiple logical blocks which
can generate interrupts. It's not a rare case that the interrupt
reason registers are arranged so that there is own status/ack/mask
register for each logical block. In some devices there is also a
'main interrupt register(s)' which can indicate what sub blocks
have interrupts pending.

When such a device is connected via slow bus like i2c the main
part of interrupt handling latency can be caused by bus accesses.
On systems where it is expected that only one (or few) sub blocks
have active interrupts we can reduce the latency by only reading
the main register and those sub registers which have active
interrupts. Support this with regmap-irq for simple cases where
main register does not require acking or masking.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/base/regmap/regmap-irq.c | 99 ++++++++++++++++++++++++++++++++++++++--
 include/linux/regmap.h           | 31 +++++++++++++
 2 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 1bd1145ad8b5..22778e9501ff 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -35,6 +35,7 @@ struct regmap_irq_chip_data {
 	int wake_count;
 
 	void *status_reg_buf;
+	unsigned int *main_status_buf;
 	unsigned int *status_buf;
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
@@ -326,6 +327,33 @@ static const struct irq_chip regmap_irq_chip = {
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
@@ -349,11 +377,65 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -518,6 +600,15 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
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
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 1781b6cb793c..daeec7dbd65c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1131,11 +1131,37 @@ struct regmap_irq {
 		.reg_offset = (_id) / (_reg_bits),	\
 	}
 
+#define REGMAP_IRQ_MAIN_REG_OFFSET(arr)				\
+	{ .num_regs = ARRAY_SIZE((arr)), .offset = &(arr)[0] }
+
+struct regmap_irq_sub_irq_map {
+	unsigned int num_regs;
+	unsigned int *offset;
+};
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
+ * @num_main_status_bits: Should be given to chips where number of meaningfull
+ *			  main status bits differs from num_regs.
+ * @sub_reg_offsets: arrays of mappings from main register bits to sub irq
+ *		     registers. First item in array describes the registers
+ *		     for first main status bit. Second array for second bit etc.
+ *		     Offset is given as sub register status offset to
+ *		     status_base. Should contain num_regs arrays.
+ *		     Can be provided for chips with more complex mapping than
+ *		     1.st bit to 1.st sub-reg, 2.nd bit to 2.nd sub-reg, ...
+ * @num_main_regs: Number of 'main status' irq registers for chips which have
+ *		   main_status set.
+ *
  * @status_base: Base status register address.
  * @mask_base:   Base mask register address.
  * @mask_writeonly: Base mask register is write only.
@@ -1181,6 +1207,11 @@ struct regmap_irq {
 struct regmap_irq_chip {
 	const char *name;
 
+	unsigned int main_status;
+	unsigned int num_main_status_bits;
+	struct regmap_irq_sub_irq_map *sub_reg_offsets;
+	int num_main_regs;
+
 	unsigned int status_base;
 	unsigned int mask_base;
 	unsigned int unmask_base;
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
