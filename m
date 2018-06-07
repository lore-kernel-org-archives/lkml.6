Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R25wDdJGGVuqOQAAmS7hNA
	; Thu, 07 Jun 2018 14:53:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AED2E608BF; Thu,  7 Jun 2018 14:53:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F22F7601C3;
	Thu,  7 Jun 2018 14:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F22F7601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934975AbeFGOxm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:53:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40956 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935286AbeFGOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:53:39 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zj-Ey; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-0002zn-3Z; Thu, 07 Jun 2018 15:09:04 +0100
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
Message-ID: <lsq.1528380321.491965928@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 204/410] pipe: fix limit checking in alloc_pipe_info()
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

commit a005ca0e6813e1d796a7422a7e31d8b8d6555df1 upstream.

The limit checking in alloc_pipe_info() (used by pipe(2) and when
opening a FIFO) has the following problems:

(1) When checking capacity required for the new pipe, the checks against
    the limit in /proc/sys/fs/pipe-user-pages-{soft,hard} are made
    against existing consumption, and exclude the memory required for
    the new pipe capacity. As a consequence: (1) the memory allocation
    throttling provided by the soft limit does not kick in quite as
    early as it should, and (2) the user can overrun the hard limit.

(2) As currently implemented, accounting and checking against the limits
    is done as follows:

    (a) Test whether the user has exceeded the limit.
    (b) Make new pipe buffer allocation.
    (c) Account new allocation against the limits.

    This is racey. Multiple processes may pass point (a) simultaneously,
    and then allocate pipe buffers that are accounted for only in step
    (c).  The race means that the user's pipe buffer allocation could be
    pushed over the limit (by an arbitrary amount, depending on how
    unlucky we were in the race). [Thanks to Vegard Nossum for spotting
    this point, which I had missed.]

This patch addresses the above problems as follows:

* Alter the checks against limits to include the memory required for the
  new pipe.
* Re-order the accounting step so that it precedes the buffer allocation.
  If the accounting step determines that a limit has been reached, revert
  the accounting and cause the operation to fail.

Link: http://lkml.kernel.org/r/8ff3e9f9-23f6-510c-644f-8e70cd1c0bd9@gmail.com
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: <socketpair@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Don't use GFP_KERNEL_ACCOUNT]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -618,24 +618,30 @@ struct pipe_inode_info *alloc_pipe_info(
 	if (pipe == NULL)
 		goto out_free_uid;
 
-	if (!too_many_pipe_buffers_hard(user)) {
-		if (too_many_pipe_buffers_soft(user))
-			pipe_bufs = 1;
-		pipe->bufs = kcalloc(pipe_bufs,
-				     sizeof(struct pipe_buffer),
-				     GFP_KERNEL);
+	account_pipe_buffers(user, 0, pipe_bufs);
+
+	if (too_many_pipe_buffers_soft(user)) {
+		account_pipe_buffers(user, pipe_bufs, 1);
+		pipe_bufs = 1;
 	}
 
+	if (too_many_pipe_buffers_hard(user))
+		goto out_revert_acct;
+
+	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
+			     GFP_KERNEL);
+
 	if (pipe->bufs) {
 		init_waitqueue_head(&pipe->wait);
 		pipe->r_counter = pipe->w_counter = 1;
 		pipe->buffers = pipe_bufs;
 		pipe->user = user;
-		account_pipe_buffers(user, 0, pipe_bufs);
 		mutex_init(&pipe->mutex);
 		return pipe;
 	}
 
+out_revert_acct:
+	account_pipe_buffers(user, pipe_bufs, 0);
 	kfree(pipe);
 out_free_uid:
 	free_uid(user);
