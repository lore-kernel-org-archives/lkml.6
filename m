Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D13FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD0E26BC2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD0E26BC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965716AbeFZNz5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:55:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965685AbeFZNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:55:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB4914023444;
        Tue, 26 Jun 2018 13:55:41 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB6992156880;
        Tue, 26 Jun 2018 13:55:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
Date:   Tue, 26 Jun 2018 15:55:35 +0200
Message-Id: <20180626135535.2990-4-hdegoede@redhat.com>
In-Reply-To: <20180626135535.2990-1-hdegoede@redhat.com>
References: <20180626135535.2990-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 13:55:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 13:55:42 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently fbcon claims fbdevs as soon as they are registered and takes over
the console as soon as the first fbdev gets registered.

This behavior is undesirable in cases where a smooth graphical bootup is
desired, in such cases we typically want the contents of the framebuffer
(typically a vendor logo) to stay in place as is.

The current solution for this problem (on embedded systems) is to not
enable fbcon.

This commit adds a new FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER config option,
which when enabled defers fbcon taking over the console from the dummy
console until the first text is displayed on the console. Together with the
"quiet" kernel commandline option, this allows fbcon to still be used
together with a smooth graphical bootup, having it take over the console as
soon as e.g. an error message is logged.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Check the whole string when checking for erases in putcs, instead of just
 the first char
-Make dummycon_blank return 1, so that a redraw gets triggered and any text
 rendered while blanked gets output so that it can trigger a deferred
 takeover if one is pending

Changes in v3:
-Call WARN_CONSOLE_UNLOCKED() from fbcon_output_notifier()
-Unregister the notifier on fbcon_exit()
-Document the fbcon=nodefer commandline option in Documentation/fb/fbcon.txt
---
 Documentation/fb/fbcon.txt       |  7 ++++
 drivers/video/console/Kconfig    | 11 +++++
 drivers/video/console/dummycon.c | 67 +++++++++++++++++++++++++----
 drivers/video/fbdev/core/fbcon.c | 72 ++++++++++++++++++++++++++++++++
 include/linux/console.h          |  5 +++
 5 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index 79c22d096bbc..d4d642e1ce9c 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -155,6 +155,13 @@ C. Boot options
 	used by text. By default, this area will be black. The 'color' value
 	is an integer number that depends on the framebuffer driver being used.
 
+6. fbcon=nodefer
+
+	If the kernel is compiled with deferred fbcon takeover support, normally
+	the framebuffer contents, left in place by the firmware/bootloader, will
+	be preserved until there actually is some text is output to the console.
+	This option causes fbcon to bind immediately to the fbdev device.
+
 C. Attaching, Detaching and Unloading
 
 Before going on how to attach, detach and unload the framebuffer console, an
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 4110ba7d7ca9..e91edef98633 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -150,6 +150,17 @@ config FRAMEBUFFER_CONSOLE_ROTATION
          such that other users of the framebuffer will remain normally
          oriented.
 
+config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+	bool "Framebuffer Console Deferred Takeover"
+	depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y
+	help
+	  If enabled this defers the framebuffer console taking over the
+	  console from the dummy console until the first text is displayed on
+	  the console. This is useful in combination with the "quiet" kernel
+	  commandline option to keep the framebuffer contents initially put up
+	  by the firmware in place, rather then replacing the contents with a
+	  black screen as soon as fbcon loads.
+
 config STI_CONSOLE
         bool "STI text console"
 	depends on PARISC && HAS_IOMEM
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index f2eafe2ed980..45ad925ad5f8 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -26,6 +26,65 @@
 #define DUMMY_ROWS	CONFIG_DUMMY_CONSOLE_ROWS
 #endif
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+/* These are both protected by the console_lock */
+static RAW_NOTIFIER_HEAD(dummycon_output_nh);
+static bool dummycon_putc_called;
+
+void dummycon_register_output_notifier(struct notifier_block *nb)
+{
+	raw_notifier_chain_register(&dummycon_output_nh, nb);
+
+	if (dummycon_putc_called)
+		nb->notifier_call(nb, 0, NULL);
+}
+
+void dummycon_unregister_output_notifier(struct notifier_block *nb)
+{
+	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
+}
+
+static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
+{
+	dummycon_putc_called = true;
+	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
+}
+
+static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
+			   int count, int ypos, int xpos)
+{
+	int i;
+
+	if (!dummycon_putc_called) {
+		/* Ignore erases */
+		for (i = 0 ; i < count; i++) {
+			if (s[i] != vc->vc_video_erase_char)
+				break;
+		}
+		if (i == count)
+			return;
+
+		dummycon_putc_called = true;
+	}
+
+	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
+}
+
+static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+{
+	/* Redraw, so that we get putc(s) for output done while blanked */
+	return 1;
+}
+#else
+static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
+static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
+			   int count, int ypos, int xpos) { }
+static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+{
+	return 0;
+}
+#endif
+
 static const char *dummycon_startup(void)
 {
     return "dummy device";
@@ -44,9 +103,6 @@ static void dummycon_init(struct vc_data *vc, int init)
 static void dummycon_deinit(struct vc_data *vc) { }
 static void dummycon_clear(struct vc_data *vc, int sy, int sx, int height,
 			   int width) { }
-static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
-static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
-			   int count, int ypos, int xpos) { }
 static void dummycon_cursor(struct vc_data *vc, int mode) { }
 
 static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
