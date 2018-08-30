Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33493C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF1820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF1820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeH3RK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:10:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728686AbeH3RK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0343840200BA;
        Thu, 30 Aug 2018 13:08:49 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B99202166B41;
        Thu, 30 Aug 2018 13:08:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH RESEND v3] locking/rwsem: Exit read lock slowpath if queue empty & no writer
Date:   Thu, 30 Aug 2018 09:08:33 -0400
Message-Id: <1535634513-8961-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 13:08:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 13:08:54 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v3: Revise the commit log and comment again.
v2: Add customer testing results and remove wording that may cause
    confusion.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/rwsem-xadd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3064c50..01fcb80 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -233,8 +233,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
-- 
1.8.3.1

