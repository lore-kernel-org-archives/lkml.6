Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756F3208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4Y9SCB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756F3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeLFMo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38811 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbeLFMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so246668lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0RHJZseajc2Hw4Z+KYKfKkiR8hwIO3G8Y+psnfNew4=;
        b=b4Y9SCB7D7zraqlNG7d7lOK10xEvKIP5VAAtxCJ+nEq3Jvjc1pEw1WosBwP1QCyeko
         7brm4VxHcNOiLQbaYmMAvZDdYrwJRpjFj7Z737OxwFwYlJ9ftG/43Vnd6x2epVLVW4X6
         4rSnlJTTTWWI3doFqTN+NUj0B6oYk4m9XQ0PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0RHJZseajc2Hw4Z+KYKfKkiR8hwIO3G8Y+psnfNew4=;
        b=n4ycO43DeNYBWW8T95A+6M6JpGH4pCedHBk8xkDX7lY9Q2GmXrwrAWC+949pnc/FgX
         CcNPNrzxfmufzh9Ql8PZEt21bBYHK3VQyKQbgenlGx3U3voHHYBzKEIxKPMohc/hRsLH
         +0tuh/Cppj+d6jl7hLjDDw92RCyOVnssA4r5UzZ8HCTFjBUGTdYrtfWiMRQU+jJvF6uc
         jM0XkptWTX/rFZNVqxhuMh11hblUntOa0S8lcpYe99AAt57v8WAeHjwFZg/TaeZiGezi
         93n7TjvJQf3fBTfvJwTSnFNmxGeMXG1+c/dHMdgwv8zMvsJzMppc8tfpRG0LFNtjIhbm
         lbWg==
X-Gm-Message-State: AA+aEWYUl3b9S1sc1RVl+LWE6gOoeSqrmSGKDpbGQ1oE7GZzao466yF6
        KAbe9TrfhRy2346PKDX3RILYww==
X-Google-Smtp-Source: AFSGD/VqUzgwmUggaBw2twxgQkWlHYzjqc2v/OzoHTIhB4pRQiUcvSV6kTUnxItNcVb4oiSB4BrMuw==
X-Received: by 2002:a19:5059:: with SMTP id z25mr16458447lfj.120.1544100260998;
        Thu, 06 Dec 2018 04:44:20 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:19 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/15 v4] gpio: Add devm_gpiod_unhinge()
Date:   Thu,  6 Dec 2018 13:43:46 +0100
Message-Id: <20181206124351.10155-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a function named devm_gpiod_unhinge() that removes
the resource management from a GPIO descriptor.

I am not sure if this is the best anglosaxon name for the
function, no other managed resources have an equivalent
currently, but I chose "unhinge" as the closest intuitive
thing I could imagine that fits Rusty Russell's API design
criterions "the obvious use is the correct one" and
"the name tells you how to use it".

The idea came out of a remark from Mark Brown that it should
be possible to handle over management of a resource from
devres to the regulator core, and indeed we can do that.

Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Pass a pointer to a pointer &desc instead of just the
  descriptor pointer: it is the memory address storing the
  pointer that hooks into resource management.
ChangeLog v2->v3:
- Make sure to bail out of gpiod_unhinge() if the descritor
  passed in is NULL or an error pointer.
- Accept of devres_destroy() returns -ENOENT: if we have
  nonexclusive GPIOs, we may attempt to remove resource
  management from the same descriptor multiple times.
ChangeLog v1->v2:
- New patch to be able to hand over GPIO descriptors to
  the regulator core.
- Mark: feel free to apply this to the regulator tree with
  the regulator tree with the rest.
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/gpio/gpiolib-devres.c         | 30 +++++++++++++++++++++++++++
 include/linux/gpio/consumer.h         | 10 +++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 43681ca0837f..fc4cc24dfb97 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -254,6 +254,7 @@ GPIO
   devm_gpiod_get_index_optional()
   devm_gpiod_get_optional()
   devm_gpiod_put()
+  devm_gpiod_unhinge()
   devm_gpiochip_add_data()
   devm_gpiochip_remove()
   devm_gpio_request()
diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index f9591b5c9748..0acc2cc6e868 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -346,6 +346,36 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
 }
 EXPORT_SYMBOL(devm_gpiod_put);
 
+/**
+ * devm_gpiod_unhinge - Remove resource management from a gpio descriptor
+ * @dev:	GPIO consumer
+ * @desc:	GPIO descriptor to remove resource management from
+ *
+ * Remove resource management from a GPIO descriptor. This is needed when
+ * you want to hand over lifecycle management of a descriptor to another
+ * mechanism.
+ */
+
+void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(desc))
+		return;
+	ret = devres_destroy(dev, devm_gpiod_release,
+			     devm_gpiod_match, &desc);
+	/*
+	 * If the GPIO descriptor is requested as nonexclusive, we
+	 * may call this function several times on the same descriptor
+	 * so it is OK if devres_destroy() returns -ENOENT.
+	 */
+	if (ret == -ENOENT)
+		return;
+	/* Anything else we should warn about */
+	WARN_ON(ret);
+}
+EXPORT_SYMBOL(devm_gpiod_unhinge);
+
 /**
  * devm_gpiod_put_array - Resource-managed gpiod_put_array()
  * @dev:	GPIO consumer
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 348885f2f3d3..8aebcf822082 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -104,6 +104,7 @@ struct gpio_descs *__must_check
 devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
 			      enum gpiod_flags flags);
 void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
+void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
 int gpiod_get_direction(struct gpio_desc *desc);
@@ -249,6 +250,15 @@ static inline void gpiod_put(struct gpio_desc *desc)
 	WARN_ON(1);
 }
 
+static inline void devm_gpiod_unhinge(struct device *dev,
+				      struct gpio_desc *desc)
+{
+	might_sleep();
+
+	/* GPIO can never have been requested */
+	WARN_ON(1);
+}
+
 static inline void gpiod_put_array(struct gpio_descs *descs)
 {
 	might_sleep();
-- 
2.19.2

