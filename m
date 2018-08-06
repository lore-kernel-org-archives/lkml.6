Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F4C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C9C21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhVqN1At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C9C21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbeHGAk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41361 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbeHGAk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so10200994lfe.8;
        Mon, 06 Aug 2018 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebIIlYMRwOV2gYgWi7T9qT+QmjkOUcUsHwsxQZ0n6Tk=;
        b=WhVqN1At68jh0Y7HUfCj4y3WSZTCj9P89b9nXlw1PQ5rNy/IL1jpTWuCmtpfoPOY5v
         FuKeruPHb2LFCCkefM4a38qkltc7Z/OxFQreVur2EJFzQaUmhKykhcSJkIKsS5x/5WAL
         gmq4YoM86EfL7xH591j4hLOipTrI3ZvQ7uQ5my67n/bnsejrZftrqBD+P3aGYztAOxPJ
         aN/ePJL8CCYoSGIfda/+uHePDu23bZwMp3O6qFC2NIVz7GyR/y2wnBVWQHJ3qF1WDPGx
         gu08VrnAtUogqQWJSFijFjwBFj4Qz5qAyxt5H+BiuGLQ9ZKEjkwbJUcK8Bh452DMCNI5
         0w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebIIlYMRwOV2gYgWi7T9qT+QmjkOUcUsHwsxQZ0n6Tk=;
        b=mLamM48CXCEnuME7PD/7OLxZuLdSuaeX2ivhJusakDqoYAqzjeQMFq9kt/puZn3Cv+
         Ef2ZkLexJTY8I9a1PraZq6uX6JhLuKtudBrtaKeFA9LV6Sj7IOZ8JtlkNRYaXeckbDRI
         s6rYdP3NBwsrnkJnLNRoodLyWy4V4fD5Wk3WiTWNTghNNL5UqwHTNVHOt+ruGc2hQeH7
         tK8dtEMetJszeOSNEEmGFqtRyJeUOXaxSwtcfyUVwpDuYy0dFVS/yL145j+rMMLF5ipw
         zrxLzrrW39gbOM3hLL4JYqWG4UV0Y7UWXDEyF4gKXcqmAvDFBrtxw+Ayk6fgsdQdIPIx
         6P/g==
X-Gm-Message-State: AOUpUlFt9YKRchnUYkBq9M4XIY1vncs/ailkkwDNnc2ZsI6ReFTlqXHr
        kaSAZ2iWA9KhimuRXv2UQt8=
X-Google-Smtp-Source: AAOMgpdN9LZehLcDgBA7w0nORZ3SY79wH/6RfscsmGRAExgcZ4fMvUNIaZmKPIAqkV0EoWG/wHvlrw==
X-Received: by 2002:a19:7609:: with SMTP id c9-v6mr11952619lff.73.1533594581791;
        Mon, 06 Aug 2018 15:29:41 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:41 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
Date:   Tue,  7 Aug 2018 00:29:16 +0200
Message-Id: <20180806222918.12644-11-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain GPIO array lookups may return arrays marked as applicable for
fast get/set array operations.  In order to make use of that
information, a new API extension which allows passing it to get/set
functions is needed.

Create a set of frontends to get/set array functions which accept
strict descriptor array structures returned by gpiod_get_array()
instead of arbitrary descriptor arrays.

Since the intended purpose of the new API extension is to speed up
get/set array operations, also replace array of integer values argument
with their bitmap representation, ready for being passed directly to
chip callback functions, without iterating them.

Applicability of the new API is limited to arrays not exceeding bit
length of type unsigned long (32 pins).

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst |  26 ++++
 drivers/gpio/gpiolib.c                     | 209 +++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h              |  14 ++
 3 files changed, 249 insertions(+)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 38a990b5f3b6..bec4eab3b87c 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -383,6 +383,32 @@ or negative on error. Note the difference to gpiod_get_value(), which returns
 0 or 1 on success to convey the GPIO value. With the array functions, the GPIO
 values are stored in value_array rather than passed back as return value.
 
+Additionally, the following variants of the above functions exist which operate
+on bitmaps of values instead of arrays of values::
+
+	int gpiod_get_array_bitmap(struct gpio_descs *desc_array,
+				   unsigned long *bits);
+	int gpiod_get_raw_array_bitmap(struct gpio_descs *desc_array,
+				       unsigned long *bits);
+	int gpiod_get_array_bitmap_cansleep(struct gpio_desc *desc_array,
+					    unsigned long *bits);
+	int gpiod_get_raw_array_bitmap_cansleep(struct gpio_desc **desc_array,
+						unsigned long *bits)
+
+	void gpiod_set_array_bitmap(struct gpio_descs *desc_array,
+				    unsigned long *bits)
+	void gpiod_set_raw_array_bitmap(struct gpio_descs *desc_array,
+				        unsigned long *bitmap)
+	void gpiod_set_array_bitmap_cansleep(struct gpio_descs *desc_array,
+					     unsigned long *bits)
+	void gpiod_set_raw_array_bitmap_cansleep(struct gpio_descs *desc_array,
+						 unsigned long *bits)
+
+Unlike their counterparts, these functions don't accept arbitrary GPIO
+descriptor arrays, only those of type struct gpio_descs returned by
+gpiod_get_array() and its variants.  Supported array size is limited to the size
+of the bitmap, i.e., sizeof(unsigned long).
+
 
 GPIOs mapped to IRQs
 --------------------
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c50bcec6e2d7..5b541364dee0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2836,6 +2836,27 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 	return 0;
 }
 
