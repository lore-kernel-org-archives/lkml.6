Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wkh8AyRHGVuLOwAAmS7hNA
	; Thu, 07 Jun 2018 14:54:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0223608BA; Thu,  7 Jun 2018 14:54:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 80AF4601C3;
	Thu,  7 Jun 2018 14:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80AF4601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935375AbeFGOyY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:54:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40989 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935200AbeFGOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:20 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbh-0005hJ-75; Thu, 07 Jun 2018 15:09:41 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002zO-Rj; Thu, 07 Jun 2018 15:09:03 +0100
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
Message-ID: <lsq.1528380321.766409795@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 199/410] pipe: relocate round_pipe_size() above
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

commit f491bd71118beba608d39ac2d5f1530e1160cd2e upstream.

Patch series "pipe: fix limit handling", v2.

When changing a pipe's capacity with fcntl(F_SETPIPE_SZ), various limits
defined by /proc/sys/fs/pipe-* files are checked to see if unprivileged
users are exceeding limits on memory consumption.

While documenting and testing the operation of these limits I noticed
that, as currently implemented, these checks have a number of problems:

(1) When increasing the pipe capacity, the checks against the limits
    in /proc/sys/fs/pipe-user-pages-{soft,hard} are made against
    existing consumption, and exclude the memory required for the
    increased pipe capacity. The new increase in pipe capacity can then
    push the total memory used by the user for pipes (possibly far) over
    a limit. This can also trigger the problem described next.

(2) The limit checks are performed even when the new pipe capacity
    is less than the existing pipe capacity. This can lead to problems
    if a user sets a large pipe capacity, and then the limits are
    lowered, with the result that the user will no longer be able to
    decrease the pipe capacity.

(3) As currently implemented, accounting and checking against the
    limits is done as follows:

    (a) Test whether the user has exceeded the limit.
    (b) Make new pipe buffer allocation.
    (c) Account new allocation against the limits.

    This is racey. Multiple processes may pass point (a) simultaneously,
    and then allocate pipe buffers that are accounted for only in step
    (c).  The race means that the user's pipe buffer allocation could be
    pushed over the limit (by an arbitrary amount, depending on how
    unlucky we were in the race). [Thanks to Vegard Nossum for spotting
    this point, which I had missed.]

This patch series addresses these three problems.

This patch (of 8):

This is a minor preparatory patch.  After subsequent patches,
round_pipe_size() will be called from pipe_set_size(), so place
round_pipe_size() above pipe_set_size().

Link: http://lkml.kernel.org/r/91a91fdb-a959-ba7f-b551-b62477cc98a1@gmail.com
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
 fs/pipe.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -994,6 +994,18 @@ const struct file_operations pipefifo_fo
 };
 
 /*
+ * Currently we rely on the pipe array holding a power-of-2 number
+ * of pages.
+ */
+static inline unsigned int round_pipe_size(unsigned int size)
+{
+	unsigned long nr_pages;
+
+	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	return roundup_pow_of_two(nr_pages) << PAGE_SHIFT;
+}
+
+/*
  * Allocate a new array of pipe buffers and copy the info over. Returns the
  * pipe size if successful, or return -ERROR on error.
  */
@@ -1044,18 +1056,6 @@ static long pipe_set_size(struct pipe_in
 }
 
 /*
- * Currently we rely on the pipe array holding a power-of-2 number
- * of pages.
- */
-static inline unsigned int round_pipe_size(unsigned int size)
-{
-	unsigned long nr_pages;
-
-	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	return roundup_pow_of_two(nr_pages) << PAGE_SHIFT;
-}
-
-/*
  * This should work even if CONFIG_PROC_FS isn't set, as proc_dointvec_minmax
  * will return an error.
  */
