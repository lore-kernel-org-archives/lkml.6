Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518156539; cv=none;
        d=google.com; s=arc-20160816;
        b=dinlIrZ3xg1IM648Y7Nx5vZMpvXqM0FsPxUzM5cXR0SsC8SXIxp96zAVqfnvSuB95i
         nJSiPV7mcEEzE0thPDYm0XCfKFkc+vuFZ9wKRWZK8QJOQHIuD8zDZNS6ZcsDypXB0oTb
         uYBV2pKaBe24DglV4R27QsDcXkghyOrTp4NmJcykJNbPxHbhUqYdRZkI3tV3jSlrP+Ee
         PKr3xTZmlP/mSU26Zq8O/X033sZMF1xMO0CGSyKEJvps7XROXLjOYL3LPDjVZI5Ri80W
         jgbDXdwav1aw12Z4teEHvQf4dvZ6tGQ89c+q4uuqmw7QP/lXYkxqQkTQbl+IBS+W1O3H
         z1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=0Q3uPb8gySQcgsQtVQr2S/bAzu9nETicVrLVrKTSbf8=;
        b=E0Aj+O1FAD13+jTnwYr8jKxabNCYCgVqunswB4mhbYJ/5MqIB93QmwWcIiM9wGKsjs
         3NYHrQP34v+bD9+NrjVszRwybZfWfCnllT1zViR4v9+xy6onPpCFBe/EUg8Mtd+4Aq44
         6XWVzP0VHjBTjSLfNZa2BzwInDPBrTCagIdzVSCh9kHqVZlDh6Uns4bS5Ny9dEkAIJ39
         64L/eEZtaD6QqBWcmM6yVg+Y6UPA0GF9xJUZDpug+GBf+NFY6TkYRltc3zwTEsj5+b/c
         kuUdpgDFI2AWELaMqwzNeU3sHlVqFtM8lLQK7PRMkQF/X09FqYRR2BhHqlZ6ZOIFFKXn
         LGFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WhEc8+uS;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WhEc8+uS;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224EXPEitfsd8LsobSkqR5c+kgIjD8Whnbbgvr0NJfYFmBRODMkrS1jXrWyf9QjAYSmeQfmdyQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: gregkh@linuxfoundation.org,
	lumotuwe@gmail.com,
	arvind.yadav.cs@gmail.com,
	josephl@nvidia.com,
	kstewart@linuxfoundation.org,
	pombredanne@nexb.com,
	tglx@linutronix.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	baolin.wang@linaro.org
Subject: [PATCH] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Fri,  9 Feb 2018 14:08:28 +0800
Message-Id: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1591902511604872416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some platforms (such as Spreadtrum platform), the GPIO keys can only
be triggered by level type. So this patch introduces one property to
indicate if the GPIO trigger type is level trigger or edge trigger.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/input/gpio-keys.txt        |    2 ++
 drivers/input/keyboard/gpio_keys.c                 |   22 +++++++++++++++++++-
 include/linux/gpio_keys.h                          |    1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a949404..e3104bd 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -29,6 +29,8 @@ Optional subnode-properties:
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
+	- gpio-key,level-trigger: Boolean, indicates that button's interrupt
+	  type is level trigger. Otherwise it is edge trigger as default.
 
 Example nodes:
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613d..d3b4bb6 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -385,6 +385,19 @@ static void gpio_keys_gpio_work_func(struct work_struct *work)
 	struct gpio_button_data *bdata =
 		container_of(work, struct gpio_button_data, work.work);
 
+	if (bdata->button->level_trigger) {
+		unsigned int trigger =
+			irq_get_trigger_type(bdata->irq) & ~IRQF_TRIGGER_MASK;
+		int state = gpiod_get_raw_value_cansleep(bdata->gpiod);
+
+		if (state)
+			trigger |= IRQF_TRIGGER_LOW;
+		else
+			trigger |= IRQF_TRIGGER_HIGH;
+
+		irq_set_irq_type(bdata->irq, trigger);
+	}
+
 	gpio_keys_gpio_report_event(bdata);
 
 	if (bdata->button->wakeup)
@@ -566,7 +579,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
 
 		isr = gpio_keys_gpio_isr;
-		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		if (button->level_trigger)
+			irqflags = gpiod_is_active_low(bdata->gpiod) ?
+				IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
+		else
+			irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
 	} else {
 		if (!button->irq) {
@@ -721,6 +738,9 @@ static void gpio_keys_close(struct input_dev *input)
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
+		button->level_trigger =
+			fwnode_property_read_bool(child, "gpio-key,level-trigger");
+
 		if (fwnode_property_read_u32(child, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77..5095645 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -28,6 +28,7 @@ struct gpio_keys_button {
 	int wakeup;
 	int debounce_interval;
 	bool can_disable;
+	bool level_trigger;
 	int value;
 	unsigned int irq;
 };
-- 
1.7.9.5
