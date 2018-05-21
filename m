Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeEURSm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:18:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752943AbeEURSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:18:40 -0400
Message-ID: <c540dd519065316c859e5cb1290de7f5041cb816.camel@redhat.com>
Subject: Re: arm64: add missing early clobber in atomic64_dec_if_positive()
From: Mark Salter <msalter@redhat.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dave.martin@arm.com, robin.murphy@arm.com, peterz@infradead.org
Date: Mon, 21 May 2018 13:18:39 -0400
In-Reply-To: <20180521170022.GD21034@arm.com>
References: <20180520001726.27808-1-msalter@redhat.com>
         <20180521170022.GD21034@arm.com>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-21 at 18:00 +0100, Will Deacon wrote:
> Hi Mark,
> 
> Thanks for reporting this.
> 
> On Sat, May 19, 2018 at 08:17:26PM -0400, Mark Salter wrote:
> > When running a kernel compiled with gcc8 on a machine using LSE, I
> > get:
> > 
> >  Unable to handle kernel paging request at virtual address 11111122222221
> 
> [...]
> 
> > The fault happens at the casal insn of inlined atomic64_dec_if_positive().
> > The inline asm code in that function has:
> > 
> > 	"1:	ldr	x30, %[v]\n"
> > 	"	subs	%[ret], x30, #1\n"
> > 	"	b.lt	2f\n"
> > 	"	casal	x30, %[ret], %[v]\n"
> > 	"	sub	x30, x30, #1\n"
> > 	"	sub	x30, x30, %[ret]\n"
> > 	"	cbnz	x30, 1b\n"
> > 	"2:")
> > 	: [ret] "+r" (x0), [v] "+Q" (v->counter)
> > 
> > gcc8 used register x0 for both [ret] and [v] and the subs was
> > clobbering [v] before it was used for casal. Gcc is free to do
> > this because [ret] lacks an early clobber modifier. So add one
> > to tell gcc a separate register is needed for [v].
> 
> Oh blimey, it looks like GCC is realising that counter is at offset 0
> of atomic_t and therefore assigns the same register for [ret] and [v],
> which is actually forced to be x0 by the 'register' local variable in
> C code. The "+Q" constraint only says that the memory is read/write, so
> the pointer is fair game.
> 
> I agree with your fix, but we also need to fix up the other places relying
> on this. Patch below -- please yell if you think I missed any.

I looked at the other places but figured they were okay because we're
explicitly using separate registers. But I suppose the early clobber
is the right thing to do in any case.

