Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELtf6jxEMsnYqUTI0CsgCqS/UnK4fHXBqPFPW9uIY80sHdPdXSMfKmag/Ucvixcgp9Lf5oKP
ARC-Seal: i=1; a=rsa-sha256; t=1520322340; cv=none;
        d=google.com; s=arc-20160816;
        b=eustSAyAnQy0+3FYzuXqHSDNa5vgdeS95svbwDwmmtlR3KWOMr/YzVaPRn152smdiP
         Bs6j9oAEvf+JyyjWD8O/wx6lrdHbPYtl4f7pFg4tUHou6d6xoIzyzFFUv34Wo8JbCEu1
         mcUCSokIJ5zKIZdFO/uKYDga5+sIqtx6mzD1Saqbc33vQaxMgYL/AFJyu0hrJAmuHxyr
         ErU527ummkYCq8G0GzSpLRXT28PHYR4bEgSSp+vVessCUy7nCQ+RNGsn0YUICvkyLBvB
         bzziU9diu1gdvPG1ZJ/dliD55iaZAT1NXUBb2e+08vosY7kVtEd3VmNTUVMND5jMJYsZ
         HLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kuSuPIl4GyuunGtbJUVzbVgKAZ5Zf//8/uFm3HUdd7o=;
        b=k2sI+DjFO0/w+GWE0F5oW1RzqSsMSR3zCsuQatSeo4qJfSjELZ8wCd2agTGwG2n6eX
         x8aa/wmYZUTs3oDJ9RABU1ttCb/sVrHlSNWJS+NMBnH4a6XR3APf3XAZ1xEIaovbwgTh
         9Zo61fqbIg6L+fToSPksRZaAO0nlGmYfx4veHbeI3uIgS6sfxI1jHaY/iFcfbly+mIFq
         l2J8BHjWUdET79viws1yNqdmEQ0VtGmfQGd13crTnUedib/ncPSHh9tWGey+qgHVeFSq
         LRzmBtwX0nVGMgbBj3vZgXqczPZ/ognkUBLSaMcm/70Gk5xORNwlPEJWvPW5IT6k5Yir
         6N7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.19 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.19 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <b15e28698ff8b43a3d976be703ff55ef>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	heiko@sntech.de,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>,
	stephen lu <lumotuwe@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v4 1/3] Input: gpio-keys - add support for wakeup event action
Date: Tue,  6 Mar 2018 15:44:16 +0800
Message-Id: <20180306074418.8879-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306074418.8879-1-jeffy.chen@rock-chips.com>
References: <20180306074418.8879-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594173518404069407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for specifying event actions to trigger wakeup when using
the gpio-keys input device as a wakeup source.

This would allow the device to configure when to wakeup the system. For
example a gpio-keys input device for pen insert, may only want to wakeup
the system when ejecting the pen.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4:
Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.