+int gpiod_get_array_bitmap_complex(bool raw, bool can_sleep,
+				   struct gpio_descs *array,
+				   unsigned long *bits)
+{
+	int value_array[sizeof(*bits)];
+	int i;
+
+	if (array->ndescs > sizeof(*bits))
+		return -EINVAL;
+
+	i = gpiod_get_array_value_complex(raw, can_sleep, array->ndescs,
+					  array->desc, value_array);
+	if (i)
+		return i;
+
+	for (i = 0; i < array->ndescs; i++)
+		__assign_bit(i, bits, value_array[i]);
+
+	return 0;
+}
+
 /**
  * gpiod_get_raw_value() - return a gpio's raw value
  * @desc: gpio whose value will be returned
@@ -2929,6 +2950,50 @@ int gpiod_get_array_value(unsigned int array_size,
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 
+/**
+ * gpiod_get_raw_array_bitmap() - read raw values from an array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be read, obtained
+ *		with gpiod_get_array(),
+ * @bits: bitmap to store the read values
+ *
+ * Read the raw values of the GPIOs, i.e. the values of the physical lines
+ * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
+ * else an error code.
+ *
+ * This function should be called from contexts where we cannot sleep,
+ * and it will complain if the GPIO chip functions potentially sleep.
+ */
+int gpiod_get_raw_array_bitmap(struct gpio_descs *desc_array,
+			       unsigned long *bits)
+{
+	if (!desc_array)
+		return -EINVAL;
+	return gpiod_get_array_bitmap_complex(true, false, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_get_raw_array_bitmap);
+
+/**
+ * gpiod_get_array_bitmap() - read values from an array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be read, obtained
+ *		with gpiod_get_array(),
+ * @bits: bitmap to store the read values
+ *
+ * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
+ * into account.  Return 0 in case of success, else an error code.
+ *
+ * This function should be called from contexts where we cannot sleep,
+ * and it will complain if the GPIO chip functions potentially sleep.
+ */
+
+int gpiod_get_array_bitmap(struct gpio_descs *desc_array,
+			   unsigned long *bits)
+{
+	if (!desc_array)
+		return -EINVAL;
+	return gpiod_get_array_bitmap_complex(false, false, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_get_raw_array_bitmap);
+
 /*
  *  gpio_set_open_drain_value_commit() - Set the open drain gpio's value.
  * @desc: gpio descriptor whose state need to be set.
@@ -3081,6 +3146,23 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 	return 0;
 }
 
+int gpiod_set_array_bitmap_complex(bool raw, bool can_sleep,
+				   struct gpio_descs *array,
+				   unsigned long *bits)
+{
+	int value_array[sizeof(*bits)];
+	int i;
+
+	if (array->ndescs > sizeof(*bits))
+		return -EINVAL;
+
+	for (i = 0; i < array->ndescs; i++)
+		value_array[i] = test_bit(i, bits);
+
+	return gpiod_set_array_value_complex(raw, can_sleep, array->ndescs,
+					     array->desc, value_array);
+}
+
 /**
  * gpiod_set_raw_value() - assign a gpio's raw value
  * @desc: gpio whose value will be assigned
@@ -3185,6 +3267,48 @@ void gpiod_set_array_value(unsigned int array_size,
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
+/**
+ * gpiod_set_raw_array_bitmap() - assign values to an array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be assigned,
+ *		obtained with gpiod_get_array(),
+ * @bits: bitmap of values to assign
+ *
+ * Set the raw values of the GPIOs, i.e. the values of the physical lines
+ * without regard for their ACTIVE_LOW status.
+ *
+ * This function should be called from contexts where we cannot sleep, and will
+ * complain if the GPIO chip functions potentially sleep.
+ */
+int gpiod_set_raw_array_bitmap(struct gpio_descs *desc_array,
+			       unsigned long *bits)
+{
+	if (!desc_array)
+		return -EINVAL;
+	return gpiod_set_array_bitmap_complex(true, false, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_raw_array_bitmap);
+
+/**
+ * gpiod_set_array_bitmap() - assign values to an array of GPIOs
+ * @array_size: number of elements in the descriptor / value arrays
+ * @desc_array: array of GPIO descriptors whose values will be assigned
+ * @bits: bitmap of values to assign
+ *
+ * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
+ * into account.
+ *
+ * This function should be called from contexts where we cannot sleep, and will
+ * complain if the GPIO chip functions potentially sleep.
+ */
+void gpiod_set_array_bitmap(struct gpio_descs *desc_array,
+			    unsigned long *bits)
+{
+	if (!desc_array)
+		return;
+	gpiod_set_array_bitmap_complex(false, false, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_array_bitmap);
+
 /**
  * gpiod_cansleep() - report whether gpio value access may sleep
  * @desc: gpio to check
@@ -3446,6 +3570,49 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
 
+/**
+ * gpiod_get_raw_array_bitmap_cansleep() - read raw values from array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be read, obtained
+ *		with gpiod_get_array(),
+ * @bits: bitmap to store the read values
+ *
+ * Read the raw values of the GPIOs, i.e. the values of the physical lines
+ * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
+ * else an error code.
+ *
+ * This function is to be called from contexts that can sleep.
+ */
+int gpiod_get_raw_array_bitmap_cansleep(struct gpio_descs *desc_array,
+					unsigned long *bits)
+{
+	might_sleep_if(extra_checks);
+	if (!desc_array)
+		return -EINVAL;
+	return gpiod_get_array_bitmap_complex(true, true, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_get_raw_array_bitmap_cansleep);
+
+/**
+ * gpiod_get_array_bitmap_cansleep() - read values from an array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be read, obtained
+ *		with gpiod_get_array(),
+ * @bits: bitmap to store the read values
+ *
+ * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
+ * into account.  Return 0 in case of success, else an error code.
+ *
+ * This function is to be called from contexts that can sleep.
+ */
+int gpiod_get_array_bitmap_cansleep(struct gpio_descs *desc_array,
+				    unsigned long *bits)
+{
+	might_sleep_if(extra_checks);
+	if (!desc_array)
+		return -EINVAL;
+	return gpiod_get_array_bitmap_complex(false, true, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_get_array_bitmap_cansleep);
+
 /**
  * gpiod_set_raw_value_cansleep() - assign a gpio's raw value
  * @desc: gpio whose value will be assigned
@@ -3545,6 +3712,48 @@ void gpiod_set_array_value_cansleep(unsigned int array_size,
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
+/**
+ * gpiod_set_raw_array_bitmap_cansleep() - assign values to an array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be assigned,
+ *		obtained with gpiod_get_array(),
+ * @bits: bitmap of values to assign
+ *
+ * Set the raw values of the GPIOs, i.e. the values of the physical lines
+ * without regard for their ACTIVE_LOW status.
+ *
+ * This function is to be called from contexts that can sleep.
+ */
+int gpiod_set_raw_array_bitmap_cansleep(struct gpio_descs *desc_array,
+					unsigned long *bits)
+{
+	might_sleep_if(extra_checks);
+	if (!desc_array)
+		return -EINVAL;
+	return gpiod_set_array_bitmap_complex(true, true, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_raw_array_bitmap_cansleep);
+
+/**
+ * gpiod_set_array_bitmap_cansleep() - assign values to an array of GPIOs
+ * @desc_array: array of GPIO descriptors whose values will be assigned,
+ *		obtained with gpiod_get_array(),
+ * @bits: bitmap of values to assign
+ *
+ * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
+ * into account.
+ *
+ * This function is to be called from contexts that can sleep.
+ */
+void gpiod_set_array_bitmap_cansleep(struct gpio_descs *desc_array,
+				     unsigned long *bits)
+{
+	might_sleep_if(extra_checks);
+	if (!desc_array)
+		return;
+	gpiod_set_array_bitmap_complex(false, true, desc_array, bits);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_array_bitmap_cansleep);
+
 /**
  * gpiod_add_lookup_table() - register GPIO device consumers
  * @table: table of consumers to register
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 862ee027a02f..1eabce4fc6c5 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -106,35 +106,49 @@ int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
 int gpiod_get_value(const struct gpio_desc *desc);
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array, int *value_array);
+int gpiod_get_array_bitmap(struct gpio_descs *desc_array, unsigned long *bits);
 void gpiod_set_value(struct gpio_desc *desc, int value);
 void gpiod_set_array_value(unsigned int array_size,
 			   struct gpio_desc **desc_array, int *value_array);
+void gpiod_set_array_bitmap(struct gpio_descs *desc_array, unsigned long *bits);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
 			      int *value_array);
+int gpiod_get_raw_array_bitmap(struct gpio_descs *desc_array,
+			       unsigned long *bits);
 void gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			       struct gpio_desc **desc_array,
 			       int *value_array);
+int gpiod_set_raw_array_bitmap(struct gpio_descs *desc_array,
+			       unsigned long *bits);
 
 /* Value get/set from sleeping context */
 int gpiod_get_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   int *value_array);
+int gpiod_get_array_bitmap_cansleep(struct gpio_descs *desc_array,
+				    unsigned long *bits);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
 				    int *value_array);
+void gpiod_set_array_bitmap_cansleep(struct gpio_descs *desc_array,
+				     unsigned long *bits);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
 				       int *value_array);
+int gpiod_get_raw_array_bitmap_cansleep(struct gpio_descs *desc_array,
+					unsigned long *bits);
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
 					int *value_array);
+int gpiod_set_raw_array_bitmap_cansleep(struct gpio_descs *desc_array,
+					unsigned long *bits);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
-- 
2.16.4

