Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeCIQjN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:39:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33656 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751147AbeCIQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:39:12 -0500
Date: Fri, 9 Mar 2018 11:39:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrea Parri <parri.andrea@gmail.com>
cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] riscv/atomic: Strengthen implementations with
 fences
In-Reply-To: <1520597620-16650-1-git-send-email-parri.andrea@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1803091129420.2256-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Andrea Parri wrote:

> Atomics present the same issue with locking: release and acquire
> variants need to be strengthened to meet the constraints defined
> by the Linux-kernel memory consistency model [1].
> 
> Atomics present a further issue: implementations of atomics such
> as atomic_cmpxchg() and atomic_add_unless() rely on LR/SC pairs,
> which do not give full-ordering with .aqrl; for example, current
> implementations allow the "lr-sc-aqrl-pair-vs-full-barrier" test
> below to end up with the state indicated in the "exists" clause.
> 
> In order to "synchronize" LKMM and RISC-V's implementation, this
> commit strengthens the implementations of the atomics operations
> by replacing .rl and .aq with the use of ("lightweigth") fences,
> and by replacing .aqrl LR/SC pairs in sequences such as:
> 
>   0:      lr.w.aqrl  %0, %addr
>           bne        %0, %old, 1f
>           ...
>           sc.w.aqrl  %1, %new, %addr
>           bnez       %1, 0b
>   1:
> 
> with sequences of the form:
> 
>   0:      lr.w       %0, %addr
>           bne        %0, %old, 1f
>           ...
>           sc.w.rl    %1, %new, %addr   /* SC-release   */
>           bnez       %1, 0b
>           fence      rw, rw            /* "full" fence */
>   1:
> 
> following Daniel's suggestion.
> 
> These modifications were validated with simulation of the RISC-V
> memory consistency model.
> 
> C lr-sc-aqrl-pair-vs-full-barrier
> 
> {}
> 
> P0(int *x, int *y, atomic_t *u)
> {
> 	int r0;
> 	int r1;
> 
> 	WRITE_ONCE(*x, 1);
> 	r0 = atomic_cmpxchg(u, 0, 1);
> 	r1 = READ_ONCE(*y);
> }
> 
> P1(int *x, int *y, atomic_t *v)
> {
> 	int r0;
> 	int r1;
> 
> 	WRITE_ONCE(*y, 1);
> 	r0 = atomic_cmpxchg(v, 0, 1);
> 	r1 = READ_ONCE(*x);
> }
> 
> exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)

There's another aspect to this imposed by the LKMM, and I'm not sure
whether your patch addresses it.  You add a fence after the cmpxchg
operation but nothing before it.  So what would happen with the 
following litmus test (which the LKMM forbids)?

C SB-atomic_cmpxchg-mb

{}

P0(int *x, int *y)
{
	int r0;

	WRITE_ONCE(*x, 1);
	r0 = atomic_cmpxchg(y, 0, 0);
}

P1(int *x, int *y)
{
	int r1;

	WRITE_ONCE(*y, 1);
	smp_mb();
	r1 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r1=0)

This is yet another illustration showing that full fences are stronger 
than cominations of release + acquire.

Alan Stern
