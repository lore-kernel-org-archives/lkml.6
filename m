Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeFEN2H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:28:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbeFEN2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:28:06 -0400
Date: Tue, 5 Jun 2018 14:28:02 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 2/7] atomics/treewide: rework ordering barriers
Message-ID: <20180605132802.lqkmbroqmcxergrr@lakrids.cambridge.arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-3-mark.rutland@arm.com>
 <20180605121623.GI12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605121623.GI12258@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:16:23PM +0200, Peter Zijlstra wrote:
> On Tue, May 29, 2018 at 07:07:41PM +0100, Mark Rutland wrote:
> > +#ifndef __atomic_mb__after_acquire
> > +#define __atomic_mb__after_acquire	smp_mb__after_atomic
> > +#endif
> > +
> > +#ifndef __atomic_mb__before_release
> > +#define __atomic_mb__before_release	smp_mb__before_atomic
> > +#endif
> > +
> > +#ifndef __atomic_mb__before_fence
> > +#define __atomic_mb__before_fence	smp_mb__before_atomic
> > +#endif
> > +
> > +#ifndef __atomic_mb__after_fence
> > +#define __atomic_mb__after_fence	smp_mb__after_atomic
> > +#endif
> 
> I really _really_ dislike those names.. because they imply providing an
> MB before/after something else.
> 
> But that is exactly what they do not.
> 
> How about:
> 
> 	__atomic_acquire_fence
> 	__atomic_release_fence
>
> for the acquire/release things,

Sure, those sound fine to me.

> and simply using smp_mb__{before,after}_atomic for the full fence, its
> exactly what they were made for.

The snag is arch/alpha, whare we have:

/*
 * To ensure dependency ordering is preserved for the _relaxed and
 * _release atomics, an smp_read_barrier_depends() is unconditionally
 * inserted into the _relaxed variants, which are used to build the
 * barriered versions. To avoid redundant back-to-back fences, we can
 * define the _acquire and _fence versions explicitly.
 */
#define __atomic_op_acquire(op, args...)        op##_relaxed(args)
#define __atomic_op_fence                       __atomic_op_release

... where alpha's smp_read_barrier_depends() is the same as
smp_mb_after_atomic().

Since alpha's non-value-returning atomics do not have the
smp_read_barrier_depends(), I can't just define an empty
smp_mb_after_atomic().

Thoughts?

Thanks,
Mark.
