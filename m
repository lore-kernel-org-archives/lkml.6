Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D047120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="yqUZUrfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D047120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFTOrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:47:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33065 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:47:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so1901947plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=d6LastiTdBYjNYfhXU9wC5ClLjhkX2tfpmqR57CM6Nc=;
        b=yqUZUrfBuhe5NcipDAITFDoc/KIyAI0f7cwHfje/W4D0TK3XuoaUdAk1etH3ZibJG7
         kuZ83JpEpQoKx0ir9lQWDcXSl5E0DGcsDXCQjkuJOXm0zNzi5pc/wOOgyLK+nipwgUKg
         vpQieRjXyIWNtcuofN7PkiEGuroZQa+uAu+A129E3JlqKMO8Mt2SCY93OdvFskt3VxBz
         qXbwnPiItiDjWGQgdxqMVnAHkL50+3csRXnXltoC+qtatUvj5CDEQyOmZX0+Aux8tCMb
         HhTb49xf5wDMrI6CCFgEi7JwUEWzIbb837XV8o5yT0PJWVHOt7ttdQ3KdvErzhyA2eSg
         FdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d6LastiTdBYjNYfhXU9wC5ClLjhkX2tfpmqR57CM6Nc=;
        b=frRCYmu9eorzkfL4H9mRXzJ2bAov2Is8y6Mq5SkqleBSkiLSuEtF0OyjkXAnsb3ogu
         PbGC9Yg6ZOcHn9TSTxtdgGAS80aH/uDVLRAjBump6fYZakTgSMdsPYqlyIuqej4YzxSS
         Oupc2zsiSFryjqLRh1C8UBs5UmiPLSi9WISETwvpCQpxDvnAEK8d2o+HxJYkXUBmy80G
         DzqRZpjqIi9XNZBlIvRQ5JnRRsRdSCNuDSDat5w6BHF+Q7S1s+cX96hLZye2qOBGGoyl
         gXR1CqdtoU6HMdJbthpyOmh89nHN3XndnWUctO3biI+6yVdSZg/12SX/A094BKBg/co/
         +t4Q==
X-Gm-Message-State: APt69E3kPg+MCJqOrOGutBgrcgqrMVepcBMHJnMdNIb3QAbNTg8bcQCf
        UFi9BBpEkK/Uaf3QS9kghZR6H/+g
X-Google-Smtp-Source: ADUXVKJQhuyyED+dKau8OG4g+mVkHJVLoGyby4Vx1Bcq5NsAjsJyS/hmJIbTrLFcObL7ZCkFbIFNBw==
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr24342004plh.291.1529506027390;
        Wed, 20 Jun 2018 07:47:07 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id w7-v6sm3029398pgr.82.2018.06.20.07.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 07:47:06 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     corentin.chary@gmail.com, dvhart@infradead.org,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v3 1/2] platform/x86: asus-wmi: Call led hw_changed API on kbd brightness change
Date:   Wed, 20 Jun 2018 22:46:44 +0800
Message-Id: <20180620144645.2084-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make asus-wmi notify on hotkey kbd brightness changes, listen for
brightness events and update the brightness directly in the driver.
Create new do_kbd_led_set function for in-driver update, and leave
kbd_led_set for original led_classdev call path.

Update the brightness by led_classdev_notify_brightness_hw_changed.
This will allow userspace to monitor (poll) for brightness changes
on the LED without reporting via input keymapping.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1f6e68f0b646..f2b9037f6ded 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -460,6 +460,7 @@ static void kbd_led_update(struct work_struct *work)
 		ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
 
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
+	led_classdev_notify_brightness_hw_changed(&asus->kbd_led, asus->kbd_led_wk);
 }
 
 static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
@@ -490,15 +491,16 @@ static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
 	return retval;
 }
 
-static void kbd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
 {
 	struct asus_wmi *asus;
+	int max_level;
 
 	asus = container_of(led_cdev, struct asus_wmi, kbd_led);
+	max_level = asus->kbd_led.max_brightness;
 
-	if (value > asus->kbd_led.max_brightness)
-		value = asus->kbd_led.max_brightness;
+	if (value > max_level)
+		value = max_level;
 	else if (value < 0)
 		value = 0;
 
@@ -506,6 +508,12 @@ static void kbd_led_set(struct led_classdev *led_cdev,
 	queue_work(asus->led_workqueue, &asus->kbd_led_work);
 }
 
+static void kbd_led_set(struct led_classdev *led_cdev,
+			enum led_brightness value)
+{
+	do_kbd_led_set(led_cdev, value);
+}
+
 static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
 {
 	struct asus_wmi *asus;
@@ -656,6 +664,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 
 		asus->kbd_led_wk = led_val;
 		asus->kbd_led.name = "asus::kbd_backlight";
+		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
 		asus->kbd_led.brightness_set = kbd_led_set;
 		asus->kbd_led.brightness_get = kbd_led_get;
 		asus->kbd_led.max_brightness = 3;
@@ -1745,6 +1754,15 @@ static void asus_wmi_notify(u32 value, void *context)
 		}
 	}
 
+	if (code == NOTIFY_KBD_BRTUP) {
+		do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
+		goto exit;
+	}
+	if (code == NOTIFY_KBD_BRTDWN) {
+		do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
+		goto exit;
+	}
+
 	if (is_display_toggle(code) &&
 	    asus->driver->quirks->no_display_toggle)
 		goto exit;
-- 
2.11.0

