Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F24C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8542184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeLRUki convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeLRUkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:40:37 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871A9217D9;
        Tue, 18 Dec 2018 20:40:36 +0000 (UTC)
Date:   Tue, 18 Dec 2018 15:40:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.14.87-rt49
Message-ID: <20181218154034.612d729d@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.14.87-rt49 stable release.

Sorry for taking so long, I've just been swamped (like everyone else)

*** PLEASE NOTE ***

This release is **NOT** just an update to the new stable 4.14.87 version
as there was a small RT specific change that has been made.

I had to make an update to handle a backport of adding
preempt_disable() around the console_unlock() code. That patch is below.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: c3fb62599cb0bf9ea0223433ccf7c0c37056c392


Or to build 4.14.87-rt49 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.87.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.87-rt49.patch.xz




Enjoy,

-- Steve


From 0ab3459b0a8b8d19054aa813611c8dc22ce04af8 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Fri, 14 Dec 2018 21:36:55 -0500
Subject: [PATCH] printk: Do not disable preemption when calling consoles in RT

console_unlock() may call consoles that call spin_lock(), where spin_lock is
a mutex in PREEMPT_RT. Although mainline may be worried about preempted
holders of the console lock from preventing printk() output, the RT kernel
does not.

Use migrate_disable() to disable preemption when !RT, but we really don't
care if the task stays on the CPU or not for RT. It just has to be able to
schedule.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8a7c4f79fca0..029ae3caa80e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1811,7 +1811,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * console_sem which would prevent anyone from printing to
 		 * console
 		 */
-		preempt_disable();
+		migrate_disable();
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore.  The release will print out buffers and wake up
@@ -1819,7 +1819,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (may_trylock && console_trylock())
 			console_unlock();
-		preempt_enable();
+		migrate_enable();
 	}
 
 	return printed_len;
-- 
2.19.2

