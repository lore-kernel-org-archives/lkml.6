Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A6EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9318220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeKFSzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:55:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:59180 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbeKFSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:55:23 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxhN-0002wF-8r; Tue, 06 Nov 2018 12:31:01 +0300
Subject: [PATCH 6/6] fuse: Verify userspace asks to requeue interrupt that
 we really sent
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:31:01 +0300
Message-ID: <154149666097.17764.12092615786683141764.stgit@localhost.localdomain>
In-Reply-To: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When queue_interrupt() is called from fuse_dev_do_write(),
it came from userspace directly. Userspace may pass any
request id, even the request's we have not interrupted
(or even background's request). This patch adds sanity
check to make kernel safe against that.

The problem is real interrupt may be queued and requeued
by two tasks on two cpus. This case, the requeuer has not
guarantees it sees FR_INTERRUPTED bit on its cpu (since
we know nothing about the way userspace manages requests
between its threads and whether it uses smp barriers).

To eliminate this problem, queuer writes FR_INTERRUPTED
bit again under fiq->waitq.lock, and this guarantees
requeuer will see the bit, when checks it.

I try to introduce solution, which does not affect on
performance, and which does not force to take more
locks. This is the reason, the below solution is worse:

   request_wait_answer()
   {
     ...
  +  spin_lock(&fiq->waitq.lock);
     set_bit(FR_INTERRUPTED, &req->flags);
  +  spin_unlock(&fiq->waitq.lock);
     ...
   }

Also, it does not look a better idea to extend fuse_dev_do_read()
with the fix, since it's already a big function:

   fuse_dev_do_read()
   {
     ...
     if (test_bit(FR_INTERRUPTED, &req->flags)) {
  +      /* Comment */
  +      barrier();
  +      set_bit(FR_INTERRUPTED, &req->flags);
         queue_interrupt(fiq, req);
     }
     ...
   }

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 315d395d5c02..3bfc5ed61c9a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -475,13 +475,27 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 	fuse_put_request(fc, req);
 }
 
-static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
+static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	bool kill = false;
 
 	if (test_bit(FR_FINISHED, &req->flags))
-		return;
+		return 0;
 	spin_lock(&fiq->waitq.lock);
+	/* Check for we've sent request to interrupt this req */
+	if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags))) {
+		spin_unlock(&fiq->waitq.lock);
+		return -EINVAL;
+	}
+	/*
+	 * Interrupt may be queued from fuse_dev_do_read(), and
+	 * later requeued on other cpu by fuse_dev_do_write().
+	 * To make FR_INTERRUPTED bit visible for the requeuer
+	 * (under fiq->waitq.lock) we write it once again.
+	 */
+	barrier();
+	__set_bit(FR_INTERRUPTED, &req->flags);
+
 	if (list_empty(&req->intr_entry)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
@@ -492,7 +506,7 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 		if (test_bit(FR_FINISHED, &req->flags)) {
 			list_del_init(&req->intr_entry);
 			spin_unlock(&fiq->waitq.lock);
-			return;
+			return 0;
 		}
 		wake_up_locked(&fiq->waitq);
 		kill = true;
@@ -500,6 +514,7 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 	spin_unlock(&fiq->waitq.lock);
 	if (kill)
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+	return (int)kill;
 }
 
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
@@ -1959,8 +1974,9 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 			nbytes = -EINVAL;
 		else if (oh.error == -ENOSYS)
 			fc->no_interrupt = 1;
-		else if (oh.error == -EAGAIN)
-			queue_interrupt(&fc->iq, req);
+		else if (oh.error == -EAGAIN &&
+			 queue_interrupt(&fc->iq, req) < 0)
+			nbytes = -EINVAL;
 
 		fuse_put_request(fc, req);
 		fuse_copy_finish(cs);

