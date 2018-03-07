Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeCGSjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:39:25 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35854 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754397AbeCGSjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:39:23 -0500
X-Google-Smtp-Source: AG47ELt9LpzYc/Bl8SXRGMybb65XVtbXJaHsQ3FU4HfqDmXFna9mJO610QNNf7YkIHe0sb511MfVIw==
Date: Wed, 07 Mar 2018 10:33:49 -0800 (PST)
X-Google-Original-Date: Wed, 07 Mar 2018 10:33:19 PST (-0800)
Subject: Re: [RFC PATCH 1/2] riscv/spinlock: Strengthen implementations with fences
In-Reply-To: <20180307105242.GA6133@andrea>
CC: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com
Message-ID: <mhng-45acdfe8-f932-4e48-aa78-b1fcd1f95344@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018 02:52:42 PST (-0800), parri.andrea@gmail.com wrote:
> On Tue, Mar 06, 2018 at 06:02:28PM -0800, Palmer Dabbelt wrote:
>> On Mon, 05 Mar 2018 10:24:09 PST (-0800), parri.andrea@gmail.com wrote:
>> >Current implementations map locking operations using .rl and .aq
>> >annotations.  However, this mapping is unsound w.r.t. the kernel
>> >memory consistency model (LKMM) [1]:
>> >
>> >Referring to the "unlock-lock-read-ordering" test reported below,
>> >Daniel wrote:
>> >
>> >  "I think an RCpc interpretation of .aq and .rl would in fact
>> >   allow the two normal loads in P1 to be reordered [...]
>> >
>> >   The intuition would be that the amoswap.w.aq can forward from
>> >   the amoswap.w.rl while that's still in the store buffer, and
>> >   then the lw x3,0(x4) can also perform while the amoswap.w.rl
>> >   is still in the store buffer, all before the l1 x1,0(x2)
>> >   executes.  That's not forbidden unless the amoswaps are RCsc,
>> >   unless I'm missing something.
>> >
>> >   Likewise even if the unlock()/lock() is between two stores.
>> >   A control dependency might originate from the load part of
>> >   the amoswap.w.aq, but there still would have to be something
>> >   to ensure that this load part in fact performs after the store
>> >   part of the amoswap.w.rl performs globally, and that's not
>> >   automatic under RCpc."
>> >
>> >Simulation of the RISC-V memory consistency model confirmed this
>> >expectation.
>> >
>> >In order to "synchronize" LKMM and RISC-V's implementation, this
>> >commit strengthens the implementations of the locking operations
>> >by replacing .rl and .aq with the use of ("lightweigth") fences,
>> >resp., "fence rw,  w" and "fence r , rw".
>> >
>> >C unlock-lock-read-ordering
>> >
>> >{}
>> >/* s initially owned by P1 */
>> >
>> >P0(int *x, int *y)
>> >{
>> >        WRITE_ONCE(*x, 1);
>> >        smp_wmb();
>> >        WRITE_ONCE(*y, 1);
>> >}
>> >
>> >P1(int *x, int *y, spinlock_t *s)
>> >{
>> >        int r0;
>> >        int r1;
>> >
>> >        r0 = READ_ONCE(*y);
>> >        spin_unlock(s);
>> >        spin_lock(s);
>> >        r1 = READ_ONCE(*x);
>> >}
>> >
>> >exists (1:r0=1 /\ 1:r1=0)
>> >
>> >[1] https://marc.info/?l=linux-kernel&m=151930201102853&w=2
>> >    https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/hKywNHBkAXM
>> >    https://marc.info/?l=linux-kernel&m=151633436614259&w=2
>> >
>> >Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>> >Cc: Palmer Dabbelt <palmer@sifive.com>
>> >Cc: Albert Ou <albert@sifive.com>
>> >Cc: Daniel Lustig <dlustig@nvidia.com>
>> >Cc: Alan Stern <stern@rowland.harvard.edu>
>> >Cc: Will Deacon <will.deacon@arm.com>
>> >Cc: Peter Zijlstra <peterz@infradead.org>
>> >Cc: Boqun Feng <boqun.feng@gmail.com>
>> >Cc: Nicholas Piggin <npiggin@gmail.com>
>> >Cc: David Howells <dhowells@redhat.com>
>> >Cc: Jade Alglave <j.alglave@ucl.ac.uk>
>> >Cc: Luc Maranget <luc.maranget@inria.fr>
>> >Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> >Cc: Akira Yokosawa <akiyks@gmail.com>
>> >Cc: Ingo Molnar <mingo@kernel.org>
>> >Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> >Cc: linux-riscv@lists.infradead.org
>> >Cc: linux-kernel@vger.kernel.org
>> >---
>> > arch/riscv/include/asm/fence.h    | 12 ++++++++++++
>> > arch/riscv/include/asm/spinlock.h | 29 +++++++++++++++--------------
>> > 2 files changed, 27 insertions(+), 14 deletions(-)
>> > create mode 100644 arch/riscv/include/asm/fence.h
>>
>> Oh, sorry about this -- I thought I'd deleted all this code, but I guess I
>> just wrote a patch and then forgot about it.  Here's my original patch,
>> which I have marked as a WIP:
>
> No problem.
>
>
>>
>> commit 39908f1f8b75ae88ce44dc77b8219a94078ad298
>> Author: Palmer Dabbelt <palmer@sifive.com>
>> Date:   Tue Dec 5 16:26:50 2017 -0800
>>
>>    RISC-V: Use generic spin and rw locks
>>
>>    This might not be exactly the right thing to do: we could use LR/SC to
>>    produce slightly better locks by rolling the tests into the LR/SC.  I'm
>>    going to defer that until I get a better handle on the new memory model
>>    and just be safe here: after some discussion I'm pretty sure the AMOs
>>    are good, and cmpxchg is safe (by being way too string).
>
> I'm pretty sure you lost me (and a few other people) here.
>
> IIUC, this says: "what we've been discussing within the last few weeks is
> going to change", but not much else...
>
> Or am I misunderstanding? You mean cmpxchg, ... as in my patch 2/2?