Changes in v3:
Adding more comments as Brian suggested.

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 drivers/input/keyboard/gpio_keys.c    | 67 +++++++++++++++++++++++++++++++++--
 include/dt-bindings/input/gpio-keys.h | 13 +++++++
 include/linux/gpio_keys.h             |  2 ++
 3 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/input/gpio-keys.h

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..4bc23648b6a7 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
+#include <dt-bindings/input/gpio-keys.h>
 
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
@@ -45,10 +46,12 @@ struct gpio_button_data {
 	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
 
 	unsigned int irq;
+	unsigned int wakeup_trigger_type;
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
 	bool suspended;
+	bool wakeup_enabled;
 };
 
 struct gpio_keys_drvdata {
@@ -540,6 +543,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	}
 
 	if (bdata->gpiod) {
+		int active_low = gpiod_is_active_low(bdata->gpiod);
+
 		if (button->debounce_interval) {
 			error = gpiod_set_debounce(bdata->gpiod,
 					button->debounce_interval * 1000);
@@ -568,6 +573,24 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		isr = gpio_keys_gpio_isr;
 		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
+		switch (button->wakeup_event_action) {
+		case EV_ACT_ASSERTED:
+			bdata->wakeup_trigger_type = active_low ?
+				IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+			break;
+		case EV_ACT_DEASSERTED:
+			bdata->wakeup_trigger_type = active_low ?
+				IRQ_TYPE_EDGE_RISING : IRQ_TYPE_EDGE_FALLING;
+			break;
+		case EV_ACT_ANY:
+			/* fall through */
+		default:
+			/*
+			 * For other cases, we are OK letting suspend/resume
+			 * not reconfigure the trigger type.
+			 */
+			break;
+		}
 	} else {
 		if (!button->irq) {
 			dev_err(dev, "Found button without gpio or irq\n");
@@ -586,6 +609,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
+
+		/*
+		 * For IRQ buttons, there is no interrupt for release.
+		 * So we don't need to reconfigure the trigger type for wakeup.
+		 */
 	}
 
 	bdata->code = &ddata->keymap[idx];
@@ -718,6 +746,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			/* legacy name */
 			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
+		fwnode_property_read_u32(child, "wakeup-event-action",
+					 &button->wakeup_event_action);
+
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
@@ -845,6 +876,31 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int gpio_keys_enable_wakeup(struct gpio_button_data *bdata)
+{
+	int ret;
+
+	ret = enable_irq_wake(bdata->irq);
+	if (ret)
+		return ret;
+
+	if (bdata->wakeup_trigger_type)
+		irq_set_irq_type(bdata->irq, bdata->wakeup_trigger_type);
+
+	return 0;
+}
+
+static void gpio_keys_disable_wakeup(struct gpio_button_data *bdata)
+{
+	/**
+	 * The trigger type is always both edges for gpio-based keys and we do
+	 * not support changing wakeup trigger for interrupt-based keys.
+	 */
+	if (bdata->wakeup_trigger_type)
+		irq_set_irq_type(bdata->irq, IRQ_TYPE_EDGE_BOTH);
+	disable_irq_wake(bdata->irq);
+}
+
 static int __maybe_unused gpio_keys_suspend(struct device *dev)
 {
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
@@ -854,8 +910,10 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
+
 			if (bdata->button->wakeup)
-				enable_irq_wake(bdata->irq);
+				bdata->wakeup_enabled =
+					!gpio_keys_enable_wakeup(bdata);
 			bdata->suspended = true;
 		}
 	} else {
@@ -878,9 +936,12 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
-				disable_irq_wake(bdata->irq);
+
 			bdata->suspended = false;
+			if (bdata->wakeup_enabled) {
+				gpio_keys_disable_wakeup(bdata);
+				bdata->wakeup_enabled = false;
+			}
 		}
 	} else {
 		mutex_lock(&input->mutex);
diff --git a/include/dt-bindings/input/gpio-keys.h b/include/dt-bindings/input/gpio-keys.h
new file mode 100644
index 000000000000..8962df79e753
--- /dev/null
+++ b/include/dt-bindings/input/gpio-keys.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for gpio keys bindings.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_KEYS_H
+#define _DT_BINDINGS_GPIO_KEYS_H
+
+#define EV_ACT_ANY		0x00	/* asserted or deasserted */
+#define EV_ACT_ASSERTED		0x01	/* asserted */
+#define EV_ACT_DEASSERTED	0x02	/* deasserted */
+
+#endif /* _DT_BINDINGS_GPIO_KEYS_H */
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77400f1..7160df54a6fe 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -13,6 +13,7 @@ struct device;
  * @desc:		label that will be attached to button's gpio
  * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
  * @wakeup:		configure the button as a wake-up source
+ * @wakeup_event_action:	event action to trigger wakeup
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
@@ -26,6 +27,7 @@ struct gpio_keys_button {
 	const char *desc;
 	unsigned int type;
 	int wakeup;
+	int wakeup_event_action;
 	int debounce_interval;
 	bool can_disable;
 	int value;
-- 
2.11.0
