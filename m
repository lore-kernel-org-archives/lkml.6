Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932556AbeD0JlW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:41:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757353AbeD0JlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:41:21 -0400
Date: Fri, 27 Apr 2018 02:40:51 -0700
From: tip-bot for Jason Low <tipbot@zytor.com>
Message-ID: <tip-7f56b58a92aaf2cab049f32a19af7cc57a3972f2@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, jason.low2@hp.com, will.deacon@arm.com,
        longman@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: longman@redhat.com, will.deacon@arm.com, jason.low2@hp.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com
In-Reply-To: <1524738868-31318-9-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-9-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/mcs: Use smp_cond_load_acquire() in MCS
 spin loop
Git-Commit-ID: 7f56b58a92aaf2cab049f32a19af7cc57a3972f2
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

Commit-ID:  7f56b58a92aaf2cab049f32a19af7cc57a3972f2
Gitweb:     https://git.kernel.org/tip/7f56b58a92aaf2cab049f32a19af7cc57a3972f2
Author:     Jason Low <jason.low2@hp.com>
AuthorDate: Thu, 26 Apr 2018 11:34:22 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:49 +0200

locking/mcs: Use smp_cond_load_acquire() in MCS spin loop

For qspinlocks on ARM64, we would like to use WFE instead
of purely spinning. Qspinlocks internally have lock
contenders spin on an MCS lock.

Update arch_mcs_spin_lock_contended() such that it uses
the new smp_cond_load_acquire() so that ARM64 can also
override this spin loop with its own implementation using WFE.

On x86, this can also be cheaper than spinning on
smp_load_acquire().

Signed-off-by: Jason Low <jason.low2@hp.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-9-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/mcs_spinlock.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index f046b7ce9dd6..5e10153b4d3c 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -23,13 +23,15 @@ struct mcs_spinlock {
 
 #ifndef arch_mcs_spin_lock_contended
 /*
- * Using smp_load_acquire() provides a memory barrier that ensures
- * subsequent operations happen after the lock is acquired.
+ * Using smp_cond_load_acquire() provides the acquire semantics
+ * required so that subsequent operations happen after the
+ * lock is acquired. Additionally, some architectures such as
+ * ARM64 would like to do spin-waiting instead of purely
+ * spinning, and smp_cond_load_acquire() provides that behavior.
  */
 #define arch_mcs_spin_lock_contended(l)					\
 do {									\
-	while (!(smp_load_acquire(l)))					\
-		cpu_relax();						\
+	smp_cond_load_acquire(l, VAL);					\
 } while (0)
 #endif
 
