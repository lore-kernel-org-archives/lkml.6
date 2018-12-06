Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13177C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB5520989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Exs3l52N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB5520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeLFMoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35143 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbeLFMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so306098ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6Ox8Mcvx6qj2ecBv6EZkuh7tLbIfkFEDjl421pVmOo=;
        b=Exs3l52NznD1n7lUvDbYRlz83GaegJEOGuuT2CAyvobNmKs23nhCZ9PQf1619Xslnx
         5Aj77Y++cxygbOfwBS0zSPPvOXl6LEFDZ28QEXFwYBzd2tZ+xS17KTpWJSsaE5FqtCuY
         4gORsEiBnZzcM4yheYQlYacST6D65sWcHB/LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6Ox8Mcvx6qj2ecBv6EZkuh7tLbIfkFEDjl421pVmOo=;
        b=DCsHTQgVWlw98CvJoqjS1bMk1L6X2jhBI1//izkZGKZTHL/jdc5IzA9ra7Qi/amKhQ
         wGQABK2trrXbxaMH77yXDzxHA2iDRoyukLNSBbXALPUIFJpkGwbXlKXkf3T+8ydXyeUr
         1EI/hhEyGLduXH3JmUFF2ZFLMZ/iiv9nX7H3ymKZZacF5akcAAoI4WHWRYL0ECl8yr8Y
         mcqZJBpHJGM3oLdloMllTJCCwYHAFNuUlhTV0fLflmWFnZXxEMXtnB3To5nHQbXRU6jv
         HDx7+4D0xgX5EeBJYvXMLq6xE7UtFi/+3rUK4oB8xsjACLkDOZaTQ3pskPeJ1qCCuEo/
         UKEw==
X-Gm-Message-State: AA+aEWY5w0vMI2pUgVo3ch7RLyYeqc856kLu0bLlLgf8FBOgZXyZoIA+
        Sv3CWbDmxJapxY7raoAdzP9H6g==
X-Google-Smtp-Source: AFSGD/W60SVeD65O7FW1CLhU5jd+wsS8n9jVxsjtv0Ks5T+Bt8pQPNRilH1hS5mYi+ui6dzO6yLawg==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr18270637ljg.155.1544100252514;
        Thu, 06 Dec 2018 04:44:12 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/15 v4] gpio: Export gpiod_get_from_of_node()
Date:   Thu,  6 Dec 2018 13:43:42 +0100
Message-Id: <20181206124351.10155-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Resending.
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

