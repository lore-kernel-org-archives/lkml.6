Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9825EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664552147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qzbltHKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfBSQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfBSQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so8168320wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=qzbltHKXWbDw/IvHCCnOWfsvc63Iy5VsInYiFsTPn8q9qmSHsobcWtechV/JWEryR4
         aazjyrbVVJ+TqfvDjM+yKn+7anRUTTpPJW/gCXDgJz4pG5S0kZQUD9ubukXma1kGGnIF
         3VjIPipTaxPw+Ecv7NJnubJIg7OgaQsOBEob0xgAA4j7IHDL+CB9tFUaJeny7Vhf9UV8
         hrxAf4hJOX2R4DxiRzUIIJD2+nzJa0R3/do/oC8jrMjv8ZfcEFFRgrax04waUkaR0l+/
         Ws9fdVulDZXFJVFsuBDBJf1b0sUDrUKx1S4RQHfSr8EK5DdDxaSvJXZrWK20qtII2PrO
         ncUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=lNvoAYNJo8pLVZSyQDwLY9SuLzgZ/uam3UOyRByZfROycEBozrV+J9KkDaa1FfHj5b
         kIPeGr6bpyZGARmuRvlEAT6piUOWdVNJmN9ukFpno6i4Qxy52+mCtpXeDRtrCkz4cB7w
         q3b9T1d2Whs6GrS/Ul/dhdFcNYtoxNc8a/qXJ1+dYbW/1IO7jQloXEn9o6e2czdqlDsI
         2LVIQfK2H4Jpef04Y3gIw3fkPT0fDtzcr5S7ViP6v6DjHJ8MpVLd+Xn93ACITtbYCDB1
         El6/z3t3gn6h4P1siTLZk7V6uZXVvGwn1cU8lqdzev+j6dT9lpYfhCHa1B07d1F5HUqb
         V3xA==
X-Gm-Message-State: AHQUAuZQeG0gK+mtAaPzkn4/6MY7+xcC+GK7UOg9sIM6KxdYeVPJJjmf
        vNs9aMN0PXDUSlpQJIHyscAiyw==
X-Google-Smtp-Source: AHgI3IZTzPFtEWcG/JMbQehUxXrSxPMfp50ZuFhnvMgOXrr/Nun1AJsPowYSY7OcgTXGoNouRezYSQ==
X-Received: by 2002:adf:9083:: with SMTP id i3mr21182664wri.124.1550592419798;
        Tue, 19 Feb 2019 08:06:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:06:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 3/7] gpio: mockup: implement get_multiple()
Date:   Tue, 19 Feb 2019 17:06:46 +0100
Message-Id: <20190219160650.9614-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219160650.9614-1-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We already support set_multiple(). Implement get_multiple() as well.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index b4c1de6acf74..1c945c967f60 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -102,6 +102,22 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	return val;
 }
 
+static int gpio_mockup_get_multiple(struct gpio_chip *gc,
+				    unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	unsigned int bit, val;
+
+	mutex_lock(&chip->lock);
+	for_each_set_bit(bit, mask, gc->ngpio) {
+		val = __gpio_mockup_get(gc, bit);
+		__assign_bit(bit, bits, val);
+	}
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
 static void __gpio_mockup_set(struct gpio_chip *gc,
 			      unsigned int offset, int value)
 {
@@ -327,6 +343,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->parent = dev;
 	gc->get = gpio_mockup_get;
 	gc->set = gpio_mockup_set;
+	gc->get_multiple = gpio_mockup_get_multiple;
 	gc->set_multiple = gpio_mockup_set_multiple;
 	gc->direction_output = gpio_mockup_dirout;
 	gc->direction_input = gpio_mockup_dirin;
-- 
2.20.1

