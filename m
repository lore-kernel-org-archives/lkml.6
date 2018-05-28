Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423709AbeE1LJJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423333AbeE1LJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 084/272] riscv/spinlock: Strengthen implementations with fences
Date: Mon, 28 May 2018 12:01:57 +0200
Message-Id: <20180528100248.177371733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit 0123f4d76ca63b7b895f40089be0ce4809e392d8 ]

Current implementations map locking operations using .rl and .aq
annotations.  However, this mapping is unsound w.r.t. the kernel
memory consistency model (LKMM) [1]:

Referring to the "unlock-lock-read-ordering" test reported below,
Daniel wrote:

  "I think an RCpc interpretation of .aq and .rl would in fact
   allow the two normal loads in P1 to be reordered [...]

   The intuition would be that the amoswap.w.aq can forward from
   the amoswap.w.rl while that's still in the store buffer, and
   then the lw x3,0(x4) can also perform while the amoswap.w.rl
   is still in the store buffer, all before the l1 x1,0(x2)
   executes.  That's not forbidden unless the amoswaps are RCsc,
   unless I'm missing something.

   Likewise even if the unlock()/lock() is between two stores.
   A control dependency might originate from the load part of
   the amoswap.w.aq, but there still would have to be something
   to ensure that this load part in fact performs after the store
   part of the amoswap.w.rl performs globally, and that's not
   automatic under RCpc."

Simulation of the RISC-V memory consistency model confirmed this
expectation.

In order to "synchronize" LKMM and RISC-V's implementation, this
commit strengthens the implementations of the locking operations
by replacing .rl and .aq with the use of ("lightweigth") fences,
resp., "fence rw,  w" and "fence r , rw".

C unlock-lock-read-ordering

{}
/* s initially owned by P1 */

P0(int *x, int *y)
{
        WRITE_ONCE(*x, 1);
        smp_wmb();
        WRITE_ONCE(*y, 1);
}

P1(int *x, int *y, spinlock_t *s)
{
        int r0;
        int r1;

        r0 = READ_ONCE(*y);
        spin_unlock(s);
        spin_lock(s);
        r1 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 1:r1=0)

[1] https://marc.info/?l=linux-kernel&m=151930201102853&w=2
    https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/hKywNHBkAXM
    https://marc.info/?l=linux-kernel&m=151633436614259&w=2

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/fence.h    |   12 ++++++++++++
 arch/riscv/include/asm/spinlock.h |   29 +++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/fence.h

--- /dev/null
+++ b/arch/riscv/include/asm/fence.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_RISCV_FENCE_H
+#define _ASM_RISCV_FENCE_H
+
+#ifdef CONFIG_SMP
+#define RISCV_ACQUIRE_BARRIER		"\tfence r , rw\n"
+#define RISCV_RELEASE_BARRIER		"\tfence rw,  w\n"
+#else
+#define RISCV_ACQUIRE_BARRIER
+#define RISCV_RELEASE_BARRIER
+#endif
+
+#endif	/* _ASM_RISCV_FENCE_H */
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -17,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <asm/current.h>
+#include <asm/fence.h>
 
 /*
  * Simple spin lock operations.  These provide no fairness guarantees.
@@ -28,10 +29,7 @@
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	__asm__ __volatile__ (
-		"amoswap.w.rl x0, x0, %0"
-		: "=A" (lock->lock)
-		:: "memory");
+	smp_store_release(&lock->lock, 0);
 }
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
@@ -39,7 +37,8 @@ static inline int arch_spin_trylock(arch
 	int tmp = 1, busy;
 
 	__asm__ __volatile__ (
-		"amoswap.w.aq %0, %2, %1"
+		"	amoswap.w %0, %2, %1\n"
+		RISCV_ACQUIRE_BARRIER
 		: "=r" (busy), "+A" (lock->lock)
 		: "r" (tmp)
 		: "memory");
@@ -68,8 +67,9 @@ static inline void arch_read_lock(arch_r
 		"1:	lr.w	%1, %0\n"
 		"	bltz	%1, 1b\n"
 		"	addi	%1, %1, 1\n"
-		"	sc.w.aq	%1, %1, %0\n"
+		"	sc.w	%1, %1, %0\n"
 		"	bnez	%1, 1b\n"
+		RISCV_ACQUIRE_BARRIER
 		: "+A" (lock->lock), "=&r" (tmp)
 		:: "memory");
 }
@@ -82,8 +82,9 @@ static inline void arch_write_lock(arch_
 		"1:	lr.w	%1, %0\n"
 		"	bnez	%1, 1b\n"
 		"	li	%1, -1\n"
-		"	sc.w.aq	%1, %1, %0\n"
+		"	sc.w	%1, %1, %0\n"
 		"	bnez	%1, 1b\n"
+		RISCV_ACQUIRE_BARRIER
 		: "+A" (lock->lock), "=&r" (tmp)
 		:: "memory");
 }
@@ -96,8 +97,9 @@ static inline int arch_read_trylock(arch
 		"1:	lr.w	%1, %0\n"
 		"	bltz	%1, 1f\n"
 		"	addi	%1, %1, 1\n"
-		"	sc.w.aq	%1, %1, %0\n"
+		"	sc.w	%1, %1, %0\n"
 		"	bnez	%1, 1b\n"
+		RISCV_ACQUIRE_BARRIER
 		"1:\n"
 		: "+A" (lock->lock), "=&r" (busy)
 		:: "memory");
@@ -113,8 +115,9 @@ static inline int arch_write_trylock(arc
 		"1:	lr.w	%1, %0\n"
 		"	bnez	%1, 1f\n"
 		"	li	%1, -1\n"
-		"	sc.w.aq	%1, %1, %0\n"
+		"	sc.w	%1, %1, %0\n"
 		"	bnez	%1, 1b\n"
+		RISCV_ACQUIRE_BARRIER
 		"1:\n"
 		: "+A" (lock->lock), "=&r" (busy)
 		:: "memory");
@@ -125,7 +128,8 @@ static inline int arch_write_trylock(arc
 static inline void arch_read_unlock(arch_rwlock_t *lock)
 {
 	__asm__ __volatile__(
-		"amoadd.w.rl x0, %1, %0"
+		RISCV_RELEASE_BARRIER
+		"	amoadd.w x0, %1, %0\n"
 		: "+A" (lock->lock)
 		: "r" (-1)
 		: "memory");
@@ -133,10 +137,7 @@ static inline void arch_read_unlock(arch
 
 static inline void arch_write_unlock(arch_rwlock_t *lock)
 {
-	__asm__ __volatile__ (
-		"amoswap.w.rl x0, x0, %0"
-		: "=A" (lock->lock)
-		:: "memory");
+	smp_store_release(&lock->lock, 0);
 }
 
 #endif /* _ASM_RISCV_SPINLOCK_H */
