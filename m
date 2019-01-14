Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02985C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEAE20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dduoQW1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfANGVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:21:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:21:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so9847697pfk.10;
        Sun, 13 Jan 2019 22:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtSlavy6basnrDt/fOWzpNK9lxbtu0hFAZu180ujMNc=;
        b=dduoQW1sLD0f5KpmFd4SU+xHnO+HBYNobgDKySwEaKE+UY3E65TykvTI0e1ZA24cIS
         14ebl/pJgYYw8IzWAAiGAIUDzgRXITTH0QJktY4/hC85DDmJvEjr/FGsmBS3xos2+N31
         1kTX5EADs148yT39Z0Lg29BC8P1He9vLpbY3cFWbiLOTX5bjaGKokmR9Bh9iQU42RR5w
         bI/1It74ouyc6U0pud9w+P2j71rGavDH9KkMKeY9CbUm1S3719BiGNW9gLc86rDJUFq/
         AWB06SbIKS/3QVNe2VqPJ3tx8sdfnt/4eB3sxXaWhLHcZ8oXVIfNFtwq8pclHcfvvkXt
         Py7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtSlavy6basnrDt/fOWzpNK9lxbtu0hFAZu180ujMNc=;
        b=szgeBNEvabq7yrNFPjY3uGUej7V6VgBQl78LAYpuAOZjInRiWTEddEQ0atCPrJjisc
         rUibxjtRUWvZW5Qwl6cI8TJU63+GQOT9q/zhSi6VjWxEVAEj6k1pURnGRIr/r59SqYVE
         +kK5y5LC06eE6sRCibuMPSHtSil9lpxOxhnblgFBDe2sZc9bF8saKouvGBrCOUJlSIcl
         tuLhQFWhWR/XiiFARgj3ABUzjos+Ogu//V/PteFVh40ZJuSWNzpDVaglHJbFjtcetN/w
         TPOALEBbmNe7lrY05ylb77oARpsUvtOWEjvw8WdWUGbZqK/nDtMDS3UG/X2B34AEYZM3
         TF3g==
X-Gm-Message-State: AJcUukcs3cvvwa4c4oAlWmQIr7aWNowABzoXAduorBjGk7OQUocAomuE
        Mm4t+Uf2CwCvBVIGBLgIU5xUbkzm
X-Google-Smtp-Source: ALg8bN5H60EJwpE9PA7ig6uINBXF29Q++SqjGZpd5bmPQYVo5C1fbDy9LFCm2gNInmVzRqT/8Jn3aA==
X-Received: by 2002:a63:4819:: with SMTP id v25mr21480405pga.308.1547446868010;
        Sun, 13 Jan 2019 22:21:08 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:70f2:4411:7de2:8afe:823b])
        by smtp.gmail.com with ESMTPSA id 78sm154538629pft.184.2019.01.13.22.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 22:21:07 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 7/8] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Mon, 14 Jan 2019 15:21:41 +0900
Message-Id: <161c35dfd29fc87463746c3e6d4306ac9c695a9d.1547445576.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547445576.git.vilhelm.gray@gmail.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 75 ++++++++++++---------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 6b7349783223..b0ed6bb68296 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -108,45 +108,24 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
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
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
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
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
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
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
@@ -186,30 +165,32 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned int offset;
+	unsigned long gpio_mask;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
+	size_t index;
+	void __iomem *port_addr;
+	unsigned int bitmask;
 	unsigned long flags;
 	unsigned int out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		index = offset / 8;
+		port_addr = ports[index];
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		bitmask = bitmap_get_value8(bits, ngpio, offset) & gpio_mask;
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

