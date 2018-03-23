Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeCWB1W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 21:27:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCWB1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 21:27:21 -0400
Date: Thu, 22 Mar 2018 18:27:16 -0700
From: "Darren Hart (VMware)" <dvhart@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Cc: Jan-Marek Glogowski <glogow@fbihome.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Jonathan Woithe <jwoithe@just42.net>
Subject: [PATCH] platform/x86: fujitsu-laptop: Simplify soft key handling
Message-ID: <2721b2f93063dd6d5586e151ec6cc14fcd39ec1b.1521768118.git.dvhart@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardcoded BIT(X) used in the soft key handling can be confusing and
prone to errors.

Instead, use the status FLAG_* defines for the sparse keymap index.
Rather than check for each known bit, use a bitmask to filter for all
known soft keys, and use the for_each_set_bit iterator.

Cc: Jan-Marek Glogowski <glogow@fbihome.de>
Cc: Michał Kępień <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---

Note: this applies on top of Jan-Marek's recent RFKILL and MICMUTE hotkey patch.
I'd really appreciate a Tested-by from Jan-Marek in particular. You can get the
entire series ready for testing here:

http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-dvhart-fujitsu

Also wondering if LID and DOCK might benefit from an input event...

 drivers/platform/x86/fujitsu-laptop.c | 47 ++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index cd95b6f3a064..6afeaece2f50 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -91,6 +91,9 @@
 #define FLAG_RFKILL			BIT(5)
 #define FLAG_LID			BIT(8)
 #define FLAG_DOCK			BIT(9)
+#define FLAG_TOUCHPAD_TOGGLE		BIT(26)
+#define FLAG_MICMUTE			BIT(29)
+#define FLAG_SOFTKEYS			(FLAG_RFKILL | FLAG_TOUCHPAD_TOGGLE | FLAG_MICMUTE)
 
 /* FUNC interface - LED control */
 #define FUNC_LED_OFF			BIT(0)
@@ -456,14 +459,15 @@ static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
 /* ACPI device for hotkey handling */
 
 static const struct key_entry keymap_default[] = {
-	{ KE_KEY, KEY1_CODE, { KEY_PROG1 } },
-	{ KE_KEY, KEY2_CODE, { KEY_PROG2 } },
-	{ KE_KEY, KEY3_CODE, { KEY_PROG3 } },
-	{ KE_KEY, KEY4_CODE, { KEY_PROG4 } },
-	{ KE_KEY, KEY5_CODE, { KEY_RFKILL } },
-	{ KE_KEY, BIT(5),    { KEY_RFKILL } },
-	{ KE_KEY, BIT(26),   { KEY_TOUCHPAD_TOGGLE } },
-	{ KE_KEY, BIT(29),   { KEY_MICMUTE } },
+	{ KE_KEY, KEY1_CODE,            { KEY_PROG1 } },
+	{ KE_KEY, KEY2_CODE,            { KEY_PROG2 } },
+	{ KE_KEY, KEY3_CODE,            { KEY_PROG3 } },
+	{ KE_KEY, KEY4_CODE,            { KEY_PROG4 } },
+	{ KE_KEY, KEY5_CODE,            { KEY_RFKILL } },
+	/* Soft keys read from status flags */
+	{ KE_KEY, FLAG_RFKILL,          { KEY_RFKILL } },
+	{ KE_KEY, FLAG_TOUCHPAD_TOGGLE, { KEY_TOUCHPAD_TOGGLE } },
+	{ KE_KEY, FLAG_MICMUTE,         { KEY_MICMUTE } },
 	{ KE_END, 0 }
 };
 
@@ -903,7 +907,8 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	int scancode, i = 0, ret;
+	unsigned long flags;
+	int scancode, i = 0;
 	unsigned int irb;
 
 	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
@@ -930,21 +935,17 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 					 "Unknown GIRB result [%x]\n", irb);
 	}
 
-	/* On some models (first seen on the Skylake-based Lifebook
-	 * E736/E746/E756), the touchpad toggle hotkey (Fn+F4) is
-	 * handled in software; its state is queried using FUNC_FLAGS
+	/*
+	 * First seen on the Skylake-based Lifebook E736/E746/E756), the
+	 * touchpad toggle hotkey (Fn+F4) is handled in software. Other models
+	 * have since added additional "soft keys". These are reported in the
+	 * status flags queried using FUNC_FLAGS.
 	 */
-	if (priv->flags_supported & (BIT(5) | BIT(26) | BIT(29))) {
-		ret = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
-		if (ret & BIT(5))
-			sparse_keymap_report_event(priv->input,
-						   BIT(5), 1, true);
-		if (ret & BIT(26))
-			sparse_keymap_report_event(priv->input,
-						   BIT(26), 1, true);
-		if (ret & BIT(29))
-			sparse_keymap_report_event(priv->input,
-						   BIT(29), 1, true);
+	if (priv->flags_supported & (FLAG_SOFTKEYS)) {
+		flags = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
+		flags &= (FLAG_SOFTKEYS);
+		for_each_set_bit(i, &flags, BITS_PER_LONG)
+			sparse_keymap_report_event(priv->input, BIT(i), 1, true);
 	}
 }
 
-- 
2.14.3


-- 
Darren Hart
VMware Open Source Technology Center
