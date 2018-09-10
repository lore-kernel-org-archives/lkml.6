Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A3EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0D220865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0D220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeIJPDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:03:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:03:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAA2PQ1807387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:10:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAA1VO1807384;
        Mon, 10 Sep 2018 03:10:01 -0700
Date:   Mon, 10 Sep 2018 03:10:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-4b486b535c33ef354ecf02a2650919004fd7d2b0@git.kernel.org>
Cc:     will.deacon@arm.com, dbueso@suse.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, longman@redhat.com, jmario@redhat.com,
        peterz@infradead.org
Reply-To: jmario@redhat.com, peterz@infradead.org, longman@redhat.com,
          tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, dbueso@suse.de,
          torvalds@linux-foundation.org, will.deacon@arm.com
In-Reply-To: <1532459425-19204-1-git-send-email-longman@redhat.com>
References: <1532459425-19204-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Exit read lock slowpath if queue
 empty & no writer
Git-Commit-ID: 4b486b535c33ef354ecf02a2650919004fd7d2b0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4b486b535c33ef354ecf02a2650919004fd7d2b0
Gitweb:     https://git.kernel.org/tip/4b486b535c33ef354ecf02a2650919004fd7d2b0
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 24 Jul 2018 15:10:25 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:16:39 +0200

locking/rwsem: Exit read lock slowpath if queue empty & no writer

It was discovered that a constant stream of readers with occassional
writers pounding on a rwsem may cause many of the readers to enter the
slowpath unnecessarily thus increasing latency and lowering performance.

In the current code, a reader entering the slowpath critical section
will unconditionally set the WAITING_BIAS, if not set yet, and clear
its active count even if no one is in the wait queue and no writer
is present. This causes some incoming readers to observe the presence
of waiters in the wait queue and hence have to go into the slowpath
themselves.

With sufficient numbers of readers and a relatively short lock hold time,
the WAITING_BIAS may be repeatedly turned on and off and a substantial
portion of the readers will go into the slowpath sustaining a rather
long queue in the wait queue spinlock and repeated WAITING_BIAS on/off
cycle until the logjam is broken opportunistically.

To avoid this situation from happening, an additional check is added to
detect the special case that the reader in the critical section is the
only one in the wait queue and no writer is present. When that happens,
it can just exit the slowpath and return immediately as its active count
has already been set in the lock.  Other incoming readers won't observe
the presence of waiters and so will not be forced into the slowpath.

The issue was found in a customer site where they had an application
that pounded on the pread64 syscalls heavily on an XFS filesystem. The
application was run in a recent 4-socket boxes with a lot of CPUs. They
saw significant spinlock contention in the rwsem_down_read_failed() call.
With this patch applied, the system CPU usage went down from 85% to 57%,
and the spinlock contention in the pread64 syscalls was gone.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1532459425-19204-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3064c50e181e..01fcb807598c 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -233,8 +233,19 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	waiter.type = RWSEM_WAITING_FOR_READ;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-	if (list_empty(&sem->wait_list))
+	if (list_empty(&sem->wait_list)) {
+		/*
+		 * In case the wait queue is empty and the lock isn't owned
+		 * by a writer, this reader can exit the slowpath and return
+		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
+		 * been set in the count.
+		 */
+		if (atomic_long_read(&sem->count) >= 0) {
+			raw_spin_unlock_irq(&sem->wait_lock);
+			return sem;
+		}
 		adjustment += RWSEM_WAITING_BIAS;
+	}
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
