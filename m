Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588BE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="szx75H+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbfBNXCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:13 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:58307 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbfBNXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=B+TeXTbcKXvZaNlqgllPbxrxECf4TktQM+VsQA5WYFQ=; b=szx75H+y5nDZ
        t5nGzzySh63vsh4YA4fQM+hyXLhWv1/3/DUBgcxO0JlkwYQU/6oXjvz+l94P0G9pf/NVe4zrasC1J
        UKIu+1C5EO48osxReXNp14H4FdQ6sF9L9LOUJt+y/Edd9eD9iMgR0aMlsB0SUwV4tRUFLVs9cRh9O
        55YUlbM+snVzDj+DJXoYROHC8lakQWhGYbaLuitRvI3jYHosyoChgVtQgE/G5i3i55vv79E757u98
        lOT35DF0+WS3LY+PB7sOfKRENZY1uTn6Lq9goFZVvE3P7wIkTgmvS/fT1okzaNgfa3S3t01gq6zzv
        rTcC8b/CfKhyAnCE59H6lA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0y-000Dd6-DV; Fri, 15 Feb 2019 00:02:02 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id B06AEC0926;
        Fri, 15 Feb 2019 00:01:53 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep complaint
Date:   Thu, 14 Feb 2019 15:00:56 -0800
Message-Id: <20190214230058.196511-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00422841141753)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5p8v+3zqkhaMi8ngsSQ+32B602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvN1XkkTBjl6xLhE2
 waBs0vHa27H+zRiICSQ3iu6fWw0X4NUOoqFHu1fD/1ux7wM3tzn4L6l07gU++OnXgFglM7pqTmqL
 jAo5Or/bIrygaHQ++dEb/jgEkWvnZFudEwa4pFOJrBiVIHPl0XQoN5aAli20yV/QjwHmH8UC+yC/
 vwmxidMlhCno/QsYaTlhyywkGZ4nawu4ulq2ZmK4xUAR3klirMVwu3Cbbl6rvLHk2XKm4pWx7WxW
 FZpsjT/483ewgvhnwwZwEJwyH2QvC7vYR+p30iNiLbJ8vTCHK9XHqezA/antyE8Gv1K5ztex/LIz
 JKglPewYmTcP8SFfSvB3EkbMRHLjidWGpJsLrrmbTUJr7TSyeNA/yS8xgHEcaGZS+n3XbS9w/jau
 a3Px00DYFQpnebAhL4b3vEDYuzMxnlzD3O5rFrTtoBvIQZCYvrCGV09cw+faPHD2CrOPeAQYmFkL
 dbbTK8f9czpk/1ZCczxinzZp/QVtjWzjB7qSCxMRc2KjFrTpRoCwbQXFT47mXCA93SsS4aMXJmiJ
 2G0eb5ahm4/xbO0BNU/49GzldiYJv+7J//0XCxCMJn8bXo41UD14W2gtt5YENTsYc3vhFq+meSKH
 M1RRvDpjIckJhuhE3nSAXIjLTBmCg/KtjybnyCatI4g+l6rCWbY0MZcgnbHs8xDOkPwDS4Z3KU4m
 WTN1VjyOzZbKfVh1v52vI8Y0fFWmP+HwGna5rfPhaTQVpSY5inCzGv/fxfhA6I3CAYqbAGHnzDBM
 FmPjJ1DPY/keQcc0Htgoo6kaaWPi6/Vf0I3qyVYdd644JQJJpTi+AnDKMycHL8+lTGBIVE9xbEkX
 79udkh0poGZbapNfC0Az9h9Cbgup1eR5MU9scj47GZVYhq6iGuQ9GjcZWn4kxX+lvo8hu1/rdU1t
 /SWu+yxj6TsAPH2uUOgUFKU1iMBgweRQTBMHwK2H1yOCBViKqY6hZSFb9LP07/cT0H+qMDfu6LSv
 MDRcCgYQIezXimM8MMGBqYQ+5CAVDq0v/5qL81x/+yKU4ilSrdN/UN6xghGloet5c/DXtHJOj+Ir
 ynVpkScfoHYIOjZ2AKeGU0KQtec8p/BYbRmdfq3DsCghNgeCB1gPIwNrCEpiUN3JsQ46W1LA7Q==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid that running test nvme/012 from the blktests suite triggers the
following false positive lockdep complaint:

============================================
WARNING: possible recursive locking detected
5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
--------------------------------------------
ksoftirqd/1/16 is trying to acquire lock:
000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0

but task is already holding lock:
00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&fq->mq_flush_lock)->rlock);
  lock(&(&fq->mq_flush_lock)->rlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by ksoftirqd/1/16:
 #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0

stack backtrace:
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 dump_stack+0x67/0x90
 __lock_acquire.cold.45+0x2b4/0x313
 lock_acquire+0x98/0x160
 _raw_spin_lock_irqsave+0x3b/0x80
 flush_end_io+0x4e/0x1d0
 blk_mq_complete_request+0x76/0x110
 nvmet_req_complete+0x15/0x110 [nvmet]
 nvmet_bio_done+0x27/0x50 [nvmet]
 blk_update_request+0xd7/0x2d0
 blk_mq_end_request+0x1a/0x100
 blk_flush_complete_seq+0xe5/0x350
 flush_end_io+0x12f/0x1d0
 blk_done_softirq+0x9f/0xd0
 __do_softirq+0xca/0x440
 run_ksoftirqd+0x24/0x50
 smpboot_thread_fn+0x113/0x1e0
 kthread+0x121/0x140
 ret_from_fork+0x3a/0x50

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c | 5 ++++-
 block/blk.h       | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6e0f2d97fc6d..86c86c76c087 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -70,6 +70,7 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
+#include <linux/lockdep.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -472,7 +473,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 	if (!fq)
 		goto fail;
 
-	spin_lock_init(&fq->mq_flush_lock);
+	lockdep_register_key(&fq->key);
+	spin_lock_init_key(&fq->mq_flush_lock, &fq->key);
 
 	rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
 	fq->flush_rq = kzalloc_node(rq_sz, flags, node);
@@ -497,6 +499,7 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 	if (!fq)
 		return;
 
+	lockdep_unregister_key(&fq->key);
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
diff --git a/block/blk.h b/block/blk.h
index 848278c52030..10f5e19aa4a1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -28,6 +28,7 @@ struct blk_flush_queue {
 	 * at the same time
 	 */
 	struct request		*orig_rq;
+	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

