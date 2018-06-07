Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CoylIvo/GVu7XgAAmS7hNA
	; Thu, 07 Jun 2018 14:24:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 89BCB6089E; Thu,  7 Jun 2018 14:24:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 83CBB602FC;
	Thu,  7 Jun 2018 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83CBB602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933461AbeFGOYK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:24:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40121 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933118AbeFGOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:24:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zx-GQ; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031V-E8; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Willy Tarreau" <w@1wt.eu>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.821029542@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 211/410] pipe, sysctl: remove pipe_proc_fn()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 319e0a21bb7823abbb4818fe2724e572bbac77a2 upstream.

pipe_proc_fn() is no longer needed, as it only calls through to
proc_dopipe_max_size().  Just put proc_dopipe_max_size() in the ctl_table
entry directly, and remove the unneeded EXPORT_SYMBOL() and the ENOSYS
stub for it.

(The reason the ENOSYS stub isn't needed is that the pipe-max-size
ctl_table entry is located directly in 'kern_table' rather than being
registered separately.  Therefore, the entry is already only defined when
the kernel is built with sysctl support.)

Link: http://lkml.kernel.org/r/20180111052902.14409-3-ebiggers3@gmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c                 | 10 ----------
 include/linux/pipe_fs_i.h |  1 -
 include/linux/sysctl.h    |  3 ---
 kernel/sysctl.c           | 15 +++++----------
 4 files changed, 5 insertions(+), 24 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1108,16 +1108,6 @@ out_revert_acct:
 }
 
 /*
- * This should work even if CONFIG_PROC_FS isn't set, as proc_dopipe_max_size
- * will return an error.
- */
-int pipe_proc_fn(struct ctl_table *table, int write, void __user *buf,
-		 size_t *lenp, loff_t *ppos)
-{
-	return proc_dopipe_max_size(table, write, buf, lenp, ppos);
-}
-
-/*
  * After the inode slimming patch, i_pipe/i_bdev/i_cdev share the same
  * location, so checking ->i_pipe is not enough to verify that this is a
  * pipe.
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -127,7 +127,6 @@ void pipe_double_lock(struct pipe_inode_
 extern unsigned int pipe_max_size;
 extern unsigned long pipe_user_pages_hard;
 extern unsigned long pipe_user_pages_soft;
-int pipe_proc_fn(struct ctl_table *, int, void __user *, size_t *, loff_t *);
 
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -45,9 +45,6 @@ extern int proc_dointvec(struct ctl_tabl
 			 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(struct ctl_table *, int,
 				void __user *, size_t *, loff_t *);
-extern int proc_dopipe_max_size(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp,
-				loff_t *ppos);
 extern int proc_dointvec_jiffies(struct ctl_table *, int,
 				 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_userhz_jiffies(struct ctl_table *, int,
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -194,6 +194,8 @@ static int proc_dointvec_minmax_coredump
 static int proc_dostring_coredump(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
+static int proc_dopipe_max_size(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp, loff_t *ppos);
 
 #ifdef CONFIG_MAGIC_SYSRQ
 /* Note: sysrq code uses it's own private copy */
@@ -1671,7 +1673,7 @@ static struct ctl_table fs_table[] = {
 		.data		= &pipe_max_size,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &pipe_proc_fn,
+		.proc_handler	= proc_dopipe_max_size,
 	},
 	{
 		.procname	= "pipe-user-pages-hard",
@@ -2245,8 +2247,8 @@ static int do_proc_dopipe_max_size_conv(
 	return 0;
 }
 
-int proc_dopipe_max_size(struct ctl_table *table, int write,
-			 void __user *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dopipe_max_size(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dopipe_max_size_conv, NULL);
@@ -2767,12 +2769,6 @@ int proc_dointvec_minmax(struct ctl_tabl
 	return -ENOSYS;
 }
 
-int proc_dopipe_max_size(struct ctl_table *table, int write,
-			 void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
 int proc_dointvec_jiffies(struct ctl_table *table, int write,
 		    void __user *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -2814,7 +2810,6 @@ int proc_doulongvec_ms_jiffies_minmax(st
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
-EXPORT_SYMBOL_GPL(proc_dopipe_max_size);
 EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
 EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
