Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeDERAb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:00:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeDEQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:58:56 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 06/10] barriers: Introduce smp_cond_load_relaxed and atomic_cond_read_relaxed
Date: Thu,  5 Apr 2018 17:59:03 +0100
Message-Id: <1522947547-24081-7-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst we currently provide smp_cond_load_acquire and
atomic_cond_read_acquire, there are cases where the ACQUIRE semantics are
not required because of a subsequent fence or release operation once the
conditional loop has exited.

This patch adds relaxed versions of the conditional spinning primitives
to avoid unnecessary barrier overhead on architectures such as arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/barrier.h | 27 +++++++++++++++++++++------
 include/linux/atomic.h        |  2 ++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fe297b599b0a..305e03b19a26 100644
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
-- 
2.1.4
