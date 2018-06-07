Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5OrLBJBEGVt9FAAAmS7hNA
	; Thu, 07 Jun 2018 14:43:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C7EA5608BA; Thu,  7 Jun 2018 14:43:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B783602FC;
	Thu,  7 Jun 2018 14:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B783602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934885AbeFGOnz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:43:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40696 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934145AbeFGOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:43:53 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zk-Ex; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-0002zs-50; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "" <socketpair@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>, "Willy Tarreau" <w@1wt.eu>,
        "Jens Axboe" <axboe@fb.com>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.469393976@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 205/410] pipe: make account_pipe_buffers() return a
 value, and use it
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

From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>

commit 9c87bcf0a31b338dc8a69a5d251a037565a94e13 upstream.

This is an optional patch, to provide a small performance
improvement.  Alter account_pipe_buffers() so that it returns the
new value in user->pipe_bufs. This means that we can refactor
too_many_pipe_buffers_soft() and too_many_pipe_buffers_hard() to
avoid the costs of repeated use of atomic_long_read() to get the
value user->pipe_bufs.

Link: http://lkml.kernel.org/r/93e5f193-1e5e-3e1f-3a20-eae79b7e1310@gmail.com
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: <socketpair@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -590,22 +590,20 @@ pipe_fasync(int fd, struct file *filp, i
 	return retval;
 }
 
-static void account_pipe_buffers(struct user_struct *user,
+static unsigned long account_pipe_buffers(struct user_struct *user,
                                  unsigned long old, unsigned long new)
 {
-	atomic_long_add(new - old, &user->pipe_bufs);
+	return atomic_long_add_return(new - old, &user->pipe_bufs);
 }
 
-static bool too_many_pipe_buffers_soft(struct user_struct *user)
+static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
-	return pipe_user_pages_soft &&
-	       atomic_long_read(&user->pipe_bufs) >= pipe_user_pages_soft;
+	return pipe_user_pages_soft && user_bufs >= pipe_user_pages_soft;
 }
 
-static bool too_many_pipe_buffers_hard(struct user_struct *user)
+static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
-	return pipe_user_pages_hard &&
-	       atomic_long_read(&user->pipe_bufs) >= pipe_user_pages_hard;
+	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
 }
 
 struct pipe_inode_info *alloc_pipe_info(void)
@@ -613,19 +611,20 @@ struct pipe_inode_info *alloc_pipe_info(
 	struct pipe_inode_info *pipe;
 	unsigned long pipe_bufs = PIPE_DEF_BUFFERS;
 	struct user_struct *user = get_current_user();
+	unsigned long user_bufs;
 
 	pipe = kzalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
 	if (pipe == NULL)
 		goto out_free_uid;
 
-	account_pipe_buffers(user, 0, pipe_bufs);
+	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
-	if (too_many_pipe_buffers_soft(user)) {
-		account_pipe_buffers(user, pipe_bufs, 1);
+	if (too_many_pipe_buffers_soft(user_bufs)) {
+		user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
 		pipe_bufs = 1;
 	}
 
-	if (too_many_pipe_buffers_hard(user))
+	if (too_many_pipe_buffers_hard(user_bufs))
 		goto out_revert_acct;
 
 	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
@@ -641,7 +640,7 @@ struct pipe_inode_info *alloc_pipe_info(
 	}
 
 out_revert_acct:
-	account_pipe_buffers(user, pipe_bufs, 0);
+	(void) account_pipe_buffers(user, pipe_bufs, 0);
 	kfree(pipe);
 out_free_uid:
 	free_uid(user);
@@ -652,7 +651,7 @@ void free_pipe_info(struct pipe_inode_in
 {
 	int i;
 
-	account_pipe_buffers(pipe->user, pipe->buffers, 0);
+	(void) account_pipe_buffers(pipe->user, pipe->buffers, 0);
 	free_uid(pipe->user);
 	for (i = 0; i < pipe->buffers; i++) {
 		struct pipe_buffer *buf = pipe->bufs + i;
@@ -1022,6 +1021,7 @@ static long pipe_set_size(struct pipe_in
 {
 	struct pipe_buffer *bufs;
 	unsigned int size, nr_pages;
+	unsigned long user_bufs;
 	long ret = 0;
 
 	size = round_pipe_size(arg);
@@ -1041,11 +1041,11 @@ static long pipe_set_size(struct pipe_in
 			size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
 		return -EPERM;
 
-	account_pipe_buffers(pipe->user, pipe->buffers, nr_pages);
+	user_bufs = account_pipe_buffers(pipe->user, pipe->buffers, nr_pages);
 
 	if (nr_pages > pipe->buffers &&
-			(too_many_pipe_buffers_hard(pipe->user) ||
-			 too_many_pipe_buffers_soft(pipe->user)) &&
+			(too_many_pipe_buffers_hard(user_bufs) ||
+			 too_many_pipe_buffers_soft(user_bufs)) &&
 			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
 		ret = -EPERM;
 		goto out_revert_acct;
@@ -1096,7 +1096,7 @@ static long pipe_set_size(struct pipe_in
 	return nr_pages * PAGE_SIZE;
 
 out_revert_acct:
-	account_pipe_buffers(pipe->user, nr_pages, pipe->buffers);
+	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->buffers);
 	return ret;
 }
 
