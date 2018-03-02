Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELtH91EpgK5E9V/Jtvmetyzz4Wdsp2HnGii8pVA6Lex1V2qi+6nZCDYjW7jtL3AA+G139+E8
ARC-Seal: i=1; a=rsa-sha256; t=1519962691; cv=none;
        d=google.com; s=arc-20160816;
        b=l9foAjEv6cncInsi3TfxX3Rs3uPeeWjVUKRKP+ydvF/GXAKGJvGJX9vAkrz0J5+Owr
         bqqReAJvViOGSMkpkYXyuVij3q8wuk1X1whKNNd08aYZxpEMsNf1Ochh4Qy8iCqxZWvO
         PzIwovXRumwx5XS7TbksrHOL1ShgLQIcUPCmypvkpdOObzUoRVneYqR/2N1A1DI1IvZ0
         eoau9HYlAmjk4n9mbHhON5F8vEIfAyG6hGCTtigrfi6cVTgVPf4joxOxlq2sbDtOys1Z
         gnyQzfLawai2pYsPszQ+dBah7CLijrXqpQ3PiS37s4+H2gGSQMW76e9IYfItsuHRczvD
         u6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=prTdjdPtbup39jPsvMAc63YyIgHsRsYuOdr7GYh9cxU=;
        b=vJqcWLFAk7cW06yKo5SCPNgpgEa/lL/LNo6fc5j8lOo+Ss7glp+ZjUwQYGTDA1932j
         U9LjMbhjCeny58I5XU8MhyNECfIOjjuE56oW/v2eMgIJFd8L9nKM8J3lzHWMhumJDnYO
         nOKJzpc+klgfVx9iYvjyhnBE2omYXmp9Dz8mE9YQss8DCl2Uw/SVheI53j/mIV4Ndjzt
         94GsmttG40hWX1a+TaZgda48qnaZlbRi21UZKSrKJnuFE02fFtN6/GNOPNdqk5/nNgSY
         hEeHCBZ7wftFLK8FVc8Cxn02djjzSC+IWhm6rzIKcB6pPSDhI/tBGxxz2Pbp3rQDCaqt
         6v9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.21 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.21 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <4d7e88c828ec82403d7372c7045d4125>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	heiko@sntech.de,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Guenter Roeck <linux@roeck-us.net>,
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
Subject: [PATCH v3 1/3] Input: gpio-keys - add support for wakeup event action
Date: Fri,  2 Mar 2018 11:51:00 +0800
Message-Id: <20180302035102.10084-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1593796398351218110?=
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

Changes in v3:
Adding more comments as Brian suggested.

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 drivers/input/keyboard/gpio_keys.c     | 39 ++++++++++++++++++++++++++++++++++
 include/linux/gpio_keys.h              |  2 ++
 include/uapi/linux/input-event-codes.h |  9 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..607f3960c886 100644
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
@@ -568,6 +572,22 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
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
@@ -586,6 +606,12 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
+
+		/*
+		 * For IRQ buttons, the irq trigger type for press and release
+		 * are the same. So we don't need to reconfigure the trigger
+		 * type for wakeup.
+		 */
 	}
 
 	bdata->code = &ddata->keymap[idx];
@@ -618,6 +644,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		return error;
 	}
 
+	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);
+
 	return 0;
 }
 
@@ -718,6 +746,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			/* legacy name */
 			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
+		fwnode_property_read_u32(child, "wakeup-event-action",
+					 &button->wakeup_event_action);
+
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
@@ -854,6 +885,10 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
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
@@ -878,6 +913,10 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
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
