Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965840AbeE2SIJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:08:09 -0400
Received: from foss.arm.com ([217.140.101.70]:45884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965778AbeE2SID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:08:03 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 2/7] atomics/treewide: rework ordering barriers
Date: Tue, 29 May 2018 19:07:41 +0100
Message-Id: <20180529180746.29684-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529180746.29684-1-mark.rutland@arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently architectures can override __atomic_op_*() to define the barriers
used before/after a relaxed atomic when used to build acquire/release/fence
variants.

This has the unfortunate property of requiring the architecture to define the
full wrapper for the atomics, rather than just the barriers they care about,
and gets in the way of generating atomics which can be easily read.

Instead, this patch has architectures define an optional set of barriers,
__atomic_mb_{before,after}_{acquire,release,fence}(), which <linux/atomic.h>
uses to build the wrappers.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
---
 arch/alpha/include/asm/atomic.h   |  8 ++++----
 arch/powerpc/include/asm/atomic.h | 17 +++++------------
 arch/riscv/include/asm/atomic.h   | 17 +++++------------
 include/linux/atomic.h            | 38 ++++++++++++++++++++++----------------
 4 files changed, 36 insertions(+), 44 deletions(-)

I'm aware that the naming of these barriers is potentially bad, and something
like atomic_acquire_mb()/atomic_release_mb() might be better. I only really
care that the core code can use the barriers directly rather than this being
hidden in an architecture's __atomic_op_*().

Peter/Will, I'll defer to your judgement on naming.

Thanks,
Mark.

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 81bf9d15dcc1..aba549a0b147 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -18,11 +18,11 @@
  * To ensure dependency ordering is preserved for the _relaxed and
  * _release atomics, an smp_read_barrier_depends() is unconditionally
  * inserted into the _relaxed variants, which are used to build the
- * barriered versions. To avoid redundant back-to-back fences, we can
- * define the _acquire and _fence versions explicitly.
+ * barriered versions. Avoid redundant back-to-back fences in the
+ * _acquire and _fence versions.
  */
-#define __atomic_op_acquire(op, args...)	op##_relaxed(args)
-#define __atomic_op_fence			__atomic_op_release
+#define __atomic_mb__after_acquire()
+#define __atomic_mb__after_fence()
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index a0156cb43d1f..39342a1602e9 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -18,18 +18,11 @@
  * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
  * on the platform without lwsync.
  */
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
-	op##_relaxed(args);						\
-})
+#define __atomic_mb__after_acquire()					\
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory")
+
+#define __atomic_mb__before_release()					\
+	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
 
 static __inline__ int atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 512b89485790..1d168857638a 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -25,18 +25,11 @@
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");	\
-	op##_relaxed(args);						\
-})
+#define __atomic_mb__after_acquire()					\
+	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
+
+#define __atomic_mb__before_release()					\
+	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
 
 static __always_inline int atomic_read(const atomic_t *v)
 {
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 9c1b0769a846..580d15b10bfd 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -36,40 +36,46 @@
  * barriers on top of the relaxed variant. In the case where the relaxed
  * variant is already fully ordered, no additional barriers are needed.
  *
- * Besides, if an arch has a special barrier for acquire/release, it could
- * implement its own __atomic_op_* and use the same framework for building
- * variants
- *
- * If an architecture overrides __atomic_op_acquire() it will probably want
- * to define smp_mb__after_spinlock().
+ * If an architecture overrides __atomic_mb_after_acquire() it will probably
+ * want to define smp_mb__after_spinlock().
  */
-#ifndef __atomic_op_acquire
+#ifndef __atomic_mb__after_acquire
+#define __atomic_mb__after_acquire	smp_mb__after_atomic
+#endif
+
+#ifndef __atomic_mb__before_release
+#define __atomic_mb__before_release	smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_mb__before_fence
+#define __atomic_mb__before_fence	smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_mb__after_fence
+#define __atomic_mb__after_fence	smp_mb__after_atomic
+#endif
+
 #define __atomic_op_acquire(op, args...)				\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	smp_mb__after_atomic();						\
+	__atomic_mb__after_acquire();					\
 	__ret;								\
 })
-#endif
 
-#ifndef __atomic_op_release
 #define __atomic_op_release(op, args...)				\
 ({									\
-	smp_mb__before_atomic();					\
+	__atomic_mb__before_release();					\
 	op##_relaxed(args);						\
 })
-#endif
 
-#ifndef __atomic_op_fence
 #define __atomic_op_fence(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret;				\
-	smp_mb__before_atomic();					\
+	__atomic_mb__before_fence();					\
 	__ret = op##_relaxed(args);					\
-	smp_mb__after_atomic();						\
+	__atomic_mb__after_fence();					\
 	__ret;								\
 })
-#endif
 
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
-- 
2.11.0
