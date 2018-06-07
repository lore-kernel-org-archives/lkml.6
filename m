Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FdtaArZFGVsOJQAAmS7hNA
	; Thu, 07 Jun 2018 14:48:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B4C6608C8; Thu,  7 Jun 2018 14:48:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69D21601C3;
	Thu,  7 Jun 2018 14:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69D21601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935113AbeFGOse (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:48:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40844 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934471AbeFGOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:48:32 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zw-Eq; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031P-DO; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Eric Biggers" <ebiggers@google.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Willy Tarreau" <w@1wt.eu>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Kees Cook" <keescook@chromium.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.744262895@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 210/410] pipe, sysctl: drop 'min' parameter from
 pipe-max-size converter
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

commit 4c2e4befb3cc9ce42d506aa537c9ab504723e98c upstream.

Patch series "pipe: buffer limits fixes and cleanups", v2.

This series simplifies the sysctl handler for pipe-max-size and fixes
another set of bugs related to the pipe buffer limits:

- The root user wasn't allowed to exceed the limits when creating new
  pipes.

- There was an off-by-one error when checking the limits, so a limit of
  N was actually treated as N - 1.

- F_SETPIPE_SZ accepted values over UINT_MAX.

- Reading the pipe buffer limits could be racy.

This patch (of 7):

Before validating the given value against pipe_min_size,
do_proc_dopipe_max_size_conv() calls round_pipe_size(), which rounds the
value up to pipe_min_size.  Therefore, the second check against
pipe_min_size is redundant.  Remove it.

Link: http://lkml.kernel.org/r/20180111052902.14409-2-ebiggers3@gmail.com
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
 fs/pipe.c                 | 10 +++-------
 include/linux/pipe_fs_i.h |  2 +-
 kernel/sysctl.c           | 15 +--------------
 3 files changed, 5 insertions(+), 22 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -34,11 +34,6 @@
  */
 unsigned int pipe_max_size = 1048576;
 
-/*
- * Minimum pipe size, as required by POSIX
- */
-unsigned int pipe_min_size = PAGE_SIZE;
-
 /* Maximum allocatable pages per user. Hard limit is unset by default, soft
  * matches default values.
  */
@@ -1012,8 +1007,9 @@ unsigned int round_pipe_size(unsigned in
 {
 	unsigned long nr_pages;
 
-	if (size < pipe_min_size)
-		size = pipe_min_size;
+	/* Minimum pipe size, as required by POSIX */
+	if (size < PAGE_SIZE)
+		size = PAGE_SIZE;
 
 	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	if (nr_pages == 0)
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -124,7 +124,7 @@ void pipe_lock(struct pipe_inode_info *)
 void pipe_unlock(struct pipe_inode_info *);
 void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
 
-extern unsigned int pipe_max_size, pipe_min_size;
+extern unsigned int pipe_max_size;
 extern unsigned long pipe_user_pages_hard;
 extern unsigned long pipe_user_pages_soft;
 int pipe_proc_fn(struct ctl_table *, int, void __user *, size_t *, loff_t *);
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1672,7 +1672,6 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &pipe_proc_fn,
-		.extra1		= &pipe_min_size,
 	},
 	{
 		.procname	= "pipe-user-pages-hard",
@@ -2223,15 +2222,9 @@ int proc_dointvec_minmax(struct ctl_tabl
 				do_proc_dointvec_minmax_conv, &param);
 }
 
-struct do_proc_dopipe_max_size_conv_param {
-	unsigned int *min;
-};
-
 static int do_proc_dopipe_max_size_conv(bool *negp, unsigned long *lvalp,
 					int *valp, int write, void *data)
 {
-	struct do_proc_dopipe_max_size_conv_param *param = data;
-
 	if (write) {
 		unsigned int val;
 
@@ -2242,9 +2235,6 @@ static int do_proc_dopipe_max_size_conv(
 		if (*negp || val == 0)
 			return -EINVAL;
 
-		if (param->min && *param->min > val)
-			return -ERANGE;
-
 		*valp = val;
 	} else {
 		unsigned int val = *valp;
@@ -2258,11 +2248,8 @@ static int do_proc_dopipe_max_size_conv(
 int proc_dopipe_max_size(struct ctl_table *table, int write,
 			 void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dopipe_max_size_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-				do_proc_dopipe_max_size_conv, &param);
+				do_proc_dopipe_max_size_conv, NULL);
 }
 
 static void validate_coredump_safety(void)
