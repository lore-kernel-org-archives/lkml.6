Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BF1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF92208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Txmgq06A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF92208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeK1VpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38873 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeK1VpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so18991209lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bERN1gHWFFWu4y/GIu0q47eugasKcAfYPgxYimfWOAc=;
        b=Txmgq06AWyWIxs4oH0GnuLdSwCl+s+vYjxdAXtWTOtv5nzK5nHs6kmoQlKhE3GBNxG
         PNOfSWKb0DsJu5SRz3Ty6JsYXgEEz/H0Jme0TNgcFwMHqZaVq8P6k4K1s6iMdnFc5iDC
         uQSZs6jI93XZ32u+34ifKWHdZ0ozCWciZ3gcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bERN1gHWFFWu4y/GIu0q47eugasKcAfYPgxYimfWOAc=;
        b=YTfrzd3utX4fwJjA5jB/XEXTmy6HmFYBoc6wbWAXg/Ry3geugFxIj77A3GGZ51oqdc
         U1VFG+9xIutIse6LRi5KqUhLM7wmWwUontEJoesiJCQTP2RylDFa3Vkz8z5ORktLf9a1
         guEm9AbPOL0BChM1HF6gEN/cbXz878Uj2t+k98HQa/aUH9hnQ3nRsUzxPHA5WpHDAN1P
         BxMt6B3wQuCblsnHykTXcchy1kF0fkzoSM5lwhRk9ipuAQGF8/RksiSDPO4mdOnfYbT5
         AbQmW2Z6jjRuJmARriqeApJPgcnw4E8WkRp/7ADpfZwAIvmRAo0EqLLeKx9Z0r+Xg117
         TM6g==
X-Gm-Message-State: AGRZ1gIc6tesr/RJ3QplaWzPStBX8r4AxSlI3LjfujGR84FDGZiBkJhk
        xPOXTa4u8tpQHT9TXJCK1AjwdQ==
X-Google-Smtp-Source: AJdET5dsnadZXkRDC9ELeQyp9K+BcgSRVbRd958fr3IRApDEX6r1zqRcv5lDJ0iJB28/IXJSsUQWEw==
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr20889914lfl.115.1543401848298;
        Wed, 28 Nov 2018 02:44:08 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/10] gpio: Export gpiod_get_from_of_node()
Date:   Wed, 28 Nov 2018 11:43:46 +0100
Message-Id: <20181128104350.31902-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function already exist inside gpiolib, we were just
reluctant to make it available to the kernel at large as
the devm_* seemed to be enough for anyone.

However we found out that regulators need to do their own
lifecycle/refcounting on GPIO descriptors and explicitly
call gpiod_put() when done with a descriptor, so export
this function so we can hand the refcounting over to the
regulator core for these descriptors after retrieveal.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.h        |  6 ------
 include/linux/gpio/consumer.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 087d865286a0..bc57f0dc5953 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -201,12 +201,6 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap);
 
-/* This is just passed between gpiolib and devres */
-struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label);
-
 extern struct spinlock gpio_lock;
 extern struct list_head gpio_devices;
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index f2f887795d43..348885f2f3d3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -172,6 +172,10 @@ int desc_to_gpio(const struct gpio_desc *desc);
 struct device_node;
 struct fwnode_handle;
 
+struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label);
 struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 					      struct device_node *node,
 					      const char *propname, int index,
@@ -517,6 +521,15 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 struct device_node;
 struct fwnode_handle;
 
+static inline
+struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline
 struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 					      struct device_node *node,
-- 
2.19.1

