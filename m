Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeBTPiv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:38:51 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:58996 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752381AbeBTPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:38:50 -0500
Date: Tue, 20 Feb 2018 10:38:49 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrea Parri <parri.andrea@gmail.com>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep, smp_read_barrier_depends,
 and lockless_dereference
In-Reply-To: <20180220093346.GA5505@andrea>
Message-ID: <Pine.LNX.4.44L0.1802201031120.1428-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Andrea Parri wrote:

> > This leaves us with a question: Do we want to change the kernel by
> > adding memory barriers after unsuccessful RMW operations on Alpha, or
> > do we want to change the model by excluding such operations from
> > address dependencies?
> 
> I'd like to continue to treat R[once] and R*[once] equally if possible.
> Given the (unconditional) smp_read_barrier_depends in READ_ONCE and in
> atomics, it seems reasonable to have it unconditionally in cmpxchg.
> 
> As with the following patch?

Yes, this seems reasonable to me.  If Will gives it his "Acked-by"  
to go with Peter's, you should submit it to Ingo Molnar.

And once this is made, there shouldn't be any trouble with the proposed 
patch for the memory model.

Alan

>   Andrea
> 
> ---
> diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
> index 68dfb3cb71454..e2660866ce972 100644
> --- a/arch/alpha/include/asm/xchg.h
> +++ b/arch/alpha/include/asm/xchg.h
> @@ -128,10 +128,9 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
>   * indicated by comparing RETURN with OLD.
>   *
> - * The memory barrier should be placed in SMP only when we actually
> - * make the change. If we don't change anything (so if the returned
> - * prev is equal to old) then we aren't acquiring anything new and
> - * we don't need any memory barrier as far I can tell.
> + * The memory barrier is placed in SMP unconditionally, in order to
> + * guarantee that dependency ordering is preserved when a dependency
> + * is headed by an unsuccessful operation.
>   */
>  
>  static inline unsigned long
> @@ -150,8 +149,8 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%4)\n"
>  	"	beq	%2,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br	1b\n"
>  	".previous"
> @@ -177,8 +176,8 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%4)\n"
>  	"	beq	%2,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br	1b\n"
>  	".previous"
> @@ -200,8 +199,8 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
>  	"	mov %4,%1\n"
>  	"	stl_c %1,%2\n"
>  	"	beq %1,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br 1b\n"
>  	".previous"
> @@ -223,8 +222,8 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
>  	"	mov %4,%1\n"
>  	"	stq_c %1,%2\n"
>  	"	beq %1,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br 1b\n"
>  	".previous"
> 
> 
> > 
> > Note that operations like atomic_add_unless() already include memory 
> > barriers.
> > 
> > Alan
