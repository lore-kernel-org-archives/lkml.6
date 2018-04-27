Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932571AbeD0Jlu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:41:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeD0Jlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:41:47 -0400
Date: Fri, 27 Apr 2018 02:41:25 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-c131a198c497db436b558ac5e9a140cdcb91b304@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        longman@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, will.deacon@arm.com
In-Reply-To: <1524738868-31318-10-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-10-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Use smp_cond_load_relaxed()
 to wait for next node
Git-Commit-ID: c131a198c497db436b558ac5e9a140cdcb91b304
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c131a198c497db436b558ac5e9a140cdcb91b304
Gitweb:     https://git.kernel.org/tip/c131a198c497db436b558ac5e9a140cdcb91b304
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:50 +0200

locking/qspinlock: Use smp_cond_load_relaxed() to wait for next node

When a locker reaches the head of the queue and takes the lock, a
concurrent locker may enqueue and force the lock holder to spin
whilst its node->next field is initialised. Rather than open-code
a READ_ONCE/cpu_relax() loop, this can be implemented using
smp_cond_load_relaxed() instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-10-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 56af1fa9874d..d6c3b029bd93 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -483,10 +483,8 @@ locked:
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
