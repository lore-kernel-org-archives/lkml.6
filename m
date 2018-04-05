Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDERAE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:00:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeDEQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:58:56 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 07/10] locking/qspinlock: Use smp_cond_load_relaxed to wait for next node
Date: Thu,  5 Apr 2018 17:59:04 +0100
Message-Id: <1522947547-24081-8-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
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
index 291e1526d27b..c8b57d375b49 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -475,10 +475,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
