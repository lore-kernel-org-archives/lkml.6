Return-Path: <kernel-hardening-return-12994-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+keDsoeRAb5YwfBOiCBcKTwAMbAW4RLHkgUQOIQVtLrup/kUex5yq56GOE7cQogCQHreYm
ARC-Seal: i=1; a=rsa-sha256; t=1523654691; cv=none;
        d=google.com; s=arc-20160816;
        b=DSs1cSlcUyTV9NseKIojeQ51frBwY6vCCZC6jXpmoQzMHviCJMGqsM3q5oBYQIdlaY
         42XmNuyAeBt+Ym8vp0U0lwmCkd8MvUMNuqrqRTX9zxr2ylR7qcSgY6+e0n3KreS43fTX
         GXJM1WRlNSVHEcpRg44cqj8SbUzRMu1f8BXeR+QW3R5tjwA2iM2AwyDuYkkzCedelcaw
         Fls3mkKwcjcldYElsdHd0gPoObr8yslKApJo8fmhFg2YxhzqZJQ1hFORop0Fzq4PGEyt
         UwV5c/+97OsGvaL3b6wk0K/Q9WZGqRYomcsQWtFMmA3Xl7MC+uzucSuG8l8uKjjL93Wv
         e/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=j8vbUjaAPiLiLb1G28YxDpYKJxkZHP8MzsT1N5dYRmI=;
        b=Nhfys+zZSR52szFt8VTCIe3Jtn9RAzgcyCTGUx/S25yPKYCgIh6WEF0T92RoFsiQi/
         TU3qAzI1rGD5xh+FBg3eMuPxJSFnvACpH3Jy35atLeE3ip6YbY/1YQ4yoZzl/b6Dq8Ob
         SS0TLKi998YoV1fUXNL0eJlWE8UZPiZFQq6xdh3+hofejyjNAMvhgmZt/H2XuXKNJg6N
         iRJaDKOeiaNFxBKHqK7Y1Cg27Q2CO0eRabUf6M9Om3CEV69CDbG36I0x8lRfM4Et7AHP
         e5R3InnHDeGUbW7KsMFmPO3rX5xPSaR1+A/RBszIXLa7YFz7IH5CbmiUG5WaeH8yLCmg
         AM4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12994-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12994-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12994-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12994-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Lukas Wunner <lukas@wunner.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv5] gpio: Remove VLA from gpiolib
Date: Fri, 13 Apr 2018 14:24:27 -0700
Message-Id: <20180413212427.18261-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409764349726473?=
X-GMAIL-MSGID: =?utf-8?q?1597667741921505746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621) to eventually
turn on -Wvla.

Using a kmalloc array is the easy way to fix this but kmalloc is still
more expensive than stack allocation. Introduce a fast path with a
fixed size stack array to cover most chip with gpios below some fixed
amount. The slow path dynamically allocates an array to cover those
chips with a large number of gpios.

Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: Dropped some outdated comments and extra whitespace. Switched to
ARCH_NR_GPIOS per suggestion of Linus Walleij.
---
 drivers/gpio/gpiolib.c        | 76 +++++++++++++++++++++++++++++++++----------
 drivers/gpio/gpiolib.h        |  2 +-
 include/linux/gpio/consumer.h | 10 +++---
 3 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d66de67ef307..79ec7a29b684 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -61,6 +61,11 @@ static struct bus_type gpio_bus_type = {
 	.name = "gpio",
 };
 
+/*
+ * Number of GPIOs to use for the fast path in set array
+ */
+#define FASTPATH_NGPIO ARCH_NR_GPIOS
+
 /* gpio_lock prevents conflicts during gpio_desc[] table updates.
  * While any GPIO is requested, its gpio_chip is not removable;
  * each GPIO's "requested" flag serves as a lock and refcount.
@@ -399,12 +404,11 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 			vals[i] = !!ghd.values[i];
 
 		/* Reuse the array setting function */
-		gpiod_set_array_value_complex(false,
+		return gpiod_set_array_value_complex(false,
 					      true,
 					      lh->numdescs,
 					      lh->descs,
 					      vals);
-		return 0;
 	}
 	return -EINVAL;
 }
@@ -1192,6 +1196,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 		goto err_free_descs;
 	}
 
+	if (chip->ngpio > FASTPATH_NGPIO)
+		chip_warn(chip, "line cnt %d is greater than fast path cnt %d\n",
+		chip->ngpio, FASTPATH_NGPIO);
+
 	gdev->label = kstrdup_const(chip->label ?: "unknown", GFP_KERNEL);
 	if (!gdev->label) {
 		status = -ENOMEM;
@@ -2662,16 +2670,28 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
-		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
-		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
+		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
+		unsigned long *mask, *bits;
 		int first, j, ret;
 
+		if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
+			memset(fastpath, 0, sizeof(fastpath));
+			mask = fastpath;
+			bits = fastpath + BITS_TO_LONGS(FASTPATH_NGPIO);
+		} else {
+			mask = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
+					   sizeof(*mask),
+					   can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+			if (!mask)
+				return -ENOMEM;
+			bits = mask + BITS_TO_LONGS(chip->ngpio);
+		}
+
 		if (!can_sleep)
 			WARN_ON(chip->can_sleep);
 
 		/* collect all inputs belonging to the same chip */
 		first = i;
