Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeEEJYo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:24:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeEEJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:24:43 -0400
Date: Sat, 5 May 2018 11:24:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
Message-ID: <20180505092438.GB12217@hirez.programming.kicks-ass.net>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505090403.p2ywuen42rnlwizq@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:04:03AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > So we could do the following simplification on top of that:
> > > 
> > >  #ifndef atomic_fetch_dec_relaxed
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
> > >  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
> > >  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
> > >  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
> > >  # else
> > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > >  # endif
> > >  #else
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  #endif
> > 
> > This would disallow an architecture to override just fetch_dec_release for
> > instance.
> 
> Couldn't such a crazy arch just define _all_ the 3 APIs in this group?
> That's really a small price and makes the place pay the complexity
> price that does the weirdness...

I would expect the pattern where it can do all 'release' and/or all
'acquire' variants special but cannot use the __atomic_op_*() wrappery.

> > I don't think there currently is any architecture that does that, but the
> > intent was to allow it to override anything and only provide defaults where it
> > does not.
> 
> I'd argue that if a new arch only defines one of these APIs that's probably a bug. 
> If they absolutely want to do it, they still can - by defining all 3 APIs.
> 
> So there's no loss in arch flexibility.

Ideally we'd generate the whole mess.. and then allowing these extra few
overrides is not a problem at all.

> > None of this takes away the giant trainwreck that is the annotated atomic stuff
> > though.
> > 
> > And I seriously hate this one:
> > 
> >   ba1c9f83f633 ("locking/atomic/x86: Un-macro-ify atomic ops implementation")
> > 
> > and will likely undo that the moment I need to change anything there.
> 
> If it makes the code more readable then I don't object - the problem was that the 
> instrumentation indirection made all that code much harder to follow.

Thing is, it is all the exact same loop, and bitrot mandates they drift
over time. When I cleaned up all the architectures I found plenty cases
where there were spurious differences between things.
