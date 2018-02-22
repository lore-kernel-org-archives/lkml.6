Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbeBVMUC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:20:02 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55890 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeBVMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:20:00 -0500
X-Google-Smtp-Source: AH8x226MGNByUD8m6wrgUpYWriTGTLB2m7d6gTyhqFGMJ5pWzmd4sEKQwJr9k3gUPxvMYRppHT7jKw==
From: Andrea Parri <parri.andrea@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
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
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH] riscv/locking: Strengthen spin_lock() and spin_unlock()
Date: Thu, 22 Feb 2018 13:19:50 +0100
Message-Id: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LKMM defines certain memory ordering constraints for spin_lock(),
spin_unlock() and other primitives that the kernel developer can rely
on; unfortunately, some of these constraints are not currently met by
the RISC-V implementation of spin_lock(), spin_unlock().

The following MP-like program exemplifies the issue: according to our
LKMM, program "unlock-lock-read-ordering" below can never reach state
(1:r0=1 /\ 1:r1=0).  However, when we map this C program to the RISCV
program "RISCV-unlock-lock-read-ordering" below following the current
implementation, the corresponding state is reachable according to the
RISCV specification and its formalizations [2].

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
	r1 = READ_ONCE(*y);
}

exists (1:r0=1 /\ 1:r1=0)

RISCV RISCV-unlock-lock-read-ordering
{
0:x2=x; 0:x4=y;
1:x2=y; 1:x4=x; 1:x6=s;
s=1;
}
 P0           |  P1                      ;
 ori x1,x0,1  | lw x1,0(x2)              ;
 sw x1,0(x2)  | amoswap.w.rl x0,x0,(x6)  ;
 fence w,w    | ori x5,x0,1              ;
 ori x3,x0,1  | amoswap.w.aq x0,x5,(x6)  ;
 sw x3,0(x4)  | lw x3,0(x4)              ;
exists
(1:x1=1 /\ 1:x3=0)

The issue can in fact be exarcebated if, as envisaged/discussed in [3],
the LKMM will be modified to become even more "demanding" on the order-
ing constraints associated to the locking primitives.  For example the
state (1:r0=1 /\ 1:r1=0) in program "unlock-lock-write-ordering" below
is currently allowed by LKMM (as is the corresponding state in "RISCV-
unlock-lock-write-ordering" below).  However, proposals modifying LKMM
to _forbid_ that state have already appeared on LKML [4].

C unlock-lock-write-ordering

{}
/* s initially owned by P0 */

P0(int *x, int *y, spinlock_t *s)
{
	WRITE_ONCE(*x, 1);
	spin_unlock(s);
	spin_lock(s);
	WRITE_ONCE(*y, 1);
}

P1(int *x, int *y)
{
	int r0;
	int r1;

	r0 = READ_ONCE(*y);
	smp_rmb();
	r1 = READ_ONCE(*y);
}

exists (1:r0=1 /\ 1:r1=0)

RISCV RISCV-unlock-lock-write-ordering
{
0:x2=x; 0:x4=y; 0:x6=s;
1:x2=y; 1:x4=x;
s=1;
}
 P0                       | P1           ;
 ori x1,x0,1              | lw x1,0(x2)  ;
 sw x1,0(x2)              | fence r,r    ;
 amoswap.w.rl x0,x0,(x6)  | lw x3,0(x4)  ;
 ori x5,x0,1              |              ;
 amoswap.w.aq x0,x5,(x6)  |              ;
 ori x3,x0,1              |              ;
 sw x3,0(x4)              |              ;
exists
(1:x1=1 /\ 1:x3=0)

[Curiously, RISC-V's current implementations of smp_load_acquire() and
 smp_store_release() provide way stronger ordering than what currently
 required by LKMM since those're relying on the generic implementation
 (c.f, also, [5]). ]

This RFC fixes the issue by strengthening RISC-V's implementations of
spin_lock() and spin_unlock(), based on "A spinlock with fences" from
Section 2.3.5 ("Acquire/Release Ordering") of the RISC-V draft spec.
It does _not_ attempt to fix read-lock and atomics (for which, AFAICT,
similar considerations would hold).

IMPORTANT.  This patch is _NOT_ intended to be applied as is.  Rather,
this is intended to test the waters, implicit questions being "Should
we take this direction?" "Are changes to LKMM needed?" (and develop a
technical discussion on the above issues.)

[1] https://marc.info/?l=linux-kernel&m=151633436614259&w=2
[2] https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/hKywNHBkAXM
[3] https://marc.info/?l=linux-kernel&m=151181741400461&w=2
[4] https://marc.info/?l=linux-kernel&m=151871035014425&w=2
[5] https://marc.info/?l=linux-kernel&m=151912186913692&w=2

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
---
 arch/riscv/include/asm/spinlock.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index 2fd27e8ef1fd6..2f89fc62c9196 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -28,8 +28,9 @@
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
+	RISCV_FENCE(rw,w);
 	__asm__ __volatile__ (
-		"amoswap.w.rl x0, x0, %0"
+		"amoswap.w x0, x0, %0"
 		: "=A" (lock->lock)
 		:: "memory");
 }
@@ -39,10 +40,11 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 	int tmp = 1, busy;
 
 	__asm__ __volatile__ (
-		"amoswap.w.aq %0, %2, %1"
+		"amoswap.w %0, %2, %1"
 		: "=r" (busy), "+A" (lock->lock)
 		: "r" (tmp)
 		: "memory");
+	RISCV_FENCE(r,rw);
 
 	return !busy;
 }
-- 
2.7.4