> 
> Cheers,
> 
> Will
> 
> --->8
> 
> From 3d9417b28ed2588c33b7e54e6681c88f0224201a Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Mon, 21 May 2018 17:44:57 +0100
> Subject: [PATCH] arm64: lse: Add early clobbers to some input/output asm
>  operands
> 
> For LSE atomics that read and write a register operand, we need to
> ensure that these operands are annotated as "early clobber" if the
> register is written before all of the input operands have been consumed.
> Failure to do so can result in the compiler allocating the same register
> to both operands, leading to splats such as:
> 
>  Unable to handle kernel paging request at virtual address 11111122222221
>  [...]
>  x1 : 1111111122222222 x0 : 1111111122222221
>  Process swapper/0 (pid: 1, stack limit = 0x000000008209f908)
>  Call trace:
>   test_atomic64+0x1360/0x155c
> 
> where x0 has been allocated as both the value to be stored and also the
> atomic_t pointer.
> 
> This patch adds the missing clobbers.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Reported-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/atomic_lse.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index 9ef0797380cb..f9b0b09153e0 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -117,7 +117,7 @@ static inline void atomic_and(int i, atomic_t *v)
>  	/* LSE atomics */
>  	"	mvn	%w[i], %w[i]\n"
>  	"	stclr	%w[i], %[v]")
> -	: [i] "+r" (w0), [v] "+Q" (v->counter)
> +	: [i] "+&r" (w0), [v] "+Q" (v->counter)
>  	: "r" (x1)
>  	: __LL_SC_CLOBBERS);
>  }
> @@ -135,7 +135,7 @@ static inline int atomic_fetch_and##name(int i, atomic_t *v)		\
>  	/* LSE atomics */						\
>  	"	mvn	%w[i], %w[i]\n"					\
>  	"	ldclr" #mb "	%w[i], %w[i], %[v]")			\
> -	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
> +	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
>  	: "r" (x1)							\
>  	: __LL_SC_CLOBBERS, ##cl);					\
>  									\
> @@ -161,7 +161,7 @@ static inline void atomic_sub(int i, atomic_t *v)
>  	/* LSE atomics */
>  	"	neg	%w[i], %w[i]\n"
>  	"	stadd	%w[i], %[v]")
> -	: [i] "+r" (w0), [v] "+Q" (v->counter)
> +	: [i] "+&r" (w0), [v] "+Q" (v->counter)
>  	: "r" (x1)
>  	: __LL_SC_CLOBBERS);
>  }
> @@ -180,7 +180,7 @@ static inline int atomic_sub_return##name(int i, atomic_t *v)		\
>  	"	neg	%w[i], %w[i]\n"					\
>  	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
>  	"	add	%w[i], %w[i], w30")				\
> -	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
> +	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
>  	: "r" (x1)							\
>  	: __LL_SC_CLOBBERS , ##cl);					\
>  									\
> @@ -207,7 +207,7 @@ static inline int atomic_fetch_sub##name(int i, atomic_t *v)		\
>  	/* LSE atomics */						\
>  	"	neg	%w[i], %w[i]\n"					\
>  	"	ldadd" #mb "	%w[i], %w[i], %[v]")			\
> -	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
> +	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
>  	: "r" (x1)							\
>  	: __LL_SC_CLOBBERS, ##cl);					\
>  									\
> @@ -314,7 +314,7 @@ static inline void atomic64_and(long i, atomic64_t *v)
>  	/* LSE atomics */
>  	"	mvn	%[i], %[i]\n"
>  	"	stclr	%[i], %[v]")
> -	: [i] "+r" (x0), [v] "+Q" (v->counter)
> +	: [i] "+&r" (x0), [v] "+Q" (v->counter)
>  	: "r" (x1)
>  	: __LL_SC_CLOBBERS);
>  }
> @@ -332,7 +332,7 @@ static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
>  	/* LSE atomics */						\
>  	"	mvn	%[i], %[i]\n"					\
>  	"	ldclr" #mb "	%[i], %[i], %[v]")			\
> -	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
> +	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
>  	: "r" (x1)							\
>  	: __LL_SC_CLOBBERS, ##cl);					\
>  									\
> @@ -358,7 +358,7 @@ static inline void atomic64_sub(long i, atomic64_t *v)
>  	/* LSE atomics */
>  	"	neg	%[i], %[i]\n"
>  	"	stadd	%[i], %[v]")
> -	: [i] "+r" (x0), [v] "+Q" (v->counter)
> +	: [i] "+&r" (x0), [v] "+Q" (v->counter)
>  	: "r" (x1)
>  	: __LL_SC_CLOBBERS);
>  }
> @@ -377,7 +377,7 @@ static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
>  	"	neg	%[i], %[i]\n"					\
>  	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
>  	"	add	%[i], %[i], x30")				\
> -	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
> +	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
>  	: "r" (x1)							\
>  	: __LL_SC_CLOBBERS, ##cl);					\
>  									\
> @@ -404,7 +404,7 @@ static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
>  	/* LSE atomics */						\
>  	"	neg	%[i], %[i]\n"					\
>  	"	ldadd" #mb "	%[i], %[i], %[v]")			\
> -	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
> +	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
>  	: "r" (x1)							\
>  	: __LL_SC_CLOBBERS, ##cl);					\
>  									\
> @@ -435,7 +435,7 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
>  	"	sub	x30, x30, %[ret]\n"
>  	"	cbnz	x30, 1b\n"
>  	"2:")
> -	: [ret] "+r" (x0), [v] "+Q" (v->counter)
> +	: [ret] "+&r" (x0), [v] "+Q" (v->counter)
>  	:
>  	: __LL_SC_CLOBBERS, "cc", "memory");
>  
> @@ -516,7 +516,7 @@ static inline long __cmpxchg_double##name(unsigned long old1,		\
>  	"	eor	%[old1], %[old1], %[oldval1]\n"			\
>  	"	eor	%[old2], %[old2], %[oldval2]\n"			\
>  	"	orr	%[old1], %[old1], %[old2]")			\
> -	: [old1] "+r" (x0), [old2] "+r" (x1),				\
> +	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
>  	  [v] "+Q" (*(unsigned long *)ptr)				\
>  	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
>  	  [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)		\
