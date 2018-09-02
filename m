Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC9C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2165420856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGwxNOFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2165420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeIBQQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:16:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40228 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:16:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so13279134ljc.7;
        Sun, 02 Sep 2018 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/CaUt41B1h8e31mRZUHbfVAUblsRndRVhwugcVG1fN4=;
        b=PGwxNOFvySNcKhukNsLbYoTY65wVryDfghQQDojmzA1+9zejkt1JfCxrYJTZUIfyh3
         7sYgjNpjKU/NnkmI/pDCMiuMzEaf+TJEDI/t/4j2qa03hZrLpCAZwSluDQM8ClsZM42c
         2fmUyAO7qCGoPaMeE2APyc23JLxMvirag8+QM6RE29HwoyvYu3HXPLhtxOqlB2yCgHGq
         nZIP2k/4SCb/oAWD0ZFEduFueqbXP5EJYOP3BwasT/yZ3dLblBReYelCeJE9n+A/ybCJ
         PuyCtgSjjY3eBDeg2V1gPsx/giSm0VI/aYFmdAHozvOdzK0wZBw2CR1VL3GhelhYD+qt
         aFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/CaUt41B1h8e31mRZUHbfVAUblsRndRVhwugcVG1fN4=;
        b=tDcfMpMzFeNHUwxkuy+2wfeKEZSrBg1OtTJHn6OT9k16nAQONXkBQNgy8Z/8jFQAJe
         UUqQK6u33HNyW8sKHVKmFTmkokYOjtJhCbHM44dSdWBkiaYCoAtma+WPOxY6gyEJATgU
         rAqvyU/vl6TguMJc4dNMI/NptTwut6CDhXts6rvVKEb+8p/ZO+H6y+SKenQhb+cKYO7p
         0JVRnNu5ODbPKFi09DaShT1rND6uoDTv6cSK5aS1EgY/rw6twkAwfNJMP4JCE8vpRzsI
         VJVnVJBJd3NBvA/HBHWE1KLIcsldmjKqyi6mIIggT0HfxI+2if5wsd2jSbUtjHQfyRPX
         cUIQ==
X-Gm-Message-State: APzg51Dzd3uS3h2euW0yUpHoK9VlAYTGHncnKJFAdBAhUX3PPQacFIur
        dEGNHszXWpYkIDye5ZYxkPP++r5VIj4=
X-Google-Smtp-Source: ANB0VdY9NA6XcpJgvXj0Rl/ewEeaq7WwLUYFe1eV/pwP+fcpnohdg2ZMTyNY2u0MfaB9kfyqraQ9wg==
X-Received: by 2002:a2e:4242:: with SMTP id p63-v6mr14930037lja.83.1535889675298;
        Sun, 02 Sep 2018 05:01:15 -0700 (PDT)
Received: from localhost.localdomain (apn-37-248-210-194.dynamic.gprs.plus.pl. [37.248.210.194])
        by smtp.gmail.com with ESMTPSA id n3-v6sm2760321lji.96.2018.09.02.05.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 05:01:14 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v7 2/4] gpiolib: Identify arrays matching GPIO hardware
Date:   Sun,  2 Sep 2018 14:01:42 +0200
Message-Id: <20180902120144.6855-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180902120144.6855-1-jmkrzyszt@gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain GPIO array lookup results may map directly to GPIO pins of a
single GPIO chip in hardware order.  If that condition is recognized
and handled efficiently, significant performance gain of get/set array
functions may be possible.

While processing a request for an array of GPIO descriptors, identify
those which represent corresponding pins of a single GPIO chip.  Skip
over pins which require open source or open drain special processing.
Moreover, identify pins which require inversion.  Pass a pointer to
that information with the array to the caller so it can benefit from
enhanced performance as soon as get/set array functions can accept and
make efficient use of it.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst |  4 +-
 drivers/gpio/gpiolib.c                     | 72 +++++++++++++++++++++++++++++-
 drivers/gpio/gpiolib.h                     |  9 ++++
 include/linux/gpio/consumer.h              |  9 ++++
 4 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index ed68042ddccf..7e0298b9a7b9 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -109,9 +109,11 @@ For a function using multiple GPIOs all of those can be obtained with one call::
 					   enum gpiod_flags flags)
 
 This function returns a struct gpio_descs which contains an array of
