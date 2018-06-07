Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J4R+NYFDGVtwCAAAmS7hNA
	; Thu, 07 Jun 2018 14:38:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA7FE607E7; Thu,  7 Jun 2018 14:38:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4314B601C3;
	Thu,  7 Jun 2018 14:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4314B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeFGOi4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:38:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40486 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933655AbeFGOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:38:54 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005a0-Cq; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031a-F4; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>, "Willy Tarreau" <w@1wt.eu>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Kees Cook" <keescook@chromium.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.251987497@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 212/410] pipe: actually allow root to exceed the pipe
 buffer limits
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

commit 85c2dd5473b2718b4b63e74bfeb1ca876868e11f upstream.

pipe-user-pages-hard and pipe-user-pages-soft are only supposed to apply
to unprivileged users, as documented in both Documentation/sysctl/fs.txt
and the pipe(7) man page.

However, the capabilities are actually only checked when increasing a
pipe's size using F_SETPIPE_SZ, not when creating a new pipe.  Therefore,
if pipe-user-pages-hard has been set, the root user can run into it and be
unable to create pipes.  Similarly, if pipe-user-pages-soft has been set,
the root user can run into it and have their pipes limited to 1 page each.

Fix this by allowing the privileged override in both cases.

Link: http://lkml.kernel.org/r/20180111052902.14409-4-ebiggers3@gmail.com
Fixes: 759c01142a5d ("pipe: limit the per-user amount of pages allocated in pipes")
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -601,6 +601,11 @@ static bool too_many_pipe_buffers_hard(u
 	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
 }
 
+static bool is_unprivileged_user(void)
+{
+	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+}
+
 struct pipe_inode_info *alloc_pipe_info(void)
 {
 	struct pipe_inode_info *pipe;
@@ -617,12 +622,12 @@ struct pipe_inode_info *alloc_pipe_info(
 
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
-	if (too_many_pipe_buffers_soft(user_bufs)) {
+	if (too_many_pipe_buffers_soft(user_bufs) && is_unprivileged_user()) {
 		user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
 		pipe_bufs = 1;
 	}
 
-	if (too_many_pipe_buffers_hard(user_bufs))
+	if (too_many_pipe_buffers_hard(user_bufs) && is_unprivileged_user())
 		goto out_revert_acct;
 
 	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
@@ -1053,7 +1058,7 @@ static long pipe_set_size(struct pipe_in
 	if (nr_pages > pipe->buffers &&
 			(too_many_pipe_buffers_hard(user_bufs) ||
 			 too_many_pipe_buffers_soft(user_bufs)) &&
-			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
+			is_unprivileged_user()) {
 		ret = -EPERM;
 		goto out_revert_acct;
 	}
