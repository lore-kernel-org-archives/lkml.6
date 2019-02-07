Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35226C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6B421904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBGTKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfBGTKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:10:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00B3AC06A802;
        Thu,  7 Feb 2019 19:10:06 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18D6161146;
        Thu,  7 Feb 2019 19:09:56 +0000 (UTC)
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
Subject: [PATCH-tip 17/22] locking/rwsem: Recheck owner if it is not on cpu
Date:   Thu,  7 Feb 2019 14:07:21 -0500
Message-Id: <1549566446-27967-18-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 07 Feb 2019 19:10:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging the owner value directly into the count field, it was
found that the number of failed optimistic spinning operations increased
significantly during the boot up process.

The cause of this increased failures was tracked down to the condition
that a lock holder might have just released the lock and gone to sleep
right after its owner value was fetched by a spinner. So the task might
have slept, but it was no longer the lock holder. The merging of owner
into count increases the chance this condition can happen.

To close this failure mode, we are now rechecking the owner value again
to see if it has been changed in case it is not on cpu.

On a 1-socket x86-64 system, the lock event counts before the patch
were:

  rwsem_opt_fail=5847
  rwsem_opt_wlock=7880
  rwsem_wlock=5847

After the patch, the counts were:

  rwsem_opt_fail=225
  rwsem_opt_wlock=8541
  rwsem_wlock=225

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 16dc7a1..21d462f 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -263,13 +263,25 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
 	}
 }
 
-static inline bool owner_on_cpu(struct task_struct *owner)
+static inline bool owner_on_cpu(struct task_struct *owner,
+				struct rw_semaphore *sem)
 {
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
 	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+	bool oncpu = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+
+	/*
+	 * There is a slight chance that the lock holder might have
+	 * just release the rwsem and gone to sleep right after we
+	 * fetched the owner value. So we double-check the sem->owner
+	 * field again to see if it has been changed. The sem->owner
+	 * would have been cleared right before the lock was released.
+	 */
+	if (!oncpu && (READ_ONCE(sem->owner) != owner))
+		return true;	/* Assume the new owner is on cpu */
+	return oncpu;
 }
 
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
@@ -286,7 +298,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
+		      owner_on_cpu(owner, sem);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -323,7 +335,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * abort spinning when need_resched or owner is not running or
 		 * owner's cpu is preempted.
 		 */
-		if (need_resched() || !owner_on_cpu(owner)) {
+		if (need_resched() || !owner_on_cpu(owner, sem)) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
1.8.3.1