@@ -61,11 +117,6 @@ static int dummycon_switch(struct vc_data *vc)
 	return 0;
 }
 
-static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
-{
-	return 0;
-}
-
 static int dummycon_font_set(struct vc_data *vc, struct console_font *font,
 			     unsigned int flags)
 {
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ac2cbdf710ee..bd5da263eaff 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -129,6 +129,12 @@ static inline void fbcon_map_override(void)
 }
 #endif /* CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY */
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+static bool deferred_takeover = true;
+#else
+#define deferred_takeover false
+#endif
+
 /* font data */
 static char fontname[40];
 
@@ -499,6 +505,12 @@ static int __init fb_console_setup(char *this_opt)
 				margin_color = simple_strtoul(options, &options, 0);
 			continue;
 		}
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+		if (!strcmp(options, "nodefer")) {
+			deferred_takeover = false;
+			continue;
+		}
+#endif
 	}
 	return 1;
 }
@@ -3096,6 +3108,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 
 	WARN_CONSOLE_UNLOCKED();
 
+	if (deferred_takeover)
+		return 0;
+
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] == idx)
@@ -3135,6 +3150,13 @@ static void fbcon_remap_all(int idx)
 
 	WARN_CONSOLE_UNLOCKED();
 
+	if (deferred_takeover) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++)
+			con2fb_map_boot[i] = idx;
+		fbcon_map_override();
+		return;
+	}
+
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		set_con2fb_map(i, idx, 0);
 
@@ -3185,6 +3207,11 @@ static int fbcon_fb_registered(struct fb_info *info)
 	idx = info->node;
 	fbcon_select_primary(info);
 
+	if (deferred_takeover) {
+		pr_info("fbcon: Deferring console take-over\n");
+		return 0;
+	}
+
 	if (info_idx == -1) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			if (con2fb_map_boot[i] == idx) {
@@ -3559,8 +3586,46 @@ static int fbcon_init_device(void)
 	return 0;
 }
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+static struct notifier_block fbcon_output_nb;
+
+static int fbcon_output_notifier(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	int i;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	pr_info("fbcon: Taking over console\n");
+
+	dummycon_unregister_output_notifier(&fbcon_output_nb);
+	deferred_takeover = false;
+	logo_shown = FBCON_LOGO_DONTSHOW;
+
+	for (i = 0; i < FB_MAX; i++) {
+		if (registered_fb[i])
+			fbcon_fb_registered(registered_fb[i]);
+	}
+
+	return NOTIFY_OK;
+}
+
+static void fbcon_register_output_notifier(void)
+{
+	fbcon_output_nb.notifier_call = fbcon_output_notifier;
+	dummycon_register_output_notifier(&fbcon_output_nb);
+}
+#else
+static inline void fbcon_register_output_notifier(void) {}
+#endif
+
 static void fbcon_start(void)
 {
+	if (deferred_takeover) {
+		fbcon_register_output_notifier();
+		return;
+	}
+
 	if (num_registered_fb) {
 		int i;
 
@@ -3587,6 +3652,13 @@ static void fbcon_exit(void)
 	if (fbcon_has_exited)
 		return;
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+	if (deferred_takeover) {
+		dummycon_unregister_output_notifier(&fbcon_output_nb);
+		deferred_takeover = false;
+	}
+#endif
+
 	kfree((void *)softback_buf);
 	softback_buf = 0UL;
 
diff --git a/include/linux/console.h b/include/linux/console.h
index dfd6b0e97855..f59f3dbca65c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -21,6 +21,7 @@ struct console_font_op;
 struct console_font;
 struct module;
 struct tty_struct;
+struct notifier_block;
 
 /*
  * this is what the terminal answers to a ESC-Z or csi0c query.
@@ -220,4 +221,8 @@ static inline bool vgacon_text_force(void) { return false; }
 
 extern void console_init(void);
 
+/* For deferred console takeover */
+void dummycon_register_output_notifier(struct notifier_block *nb);
+void dummycon_unregister_output_notifier(struct notifier_block *nb);
+
 #endif /* _LINUX_CONSOLE_H */
-- 
2.17.1

