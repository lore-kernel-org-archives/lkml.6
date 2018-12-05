Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384CB2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHwdU6US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384CB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeLEMsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41427 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeLEMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so733589ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AByHMOP3S01NinyElG6HmeuOLN4IWUXl2HPqQubasw=;
        b=KHwdU6USscCF/4a1LQxFqOmSbcfva5RfFEiVtKCJ57nfdTXetVjAPKMnfaTs2mLp1e
         HeC+6+QT6Q0OZcCRSyZ+yFTmMx7A7FHwFNOC2k2ymgTM+U47gMDDj/4C2Pv6iUufa3m8
         lGbwGevATPK87shLl0vP1HQt1mAVxJsTTKByI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AByHMOP3S01NinyElG6HmeuOLN4IWUXl2HPqQubasw=;
        b=P+CI0rjPGmNOxTeVfnyot4utmpyrISxL8mft7+8nG+CrjEmlUMQ/URLs3pSQp8ACzJ
         ccYU2N43VZKzK0/DuB8tVFnNCXIfI9P2H1i293e8X02X2fJSVhC3bZoZ1ShWke5Gnkm4
         8Hh/DGjRV1cIxALdseTPgJ38BCDyD4Z9sLlBcaSuPkZNoWftxbQtF/Alyf2zJQDo0lIV
         tNpf/TNYRAQu55iwLa4aHmfGFXkg9kGSpL60xIF39twAtuuvhbQN9PqmjvSsfPGD0jM6
         Wq7AfKUeXl1ARFnJK7c/rL/zOQf16utWo+L+OkdgcuCPdCkIvi02N6ZX/V7GVnntFEJ5
         hpTA==
X-Gm-Message-State: AA+aEWY/DMrudoD/2aqXIlFDym6WMXMWas5IhUymLtr7yvQTWUoiBOZs
        ywIRc8aauJge868AU0QPMeFghQ==
X-Google-Smtp-Source: AFSGD/VM/MfoR3Es4k/+D7xgt1tNBKbFhavNpaEiUIZQ9fOY9ux8Am55wgV+jlw4HtGGJY+1w/HTYQ==
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr17428594lji.60.1544014072481;
        Wed, 05 Dec 2018 04:47:52 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/15 v3] gpio: Add devm_gpiod_unhinge()
Date:   Wed,  5 Dec 2018 13:47:17 +0100
Message-Id: <20181205124721.26624-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
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
index a57e968025a8..e9a17ec4de02 100644
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
+			     devm_gpiod_match, desc);
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

