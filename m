Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GYU6M89BGVuddAAAmS7hNA
	; Thu, 07 Jun 2018 14:33:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EDA07608C1; Thu,  7 Jun 2018 14:33:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 42540602FC;
	Thu,  7 Jun 2018 14:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42540602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbeFGOdk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:33:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40321 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933910AbeFGOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:33:35 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbh-0005hL-79; Thu, 07 Jun 2018 15:09:41 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002zT-TJ; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "" <socketpair@gmail.com>, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Willy Tarreau" <w@1wt.eu>, "Jens Axboe" <axboe@fb.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.162590349@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 200/410] pipe: move limit checking logic into
 pipe_set_size()
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

commit d37d41666408102bf0ac8e48d8efdce7b809e5f6 upstream.

This is a preparatory patch for following work. Move the F_SETPIPE_SZ
limit-checking logic from pipe_fcntl() into pipe_set_size().  This
simplifies the code a little, and allows for reworking required in
a later patch that fixes the limit checking in pipe_set_size()

Link: http://lkml.kernel.org/r/3701b2c5-2c52-2c3e-226d-29b9deb29b50@gmail.com
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
 fs/pipe.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1009,9 +1009,24 @@ static inline unsigned int round_pipe_si
  * Allocate a new array of pipe buffers and copy the info over. Returns the
  * pipe size if successful, or return -ERROR on error.
  */
-static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long nr_pages)
+static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 {
 	struct pipe_buffer *bufs;
+	unsigned int size, nr_pages;
+
+	size = round_pipe_size(arg);
+	nr_pages = size >> PAGE_SHIFT;
+
+	if (!nr_pages)
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_RESOURCE) && size > pipe_max_size)
+		return -EPERM;
+
+	if ((too_many_pipe_buffers_hard(pipe->user) ||
+			too_many_pipe_buffers_soft(pipe->user)) &&
+			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 
 	/*
 	 * We can shrink the pipe, if arg >= pipe->nrbufs. Since we don't
@@ -1094,28 +1109,9 @@ long pipe_fcntl(struct file *file, unsig
 	__pipe_lock(pipe);
 
 	switch (cmd) {
-	case F_SETPIPE_SZ: {
-		unsigned int size, nr_pages;
-
-		size = round_pipe_size(arg);
-		nr_pages = size >> PAGE_SHIFT;
-
-		ret = -EINVAL;
-		if (!nr_pages)
-			goto out;
-
-		if (!capable(CAP_SYS_RESOURCE) && size > pipe_max_size) {
-			ret = -EPERM;
-			goto out;
-		} else if ((too_many_pipe_buffers_hard(pipe->user) ||
-			    too_many_pipe_buffers_soft(pipe->user)) &&
-		           !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
-			ret = -EPERM;
-			goto out;
-		}
-		ret = pipe_set_size(pipe, nr_pages);
+	case F_SETPIPE_SZ:
+		ret = pipe_set_size(pipe, arg);
 		break;
-		}
 	case F_GETPIPE_SZ:
 		ret = pipe->buffers * PAGE_SIZE;
 		break;
@@ -1124,7 +1120,6 @@ long pipe_fcntl(struct file *file, unsig
 		break;
 	}
 
-out:
 	__pipe_unlock(pipe);
 	return ret;
 }
