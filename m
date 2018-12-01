Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1252146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFpIXWvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1252146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeLBDGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45218 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeLBDGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so6179823lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrPFi/hYRcSPeEznRnCiUx3rZp8u++LmCL/2uJqnCDA=;
        b=KFpIXWvX/c7KhKGC2JIPNiTBFev/AFC5/8JBt3xSiKj9q7RUbEK2RmjHLOAq7ZI/dH
         Pniq4IyCwgKEqkqknDyCXy6e6BB228uyedRfGLqAyQEVGBX0zyJnCP4yaD8Cghsje0dX
         gwwszSAHDIlrrako15Fn5N6CyByDXBsehnlCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrPFi/hYRcSPeEznRnCiUx3rZp8u++LmCL/2uJqnCDA=;
        b=E+niyMj7s1WPV08sPqucLz+oJkMQdIQ88XiJTx6rwV/zJFWVZqCL++EMcISfaeYszH
         6zvyLCHFmU7L6snZdm+NBfrWGbyr9QSO01xWhw/Ehi9sz2qCHTYC1J+WOU54Fn8Ivh/o
         p5x/rhdfX0i8KVZqO4ftMi98fMITVBNnv5US/r/VOfIH+It2t8Dzdzzl356WWyQM5PWu
         vA4hH8eaH4aM8QnoTRtvfvrGXtBGtkHH+JNXvG1nUAeCZvILywT9o0X0GKoHDuXCnpnZ
         1uEz0mWCeTCGR6watKDMv+AIeiHrAfebQ7DmTuWPuUGgEoHrZq37H8MyNLri4mZFr2Cr
         JZpg==
X-Gm-Message-State: AA+aEWaZZQYK/Dc2fTt6G36ZiGCo7Yu0NJTaYJ1EjoDTmtUX3VhcMVA9
        fWBpSBV1XNO9dS+3pizZhVY0Fw==
X-Google-Smtp-Source: AFSGD/UsTbprOtvz2Yf+2zDKNQXvjD6Ya99FdSXVTLSj6J7TKpRwClH5baMJX51bzJ+jRNuxd3FccQ==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr5654825lfs.42.1543679596440;
        Sat, 01 Dec 2018 07:53:16 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/13 v2] gpio: Export gpiod_get_from_of_node()
Date:   Sat,  1 Dec 2018 16:41:45 +0100
Message-Id: <20181201154151.14890-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
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
2.19.1

