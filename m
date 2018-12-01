Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D06DC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DA720834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2pzSeKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DA720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLBDGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41976 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeLBDGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so6199677lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKBvHfafiQ4kCpEJu7bit7Ossq558os4BIrgEwZdU7g=;
        b=I2pzSeKIFvN8gmFrIykZ6uJTglYZyR5CRTkfC6bB7qEWQ/YcmlGR9CFfgqi0Sz2Jon
         hje/27hhg52448csivuTpbC+pr5wBzOBVAj5B6Z7KSFKhnx7FW/OucIKyv0ByliW5LSy
         /PkkIJgF96tKcUsMm9AYCbnNMM7eRuzlfUUOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKBvHfafiQ4kCpEJu7bit7Ossq558os4BIrgEwZdU7g=;
        b=FrfeH65nVUCfWQako3+HzfM8jqA3s6CvW0Nz4pXrnWL3n9X+LcIUj2DNkpC6wMYZ38
         ybSEyRwC+jhllyAS3Lz7oeV6U9wuZbXcCx0a+NZjx8W1d/Q1FR4nYXeyk/ithNNQ17wZ
         Z68JxnkME+FvauOdsB8ESCcoinlW+/I2lXav8o9Lpl3Ov5NiEn5p4P2bJalflmwQrewm
         zWvvqr0NC/wouR1i0+ZistVZaK8AQ+l88MxB4hchsoxWkpWdgM3f2gADPnej9kBuJRwt
         YQ8sg9lTeCokRz5DLd9o6bqRgMfIPXDC5cr0HwZRYAZEtsdv8vl5oRqp938aR3t16PrU
         ClVA==
X-Gm-Message-State: AA+aEWZeIkpQ+APG+8F+zOYC6KrG2D5+g/73ZlAGunIwwmY2mRHL/AWs
        jzbA1yyn7NAipTPz2andKSOVIg==
X-Google-Smtp-Source: AFSGD/UIl28eZygtAXaWS36HYMnlHsR6cyctfC0deWCktAbfOKaI0d6xt+kf8JiLc9PRsxLJhDH+Ag==
X-Received: by 2002:a19:d70f:: with SMTP id o15mr6031149lfg.134.1543679600779;
        Sat, 01 Dec 2018 07:53:20 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:19 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/13 v2] gpio: Add devm_gpiod_unhinge()
Date:   Sat,  1 Dec 2018 16:41:47 +0100
Message-Id: <20181201154151.14890-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- New patch to be able to hand over GPIO descriptors to
  the regulator core.
- Mark: feel free to apply this to the regulator tree with
  the regulator tree with the rest.
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/gpio/gpiolib-devres.c         | 17 +++++++++++++++++
 include/linux/gpio/consumer.h         | 10 ++++++++++
 3 files changed, 28 insertions(+)

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
index 01959369360b..5864e758d7f2 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -320,6 +320,23 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
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
+	WARN_ON(devres_destroy(dev, devm_gpiod_release,
+			       devm_gpiod_match, desc));
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
2.19.1

