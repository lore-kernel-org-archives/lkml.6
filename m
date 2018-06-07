Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2t9EOeNBGVsfdwAAmS7hNA
	; Thu, 07 Jun 2018 14:32:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C72E0608BA; Thu,  7 Jun 2018 14:32:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D0AB607DC;
	Thu,  7 Jun 2018 14:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D0AB607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933848AbeFGOcR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:32:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40273 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932911AbeFGOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:32:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zp-G9; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-0002zh-23; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "" <socketpair@gmail.com>, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Willy Tarreau" <w@1wt.eu>, "Jens Axboe" <axboe@fb.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.608368031@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 203/410] pipe: simplify logic in alloc_pipe_info()
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

commit 09b4d1990094dd22c27fb0163534db419458569c upstream.

Replace an 'if' block that covers most of the code in this function
with a 'goto'. This makes the code a little simpler to read, and also
simplifies the next patch (fix limit checking in alloc_pipe_info())

Link: http://lkml.kernel.org/r/aef030c1-0257-98a9-4988-186efa48530c@gmail.com
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: <socketpair@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Don't use GFP_KERNEL_ACCOUNT
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -611,31 +611,34 @@ static bool too_many_pipe_buffers_hard(s
 struct pipe_inode_info *alloc_pipe_info(void)
 {
 	struct pipe_inode_info *pipe;
+	unsigned long pipe_bufs = PIPE_DEF_BUFFERS;
+	struct user_struct *user = get_current_user();
 
 	pipe = kzalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
-	if (pipe) {
-		unsigned long pipe_bufs = PIPE_DEF_BUFFERS;
-		struct user_struct *user = get_current_user();
+	if (pipe == NULL)
+		goto out_free_uid;
 
-		if (!too_many_pipe_buffers_hard(user)) {
-			if (too_many_pipe_buffers_soft(user))
-				pipe_bufs = 1;
-			pipe->bufs = kzalloc(sizeof(struct pipe_buffer) * pipe_bufs, GFP_KERNEL);
-		}
+	if (!too_many_pipe_buffers_hard(user)) {
+		if (too_many_pipe_buffers_soft(user))
+			pipe_bufs = 1;
+		pipe->bufs = kcalloc(pipe_bufs,
+				     sizeof(struct pipe_buffer),
+				     GFP_KERNEL);
+	}
 
-		if (pipe->bufs) {
-			init_waitqueue_head(&pipe->wait);
-			pipe->r_counter = pipe->w_counter = 1;
-			pipe->buffers = pipe_bufs;
-			pipe->user = user;
-			account_pipe_buffers(user, 0, pipe_bufs);
-			mutex_init(&pipe->mutex);
-			return pipe;
-		}
-		free_uid(user);
-		kfree(pipe);
+	if (pipe->bufs) {
+		init_waitqueue_head(&pipe->wait);
+		pipe->r_counter = pipe->w_counter = 1;
+		pipe->buffers = pipe_bufs;
+		pipe->user = user;
+		account_pipe_buffers(user, 0, pipe_bufs);
+		mutex_init(&pipe->mutex);
+		return pipe;
 	}
 
+	kfree(pipe);
+out_free_uid:
+	free_uid(user);
 	return NULL;
 }
 
