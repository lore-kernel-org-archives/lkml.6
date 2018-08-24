Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBFC2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBFC2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yhbt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHYCgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:36:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54246 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeHYCgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:36:52 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 22:36:51 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AB81A1F404;
        Fri, 24 Aug 2018 22:54:31 +0000 (UTC)
Date:   Fri, 24 Aug 2018 22:54:31 +0000
From:   Eric Wong <normalperson@yhbt.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] pipe: prevent compiler reordering in pipe_poll
Message-ID: <20180824225431.tpaxuck7idgnj3b7@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pipe_poll function does not use locks, and adding an entry
to the waitqueue is not guaranteed to happen before pipe->nrbufs
(or other fields) are read, leading to missed wakeups.

Looking at Ruby CI build logs and backtraces, I've noticed
occasional instances where processes are stuck in select(2) or
ppoll(2) with a pipe.

I don't have access to the systems where this is happening to
test/reproduce the problem, and haven't been able to reproduce
it locally on less-powerful hardware, either.  However, it seems
like a problem based on similar comments in
fs/eventfd.c::eventfd_poll made by Paolo.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 fs/pipe.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 39d6f431da83..1a904d941cf1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -509,7 +509,7 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
-/* No kernel lock held - fine */
+/* No kernel lock held - fine, but a compiler barrier is required */
 static __poll_t
 pipe_poll(struct file *filp, poll_table *wait)
 {
@@ -519,7 +519,35 @@ pipe_poll(struct file *filp, poll_table *wait)
 
 	poll_wait(filp, &pipe->wait, wait);
 
-	/* Reading only -- no need for acquiring the semaphore.  */
+	/*
+	 * Reading only -- no need for acquiring the semaphore, but
+	 * we need a compiler barrier to ensure the compiler does
+	 * not reorder reads to pipe->nrbufs, pipe->writers,
+	 * pipe->readers, filp->f_version, pipe->w_counter, and
+	 * pipe->buffers before poll_wait to avoid missing wakeups
+	 * from compiler reordering.  In other words, we need to
+	 * prevent the following situation:
+	 *
+	 * pipe_poll                          pipe_write
+	 * -----------------                  ------------
+	 * nrbufs = pipe->nrbufs (INVALID!)
+	 *
+	 *                                    __pipe_lock
+	 *                                    pipe->nrbufs = ++bufs;
+	 *                                    __pipe_unlock
+	 *                                    wake_up_interruptible_sync_poll
+	 *                                      pipe->wait is empty, no wakeup
+	 *
+	 * lock pipe->wait.lock (in poll_wait)
+	 * __add_wait_queue
+	 * unlock pipe->wait.lock
+	 *
+	 *  // pipe->nrbufs should be read here, NOT above
+	 *
+	 * pipe_poll returns 0 (WRONG)
+	 */
+	barrier();
+
 	nrbufs = pipe->nrbufs;
 	mask = 0;
 	if (filp->f_mode & FMODE_READ) {
-- 
EW