-		memset(mask, 0, sizeof(mask));
 		do {
 			const struct gpio_desc *desc = desc_array[i];
 			int hwgpio = gpio_chip_hwgpio(desc);
@@ -2682,8 +2702,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			 (desc_array[i]->gdev->chip == chip));
 
 		ret = gpio_chip_get_multiple(chip, mask, bits);
-		if (ret)
+		if (ret) {
+			if (mask != fastpath)
+				kfree(mask);
 			return ret;
+		}
 
 		for (j = first; j < i; j++) {
 			const struct gpio_desc *desc = desc_array[j];
@@ -2695,6 +2718,9 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			value_array[j] = value;
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 		}
+
+		if (mask != fastpath)
+			kfree(mask);
 	}
 	return 0;
 }
@@ -2878,7 +2904,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
 	}
 }
 
-void gpiod_set_array_value_complex(bool raw, bool can_sleep,
+int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   int *value_array)
@@ -2887,14 +2913,26 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
 
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
-		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
-		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
+		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
+		unsigned long *mask, *bits;
 		int count = 0;
 
+		if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
+			memset(fastpath, 0, sizeof(fastpath));
+			mask = fastpath;
+			bits = fastpath + BITS_TO_LONGS(FASTPATH_NGPIO);
+		} else {
+			mask = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
+					   sizeof(*mask),
+					   can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+			if (!mask)
+				return -ENOMEM;
+			bits = mask + BITS_TO_LONGS(chip->ngpio);
+		}
+
 		if (!can_sleep)
 			WARN_ON(chip->can_sleep);
 
-		memset(mask, 0, sizeof(mask));
 		do {
 			struct gpio_desc *desc = desc_array[i];
 			int hwgpio = gpio_chip_hwgpio(desc);
@@ -2925,7 +2963,11 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		/* push collected bits to outputs */
 		if (count != 0)
 			gpio_chip_set_multiple(chip, mask, bits);
+
+		if (mask != fastpath)
+			kfree(mask);
 	}
+	return 0;
 }
 
 /**
@@ -3000,13 +3042,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  * This function should be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
  */
-void gpiod_set_raw_array_value(unsigned int array_size,
+int gpiod_set_raw_array_value(unsigned int array_size,
 			 struct gpio_desc **desc_array, int *value_array)
 {
 	if (!desc_array)
-		return;
-	gpiod_set_array_value_complex(true, false, array_size, desc_array,
-				      value_array);
+		return -EINVAL;
+	return gpiod_set_array_value_complex(true, false, array_size,
+					desc_array, value_array);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
 
@@ -3326,14 +3368,14 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  *
  * This function is to be called from contexts that can sleep.
  */
-void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
+int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
 					int *value_array)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
-		return;
-	gpiod_set_array_value_complex(true, true, array_size, desc_array,
+		return -EINVAL;
+	return gpiod_set_array_value_complex(true, true, array_size, desc_array,
 				      value_array);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value_cansleep);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b17ec6795c81..b64813e3876e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -188,7 +188,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
 				  int *value_array);
-void gpiod_set_array_value_complex(bool raw, bool can_sleep,
+int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   int *value_array);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index dbd065963296..243112c7fa7d 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -116,7 +116,7 @@ int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
 			      int *value_array);
 void gpiod_set_raw_value(struct gpio_desc *desc, int value);
-void gpiod_set_raw_array_value(unsigned int array_size,
+int gpiod_set_raw_array_value(unsigned int array_size,
 			       struct gpio_desc **desc_array,
 			       int *value_array);
 
@@ -134,7 +134,7 @@ int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
 				       int *value_array);
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
-void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
+int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
 					int *value_array);
 
@@ -369,12 +369,13 @@ static inline void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 	/* GPIO can never have been requested */
 	WARN_ON(1);
 }
-static inline void gpiod_set_raw_array_value(unsigned int array_size,
+static inline int gpiod_set_raw_array_value(unsigned int array_size,
 					     struct gpio_desc **desc_array,
 					     int *value_array)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return 0;
 }
 
 static inline int gpiod_get_value_cansleep(const struct gpio_desc *desc)
@@ -423,12 +424,13 @@ static inline void gpiod_set_raw_value_cansleep(struct gpio_desc *desc,
 	/* GPIO can never have been requested */
 	WARN_ON(1);
 }
-static inline void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
+static inline int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,
 						int *value_array)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return 0;
 }
 
 static inline int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
-- 
2.14.3
