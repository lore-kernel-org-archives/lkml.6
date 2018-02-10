Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x226fbCIiEkrpI+XTii572ikS4xAvb7QKqlbJb0Lk152OwFih4fkvdTTITr32kb8naG5NWIuP
ARC-Seal: i=1; a=rsa-sha256; t=1518261002; cv=none;
        d=google.com; s=arc-20160816;
        b=XBiHvXn+IUxC+8ROi2fqyFiREDrjypmg3ZThtYpQPfrWQNVNHCVPaTf/McWYPiR/Mx
         gFG7WRHLa69/gTIhgxp+5MJng35e9TEdmfpEzoKAUx+E6gODHyXmfmWSfH8hYav/inBT
         q7RP3RPbHoiTN3RI1iYk5gM42XNqZtfOUby1sEn56rLBAfry9SWVxjAA6eZbqkHkL3TG
         qfZijXK3UDmcMCkuSd1SUcBerFh0qoQxpQ5qefNAtyfEqhfTQMvxtltch0YnaygCrs4V
         Q8EkO/r5c4+rX+s2A9eXBjgQ+f8hSjvWFdHp5E1IzwMcwp89WN5RqTvuitUdlXM855E6
         OzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UnLWS10Du+PZmIdC0JBy936WtMEvDFRI4ps9N/nhE24=;
        b=w+JxPvly0WrH2yKvfwvmtKC6xJu1WT775iZnDeGIzvDzGuouWU/JIRBhCwOGTS+Bsq
         cI5o+OIMUeTn9Lq8rs1LYF1L82UB11kU23wK1jAuX8vAd9JnSLT+DaSMZ99EKH4G7Vt2
         we6taFcsbpclCWw7tnO4KSn8Lpx2e8u0g8SCN2OFc9bP/XjMpSRYSrTinyIV2X98rw9c
         DyOwq1Ab9eeRwt81nrGvRmPQ7Htdhg0jY9dzcOC4e++rxXubX+Zyl6ahg1H0Tr9J4fnK
         roNUYxOs1sj666Moqs3ebXU3PhTZUvg0XnPIeZw3LnDh7OKHEXLTfFWyGzTkRm4+HHMQ
         QxhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.11 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.11 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <d7f4214065fd72992daec99752d1c74a>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>,
	stephen lu <lumotuwe@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event action
Date: Sat, 10 Feb 2018 19:09:05 +0800
Message-Id: <20180210110907.5504-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1592012049405115473?=
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

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 drivers/input/keyboard/gpio_keys.c     | 27 +++++++++++++++++++++++++++
 include/linux/gpio_keys.h              |  2 ++
 include/uapi/linux/input-event-codes.h |  9 +++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..5c57339d3999 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -45,6 +45,8 @@ struct gpio_button_data {
 	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
 
 	unsigned int irq;
+	unsigned int irq_trigger_type;
+	unsigned int wakeup_trigger_type;
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
@@ -540,6 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	}
 
 	if (bdata->gpiod) {
+		int active_low = gpiod_is_active_low(bdata->gpiod);
+
 		if (button->debounce_interval) {
 			error = gpiod_set_debounce(bdata->gpiod,
 					button->debounce_interval * 1000);
@@ -568,6 +572,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		isr = gpio_keys_gpio_isr;
 		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
+		switch (button->wakeup_event_action) {
+		case EV_ACT_ASSERTED:
+			bdata->wakeup_trigger_type = active_low ?
+				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
+			break;
+		case EV_ACT_DEASSERTED:
+			bdata->wakeup_trigger_type = active_low ?
+				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
+			break;
+		}
 	} else {
 		if (!button->irq) {
 			dev_err(dev, "Found button without gpio or irq\n");
@@ -618,6 +632,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		return error;
 	}
 
+	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);
+
 	return 0;
 }
 
@@ -718,6 +734,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			/* legacy name */
 			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
+		fwnode_property_read_u32(child, "wakeup-event-action",
+					 &button->wakeup_event_action);
+
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
@@ -854,6 +873,10 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
+
+			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
+				irq_set_irq_type(bdata->irq,
+						 bdata->wakeup_trigger_type);
 			if (bdata->button->wakeup)
 				enable_irq_wake(bdata->irq);
 			bdata->suspended = true;
@@ -878,6 +901,10 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
+
+			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
+				irq_set_irq_type(bdata->irq,
+						 bdata->irq_trigger_type);
 			if (bdata->button->wakeup)
 				disable_irq_wake(bdata->irq);
 			bdata->suspended = false;
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
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 53fbae27b280..d7917b0bd438 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -32,6 +32,15 @@
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
 
 /*
+ * Event action types
+ */
+#define EV_ACT_ANY			0x00	/* asserted or deasserted */
+#define EV_ACT_ASSERTED			0x01	/* asserted */
+#define EV_ACT_DEASSERTED		0x02	/* deasserted */
+#define EV_ACT_MAX			0x02
+#define EV_ACT_CNT			(EV_ACT_MAX+1)
+
+/*
  * Event types
  */
 
-- 
2.11.0
