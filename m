Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F41C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5527F20878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6kVu4bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfALBtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:49:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39790 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfALBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:49:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so7536211pld.6;
        Fri, 11 Jan 2019 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTzVoRUCUmsw6JJQwL/GudbwLQByFCx/7cmwrU+BhiQ=;
        b=e6kVu4bL6SYzmzWgExnsZ4tMFecdyv1391hJc3SJ+oqyDZzKQj1o1dUJ4Lcoc1DPk3
         DAOK473DbR+W8wGKmjoWhId4qoQ/e4ZhHGlZecwEKmv9n7DYIdatsyTNhyaTYVqOeb65
         bQogce+rubiY17R63wworsNdyZGIIBZ1rw/oB4JLp1H581sBrZTwQu4unPRszUukHQAL
         PxJBhMwJyEzz65DYjeMqSFT3waMsFtMEF5vTwyD7+ZarFbOyOAtgObc+XMd7ksduxVgB
         XyLaBTSsNCZ/RCVOEbmQKAR0nFqA0j2ZTLgoYeWc5Pol0gIgopd2V1kHz8l9SPvPJ2n1
         r1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTzVoRUCUmsw6JJQwL/GudbwLQByFCx/7cmwrU+BhiQ=;
        b=iHSpXskB1iwhbuiJ71/9KU0/H+vzAVeOpItlBh6WqchSga4P+FMV9yLhGVIbnSV1W0
         7AxxjPJNTlcr2T3na7BJUw7oPXWGNIGmUK/foFaQuv5ZXTiOb/woJ+y3r6REYb+J2GMw
         qmTMv70FMVfQX+yXTkGSkdC3GHHuTQfU/PpXB4N6/TRq2UN+qbJMlizmjb9LyHSW+SE2
         I5AmyKYunlFwcfPn0L5i/o66j6G76scVOJNoYtVgM7PIJJexS9cIfd8OluuAJvSR5ymz
         38PrftIEBtPV99rNOe1uYsBihegJKuztkwd+ZyaaXI0YulOj29fvIP5dDl5cyfI0J/ln
         bUJQ==
X-Gm-Message-State: AJcUukdzrnn7pQTn9oi3bsZ8BOefp8ZTqqpq0CNEygPsT+3al3neek7X
        RWQsRYU7LI3UDbsNUsy0eCg=
X-Google-Smtp-Source: ALg8bN42pcs/xbMT69wcX9Q9oTApAADZGd4X598hcehGjxC63qcge3SSW63EH+yLpvOD/EGGlFNSMQ==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr16489635plr.207.1547257760516;
        Fri, 11 Jan 2019 17:49:20 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:ffc5:36e2:bccb:ba63:9e84])
        by smtp.gmail.com with ESMTPSA id 186sm157318979pga.36.2019.01.11.17.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 17:49:20 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 7/8] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Sat, 12 Jan 2019 10:49:57 +0900
Message-Id: <e71162ab659dd96d345ca7954fdc744e2a436dbc.1547257386.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547257386.git.vilhelm.gray@gmail.com>
References: <cover.1547257386.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 73 ++++++++++++---------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 6b7349783223..f115b923ae98 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -108,45 +108,23 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
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
 		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
 		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
 	};
+	void __iomem *port_addr;
+	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = ports[offset / 8];
+		port_state = ioread8(port_addr) & gpio_mask;
 
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = ioread8(ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -186,30 +164,31 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned int offset;
+	unsigned long gpio_mask;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	size_t index;
+	void __iomem *port_addr;
+	unsigned int bitmask;
 	unsigned long flags;
 	unsigned int out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
+		port_addr = ports[index];
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+
+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-	/* shift to next output line word */
-	*mask >>= 8;
+		out_state = ioread8(port_addr) & ~gpio_mask;
+		out_state |= bitmask;
+		iowrite8(out_state, port_addr);
 
-	/* process output lines 8-15 */
-	if (*mask & 0xFF) {
-		*bits >>= 8;
-		out_state = ioread8(&idio16gpio->reg->out8_15) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out8_15);
+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
 
 static void idio_16_irq_ack(struct irq_data *data)
-- 
2.20.1

