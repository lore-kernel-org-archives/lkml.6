Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Mw7q6Q6MklCVTTfZ6HSMISRVpYVmEDO5uTLUGFq0Dn/BbcqZ8FZwrJpiaJFc+TSC0tX86
ARC-Seal: i=1; a=rsa-sha256; t=1524652722; cv=none;
        d=google.com; s=arc-20160816;
        b=ztFG2iv9avD4bcpVpjwVb8GGVrvhrICza8Oc74FQ1bgoF5aoJ67Pc5RNoO58+OSPQq
         7IAmbzIwrYce9Cs3MQsq6w6GQomDHUnBhJlAEXADMcgaBtrTrQYYk43eYCKLMsUdXBQT
         urEn1N9GLxRwqF2/fLM/9ZEfhMuLClLmDnvxI44+JIeIgVgkEG+chmaFFfYnsDpPSmA/
         +Vfck/IqABJbFgdVzgzVTbiTgTl5eEnIovJcI9DziI2ODeVUwSv4S/DDomAZjNeOKdUp
         KUlW6eIZwHEZooP8HGxq/PKAUCNmRu2Xefzhdslh6yuPt/u+AuuPv86paxU5O7EM5bcU
         Y7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/ZKOlfbcKrXjESlVylfG7xkUGaVdQ2eUEU1STVY7uNg=;
        b=oHNyaJuBJ7lZ1/ztlCOtQRZW2WuXWayjL6CRbSCwuVV1Gtwz85hVygeF7mWjJ8MABH
         E9OaY10z7/Zf4RGjuLZl1Vl+5TFrSNcqysuLAFHaldBz26MEheTZ3TsjuhPerz2/m5cw
         0CSNkhZeOfSFeB1Lo6F67NRf08EIANidWUHUX6Xo9U9M0SwElYXOqsYsM/mBpNiZwoOg
         /+uwUML9dyh6LKqyD6wJFVcWSbvctP8Q8vpag8pW7Y7TAmpEHRXa7AZtNewru+h48kia
         nvafCtbY4QGrigAxp5SWwSf7GECNVgL3L3QvkbkcLC0dK3pDlBcA1xXaNshwInHTvdr6
         SK4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 028/183] platform/x86: dell-laptop: Filter out spurious keyboard backlight change events
Date: Wed, 25 Apr 2018 12:34:08 +0200
Message-Id: <20180425103243.725877621@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714253700255986?=
X-GMAIL-MSGID: =?utf-8?q?1598714253700255986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 4d6bde512a86c32df3a1f289d2b4cd04b17758d1 ]

On some Dell XPS models WMI events of type 0x0000 reporting a keycode of
0xe00c get reported when the brightness of the LCD panel changes.

This leads to us reporting false-positive kbd_led change events to
userspace which in turn leads to the kbd backlight OSD showing when it
should not.

We already read the current keyboard backlight brightness value when
reporting events because the led_classdev_notify_brightness_hw_changed
API requires this. Compare this value to the last known value and filter
out duplicate events, fixing this.

Note the fixed issue is esp. a problem on XPS models with an ambient light
sensor and automatic brightness adjustments turned on, this causes the kbd
backlight OSD to show all the time there.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514969
Fixes: 9c656b0799 ("platform/x86: dell-*: Call new led hw_changed API ...")
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell-laptop.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -1177,6 +1177,7 @@ static u8 kbd_previous_mode_bit;
 
 static bool kbd_led_present;
 static DEFINE_MUTEX(kbd_led_mutex);
+static enum led_brightness kbd_led_level;
 
 /*
  * NOTE: there are three ways to set the keyboard backlight level.
@@ -2020,6 +2021,7 @@ static enum led_brightness kbd_led_level
 static int kbd_led_level_set(struct led_classdev *led_cdev,
 			     enum led_brightness value)
 {
+	enum led_brightness new_value = value;
 	struct kbd_state state;
 	struct kbd_state new_state;
 	u16 num;
@@ -2049,6 +2051,9 @@ static int kbd_led_level_set(struct led_
 	}
 
 out:
+	if (ret == 0)
+		kbd_led_level = new_value;
+
 	mutex_unlock(&kbd_led_mutex);
 	return ret;
 }
@@ -2076,6 +2081,9 @@ static int __init kbd_led_init(struct de
 		if (kbd_led.max_brightness)
 			kbd_led.max_brightness--;
 	}
+
+	kbd_led_level = kbd_led_level_get(NULL);
+
 	ret = led_classdev_register(dev, &kbd_led);
 	if (ret)
 		kbd_led_present = false;
@@ -2100,13 +2108,25 @@ static void kbd_led_exit(void)
 static int dell_laptop_notifier_call(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
+	bool changed = false;
+	enum led_brightness new_kbd_led_level;
+
 	switch (action) {
 	case DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED:
 		if (!kbd_led_present)
 			break;
 
-		led_classdev_notify_brightness_hw_changed(&kbd_led,
-						kbd_led_level_get(&kbd_led));
+		mutex_lock(&kbd_led_mutex);
+		new_kbd_led_level = kbd_led_level_get(&kbd_led);
+		if (kbd_led_level != new_kbd_led_level) {
+			kbd_led_level = new_kbd_led_level;
+			changed = true;
+		}
+		mutex_unlock(&kbd_led_mutex);
+
+		if (changed)
+			led_classdev_notify_brightness_hw_changed(&kbd_led,
+								kbd_led_level);
 		break;
 	}
 
