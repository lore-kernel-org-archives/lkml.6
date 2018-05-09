Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935232AbeEINC4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:02:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43496 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935024AbeEINCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:02:53 -0400
Date: Wed, 9 May 2018 14:03:16 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180509130316.GB20254@arm.com>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509073327.GE12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Peter,

[I was at a conference last week and not reading email]

On Wed, May 09, 2018 at 09:33:27AM +0200, Peter Zijlstra wrote:
> On Sun, May 06, 2018 at 05:14:36AM -0700, tip-bot for Ingo Molnar wrote:
> > Commit-ID:  87d655a48dfe74293f72dc001ed042142cf00d44
> > Gitweb:     https://git.kernel.org/tip/87d655a48dfe74293f72dc001ed042142cf00d44
> > Author:     Ingo Molnar <mingo@kernel.org>
> > AuthorDate: Sat, 5 May 2018 10:36:35 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Sat, 5 May 2018 15:22:44 +0200
> > 
> > locking/atomics: Simplify the op definitions in atomic.h some more
> > 
> > Before:
> > 
> >  #ifndef atomic_fetch_dec_relaxed
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
> >  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
> >  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
> >  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
> >  # else
> >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> >  # endif
> >  #else
> >  # ifndef atomic_fetch_dec_acquire
> >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  # ifndef atomic_fetch_dec_release
> >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  #endif
> > 
> > After:
> > 
> >  #ifndef atomic_fetch_dec_relaxed
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
> >  #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
> >  #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
> >  #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
> >  # else
> >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> >  # endif
> >  #else
> >  # ifndef atomic_fetch_dec
> >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> >  # endif
> >  #endif
> > 
> > The idea is that because we already group these APIs by certain defines
> > such as atomic_fetch_dec_relaxed and atomic_fetch_dec in the primary
> > branches - we can do the same in the secondary branch as well.
> > 
> 
> ARGH, why did you merge this? It's pointless wankery, and doesn't solve
> anything wrt. the annotated atomic crap.
> 
> And if we're going to do codegen, we might as well all generate this
> anyway, so all this mucking about is a complete waste of time.

I have to agree here.

The reason we allowed the atomic primitives to be overridden on a
fine-grained basis is because there are often architecture-specific
barriers or instructions which mean that it is common to be able to provide
optimised atomics in some cases, but not others. Given that this stuff is
error-prone, having the generic code provide a safe and correct fallback
for all of the atomics that the architecture doesn't implement seemed like
a good thing to me. New architecture ports basically just have to provide
the weakest thing they have and a fence to get started, then they can
optimise where they can and not have to worry about the rest of the atomics
API.

With this patch, we're already seeing arch code (powerpc, risc-v) having
to add what is basically boiler-plate code, and it seems like we're just
doing this to make the generic code more readable! I'd much prefer we kept
the arch code simple, and took on the complexity burden in the generic code
where it can be looked after in one place.

For instrumentation, we're going to need to generate this stuff *anyway*,
so I think the readability argument mostly disappears.

Will
