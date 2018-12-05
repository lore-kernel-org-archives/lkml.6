Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B37C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBD42082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK7+AjO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBD42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeLEMsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42162 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbeLEMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so18197207lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wc1j/0Qq8o4SJIOdzJVRjBHOW+PSsZdnGaM6qp9lzlo=;
        b=HK7+AjO8+Q+QJM1J2np4NUI70PHgLQmmlqMs/rhoNn7mW6teTjDBtS92DmX3SyNjJ+
         eUSK3tUSLMVH8f/K3SNllbphg0r7+rwhP921052TwI+xUvJBMF4EBcjiQU6uaSUG59mu
         kRc+MHSiYcVys8DWVOCD9rg14vbp/L7Fz7o6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wc1j/0Qq8o4SJIOdzJVRjBHOW+PSsZdnGaM6qp9lzlo=;
        b=q9RrgBzK3u/PptOgpbw8YQ+LbyyT6JSb3jPwbufqqrFklVZsRWSqNg9mZD3ksTLvPK
         YiQmw/6/syJjzeGu64sJaW04BZiIYt7i4u/Knsh3pbRt3HM3BC6WYlo/s2HGeVCnAt8N
         kUlEsnTkvvBQxLD96zyLZ/jmsEcoucsfbczOuMRkO5S5fRBgy1Hv5o3MKQX8KhHkyhWj
         /YeZiYvbU82N00bSXF8Yppqg019BW0hy47kTFfwOKv93A/Zg8DzRowfTj70NVvolgF2X
         wfMhgznHzqnpgeU84anuCGjOKq59/gMpSAyG6gTjtlctPccakHjR9iolheuQVVri+Abt
         qCdw==
X-Gm-Message-State: AA+aEWbKq20YJapFxWrGCtMNe7il2BnqhjBWN2vl5s1kLTtGmffyzX2V
        ZlSpKKRqOPIDy33pMHLv7mWYHA==
X-Google-Smtp-Source: AFSGD/U8tmqe30uH+91N1L12IvBq6S5uPAyAA04iJ4Bj8IKoPxPNYBht1pAHjMVMLsjJgcEkd382DQ==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr15366401ljd.45.1544014064091;
        Wed, 05 Dec 2018 04:47:44 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:43 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/15 v3] gpio: Export gpiod_get_from_of_node()
Date:   Wed,  5 Dec 2018 13:47:13 +0100
Message-Id: <20181205124721.26624-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Resending
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
2.19.2

