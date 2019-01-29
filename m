Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C5C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8512177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lyKX9xki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfA2Iob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36211 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfA2Io3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so16715376wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=758F2G6mHwZtHqDlM/wuN9QC0Q3bwGTIieLyA4J0jgo=;
        b=lyKX9xkiI/Bovn76zRMXJO30jERWYnJHRj1nbY9VwTRItB8f+F68u07LdTNwMtLeX2
         X3ooOKBVT/qgY1uoEyFq9QuzXUbdTLSmGzTq9iuIAPpDm1gbtyeqEPmSPHXmsFnpIp1N
         xGNEM/DsWCvDe/IgcfNV1uMUFj3I4Hp1MGhuKpX3HXfDTAkNfTcdQqP9ncoy7lAJMIp9
         2ceyhF7D40/4fyZ8dEB9cEVM1LLmLovFxhQdfOSUIZ1KRzsGxlfB8tWZpIQY9N/LgHY3
         tXK23cl3PGGz2+nCGSxpPKr0TMmMj9+F972KnYQBivI4BTUeVVUSFuLkpTQcSwOgKIe4
         PSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=758F2G6mHwZtHqDlM/wuN9QC0Q3bwGTIieLyA4J0jgo=;
        b=STrDAHXsdMLitmZ127EwRDfqVvrnU0nXCaoPz8WrSA1pVInpoum34oc7dvoltY2p+9
         hw71mZl43l5hcdDqsHkI4g4PfHXfOS9gWe5DIsCQjfJZkqt+Z2yUhwXISS0QlDEj5gp4
         4t5UpwmKfJGq2k4CCzDtkAwFGMS62iIj0HgyTDjXLuCMFwbnOqV+AGaYLjixw4NrWNYU
         +QmMlCgv50cOe1teEG3azwdjMLs6SFKbMea8hmdJbnKEDc+jTGwy1LpFcDXuVZeVxB3t
         NKHoo50wpCUTVMx/tgTk/LsJxR+KBUOdPHz+BIF3/ieSLEhggBD/98ktE+QsKHqzI4/h
         E6tw==
X-Gm-Message-State: AJcUuke2Q/ZPReN6+6C1+uo+AhU8DySsqmbeVj/JJKZiNk7F9jM8K2SW
        5ZpmBkzSn4hmo5ugbvHE7qkGbg==
X-Google-Smtp-Source: ALg8bN4m1L7bgNHf5/WqP1XjiyFIzvV2wKp1npYAIqMfzD5zkyUybevb9PiM7ahJVcTc0l2Rt+6KsA==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr21132414wmf.72.1548751467733;
        Tue, 29 Jan 2019 00:44:27 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 8/9] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Tue, 29 Jan 2019 09:44:10 +0100
Message-Id: <20190129084411.30495-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129084411.30495-1-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The unlocked variants only get called from places where we already have
the pointer to the underlying gpio_mockup_chip structure, so take it
as parameter instead of struct gpio_chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 433adb3b4617..c498b0fbbec8 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -83,10 +83,9 @@ static int gpio_mockup_range_ngpio(unsigned int index)
 	return gpio_mockup_ranges[index * 2 + 1];
 }
 
-static int __gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+static int __gpio_mockup_get(struct gpio_mockup_chip *chip,
+			     unsigned int offset)
 {
-	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
-
 	return chip->lines[offset].value;
 }
 
@@ -96,7 +95,7 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	int val;
 
 	mutex_lock(&chip->lock);
-	val = __gpio_mockup_get(gc, offset);
+	val = __gpio_mockup_get(chip, offset);
 	mutex_unlock(&chip->lock);
 
 	return val;
@@ -110,7 +109,7 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio) {
-		val = __gpio_mockup_get(gc, bit);
+		val = __gpio_mockup_get(chip, bit);
 		__assign_bit(bit, bits, val);
 	}
 	mutex_unlock(&chip->lock);
@@ -118,11 +117,9 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 	return 0;
 }
 
-static void __gpio_mockup_set(struct gpio_chip *gc,
+static void __gpio_mockup_set(struct gpio_mockup_chip *chip,
 			      unsigned int offset, int value)
 {
-	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
-
 	chip->lines[offset].value = !!value;
 }
 
@@ -132,7 +129,7 @@ static void gpio_mockup_set(struct gpio_chip *gc,
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	mutex_lock(&chip->lock);
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	mutex_unlock(&chip->lock);
 }
 
@@ -144,7 +141,7 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+		__gpio_mockup_set(chip, bit, test_bit(bit, bits));
 	mutex_unlock(&chip->lock);
 }
 
@@ -155,7 +152,7 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	mutex_unlock(&chip->lock);
 
 	return 0;
-- 
2.19.1

