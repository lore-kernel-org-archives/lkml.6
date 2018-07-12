Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2596C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B92621479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeGLNjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeGLNjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:39:15 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD83213A2;
        Thu, 12 Jul 2018 13:29:40 +0000 (UTC)
Date:   Thu, 12 Jul 2018 09:29:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: [PATCH v2] console: Replace #if 1 with a bool to ignore
Message-ID: <20180712092938.22e33641@gandalf.local.home>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since V1:
 - Added comment to describe ignore_console_unlock_waring variable
 - Abide by 80 character limit

Index: linux-trace.git/include/linux/console.h
===================================================================
--- linux-trace.git.orig/include/linux/console.h
+++ linux-trace.git/include/linux/console.h
@@ -200,11 +200,14 @@ void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
 
 /* Some debug stub to catch some of the obvious races in the VT code */
-#if 1
-#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
-#else
-#define WARN_CONSOLE_UNLOCKED()
-#endif
+#define WARN_CONSOLE_UNLOCKED()						\
+	WARN_ON(!ignore_console_lock_warning &&				\
+		!is_console_locked() && !oops_in_progress)
+/*
+ * Set ignore_console_lock_warning to true if you need to quiet
+ * WARN_CONSOLE_UNLOCKED() for debugging purposes.
+ */
+extern bool ignore_console_lock_warning;
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0
Index: linux-trace.git/kernel/printk/printk.c
===================================================================
--- linux-trace.git.orig/kernel/printk/printk.c
+++ linux-trace.git/kernel/printk/printk.c
@@ -66,6 +66,9 @@ int console_printk[4] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 
+bool ignore_console_lock_warning __read_mostly;
+EXPORT_SYMBOL(ignore_console_lock_warning);
+
 /*
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
