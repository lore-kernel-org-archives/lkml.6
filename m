Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755749AbeDZKfg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:35:36 -0400
Received: from foss.arm.com ([217.140.101.70]:51126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755164AbeDZKeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:34:11 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, will.deacon@arm.com
Subject: [PATCH v3 09/14] locking/qspinlock: Use smp_cond_load_relaxed to wait for next node
Date: Thu, 26 Apr 2018 11:34:23 +0100
Message-Id: <1524738868-31318-10-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a locker reaches the head of the queue and takes the lock, a
concurrent locker may enqueue and force the lock holder to spin
whilst its node->next field is initialised. Rather than open-code
a READ_ONCE/cpu_relax() loop, this can be implemented using
smp_cond_load_relaxed instead.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5e383cfe4cce..7b8c81ebb15e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -483,10 +483,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * contended path; wait for next if not observed yet, release.
 	 */
-	if (!next) {
-		while (!(next = READ_ONCE(node->next)))
-			cpu_relax();
-	}
+	if (!next)
+		next = smp_cond_load_relaxed(&node->next, (VAL));
 
 	arch_mcs_spin_unlock_contended(&next->locked);
 	pv_kick_node(lock, next);
-- 
2.1.4
