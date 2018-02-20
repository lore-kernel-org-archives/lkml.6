Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBTJd7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:33:59 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37554 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeBTJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:33:55 -0500
X-Google-Smtp-Source: AH8x224J+DvqINx61Oepia3n+Ns0dfT+CZ4bnz7AsfkXQes5Be6EblviKA5htz8U2FaeT6OdosRJFA==
Date: Tue, 20 Feb 2018 10:33:47 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180220093346.GA5505@andrea>
References: <20180217151413.GA3785@andrea>
 <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> On Sat, 17 Feb 2018, Andrea Parri wrote:
> 
> > > Akira's observation about READ_ONCE extends to all (annotated) loads.  In
> > > fact, it also applies to loads corresponding to unsuccessful RMW operations;
> > > consider, for example, the following variation of MP+onceassign+derefonce:
> > > 
> > > C T
> > > 
> > > {
> > > y=z;
> > > z=0;
> > > }
> > > 
> > > P0(int *x, int **y)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	smp_store_release(y, x);
> > > }
> > > 
> > > P1(int **y, int *z)
> > > {
> > > 	int *r0;
> > > 	int r1;
> > > 
> > > 	r0 = cmpxchg_relaxed(y, z, z);
> > > 	r1 = READ_ONCE(*r0);
> > > }
> > > 
> > > exists (1:r0=x /\ 1:r1=0)
> > > 
> > > The final state is allowed w/o the patch, and forbidden w/ the patch.
> > > 
> > > This also reminds me of
> > > 
> > >    5a8897cc7631fa544d079c443800f4420d1b173f
> > >    ("locking/atomics/alpha: Add smp_read_barrier_depends() to _release()/_relaxed() atomics")
> > > 
> > > (that we probably want to mention in the commit message).
> > 
> > Please also notice that 5a8897cc7631f only touched alpha's atomic.h:
> > I see no corresponding commit/change on {,cmp}xchg.h (where the "mb"
> > is currently conditionally executed).
> 
> This leaves us with a question: Do we want to change the kernel by
> adding memory barriers after unsuccessful RMW operations on Alpha, or
> do we want to change the model by excluding such operations from
> address dependencies?

I'd like to continue to treat R[once] and R*[once] equally if possible.
Given the (unconditional) smp_read_barrier_depends in READ_ONCE and in
atomics, it seems reasonable to have it unconditionally in cmpxchg.

As with the following patch?

  Andrea

---
diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
index 68dfb3cb71454..e2660866ce972 100644
--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -128,10 +128,9 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  *
- * The memory barrier should be placed in SMP only when we actually
- * make the change. If we don't change anything (so if the returned
- * prev is equal to old) then we aren't acquiring anything new and
- * we don't need any memory barrier as far I can tell.
+ * The memory barrier is placed in SMP unconditionally, in order to
+ * guarantee that dependency ordering is preserved when a dependency
+ * is headed by an unsuccessful operation.
  */
 
 static inline unsigned long
@@ -150,8 +149,8 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
@@ -177,8 +176,8 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
@@ -200,8 +199,8 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
 	"	mov %4,%1\n"
 	"	stl_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
@@ -223,8 +222,8 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
 	"	mov %4,%1\n"
 	"	stq_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"


> 
> Note that operations like atomic_add_unless() already include memory 
> barriers.
> 
> Alan
> 
