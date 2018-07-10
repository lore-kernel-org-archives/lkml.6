Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3AEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B18B20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B18B20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbeGJScQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732845AbeGJScO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 888F640122D8;
        Tue, 10 Jul 2018 18:32:02 +0000 (UTC)
Received: from llong.com (ovpn-122-125.rdu2.redhat.com [10.10.122.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92F5A111AF21;
        Tue, 10 Jul 2018 18:31:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Take read lock immediate if empty queue with no writer
Date:   Tue, 10 Jul 2018 14:31:30 -0400
Message-Id: <1531247490-26852-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 18:32:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 18:32:02 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that a constant stream of readers might cause the count to
go negative most of the time after an initial trigger by a writer even
if no writer was present afterward. As a result, most of the readers
would have to go through the slowpath reducing their performance.

To avoid that from happening, an additional check is added to detect
the special case that the reader in the critical section is the only
one in the wait queue and no writer is present. When that happens, it
can just have the lock and return immediately without further action.
Other incoming readers won't see a waiter is present and be forced
into the slowpath.

After the list_empty() calls, the CPU should have the lock cacheline
anyway, so an additional semaphore count check shouldn't have any
performance impact.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3064c50..ef8a5f3 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -233,8 +233,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	waiter.type = RWSEM_WAITING_FOR_READ;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-	if (list_empty(&sem->wait_list))
+	if (list_empty(&sem->wait_list)) {
+		/*
+		 * In the unlikely event that the task is the only one in
+		 * the wait queue and a writer isn't present, it can have
+		 * the lock and return immediately without going through
+		 * the remaining slowpath code.
+		 *
+		 * Count won't be 0, but allowing it will probably generate
+		 * better code.
+		 */
+		if (unlikely(atomic_long_read(&sem->count) >= 0)) {
+			raw_spin_unlock_irq(&sem->wait_lock);
+			return sem;
+		}
 		adjustment += RWSEM_WAITING_BIAS;
+	}
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
-- 
1.8.3.1

