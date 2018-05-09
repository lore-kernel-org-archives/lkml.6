Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756221AbeEIHdl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:33:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeEIHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:33:39 -0400
Date: Wed, 9 May 2018 09:33:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        will.deacon@arm.com, mark.rutland@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180509073327.GE12217@hirez.programming.kicks-ass.net>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 05:14:36AM -0700, tip-bot for Ingo Molnar wrote:
> Commit-ID:  87d655a48dfe74293f72dc001ed042142cf00d44
> Gitweb:     https://git.kernel.org/tip/87d655a48dfe74293f72dc001ed042142cf00d44
> Author:     Ingo Molnar <mingo@kernel.org>
> AuthorDate: Sat, 5 May 2018 10:36:35 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sat, 5 May 2018 15:22:44 +0200
> 
> locking/atomics: Simplify the op definitions in atomic.h some more
> 
> Before:
> 
>  #ifndef atomic_fetch_dec_relaxed
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
>  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
>  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
>  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
>  # else
>  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
>  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
>  #  define atomic_fetch_dec_release		atomic_fetch_dec
>  # endif
>  #else
>  # ifndef atomic_fetch_dec_acquire
>  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  # ifndef atomic_fetch_dec_release
>  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  #endif
> 
> After:
> 
>  #ifndef atomic_fetch_dec_relaxed
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
>  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
>  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
>  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
>  # else
>  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
>  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
>  #  define atomic_fetch_dec_release		atomic_fetch_dec
>  # endif
>  #else
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  #endif
> 
> The idea is that because we already group these APIs by certain defines
> such as atomic_fetch_dec_relaxed and atomic_fetch_dec in the primary
> branches - we can do the same in the secondary branch as well.
> 

ARGH, why did you merge this? It's pointless wankery, and doesn't solve
anything wrt. the annotated atomic crap.

And if we're going to do codegen, we might as well all generate this
anyway, so all this mucking about is a complete waste of time.
