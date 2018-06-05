Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeFEN42 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:56:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36086 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFEN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:56:22 -0400
Date: Tue, 5 Jun 2018 15:56:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 2/7] atomics/treewide: rework ordering barriers
Message-ID: <20180605135616.GV12198@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-3-mark.rutland@arm.com>
 <20180605121623.GI12258@hirez.programming.kicks-ass.net>
 <20180605132802.lqkmbroqmcxergrr@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132802.lqkmbroqmcxergrr@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:28:02PM +0100, Mark Rutland wrote:
> On Tue, Jun 05, 2018 at 02:16:23PM +0200, Peter Zijlstra wrote:
> > and simply using smp_mb__{before,after}_atomic for the full fence, its
> > exactly what they were made for.
> 
> The snag is arch/alpha, whare we have:
> 
> /*
>  * To ensure dependency ordering is preserved for the _relaxed and
>  * _release atomics, an smp_read_barrier_depends() is unconditionally
>  * inserted into the _relaxed variants, which are used to build the
>  * barriered versions. To avoid redundant back-to-back fences, we can
>  * define the _acquire and _fence versions explicitly.
>  */
> #define __atomic_op_acquire(op, args...)        op##_relaxed(args)
> #define __atomic_op_fence                       __atomic_op_release
> 
> ... where alpha's smp_read_barrier_depends() is the same as
> smp_mb_after_atomic().
> 
> Since alpha's non-value-returning atomics do not have the
> smp_read_barrier_depends(), I can't just define an empty
> smp_mb_after_atomic().
> 
> Thoughts?

Bah, of course there had to be a misfit.

Something along these lines then:

 __atomic_acquire_fence
 __atomic_release_fence
 __atomic_mb_before
 __atomic_mb_after

?