Well, it was what we were discussing for the past few weeks before Dec 5th (as 
that's when I wrote the patch).  It's more of a note for myself than a proper 
commit message, and I've also forgotten what I was talking about.

>>
>>    Since we'd want to rewrite the spinlocks anyway so they queue, I don't
>>    see any reason to keep the old implementations around.
>
> Keep in mind that queued locks were written and optimized for x86.  arm64
> only recently adopted qrwlocks:
>
>   087133ac90763cd339b6b67f2998f87dcc136c52
>   ("locking/qrwlock, arm64: Move rwlock implementation over to qrwlocks")
>
> This certainly needs further testing and reviewing. (Nit: your patch does
> not compile on any of the "riscv" branches I'm currently tracking...)

That's probably why it was just floating around and not sent out :).  I went 
and talked to Andrew and we think there's actually a reasonable argument for 
some spinlocks that are similar to what we currently have.  The ISA manual 
describes some canonical spinlock code, which has the advantage of being 
smaller and being defined as a target for micro architectural pattern matching.

I'm going to go produce a new set of spinlocks, I think it'll be a bit more 
coherent then.

I'm keeping your other patch in my queue for now, it generally looks good but I 
haven't looked closely yet.

Thanks!

>
>   Andrea
>
>
>>
>>    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
>> index 2fd27e8ef1fd..9b166ea81fe5 100644
>> --- a/arch/riscv/include/asm/spinlock.h
>> +++ b/arch/riscv/include/asm/spinlock.h
>> @@ -15,128 +15,7 @@
>> #ifndef _ASM_RISCV_SPINLOCK_H
>> #define _ASM_RISCV_SPINLOCK_H
>>
>> -#include <linux/kernel.h>
>> -#include <asm/current.h>
>> -
>> -/*
>> - * Simple spin lock operations.  These provide no fairness guarantees.
>> - */
>> -
>> -/* FIXME: Replace this with a ticket lock, like MIPS. */
>> -
>> -#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
>> -
>> -static inline void arch_spin_unlock(arch_spinlock_t *lock)
>> -{
>> -	__asm__ __volatile__ (
>> -		"amoswap.w.rl x0, x0, %0"
>> -		: "=A" (lock->lock)
>> -		:: "memory");
>> -}
>> -
>> -static inline int arch_spin_trylock(arch_spinlock_t *lock)
>> -{
>> -	int tmp = 1, busy;
>> -
>> -	__asm__ __volatile__ (
>> -		"amoswap.w.aq %0, %2, %1"
>> -		: "=r" (busy), "+A" (lock->lock)
>> -		: "r" (tmp)
>> -		: "memory");
>> -
>> -	return !busy;
>> -}
>> -
>> -static inline void arch_spin_lock(arch_spinlock_t *lock)
>> -{
>> -	while (1) {
>> -		if (arch_spin_is_locked(lock))
>> -			continue;
>> -
>> -		if (arch_spin_trylock(lock))
>> -			break;
>> -	}
>> -}
>> -
>> -/***********************************************************/
>> -
>> -static inline void arch_read_lock(arch_rwlock_t *lock)
>> -{
>> -	int tmp;
>> -
>> -	__asm__ __volatile__(
>> -		"1:	lr.w	%1, %0\n"
>> -		"	bltz	%1, 1b\n"
>> -		"	addi	%1, %1, 1\n"
>> -		"	sc.w.aq	%1, %1, %0\n"
>> -		"	bnez	%1, 1b\n"
>> -		: "+A" (lock->lock), "=&r" (tmp)
>> -		:: "memory");
>> -}
>> -
>> -static inline void arch_write_lock(arch_rwlock_t *lock)
>> -{
>> -	int tmp;
>> -
>> -	__asm__ __volatile__(
>> -		"1:	lr.w	%1, %0\n"
>> -		"	bnez	%1, 1b\n"
>> -		"	li	%1, -1\n"
>> -		"	sc.w.aq	%1, %1, %0\n"
>> -		"	bnez	%1, 1b\n"
>> -		: "+A" (lock->lock), "=&r" (tmp)
>> -		:: "memory");
>> -}
>> -
>> -static inline int arch_read_trylock(arch_rwlock_t *lock)
>> -{
>> -	int busy;
>> -
>> -	__asm__ __volatile__(
>> -		"1:	lr.w	%1, %0\n"
>> -		"	bltz	%1, 1f\n"
>> -		"	addi	%1, %1, 1\n"
>> -		"	sc.w.aq	%1, %1, %0\n"
>> -		"	bnez	%1, 1b\n"
>> -		"1:\n"
>> -		: "+A" (lock->lock), "=&r" (busy)
>> -		:: "memory");
>> -
>> -	return !busy;
>> -}
>> -
>> -static inline int arch_write_trylock(arch_rwlock_t *lock)
>> -{
>> -	int busy;
>> -
>> -	__asm__ __volatile__(
>> -		"1:	lr.w	%1, %0\n"
>> -		"	bnez	%1, 1f\n"
>> -		"	li	%1, -1\n"
>> -		"	sc.w.aq	%1, %1, %0\n"
>> -		"	bnez	%1, 1b\n"
>> -		"1:\n"
>> -		: "+A" (lock->lock), "=&r" (busy)
>> -		:: "memory");
>> -
>> -	return !busy;
>> -}
>> -
>> -static inline void arch_read_unlock(arch_rwlock_t *lock)
>> -{
>> -	__asm__ __volatile__(
>> -		"amoadd.w.rl x0, %1, %0"
>> -		: "+A" (lock->lock)
>> -		: "r" (-1)
>> -		: "memory");
>> -}
>> -
>> -static inline void arch_write_unlock(arch_rwlock_t *lock)
>> -{
>> -	__asm__ __volatile__ (
>> -		"amoswap.w.rl x0, x0, %0"
>> -		: "=A" (lock->lock)
>> -		:: "memory");
>> -}
>> +#include <asm-generic/qspinlock.h>
>> +#include <asm-generic/qrwlock.h>
>>
>> #endif /* _ASM_RISCV_SPINLOCK_H */
>>
