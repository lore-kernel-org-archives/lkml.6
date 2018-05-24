Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935576AbeEXBuS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:50:18 -0400
Received: from ozlabs.org ([203.11.71.1]:32915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935218AbeEXBuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:50:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/13] atomics/powerpc: define atomic64_fetch_add_unless()
In-Reply-To: <20180523133533.1076-11-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com> <20180523133533.1076-11-mark.rutland@arm.com>
Date: Thu, 24 May 2018 11:50:15 +1000
Message-ID: <87lgc9styg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> writes:
> As a step towards unifying the atomic/atomic64/atomic_long APIs, this
> patch converts the arch/powerpc implementation of atomic64_add_unless()
> into an implementation of atomic64_fetch_add_unless().
>
> A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
> this, provided it is given a preprocessor definition.
>
> No functional change is intended as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/atomic.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index b5646c079c16..233dbf31911c 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -525,7 +525,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
>  #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
>  
>  /**
> - * atomic64_add_unless - add unless the number is a given value
> + * atomic64_fetch_add_unless - add unless the number is a given value
>   * @v: pointer of type atomic64_t
>   * @a: the amount to add to v...
>   * @u: ...unless v is equal to u.
> @@ -533,13 +533,13 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
>   * Atomically adds @a to @v, so long as it was not @u.
>   * Returns the old value of @v.

Comment was wrong, but is right now. Win.

>   */
> -static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> +static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
>  {
>  	long t;
>  
>  	__asm__ __volatile__ (
>  	PPC_ATOMIC_ENTRY_BARRIER
> -"1:	ldarx	%0,0,%1		# atomic_fetch_add_unless\n\
> +"1:	ldarx	%0,0,%1		# atomic64_fetch_add_unless\n\
>  	cmpd	0,%0,%3 \n\
>  	beq	2f \n\
>  	add	%0,%2,%0 \n"

We overwrite t here with the new value ...

> @@ -552,8 +552,9 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)

But then in the context above here we do:

"	subf	%0,%2,%0 \n\

Which puts the old value back into t.

>  	: "r" (&v->counter), "r" (a), "r" (u)
>  	: "cc", "memory");
>  
> -	return t != u;
> +	return t;

ie. this is correct.

I'm not sure why we wrote it that way, to add and then subtract, but
that's not your problem.

So LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
