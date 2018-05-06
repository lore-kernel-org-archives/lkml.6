Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeEFOQB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 10:16:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52615 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeEFOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 10:15:59 -0400
X-Google-Smtp-Source: AB8JxZovMuaSbotbbUN/U7Q7EiflLD3gs7dUMVMpjrVjpkOLVBrd1WicjhiFdKd+SuT9wmY2SIqRhA==
Date: Sun, 6 May 2018 16:15:52 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/atomics: Combine the atomic_andnot() and
 atomic64_andnot() API definitions
Message-ID: <20180506141552.GA28937@andrea>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <20180505085445.cmdnqh6xpnpfoqzb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505085445.cmdnqh6xpnpfoqzb@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> From f5efafa83af8c46b9e81b010b46caeeadb450179 Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@kernel.org>
> Date: Sat, 5 May 2018 10:46:41 +0200
> Subject: [PATCH] locking/atomics: Combine the atomic_andnot() and atomic64_andnot() API definitions
> 
> The atomic_andnot() and atomic64_andnot() are defined in 4 separate groups
> spred out in the atomic.h header:
> 
>  #ifdef atomic_andnot
>  ...
>  #endif /* atomic_andnot */
>  ...
>  #ifndef atomic_andnot
>  ...
>  #endif
>  ...
>  #ifdef atomic64_andnot
>  ...
>  #endif /* atomic64_andnot */
>  ...
>  #ifndef atomic64_andnot
>  ...
>  #endif
> 
> Combine them into unify them into two groups:

Nit: "Combine them into unify them into"

  Andrea


> 
>  #ifdef atomic_andnot
>  #else
>  #endif
> 
>  ...
> 
>  #ifdef atomic64_andnot
>  #else
>  #endif
> 
> So that one API group is defined in a single place within the header.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/atomic.h | 72 +++++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 352ecc72d7f5..1176cf7c6f03 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -205,22 +205,6 @@
>  # endif
>  #endif
>  
> -#ifdef atomic_andnot
> -
> -#ifndef atomic_fetch_andnot_relaxed
> -# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
> -# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
> -# define atomic_fetch_andnot_release		atomic_fetch_andnot
> -#else
> -# ifndef atomic_fetch_andnot
> -#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
> -#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
> -#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
> -# endif
> -#endif
> -
> -#endif /* atomic_andnot */
> -
>  #ifndef atomic_fetch_xor_relaxed
>  # define atomic_fetch_xor_relaxed		atomic_fetch_xor
>  # define atomic_fetch_xor_acquire		atomic_fetch_xor
> @@ -338,7 +322,22 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
>  # define atomic_inc_not_zero(v)			atomic_add_unless((v), 1, 0)
>  #endif
>  
> -#ifndef atomic_andnot
> +#ifdef atomic_andnot
> +
> +#ifndef atomic_fetch_andnot_relaxed
> +# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
> +# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
> +# define atomic_fetch_andnot_release		atomic_fetch_andnot
> +#else
> +# ifndef atomic_fetch_andnot
> +#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
> +#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
> +#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
> +# endif
> +#endif
> +
> +#else /* !atomic_andnot: */
> +
>  static inline void atomic_andnot(int i, atomic_t *v)
>  {
>  	atomic_and(~i, v);
> @@ -363,7 +362,8 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
>  {
>  	return atomic_fetch_and_release(~i, v);
>  }
> -#endif
> +
> +#endif /* !atomic_andnot */
>  
>  /**
>   * atomic_inc_not_zero_hint - increment if not null
> @@ -600,22 +600,6 @@ static inline int atomic_dec_if_positive(atomic_t *v)
>  # endif
>  #endif
>  
> -#ifdef atomic64_andnot
> -
> -#ifndef atomic64_fetch_andnot_relaxed
> -# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
> -# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
> -# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
> -#else
> -# ifndef atomic64_fetch_andnot
> -#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
> -#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
> -#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
> -# endif
> -#endif
> -
> -#endif /* atomic64_andnot */
> -
>  #ifndef atomic64_fetch_xor_relaxed
>  # define atomic64_fetch_xor_relaxed		atomic64_fetch_xor
>  # define atomic64_fetch_xor_acquire		atomic64_fetch_xor
> @@ -672,7 +656,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
>  # define atomic64_try_cmpxchg_release		atomic64_try_cmpxchg
>  #endif
>  
> -#ifndef atomic64_andnot
> +#ifdef atomic64_andnot
> +
> +#ifndef atomic64_fetch_andnot_relaxed
> +# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
> +# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
> +# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
> +#else
> +# ifndef atomic64_fetch_andnot
> +#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
> +#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
> +#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
> +# endif
> +#endif
> +
> +#else /* !atomic64_andnot: */
> +
>  static inline void atomic64_andnot(long long i, atomic64_t *v)
>  {
>  	atomic64_and(~i, v);
> @@ -697,7 +696,8 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
>  {
>  	return atomic64_fetch_and_release(~i, v);
>  }
> -#endif
> +
> +#endif /* !atomic64_andnot */
>  
>  #define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
>  #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
