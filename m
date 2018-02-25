Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeBYT1w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:27:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBYT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:27:49 -0500
Date: Sun, 25 Feb 2018 20:28:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] locking fixes for 4.16
Message-ID: <alpine.DEB.2.21.1802252026190.1468@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

Three patches to fix memory ordering issues on ALPHA and a comment to
clarify the usage scope of a mutex internal function.

Thanks,

	tglx

------------------>
Andrea Parri (3):
      locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()
      locking/xchg/alpha: Clean up barrier usage by using smp_mb() in place of __ASM__MB
      locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Peter Zijlstra (1):
      locking/mutex: Add comment to __mutex_owner() to deter usage


 arch/alpha/include/asm/cmpxchg.h |  6 ------
 arch/alpha/include/asm/xchg.h    | 38 ++++++++++++++++++++++++++------------
 include/linux/mutex.h            |  5 +++++
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 46ebf14aed4e..8a2b331e43fe 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -6,7 +6,6 @@
  * Atomic exchange routines.
  */
 
-#define __ASM__MB
 #define ____xchg(type, args...)		__xchg ## type ## _local(args)
 #define ____cmpxchg(type, args...)	__cmpxchg ## type ## _local(args)
 #include <asm/xchg.h>
@@ -33,10 +32,6 @@
 	cmpxchg_local((ptr), (o), (n));					\
 })
 
-#ifdef CONFIG_SMP
-#undef __ASM__MB
-#define __ASM__MB	"\tmb\n"
-#endif
 #undef ____xchg
 #undef ____cmpxchg
 #define ____xchg(type, args...)		__xchg ##type(args)
@@ -64,7 +59,6 @@
 	cmpxchg((ptr), (o), (n));					\
 })
 
-#undef __ASM__MB
 #undef ____cmpxchg
 
 #endif /* _ALPHA_CMPXCHG_H */
diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
index 68dfb3cb7145..e2b59fac5257 100644
--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -12,6 +12,10 @@
  * Atomic exchange.
  * Since it can be used to implement critical sections
  * it must clobber "memory" (also for interrupts in UP).
+ *
+ * The leading and the trailing memory barriers guarantee that these
+ * operations are fully ordered.
+ *
  */
 
 static inline unsigned long
@@ -19,6 +23,7 @@ ____xchg(_u8, volatile char *m, unsigned long val)
 {
 	unsigned long ret, tmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%4,7,%3\n"
 	"	insbl	%1,%4,%1\n"
@@ -28,12 +33,12 @@ ____xchg(_u8, volatile char *m, unsigned long val)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%3)\n"
 	"	beq	%2,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
 	: "r" ((long)m), "1" (val) : "memory");
+	smp_mb();
 
 	return ret;
 }
@@ -43,6 +48,7 @@ ____xchg(_u16, volatile short *m, unsigned long val)
 {
 	unsigned long ret, tmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%4,7,%3\n"
 	"	inswl	%1,%4,%1\n"
@@ -52,12 +58,12 @@ ____xchg(_u16, volatile short *m, unsigned long val)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%3)\n"
 	"	beq	%2,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
 	: "r" ((long)m), "1" (val) : "memory");
+	smp_mb();
 
 	return ret;
 }
@@ -67,17 +73,18 @@ ____xchg(_u32, volatile int *m, unsigned long val)
 {
 	unsigned long dummy;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldl_l %0,%4\n"
 	"	bis $31,%3,%1\n"
 	"	stl_c %1,%2\n"
 	"	beq %1,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br 1b\n"
 	".previous"
 	: "=&r" (val), "=&r" (dummy), "=m" (*m)
 	: "rI" (val), "m" (*m) : "memory");
+	smp_mb();
 
 	return val;
 }
@@ -87,17 +94,18 @@ ____xchg(_u64, volatile long *m, unsigned long val)
 {
 	unsigned long dummy;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l %0,%4\n"
 	"	bis $31,%3,%1\n"
 	"	stq_c %1,%2\n"
 	"	beq %1,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br 1b\n"
 	".previous"
 	: "=&r" (val), "=&r" (dummy), "=m" (*m)
 	: "rI" (val), "m" (*m) : "memory");
+	smp_mb();
 
 	return val;
 }
@@ -128,10 +136,12 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  *
- * The memory barrier should be placed in SMP only when we actually
- * make the change. If we don't change anything (so if the returned
- * prev is equal to old) then we aren't acquiring anything new and
- * we don't need any memory barrier as far I can tell.
+ * The leading and the trailing memory barriers guarantee that these
+ * operations are fully ordered.
+ *
+ * The trailing memory barrier is placed in SMP unconditionally, in
+ * order to guarantee that dependency ordering is preserved when a
+ * dependency is headed by an unsuccessful operation.
  */
 
 static inline unsigned long
@@ -139,6 +149,7 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
 {
 	unsigned long prev, tmp, cmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%5,7,%4\n"
 	"	insbl	%1,%5,%1\n"
@@ -150,13 +161,13 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
 	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
 	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+	smp_mb();
 
 	return prev;
 }
@@ -166,6 +177,7 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
 {
 	unsigned long prev, tmp, cmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%5,7,%4\n"
 	"	inswl	%1,%5,%1\n"
@@ -177,13 +189,13 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
 	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
 	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+	smp_mb();
 
 	return prev;
 }
@@ -193,6 +205,7 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
 {
 	unsigned long prev, cmp;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldl_l %0,%5\n"
 	"	cmpeq %0,%3,%1\n"
@@ -200,13 +213,13 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
 	"	mov %4,%1\n"
 	"	stl_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
 	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
 	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+	smp_mb();
 
 	return prev;
 }
@@ -216,6 +229,7 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
 {
 	unsigned long prev, cmp;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l %0,%5\n"
 	"	cmpeq %0,%3,%1\n"
@@ -223,13 +237,13 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
 	"	mov %4,%1\n"
 	"	stq_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
 	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
 	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+	smp_mb();
 
 	return prev;
 }
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index f25c13423bd4..cb3bbed4e633 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -66,6 +66,11 @@ struct mutex {
 #endif
 };
 
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex code).
+ */
 static inline struct task_struct *__mutex_owner(struct mutex *lock)
 {
 	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
