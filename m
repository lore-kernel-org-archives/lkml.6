Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D2A21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVDwNNN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbeLSGCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:02:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40112 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSGCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:02:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so8974148plq.7;
        Tue, 18 Dec 2018 22:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsdsM+RlRyjEYiOfR3l9qfrS9JfRbsBc4uOym3o91cU=;
        b=FVDwNNN4/QEW0JxopFOPAytCm7K0c+FbApWoylTZAy6V/YU+SwJ7LYw3AkdXHZ8Itp
         zEpdHAjegbfja/7hHlB4W7q+Lf2w6QArmUp1gEU09dMnI/8NbDNq8gUtSlQmerFU9uWm
         lNJjFXudlbdzpFjlcWYhE/pL+O/wbm4JWyai+pSguneOq4iV5ZNZIdPwrY+74cGpuLmY
         +n5m4d+BnHMzEefGgJhcmjmbqwPvdy1AC4GL9bJIn2nrc3D9P6xiUdIRKYLCIfNK8AQc
         FovsZjaAxZ6Y59MOfYPm6ALbNJ6RPov6fvqY8r+LDEST1Xg+ac2Ki7/AuJTlGeLpRWCF
         +2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsdsM+RlRyjEYiOfR3l9qfrS9JfRbsBc4uOym3o91cU=;
        b=qpUoHvYTTcKCcCdXSDf2xcoGKIS1k90UW9Wle+EgHuw5e4nkU66fJNsFg6kBw7XRat
         y0l0szot1xInr5IaBtVLJQBxTUDYJpy5C0m/PFM0gOoYUKM/HD570I/ATAyYMcichy0d
         jSDyw8OZHz/2lnXy4hu0EzudiMiX/EJrpoOnywG8ySMRaaK75qWmku02+rFcGXW62tCR
         YOjogMSMTatHzRr+/ZyqOHE4b6eYI2XMMLm3v8UVOyhZZUYKsHcFccupVI93H/Of9EhF
         t6PSDeeeKGtY6N++MCfjtdur0izxhX9mFjUKu201bWrtuRFms5doLBjhmEGtVGFFKyXM
         wJ3A==
X-Gm-Message-State: AA+aEWZpprNzjsRSyzcJtWF0yM4088rsBC6MAty5lBVJv4aeDt8Zwaaa
        c6JDfVFuApdHQFwWBwUDodI=
X-Google-Smtp-Source: AFSGD/VVrN2SKlSw43k8ZzTjfFOFnm011I9x2XD7QFckTwebxE7SOjDaP/lPJtiUnAxZ5tUTVaxP4A==
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11mr18410953plb.251.1545199331909;
        Tue, 18 Dec 2018 22:02:11 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a2:eb51:6018:45d4:55a2:e94b])
        by smtp.gmail.com with ESMTPSA id y71sm35607348pfi.123.2018.12.18.22.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:02:11 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 8/8] gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
Date:   Wed, 19 Dec 2018 15:02:41 +0900
Message-Id: <e3209836fdc9a2d7a4aad55dc5e102e7c131ac9d.1545198260.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545198260.git.vilhelm.gray@gmail.com>
References: <cover.1545198260.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pcie-idio-24.c | 109 ++++++++++++-------------------
 1 file changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 52f1647a46fd..b1686b052633 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -198,52 +198,34 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	unsigned int offset;
+	unsigned long gpio_mask;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
 		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
+	size_t index;
+	unsigned long port_state;
 	const unsigned long out_mode_mask = BIT(1);
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports) + 1; i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
-
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (i < 6)
-			port_state = ioread8(ports[i]);
+		if (index < 6)
+			port_state = ioread8(ports[index]);
 		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
 			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
 		else
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		port_state &= gpio_mask;
+
+		bitmap_set_value8(bits, &port_state, offset);
 	}
 
 	return 0;
@@ -294,59 +276,48 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	unsigned long bits_offset;
+	unsigned int offset;
 	unsigned long gpio_mask;
-	const unsigned int gpio_reg_size = 8;
-	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
-	unsigned long flags;
-	unsigned int out_state;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23
 	};
+	size_t index;
+	unsigned int bitmask;
+	unsigned long flags;
+	unsigned int out_state;
 	const unsigned long out_mode_mask = BIT(1);
-	const unsigned int ttl_offset = 48;
-	const size_t ttl_i = BIT_WORD(ttl_offset);
-	const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
-	const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
-	const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
-
-	/* set bits are processed a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* check if any set bits for current port */
-		gpio_mask = (*mask >> bits_offset) & port_mask;
-		if (!gpio_mask) {
-			/* no set bits for this port so move on to next port */
-			continue;
-		}
 
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
-		/* process output lines */
-		out_state = ioread8(ports[i]) & ~gpio_mask;
-		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports[i]);
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
-	/* check if setting TTL lines and if they are in output mode */
-	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (index < 6) {
+			out_state = ioread8(ports[index]);
+		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
+			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		} else {
+			/* skip TTL GPIO if set for input */
+			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+			continue;
+		}
 
-	/* handle TTL output */
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+		/* set requested bit states */
+		out_state &= ~gpio_mask;
+		out_state |= bitmask;
 
-	/* process output lines */
-	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
-	out_state |= ttl_bits;
-	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
+		/* write bits for current gpio port (port 6 is TTL GPIO) */
+		if (index < 6)
+			iowrite8(out_state, ports[index]);
+		else
+			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	}
 }
 
 static void idio_24_irq_ack(struct irq_data *data)
-- 
2.20.1

