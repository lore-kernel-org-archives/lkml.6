Return-Path: <kernel-hardening-return-12350-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvj3oAF18ibg8VujJea/SMzszeaHDNrXIOIpcHY/oLOfEAwCbzT24KEI5tOxFSDAGeY+1IN
ARC-Seal: i=1; a=rsa-sha256; t=1520640663; cv=none;
        d=google.com; s=arc-20160816;
        b=E83BKUIKWHavui3yvIHgax9UDYrb3j/7OzuncZ3cQgOC/TOeHJ5V/cjQRw6lCrXFgJ
         eHT7OZDOgwFga/laFK0V1TEFphzW9IwsagNpOpu4QTGYl6myI7fdZFEvhngu1RCUcTkd
         zayyRm//Kime68NvNp90Ib0r79EIkLyHL2ELdKUX0YOffcycqS2nHk6r2iKy4dfbL9zF
         aQNHnbFXAFKHwtJ5sq77/bUwMfPwL/e5uH7N8XaeJrmpznXZr1ZIzVry+UXSAtPlr809
         0boJYgyL6ClIK8Jeolonsc96ZHV58H4VY0T1G6Rd3OPHt/QG7MFHYBFLi8jvBqJw1E9G
         Gi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=roQovXqc354fTff3XJfD8Mqu/kAFDMxTuYxokb4/mj8=;
        b=TvwutWC7Bk3Ot3GXlZqnUEq1fCLgmhEpUHr1ulHEkuPq7Ex6tmDGnK5O0BU9s/0xGO
         wQ6tc5mENxgqZZ0d/MuXP8m2AzDktMV55qTatr+XqYYNJRJr4JagIFlMEdgwXrqjd6rh
         SXIHSOZw1pkb7B4ihsRFpeRBWQ8y1dQCX1udlGfXypZi2duFu6tbYyJg+xwXJGo8J8CQ
         RihEFGZdXM80iA1T9Q1YId+irs+2NiH+8sq/hGLtq6OBhO5zPFQKrzsfBaKQITgaVv/C
         QJOuPVu4Y3NV9PilcGjHZL5r8A2ulfV8CdMVjB85oXrFDVfJJsEJ9Hn+USmJOEr0ruPQ
         6Ymg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12350-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12350-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12350-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12350-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Lukas Wunner <lukas@wunner.de>,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Nandor Han <nandor.han@ge.com>,
	Semi Malinen <semi.malinen@ge.com>,
	Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 1/4] gpio: Remove VLA from gpiolib
Date: Fri,  9 Mar 2018 16:10:18 -0800
Message-Id: <20180310001021.6437-2-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310001021.6437-1-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1594507304079648871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

This patch replaces several VLAs with an appropriate call to
kmalloc_array.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpio/gpiolib.c | 55 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d66de67ef307..124727c74931 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2662,16 +2662,33 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
-		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
-		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
+		unsigned long *mask;
+		unsigned long *bits;
 		int first, j, ret;
 
+		mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
+				sizeof(*mask),
+				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+
+		if (!mask)
+			return -ENOMEM;
+
+		bits = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
+				sizeof(*bits),
+				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+
+		if (!bits) {
+			kfree(mask);
+			return -ENOMEM;
+		}
+
+
 		if (!can_sleep)
 			WARN_ON(chip->can_sleep);
 
 		/* collect all inputs belonging to the same chip */
 		first = i;
-		memset(mask, 0, sizeof(mask));
+		memset(mask, 0, sizeof(*mask));
 		do {
 			const struct gpio_desc *desc = desc_array[i];
 			int hwgpio = gpio_chip_hwgpio(desc);
@@ -2682,8 +2699,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			 (desc_array[i]->gdev->chip == chip));
 
 		ret = gpio_chip_get_multiple(chip, mask, bits);
-		if (ret)
+		if (ret) {
+			kfree(bits);
+			kfree(mask);
 			return ret;
+		}
 
 		for (j = first; j < i; j++) {
 			const struct gpio_desc *desc = desc_array[j];
@@ -2695,6 +2715,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			value_array[j] = value;
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 		}
+		kfree(bits);
+		kfree(mask);
 	}
 	return 0;
 }
@@ -2887,14 +2909,30 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
 
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
-		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
-		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
+		unsigned long *mask;
+		unsigned long *bits;
 		int count = 0;
 
+		mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
+				sizeof(*mask),
+				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+
+		if (!mask)
+			return;
+
+		bits = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
+				sizeof(*bits),
+				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+
+		if (!bits) {
+			kfree(mask);
+			return;
+		}
+
 		if (!can_sleep)
 			WARN_ON(chip->can_sleep);
 
-		memset(mask, 0, sizeof(mask));
+		memset(mask, 0, sizeof(*mask));
 		do {
 			struct gpio_desc *desc = desc_array[i];
 			int hwgpio = gpio_chip_hwgpio(desc);
@@ -2925,6 +2963,9 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		/* push collected bits to outputs */
 		if (count != 0)
 			gpio_chip_set_multiple(chip, mask, bits);
+
+		kfree(mask);
+		kfree(bits);
 	}
 }
 
-- 
2.14.3
