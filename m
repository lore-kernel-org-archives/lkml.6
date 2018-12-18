Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68797C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350EB217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVHe0mJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLRKMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:12:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:12:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so7598681pgc.5;
        Tue, 18 Dec 2018 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eB7spxvnRVzN64veVyAd+oRPwk/YF9AvoB3zSfrDoHQ=;
        b=PVHe0mJJnKQ4CZTVx5O10lu/FZg5OdeoH35Si01XPfW7s77k0MDM89wycUwOVedHCb
         xOJJjTEIuNRVVSscNWQlpY7ZwziTY7ZwoSrF1WFlqu9kkIz85nLfLL16OTGSQa1VOTJ/
         AgaAMBN507tUHv4VTjrW98LCQU0urOArODcHr7NKqQasY14kUE93FBRGqCw8Tlrn1m4u
         Eegdu4bK396WQWdBvaKs0XIyMVKi+75ZZIjVWSkdolhjBBoA5tHB8bhJQtCnI9Zy0py/
         IUBYNF+k9IouW05EJj1iwIfuhVwMRTPQHIQzFi3kKS17LWnX7Zot2Eky+mRpocwnSBhA
         i24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eB7spxvnRVzN64veVyAd+oRPwk/YF9AvoB3zSfrDoHQ=;
        b=OXm8zowePJ4J3/wQxZErZ4uFPUh3cL72TtBSnqtvMAmkj5z4L9/tZIOOesVBotpIHm
         YMbDkswCgdabUNiauS/s4W+E4tycjSWqaSZty86Q9ewzzKgoFH7X6PuRXMns59xbSj1T
         z0+Vd2DWonA139yMOkAJQt3+uLDU+9HfX6qfgw7IsIGp8veMtVvlB1DCmDdkkQ9eY3QU
         Tilji0WSQGlrFICEcdW8ZwRQDj+lIbvBQcX1v6zYy7L1aLRmHVLJVUAf4QX/ASJxkZ7n
         iUwsUxy9uWCDP0bc0owhMH8wYS6fsgoH/FotejYmv5/JC2P80eXNJSvQO6sr/vAU//x8
         5NtA==
X-Gm-Message-State: AA+aEWZsBV8vQFMfGoYectTOtd2FTbRKyd7PtXB5ex7colZ/ZdEvLmAa
        slYCmHxIPxCq9yceBUt3ghA=
X-Google-Smtp-Source: AFSGD/UHdZ2aoK7C83n7xjxD9okxNe0z4Ssc9DY7/JWBAAIA3hO+1gwfefMLff9fYZR/YZJVb2DoFA==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr15802212pfj.58.1545127951505;
        Tue, 18 Dec 2018 02:12:31 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id t67sm26244979pfd.90.2018.12.18.02.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:12:31 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 4/8] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Tue, 18 Dec 2018 19:13:01 +0900
Message-Id: <d0d9964fe206c68b8fa731a2be28a1e482eb9928.1545126272.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545126272.git.vilhelm.gray@gmail.com>
References: <cover.1545126272.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 36 +++++++---------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 88dc6f2449f6..fdf1b8b64cc4 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -93,42 +93,20 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned int offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = idi48gpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
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
-
-		/* read bits from current gpio port */
-		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, &port_state, offset);
 	}
 
 	return 0;
-- 
2.20.1

