Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B29C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF8A218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfBGTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:10:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfBGTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:10:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB5252551;
        Thu,  7 Feb 2019 19:10:23 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9488961146;
        Thu,  7 Feb 2019 19:10:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 21/22] locking/rwsem: Wake up all readers in wait queue
Date:   Thu,  7 Feb 2019 14:07:25 -0500
Message-Id: <1549566446-27967-22-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Feb 2019 19:10:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the front of the wait queue is a reader, other readers
immediately following the first reader will also be woken up at the
same time. However, if there is a writer in between. Those readers
behind the writer will not be woken up.

Because of optimistic spinning, the lock acquisition order is not FIFO
anyway. The lock handoff mechanism will ensure that lock starvation
will not happen.

Assuming that the lock hold times of the other readers still in the
queue will be about the same as the readers that are being woken up,
there is really not much additional cost other than the additional
latency due to the wakeup of additional tasks by the waker. Therefore
all the readers in the queue are woken up when the first waiter is a
reader to improve reader throughput.

With a locking microbenchmark running on 5.0 based kernel, the total
locking rates (in kops/s) of the benchmark on a 4-socket 56-core x86-64
system with equal numbers of readers and writers before all the reader
spining patches, before this patch and after this patch were as follows:

   # of Threads  Pre-rspin    Pre-Patch   Post-patch
   ------------  ---------    ---------   ----------
        2          1,926        8,057       7,397
        4          1,391        7,680       6,161
        8            716        7,284       6,405
       16            618        6,542       6,768
       32            501        1,449       6,550
       64             61          480       5,548
      112             75          769       5,216

At low contention level, there is a slight drop in performance. At high
contention level, however, this patch gives a big performance boost.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3beb942..3cf2e84 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -180,16 +180,16 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * Grant an infinite number of read locks to the readers at the front
-	 * of the queue. We know that woken will be at least 1 as we accounted
-	 * for above. Note we increment the 'active part' of the count by the
+	 * Grant an infinite number of read locks to all the readers in the
+	 * queue. We know that woken will be at least 1 as we accounted for
+	 * above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
 	 */
 	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
 		struct task_struct *tsk;
 
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
-			break;
+			continue;
 
 		woken++;
 		tsk = waiter->task;
-- 
1.8.3.1

