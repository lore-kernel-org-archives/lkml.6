Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pwNeGRRHGVtJOwAAmS7hNA
	; Thu, 07 Jun 2018 14:54:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54455608BA; Thu,  7 Jun 2018 14:54:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A3471606DD;
	Thu,  7 Jun 2018 14:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3471606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935345AbeFGOyJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:54:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40978 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935307AbeFGOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:05 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005dI-H8; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002zY-Ux; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@fb.com>,
        "" <socketpair@gmail.com>, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Willy Tarreau" <w@1wt.eu>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.820524984@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 201/410] pipe: refactor argument for account_pipe_buffers()
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

commit 3734a13b96ebf039b293d8d37a934fd1bd9e03ab upstream.

This is a preparatory patch for following work. account_pipe_buffers()
performs accounting in the 'user_struct'. There is no need to pass a
pointer to a 'pipe_inode_info' struct (which is then dereferenced to
obtain a pointer to the 'user' field). Instead, pass a pointer directly
to the 'user_struct'. This change is needed in preparation for a
subsequent patch that the fixes the limit checking in alloc_pipe_info()
(and the resulting code is a little more logical).

Link: http://lkml.kernel.org/r/7277bf8c-a6fc-4a7d-659c-f5b145c981ab@gmail.com
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
 fs/pipe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -590,10 +590,10 @@ pipe_fasync(int fd, struct file *filp, i
 	return retval;
 }
 
-static void account_pipe_buffers(struct pipe_inode_info *pipe,
+static void account_pipe_buffers(struct user_struct *user,
                                  unsigned long old, unsigned long new)
 {
-	atomic_long_add(new - old, &pipe->user->pipe_bufs);
+	atomic_long_add(new - old, &user->pipe_bufs);
 }
 
 static bool too_many_pipe_buffers_soft(struct user_struct *user)
@@ -628,7 +628,7 @@ struct pipe_inode_info *alloc_pipe_info(
 			pipe->r_counter = pipe->w_counter = 1;
 			pipe->buffers = pipe_bufs;
 			pipe->user = user;
-			account_pipe_buffers(pipe, 0, pipe_bufs);
+			account_pipe_buffers(user, 0, pipe_bufs);
 			mutex_init(&pipe->mutex);
 			return pipe;
 		}
@@ -643,7 +643,7 @@ void free_pipe_info(struct pipe_inode_in
 {
 	int i;
 
-	account_pipe_buffers(pipe, pipe->buffers, 0);
+	account_pipe_buffers(pipe->user, pipe->buffers, 0);
 	free_uid(pipe->user);
 	for (i = 0; i < pipe->buffers; i++) {
 		struct pipe_buffer *buf = pipe->bufs + i;
@@ -1062,7 +1062,7 @@ static long pipe_set_size(struct pipe_in
 			memcpy(bufs + head, pipe->bufs, tail * sizeof(struct pipe_buffer));
 	}
 
-	account_pipe_buffers(pipe, pipe->buffers, nr_pages);
+	account_pipe_buffers(pipe->user, pipe->buffers, nr_pages);
 	pipe->curbuf = 0;
 	kfree(pipe->bufs);
 	pipe->bufs = bufs;
