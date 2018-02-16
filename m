Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933600AbeBPKf0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:35:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53988 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeBPKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:35:25 -0500
Date: Fri, 16 Feb 2018 11:35:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org
Subject: Re: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180216103520.GC25201@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215182049.GC15274@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 06:20:49PM +0000, Will Deacon wrote:

> > The only other comment is that I think it would be better if you use
> > atomic_t instead of atomic_long_t. It would just mean changing
> > BIT_WORD() and BIT_MASK().
> 
> It would make it pretty messy for big-endian architectures, I think...

Urgh, the big.little indians strike again.. Bah I always forget about
that.

#define BIT_U32_MASK(nr)	(1UL << ((nr) % 32))
#define BIT_U32_WORD(nr)	(((nr) / 32) ^ (4 * __BIG_ENDIAN__))

Or something like that might work, but I always get these things wrong.

> > The reason is that we generate a pretty sane set of atomic_t primitives
> > as long as the architecture supplies cmpxchg, but atomic64 defaults to
> > utter crap, even on 64bit platforms.
> 
> I think all the architectures using this today are 32-bit:
> 
> blackfin
> c6x
> cris
> metag
> openrisc
> sh
> xtensa
> 
> and I don't know how much we should care about optimising the generic atomic
> bitops for 64-bit architectures that rely on spinlocks for 64-bit atomics!

You're probably right, but it just bugs me that we default to such
horrible crap. Arguably we should do a better default for atomic64_t on
64bit archs. But that's for another time.
