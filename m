Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x2263o2aUgWcbiGZCOu9K3BMAI2Zd/vWI9AcM3OfE3iqBANd6SCnBoGzpJr9PhagaLr8ouO4N
ARC-Seal: i=1; a=rsa-sha256; t=1518177351; cv=none;
        d=google.com; s=arc-20160816;
        b=H6I+Wa8EKthmGwnk8jd83GtuyBhnhogQxPdkzKub6G2ZB2G8LbiR5QYULI8zvttRRn
         lxHYOVzUHKTXiMuaDiQLn9sNObLeBu9gq1xC9hYoRl91YXJw+L/wNIOkkduRSM2M1gsh
         twuyqK2sigzmo+Log1GqWVtibi9hB+XJ1aksmSg3Zj/aWYfc8ElY4ioaHNfUsBBTu95S
         BziKodgM6slwUXc5QgZSfw4x4xrNP+JC5GtIfTzch2z2qs/BEBPP2jaHjE5Ql1+mayqE
         F4TQYn5bs4enS2EIRXl7mFR1hVDzI2c+YGmd0gyivOJqHvFSdrhrEG40NqG+q2dggNrk
         J0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dGEgUgsjTKCgZ56qQV7KJG/NaJmPiTUp7lnnc3gYRdw=;
        b=zqbyk0AqUz+mM/3l+/DJGjKoNB/DfFuI6D1fPpIuLqHrj/6aJb7s/oGajZUobxrWR7
         2fp5VEMHg0qrM8iy5s/4X1hPb8sKGR7HpxggcJX67V+YLzD+EBjzQrT2V1tKarZAJM4t
         wd3w/hdJ8L+CXgQlOOPV+07frcj1jTZeu5K89cVBiKrnJ+78cMQ7Hfv3gPcDd+uhQnhz
         UH0Be0LKWITJOPWtsz3+8h5sJTT4rcoaSfSVhbmXrXAOuGlBF5hltJKkGF9dOVnHj2o6
         KrBxZtkC/vcbhL7R0sxGf0QZ2bViI8/A/S1M57V7DzoPPQ3Q5a5hXHbCFXXKtx4cglju
         iAYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.16 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.16 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <a3fbe9e62233394c7b605a7a4f71dcce>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>,
	stephen lu <lumotuwe@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/3] Input: gpio-keys - add support for wakeup interrupt trigger type
Date: Fri,  9 Feb 2018 19:55:08 +0800
Message-Id: <20180209115510.11868-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591924334357410386?=
X-GMAIL-MSGID: =?utf-8?q?1591924334357410386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for specifying a different interrupt trigger type for wakeup
when using the gpio-keys input device as a wakeup source.

This would allow the device to configure when to wakeup the system. For
example a gpio-keys input device for pen insert, may only want to wakeup
the system when ejecting the pen.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/input/keyboard/gpio_keys.c | 20 ++++++++++++++++++--
 include/linux/gpio_keys.h          |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..5e5c93b75a71 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -45,6 +45,7 @@ struct gpio_button_data {
 	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
 
 	unsigned int irq;
+	unsigned int irq_trigger_type;
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
@@ -618,6 +619,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		return error;
 	}
 
+	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);
+
 	return 0;
 }
 
@@ -718,6 +721,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			/* legacy name */
 			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
+		fwnode_property_read_u32(child, "wakeup-trigger-type",
+					 &button->wakeup_trigger_type);
+
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
@@ -854,7 +860,12 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
+			const struct gpio_keys_button *button = bdata->button;
+
+			if (button->wakeup && button->wakeup_trigger_type)
+				irq_set_irq_type(bdata->irq,
+						 button->wakeup_trigger_type);
+			if (button->wakeup)
 				enable_irq_wake(bdata->irq);
 			bdata->suspended = true;
 		}
@@ -878,7 +889,12 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
+			const struct gpio_keys_button *button = bdata->button;
+
+			if (button->wakeup && button->wakeup_trigger_type)
+				irq_set_irq_type(bdata->irq,
+						 bdata->irq_trigger_type);
+			if (button->wakeup)
 				disable_irq_wake(bdata->irq);
 			bdata->suspended = false;
 		}
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77400f1..9b7e7137f768 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -13,6 +13,7 @@ struct device;
  * @desc:		label that will be attached to button's gpio
  * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
  * @wakeup:		configure the button as a wake-up source
+ * @wakeup_trigger_type:	wakeup interrupt trigger type
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
@@ -26,6 +27,7 @@ struct gpio_keys_button {
 	const char *desc;
 	unsigned int type;
 	int wakeup;
+	int wakeup_trigger_type;
 	int debounce_interval;
 	bool can_disable;
 	int value;
-- 
2.11.0
