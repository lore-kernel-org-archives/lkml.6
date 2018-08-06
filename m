Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E14FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B25B208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4rnAwwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B25B208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbeHGAky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45366 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbeHGAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so10187951lfj.12;
        Mon, 06 Aug 2018 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ddxbjKWbH/qs2/dbAkPSUgMcTxkDVe7XOShiS2ShNhg=;
        b=O4rnAwwU+E19y/dHgqfV5/LNr5ueAwgq1W7nBCLWP9ADhnJm3CbxcOA0zniiu5qIaB
         uMdeXG1Q0fL84RvXKIoJI12MkL7KR5sbIs/gEK2NUFnDr2nNHfKYnZharQuaiiuKFqC8
         8RgIEEsCaErRxPzNN4yUOpduIm/yGT/ExpYhfRrzE/E9DEVPDnqyg7SxAAGs4+nYSoeY
         LVnc1S7SZeQOeDGnalM3AWlivmjquUd0keZr4mfAr6GXPsj+JMkcFaHaSIeveco+BJUJ
         MogHKF5Y2TLZGnBsmEwjw2scpufQ0GLAqf+kps9CmBrEz8DYUiN0iQEQDdZjIlILRTwa
         GNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ddxbjKWbH/qs2/dbAkPSUgMcTxkDVe7XOShiS2ShNhg=;
        b=Rnly4VRhTPnPL5I12RaGRy/scuz89r7Ha1GeUm82VH0oTR0xHcTfpDimzHUjj/vKRK
         WOe8mxCihCpss5/SHqjia1y4M9uXzOJJXyGkfutVeJ0MbiF8h5u0shvEtfAqQBojZntL
         3Onqst5VLAVuaXpmD4G5PBnuTGgcw+ixB0OjuWPlpLZsZV+1Z8zAO4JV61kfezlJ4EO+
         UQRvmwX4TSKFpA0IVPPgtkZc0We21v42iO+WESuqC6XlzAIJ0NYODet0/vz8ADmROrVI
         H/W2FaRo79YtJcDQhQ1o/YsNb7ANphWZjWuZL6mGP5Icg9U5oedzMTSP5Bs9ACkD4jJ8
         0aqw==
X-Gm-Message-State: AOUpUlEPH09861mEXivW+jnBeJYf1cOuaBQgLVCIO0tETDzy8zEq/vLW
        5ap+r4iyojKIh5PthoYxCU8=
X-Google-Smtp-Source: AAOMgpe1kBSzm5J6s2TGZ6xuh9XrZ36DhEPwqaDLXIoZov77FCx7o+JryEyDTjswU9SaAdSCixn93A==
X-Received: by 2002:a19:14dc:: with SMTP id 89-v6mr11947557lfu.45.1533594580408;
        Mon, 06 Aug 2018 15:29:40 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:39 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct mapping
Date:   Tue,  7 Aug 2018 00:29:15 +0200
Message-Id: <20180806222918.12644-10-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain GPIO array lookup results may map directly to GPIO pins of a
single GPIO chip in hardware order.  If that condition is recognized
and handled efficiently, significant performance gain of get/set array
functions may be possible.

While processing a request for an array of GPIO descriptors, verify if
the descriptors just collected represent consecutive pins of a single
GPIO chip.  Pass that information with the array to the caller so it
can benefit from enhanced performance as soon as bitmap based get/set
array functions which can make efficient use of that are available.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst |  4 +++-
 drivers/gpio/gpiolib.c                     | 14 ++++++++++++++
 include/linux/gpio/consumer.h              |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index aa03f389d41d..38a990b5f3b6 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -109,11 +109,13 @@ For a function using multiple GPIOs all of those can be obtained with one call::
 					   enum gpiod_flags flags)
 
 This function returns a struct gpio_descs which contains an array of
-descriptors::
+descriptors.  It may also contain a valid descriptor of a single GPIO chip in
+case the array strictly matches pin hardware layout of the chip::
 
 	struct gpio_descs {
 		unsigned int ndescs;
 		struct gpio_desc *desc[];
+		struct gpio_chip *chip;
 	}
 
 The following function returns NULL instead of -ENOENT if no GPIOs have been
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bdbfc95793e7..c50bcec6e2d7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4161,6 +4161,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 {
 	struct gpio_desc *desc;
 	struct gpio_descs *descs;
+	struct gpio_chip *chip;
 	int count;
 
 	count = gpiod_count(dev, con_id);
@@ -4177,6 +4178,19 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			gpiod_put_array(descs);
 			return ERR_CAST(desc);
 		}
+
+		/*
+		 * Verify if the array qualifies for fast bitmap operations
+		 * (single chip, pins in hardware order starting from 0)
+		 * and mark the array with the chip descriptor if true.
+		 */
+		chip = gpiod_to_chip(desc);
+		if (descs->chip == NULL)
+			descs->chip = chip;
+		if (!IS_ERR(descs->chip) && (chip != descs->chip ||
+		    gpio_chip_hwgpio(desc) != descs->ndescs))
+			descs->chip = ERR_PTR(-EINVAL);
+
 		descs->desc[descs->ndescs] = desc;
 		descs->ndescs++;
 	}
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 21ddbe440030..862ee027a02f 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -22,6 +22,7 @@ struct gpio_desc;
  * gpiod_get_array().
  */
 struct gpio_descs {
+	struct gpio_chip *chip;
 	unsigned int ndescs;
 	struct gpio_desc *desc[];
 };
-- 
2.16.4

