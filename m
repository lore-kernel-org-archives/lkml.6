Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeBTFZm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:25:42 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33963 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBTFZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:09 -0500
X-Google-Smtp-Source: AH8x227ZPjr7yi7eIUZ9qyUhm8jziA7emWdlGLURJc9B3bsmD/vdZfMlszWQnkL8paKZQKDGj30lXw==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] platform/x86: fujitsu-laptop: Define constants for backlight power control
Date: Tue, 20 Feb 2018 06:24:53 +0100
Message-Id: <20180220052454.11134-7-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use named constants instead of integers in call_fext_func() invocations
related to backlight power control in order to more clearly convey the
intent of each call.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 17779b8b7f30..6b0484cbdcf2 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -101,6 +101,11 @@
 #define ECO_LED	0x10000
 #define ECO_LED_ON	0x80000
 
+/* FUNC interface - backlight power control */
+#define BACKLIGHT_PARAM_POWER	0x4
+#define BACKLIGHT_OFF	0x3
+#define BACKLIGHT_ON	0x0
+
 /* Hotkey details */
 #define KEY1_CODE	0x410	/* codes for the keys in the GIRB register */
 #define KEY2_CODE	0x411
@@ -257,9 +262,11 @@ static int bl_update_status(struct backlight_device *b)
 
 	if (fext) {
 		if (b->props.power == FB_BLANK_POWERDOWN)
-			call_fext_func(fext, FUNC_BACKLIGHT, 0x1, 0x4, 0x3);
+			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
+				       BACKLIGHT_PARAM_POWER, BACKLIGHT_OFF);
 		else
-			call_fext_func(fext, FUNC_BACKLIGHT, 0x1, 0x4, 0x0);
+			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
+				       BACKLIGHT_PARAM_POWER, BACKLIGHT_ON);
 	}
 
 	return set_lcd_level(device, b->props.brightness);
@@ -818,7 +825,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	/* Sync backlight power status */
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
 	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
-		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2, 0x4, 0x0) == 3)
+		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2,
+				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
 		else
 			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
-- 
2.16.1
