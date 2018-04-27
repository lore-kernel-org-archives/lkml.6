Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757958AbeD0Jh0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:37:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757645AbeD0JhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:37:24 -0400
Date: Fri, 27 Apr 2018 02:36:53 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-fcfdfe30e324725007e9dc5814b62a4c430ea909@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        will.deacon@arm.com, longman@redhat.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, longman@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, will.deacon@arm.com
In-Reply-To: <1524738868-31318-2-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-2-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/barriers: Introduce
 smp_cond_load_relaxed() and atomic_cond_read_relaxed()
Git-Commit-ID: fcfdfe30e324725007e9dc5814b62a4c430ea909
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

Commit-ID:  fcfdfe30e324725007e9dc5814b62a4c430ea909
Gitweb:     https://git.kernel.org/tip/fcfdfe30e324725007e9dc5814b62a4c430ea909
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:15 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:44 +0200

locking/barriers: Introduce smp_cond_load_relaxed() and atomic_cond_read_relaxed()

Whilst we currently provide smp_cond_load_acquire() and
atomic_cond_read_acquire(), there are cases where the ACQUIRE semantics are
not required because of a subsequent fence or release operation once the
conditional loop has exited.

This patch adds relaxed versions of the conditional spinning primitives
to avoid unnecessary barrier overhead on architectures such as arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-2-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-long.h |  2 ++
 include/asm-generic/barrier.h     | 27 +++++++++++++++++++++------
 include/linux/atomic.h            |  2 ++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index 34a028a7bcc5..5b2b0b5ea06d 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -244,6 +244,8 @@ static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 #define atomic_long_inc_not_zero(l) \
 	ATOMIC_LONG_PFX(_inc_not_zero)((ATOMIC_LONG_PFX(_t) *)(l))
 
+#define atomic_long_cond_read_relaxed(v, c) \
+	ATOMIC_LONG_PFX(_cond_read_relaxed)((ATOMIC_LONG_PFX(_t) *)(v), (c))
 #define atomic_long_cond_read_acquire(v, c) \
 	ATOMIC_LONG_PFX(_cond_read_acquire)((ATOMIC_LONG_PFX(_t) *)(v), (c))
 
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 29458bbb2fa0..2cafdbb9ae4c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -221,18 +221,17 @@ do {									\
 #endif
 
 /**
- * smp_cond_load_acquire() - (Spin) wait for cond with ACQUIRE ordering
+ * smp_cond_load_relaxed() - (Spin) wait for cond with no ordering guarantees
  * @ptr: pointer to the variable to wait on
  * @cond: boolean expression to wait for
  *
- * Equivalent to using smp_load_acquire() on the condition variable but employs
- * the control dependency of the wait to reduce the barrier on many platforms.
+ * Equivalent to using READ_ONCE() on the condition variable.
  *
  * Due to C lacking lambda expressions we load the value of *ptr into a
  * pre-named variable @VAL to be used in @cond.
  */
-#ifndef smp_cond_load_acquire
-#define smp_cond_load_acquire(ptr, cond_expr) ({		\
+#ifndef smp_cond_load_relaxed
+#define smp_cond_load_relaxed(ptr, cond_expr) ({		\
 	typeof(ptr) __PTR = (ptr);				\
 	typeof(*ptr) VAL;					\
 	for (;;) {						\
@@ -241,10 +240,26 @@ do {									\
 			break;					\
 		cpu_relax();					\
 	}							\
-	smp_acquire__after_ctrl_dep();				\
 	VAL;							\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire() - (Spin) wait for cond with ACQUIRE ordering
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ *
+ * Equivalent to using smp_load_acquire() on the condition variable but employs
+ * the control dependency of the wait to reduce the barrier on many platforms.
+ */
+#ifndef smp_cond_load_acquire
+#define smp_cond_load_acquire(ptr, cond_expr) ({		\
+	typeof(*ptr) _val;					\
+	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
+	smp_acquire__after_ctrl_dep();				\
+	_val;							\
+})
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8b276fd9a127..01ce3997cb42 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -654,6 +654,7 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 }
 #endif
 
+#define atomic_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
 #define atomic_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
 
 #ifdef CONFIG_GENERIC_ATOMIC64
@@ -1075,6 +1076,7 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
 }
 #endif
 
+#define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
 #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
 
 #include <asm-generic/atomic-long.h>
