Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B89C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EB1223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB1223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=80x24.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeKORlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:41:11 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48492 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbeKORlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:41:11 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6A0541F87F;
        Thu, 15 Nov 2018 07:34:30 +0000 (UTC)
Date:   Thu, 15 Nov 2018 07:34:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Shuduo Sang <shuduo.sang@canonical.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: add adaptive_kbd_modes parameter
Message-ID: <20181115073429.z44czywrf7f65ndb@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bitmap parameter allows the user to add/remove modes for
DFR_CHANGE_ROW to cycle through.

Users who wish to cycle through WEB_BROWSER_MODE and/or
WEB_CONFERENCE_MODE may now do so by enabling corresponding bits.

While some appreciate more modes, I made this feature because I
wanted to lock the keyboard into FUNCTION_MODE.  This is because
my Fn key (DFR_CHANGE_ROW) is mapped to Escape, and my "Esc" key
is mapped to grave/asciitilde to match the layout of a regular
keyboard.

The default remains unchanged with the DFR_CHANGE_ROW key
toggling between HOME_MODE and FUNCTION_MODE.  Thus the
default "adaptive_kbd_modes" value is 9, but I use 8:

echo 8 >/sys/devices/platform/thinkpad_acpi/adaptive_kbd_modes

The above setting with this change and the following keymap
preserves my sanity on the atrocious adaptive keyboard on
the 2nd-gen X1 Carbon:

	{
		echo keymaps 0-255
		# Esc key maps to '`' or '~'
		echo keycode  1 = grave asciitilde

		# Fn key maps to Escape
		echo keycode 143 = Escape

		# Home and End on the keyboard map to Control
		echo keycode 102 = Control
		echo keycode 107 = Control
	} | loadkeys -

Or with the following xmodmaprc:

	remove Control = Control_L
	remove Lock = Control_L
	keycode   9 = grave asciitilde grave
	keycode 110 = Control_L NoSymbol Control_L
	keycode 115 = Control_L NoSymbol Control_L
	keycode 151 = Escape NoSymbol Escape
	add Control = Control_L

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/laptops/thinkpad-acpi.txt | 11 +++++
 drivers/platform/x86/thinkpad_acpi.c    | 79 ++++++++++++++++++++++-----------
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 6cced88de6da..36c8731b6919 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1378,6 +1378,17 @@ For more details about which buttons will appear depending on the mode, please
 review the laptop's user guide:
 http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
 
+sysfs device attribute: adaptive_kbd_modes
+
+This bitmap attribute controls the modes the "Fn" key is allowed
+to cycle through.  The value can be read and set.  Enabled bits
+correspond to the modes above (that is, the first bit is "Home mode"
+and the fourth bit "Function mode").
+
+The default value is 9, which allows cycling between Home and Function modes.
+Setting and unsetting corresponding bits allows adding or removing modes
+to cycle through.
+
 Multiple Commands, Module Parameters
 ------------------------------------
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index fde08a997557..77b4f00e0443 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3094,8 +3094,44 @@ static ssize_t adaptive_kbd_mode_store(struct device *dev,
 
 static DEVICE_ATTR_RW(adaptive_kbd_mode);
 
+/* Thinkpad X1 Carbon support 5 modes including Home mode, Web browser
+ * mode, Web conference mode, Function mode and Lay-flat mode.
+ * We support cycling between Home mode and Function mode by default.
+ *
+ * Users may enable and disable other modes by changing the
+ * adaptive_kbd_modes bitmap attribute
+ */
+static unsigned adaptive_kbd_modes =
+	1 << HOME_MODE |
+/*	1 << WEB_BROWSER_MODE |
+	1 << WEB_CONFERENCE_MODE | */
+	1 << FUNCTION_MODE;
+
+static ssize_t adaptive_kbd_modes_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", adaptive_kbd_modes);
+}
+
+static ssize_t adaptive_kbd_modes_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, (1 << LAYFLAT_MODE) - 1, &t))
+		return -EINVAL;
+
+	adaptive_kbd_modes = (unsigned int)t;
+	return count;
+}
+
+static DEVICE_ATTR_RW(adaptive_kbd_modes);
+
 static struct attribute *adaptive_kbd_attributes[] = {
 	&dev_attr_adaptive_kbd_mode.attr,
+	&dev_attr_adaptive_kbd_modes.attr,
 	NULL
 };
 
@@ -3763,20 +3799,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	return (res < 0) ? res : 1;
 }
 
-/* Thinkpad X1 Carbon support 5 modes including Home mode, Web browser
- * mode, Web conference mode, Function mode and Lay-flat mode.
- * We support Home mode and Function mode currently.
- *
- * Will consider support rest of modes in future.
- *
- */
-static const int adaptive_keyboard_modes[] = {
-	HOME_MODE,
-/*	WEB_BROWSER_MODE = 2,
-	WEB_CONFERENCE_MODE = 3, */
-	FUNCTION_MODE
-};
-
+/* Thinkpad X1 Carbon adaptive keyboard */
 #define DFR_CHANGE_ROW			0x101
 #define DFR_SHOW_QUICKVIEW_ROW		0x102
 #define FIRST_ADAPTIVE_KEY		0x103
@@ -3815,20 +3838,20 @@ static int adaptive_keyboard_set_mode(int new_mode)
 
 static int adaptive_keyboard_get_next_mode(int mode)
 {
-	size_t i;
-	size_t max_mode = ARRAY_SIZE(adaptive_keyboard_modes) - 1;
-
-	for (i = 0; i <= max_mode; i++) {
-		if (adaptive_keyboard_modes[i] == mode)
-			break;
-	}
+	int max_mode = fls(adaptive_kbd_modes);
+	int new_mode = mode >= max_mode ? HOME_MODE : mode + 1;
 
-	if (i >= max_mode)
-		i = 0;
-	else
-		i++;
+	/* make sure the new mode is allowed by the user */
+	while (!(adaptive_kbd_modes & (1 << new_mode))) {
+		new_mode++;
+		if (new_mode > max_mode)
+			new_mode = HOME_MODE;
 
-	return adaptive_keyboard_modes[i];
+		/* maybe the user disabled all other modes: */
+		if (new_mode == mode)
+			return mode;
+	}
+	return new_mode;
 }
 
 static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
@@ -3848,6 +3871,10 @@ static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
 				return false;
 			new_mode = adaptive_keyboard_get_next_mode(
 					current_mode);
+
+			/* some users may not want cycling */
+			if (new_mode == current_mode)
+				return true;
 		}
 
 		if (adaptive_keyboard_set_mode(new_mode) < 0)
-- 
EW