-descriptors::
+descriptors.  It also contains a pointer to a gpiolib private structure which,
+if passed back to get/set array functions, may speed up I/O proocessing::
 
 	struct gpio_descs {
+		struct gpio_array *info;
 		unsigned int ndescs;
 		struct gpio_desc *desc[];
 	}
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 434d09779a1f..141f2f290538 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4174,7 +4174,9 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 {
 	struct gpio_desc *desc;
 	struct gpio_descs *descs;
-	int count;
+	struct gpio_array *array_info = NULL;
+	struct gpio_chip *chip;
+	int count, bitmap_size;
 
 	count = gpiod_count(dev, con_id);
 	if (count < 0)
@@ -4190,9 +4192,77 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			gpiod_put_array(descs);
 			return ERR_CAST(desc);
 		}
+
 		descs->desc[descs->ndescs] = desc;
+
+		chip = gpiod_to_chip(desc);
+		/*
+		 * Select a chip of first array member
+		 * whose index matches its pin hardware number
+		 * as a candidate for fast bitmap processing.
+		 */
+		if (!array_info && gpio_chip_hwgpio(desc) == descs->ndescs) {
+			struct gpio_descs *array;
+
+			bitmap_size = BITS_TO_LONGS(chip->ngpio > count ?
+						    chip->ngpio : count);
+
+			array = kzalloc(struct_size(descs, desc, count) +
+					struct_size(array_info, invert_mask,
+					3 * bitmap_size), GFP_KERNEL);
+			if (!array) {
+				gpiod_put_array(descs);
+				return ERR_PTR(-ENOMEM);
+			}
+
+			memcpy(array, descs,
+			       struct_size(descs, desc, descs->ndescs + 1));
+			kfree(descs);
+
+			descs = array;
+			array_info = (void *)(descs->desc + count);
+			array_info->get_mask = array_info->invert_mask +
+						  bitmap_size;
+			array_info->set_mask = array_info->get_mask +
+						  bitmap_size;
+
+			array_info->desc = descs->desc;
+			array_info->size = count;
+			array_info->chip = chip;
+			bitmap_set(array_info->get_mask, descs->ndescs,
+				   count - descs->ndescs);
+			bitmap_set(array_info->set_mask, descs->ndescs,
+				   count - descs->ndescs);
+			descs->info = array_info;
+		}
+		/*
+		 * Unmark members which don't qualify for fast bitmap
+		 * processing (different chip, not in hardware order)
+		 */
+		if (array_info && (chip != array_info->chip ||
+		    gpio_chip_hwgpio(desc) != descs->ndescs)) {
+			__clear_bit(descs->ndescs, array_info->get_mask);
+			__clear_bit(descs->ndescs, array_info->set_mask);
+		} else if (array_info) {
+			/* Exclude open drain or open source from fast output */
+			if (gpiochip_line_is_open_drain(chip, descs->ndescs) ||
+			    gpiochip_line_is_open_source(chip, descs->ndescs))
+				__clear_bit(descs->ndescs,
+					    array_info->set_mask);
+			/* Identify 'fast' pins which require invertion */
+			if (gpiod_is_active_low(desc))
+				__set_bit(descs->ndescs,
+					  array_info->invert_mask);
+		}
+
 		descs->ndescs++;
 	}
+	if (array_info)
+		dev_dbg(dev,
+			"GPIO array info: chip=%s, size=%d, get_mask=%lx, set_mask=%lx, invert_mask=%lx\n",
+			array_info->chip->label, array_info->size,
+			*array_info->get_mask, *array_info->set_mask,
+			*array_info->invert_mask);
 	return descs;
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 11e83d2eef89..b60905d558b1 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -183,6 +183,15 @@ static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 }
 #endif
 
+struct gpio_array {
+	struct gpio_desc	**desc;
+	unsigned int		size;
+	struct gpio_chip	*chip;
+	unsigned long		*get_mask;
+	unsigned long		*set_mask;
+	unsigned long		invert_mask[];
+};
+
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 1b21dc7b0fad..8dede3e886af 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -17,11 +17,20 @@ struct device;
  */
 struct gpio_desc;
 
+/**
+ * Opaque descriptor for a structure of GPIO array attributes.  This structure
+ * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
+ * passed back to get/set array functions in order to activate fast processing
+ * path if applicable.
+ */
+struct gpio_array;
+
 /**
  * Struct containing an array of descriptors that can be obtained using
  * gpiod_get_array().
  */
 struct gpio_descs {
+	struct gpio_array *info;
 	unsigned int ndescs;
 	struct gpio_desc *desc[];
 };
-- 
2.16.4

