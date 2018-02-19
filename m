Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeBSOBi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:01:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59478 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbeBSOBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:01:35 -0500
Date: Mon, 19 Feb 2018 14:01:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org
Subject: Re: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180219140142.GD30394@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216102100.GB25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216102100.GB25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Feb 16, 2018 at 11:21:00AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 06:20:49PM +0000, Will Deacon wrote:
> > On Thu, Feb 15, 2018 at 06:08:47PM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 15, 2018 at 03:29:33PM +0000, Will Deacon wrote:
> > > > +static inline void __clear_bit_unlock(unsigned int nr,
> > > > +				      volatile unsigned long *p)
> > > > +{
> > > > +	unsigned long old;
> > > >  
> > > > +	p += BIT_WORD(nr);
> > > > +	old = READ_ONCE(*p);
> > > > +	old &= ~BIT_MASK(nr);
> > > > +	smp_store_release(p, old);
> > > 
> > > This should be atomic_set_release() I think, for the special case where
> > > atomics are implemented with spinlocks, see the 'fun' case in
> > > Documentation/atomic_t.txt.
> > 
> > My understanding of __clear_bit_unlock is that there is guaranteed to be
> > no concurrent accesses to the same word, so why would it matter whether
> > locks are used to implement atomics?
> 
> 
> commit f75d48644c56a31731d17fa693c8175328957e1d
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Mar 9 12:40:54 2016 +0100
> 
>     bitops: Do not default to __clear_bit() for __clear_bit_unlock()
>     
>     __clear_bit_unlock() is a special little snowflake. While it carries the
>     non-atomic '__' prefix, it is specifically documented to pair with
>     test_and_set_bit() and therefore should be 'somewhat' atomic.
>     
>     Therefore the generic implementation of __clear_bit_unlock() cannot use
>     the fully non-atomic __clear_bit() as a default.
>     
>     If an arch is able to do better; is must provide an implementation of
>     __clear_bit_unlock() itself.
>     
>     Specifically, this came up as a result of hackbench livelock'ing in
>     slab_lock() on ARC with SMP + SLUB + !LLSC.
>     
>     The issue was incorrect pairing of atomic ops.
>     
>      slab_lock() -> bit_spin_lock() -> test_and_set_bit()
>      slab_unlock() -> __bit_spin_unlock() -> __clear_bit()
>     
>     The non serializing __clear_bit() was getting "lost"
>     
>      80543b8e:      ld_s       r2,[r13,0] <--- (A) Finds PG_locked is set
>      80543b90:      or         r3,r2,1    <--- (B) other core unlocks right here
>      80543b94:      st_s       r3,[r13,0] <--- (C) sets PG_locked (overwrites unlock)

Ah, so it's problematic for the case where atomics are built using locks.
Got it. I'll err on the side of caution here and have the asm-generic header
(which should be bitops/lock.h not bitops/atomic.h) conditionally define
__clear_bit_unlock as clear_bit_lock unless the architecture has provided
its own implementation.

Thanks,

Will
