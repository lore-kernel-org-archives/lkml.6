Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A15204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd7PhlVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A15204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeKAWQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:16:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33000 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKAWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:16:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id q5-v6so5326544pgv.0;
        Thu, 01 Nov 2018 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K/UZKMyROPf83f0UxSJeA3os/fw2EDFboY7BMLq5Mss=;
        b=rd7PhlVMR8Cast9Ra8kTK6/IqL/iFzEetx/2bugsr6uOUAF9RWYdXyLtwm3YTqwq7z
         dfi5YOBbhBZd/cVMQS7tozk7Bbk2ZI4exugSkAnYgbfYsB5jR9quZ474t5HKM/qkd9Pd
         SYgI1gwbikdTR/9kAh14R/YEEPx9WGNhlP0AFcmYBZdHK1gOBV0olgEoH4OqfMv9H+x+
         N6Os+vNw8ZiCd6zq7RYNwmZgGm8KpRo3bBeaqxD2Mx1WovLW76zV0JccT8DOeeY5TbeX
         Bb44S2KQXfSqrZOFj3U+brUzGxvxR/iDenVnxRnCU08xqobXMiGwYTvrEUjkvJKVcA4+
         bjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K/UZKMyROPf83f0UxSJeA3os/fw2EDFboY7BMLq5Mss=;
        b=kiFvA8p+ffpA9yuD6AyZKaasrvY6Hv9TWG0KZQkjZzU4SGNt6sNUIQaZ6rTmGmFG3w
         eqdIhREFaPOktgPv47qgtKV1oUm6zvoOHSEfMsRK77BvCR3cNwOQRjOETcgDTl8e5xDJ
         FXvMn/AC3HAp89JndFJ2igcQOgiqZ17pJe/Lvi5jKv4xFwjvoSxJYtNMFBbk9NL+aIR7
         Dkq5XO4m+aPeC7bESvcxnIAaynPcwrbO5ULDE8UhHGStpmD5z5lus0Nt5OKIUIjLtea5
         0G9g0kV600e/NX0KPxtTmBVb7yxe31/TiQFuNbaYdSgqYvHaBkkSe1b1aN92d+Rw1mOt
         KJww==
X-Gm-Message-State: AGRZ1gLQzoQFo2bL1EXJRzXGfhO2+kcH4D2ANWYB516GXr0ftl3/Wqxn
        NmtfSOYxWNWGfZ1xz2CeB9olKQjI
X-Google-Smtp-Source: AJdET5cM/lybRs+kATNgZ5jg2nN8L/dF3IOzo7xpRHvGlL9kuBoTlWz3ahDOPuHZy6TcKQDKqWo4SA==
X-Received: by 2002:a63:e302:: with SMTP id f2mr7240523pgh.320.1541077992808;
        Thu, 01 Nov 2018 06:13:12 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id f3-v6sm31659442pgd.41.2018.11.01.06.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:13:12 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpiolib: Fix possible use after free on label
Date:   Thu,  1 Nov 2018 21:12:50 +0800
Message-Id: <20181101131250.41636-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_request_commit() copies the pointer to the label passed as
an argument only to be used later. But there's a chance the caller
could immediately free the passed string(e.g., local variable).
This could trigger a use after free when we use gpio label(e.g.,
gpiochip_unlock_as_irq(), gpiochip_is_requested()).

To be on the safe side: duplicate the string with kstrdup_const()
so that if an unaware user passes an address to a stack-allocated
buffer, we won't get the arbitrary label.

Also fix gpiod_set_consumer_name().

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 drivers/gpio/gpiolib.c        | 25 +++++++++++++++++++++----
 include/linux/gpio/consumer.h |  6 ++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 25187403e3ac..550918268549 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2270,6 +2270,12 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	unsigned long		flags;
 	unsigned		offset;
 
+	if (label) {
+		label = kstrdup_const(label, GFP_KERNEL);
+		if (!label)
+			return -ENOMEM;
+	}
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	/* NOTE:  gpio_request() can be called in early boot,
@@ -2280,6 +2286,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		desc_set_label(desc, label ? : "?");
 		status = 0;
 	} else {
+		kfree_const(label);
 		status = -EBUSY;
 		goto done;
 	}
@@ -2296,6 +2303,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 
 		if (status < 0) {
 			desc_set_label(desc, NULL);
+			kfree_const(label);
 			clear_bit(FLAG_REQUESTED, &desc->flags);
 			goto done;
 		}
@@ -2391,6 +2399,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			chip->free(chip, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
+		kfree_const(desc->label);
 		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
@@ -3212,11 +3221,19 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
  * @desc: gpio to set the consumer name on
  * @name: the new consumer name
  */
-void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
+int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 {
-	VALIDATE_DESC_VOID(desc);
-	/* Just overwrite whatever the previous name was */
-	desc->label = name;
+	VALIDATE_DESC(desc);
+	if (name) {
+		name = kstrdup_const(name, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+	}
+
+	kfree_const(desc->label);
+	desc_set_label(desc, name);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 21ddbe440030..acc4279ad5e3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -142,7 +142,7 @@ int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
 
 int gpiod_to_irq(const struct gpio_desc *desc);
-void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
+int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 
 /* Convert between the old gpio_ and new gpiod_ interfaces */
 struct gpio_desc *gpio_to_desc(unsigned gpio);
@@ -465,10 +465,12 @@ static inline int gpiod_to_irq(const struct gpio_desc *desc)
 	return -EINVAL;
 }
 
-static inline void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
+static inline int gpiod_set_consumer_name(struct gpio_desc *desc,
+					  const char *name)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return -EINVAL;
 }
 
 static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
-- 
2.17.1

