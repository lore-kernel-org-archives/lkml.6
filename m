Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5461C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D28D20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D28D20C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbeGKTXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKTXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:23:41 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B2A2064D;
        Wed, 11 Jul 2018 19:17:57 +0000 (UTC)
Date:   Wed, 11 Jul 2018 15:17:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
Message-ID: <20180711151755.613eba3c@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

There's been discussion on the fb list about the addition of
WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
the fb module is loaded with lockless_register_fb the console lock is
not taken for debugging reasons. With the addition of
WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
fill up with warnings when trying to debug the fb driver.

There's also a #if 1 that enables the warning which was added before
git history, and we look down on constant #if's in the kernel nowadays
anyway.

Remove the #if 1 and add a ignore_console_lock_warning boolean that can
be set by drivers to ignore the warning in order to do debugging.

Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/include/linux/console.h b/include/linux/console.h
index dfd6b0e97855..9d4a6b985154 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -200,11 +200,9 @@ void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
 
 /* Some debug stub to catch some of the obvious races in the VT code */
-#if 1
-#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
-#else
-#define WARN_CONSOLE_UNLOCKED()
-#endif
+extern bool ignore_console_lock_warning;
+#define WARN_CONSOLE_UNLOCKED()						\
+	WARN_ON(!ignore_console_lock_warning && !is_console_locked() && !oops_in_progress)
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..d9056efc3739 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -66,6 +66,9 @@ int console_printk[4] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 
+bool ignore_console_lock_warning __read_mostly;
+EXPORT_SYMBOL(ignore_console_lock_warning);
+
 /*
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
