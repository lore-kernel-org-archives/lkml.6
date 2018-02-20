Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeBTNCz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:02:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeBTNCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:13 -0500
Date: Tue, 20 Feb 2018 10:51:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180220095158.GJ25181@hirez.programming.kicks-ass.net>
References: <20180217151413.GA3785@andrea>
 <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
 <20180220093346.GA5505@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220093346.GA5505@andrea>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 10:33:47AM +0100, Andrea Parri wrote:
> I'd like to continue to treat R[once] and R*[once] equally if possible.
> Given the (unconditional) smp_read_barrier_depends in READ_ONCE and in
> atomics, it seems reasonable to have it unconditionally in cmpxchg.
> 
> As with the following patch?
> 
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

ACK
