Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCEFC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFE920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFE920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKHSj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:59 -0500
Received: from relay.sw.ru ([185.231.240.75]:36776 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeKHSj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:58 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gKgFi-00062U-4w; Thu, 08 Nov 2018 12:05:26 +0300
Subject: [PATCH v2 2/5] fuse: Optimize request_end() by not taking
 fiq->waitq.lock
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Nov 2018 12:05:25 +0300
Message-ID: <154166792544.10655.2541613506844325108.stgit@localhost.localdomain>
In-Reply-To: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
References: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We take global fiq->waitq.lock every time, when we are
in this function, but interrupted requests are just small
subset of all requests. This patch optimizes request_end()
and makes it to take the lock when it's really needed.

queue_interrupt() needs small change for that. After req
is linked to interrupt list, we do smp_mb() and check
for FR_FINISHED again. In case of FR_FINISHED bit has
appeared, we remove req and leave the function:

CPU 0                                                CPU 1
queue_interrupt()                                    request_end()

  spin_lock(&fiq->waitq.lock)


  list_add_tail(&req->intr_entry, &fiq->interrupts)    test_and_set_bit(FR_FINISHED, &req->flags)
  smp_mb()                                             <memory barrier implied test_and_set_bit()>
  if (test_bit(FR_FINISHED, &req->flags))              if (!list_empty(&req->intr_entry))

    list_del_init(&req->intr_entry)                      spin_lock(&fiq->waitq.lock)
                                                         list_del_init(&req->intr_entry)

Check the change is visible in perf report:

1)Firstly mount fusexmp_fh:
  $fuse/example/.libs/fusexmp_fh mnt

2)Run test doing
    futimes(fd, tv1);
    futimes(fd, tv2);
  in many threads endlessly.

3)perf record -g (all the system load)

Without the patch in request_end() we spend 62.58% of do_write() time:
(= 12.58 / 20.10 * 100%)

   55,22% entry_SYSCALL_64
     20,10% do_writev
      ...
          18,08% fuse_dev_do_write
           12,58% request_end
            10,08% __wake_up_common_lock
            1,97% queued_spin_lock_slowpath
           1,31% fuse_copy_args
           1,04% fuse_copy_one
           0,85% queued_spin_lock_slowpath

With the patch, the perf report becomes better, and only 58.16%
of do_write() time we spend in request_end():

   54,15% entry_SYSCALL_64
     18,24% do_writev
      ...
          16,25% fuse_dev_do_write
           10,61% request_end
            10,25% __wake_up_common_lock
           1,34% fuse_copy_args
           1,06% fuse_copy_one
           0,88% queued_spin_lock_slowpath

v2: Remove unlocked test of FR_FINISHED from queue_interrupt()

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1ecec7fcb841..7374a23b1bc8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -427,10 +427,16 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
-
-	spin_lock(&fiq->waitq.lock);
-	list_del_init(&req->intr_entry);
-	spin_unlock(&fiq->waitq.lock);
+	/*
+	 * test_and_set_bit() implies smp_mb() between bit
+	 * changing and below intr_entry check. Pairs with
+	 * smp_mb() from queue_interrupt().
+	 */
+	if (!list_empty(&req->intr_entry)) {
+		spin_lock(&fiq->waitq.lock);
+		list_del_init(&req->intr_entry);
+		spin_unlock(&fiq->waitq.lock);
+	}
 	WARN_ON(test_bit(FR_PENDING, &req->flags));
 	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
@@ -469,12 +475,18 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->waitq.lock);
-	if (test_bit(FR_FINISHED, &req->flags)) {
-		spin_unlock(&fiq->waitq.lock);
-		return;
-	}
 	if (list_empty(&req->intr_entry)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
+		/*
+		 * Pairs with smp_mb() implied by test_and_set_bit()
+		 * from request_end().
+		 */
+		smp_mb();
+		if (test_bit(FR_FINISHED, &req->flags)) {
+			list_del_init(&req->intr_entry);
+			spin_unlock(&fiq->waitq.lock);
+			return;
+		}
 		wake_up_locked(&fiq->waitq);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 	}

