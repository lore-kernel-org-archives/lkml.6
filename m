Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeEURNJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:13:09 -0400
Received: from foss.arm.com ([217.140.101.70]:53920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753082AbeEURNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:13:05 -0400
Date: Mon, 21 May 2018 18:12:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180521171259.h6xsenh57zbumcox@lakrids.cambridge.arm.com>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net>
 <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
 <20180515171021.GI12217@hirez.programming.kicks-ass.net>
 <20180515175307.m4xbkbicdrzo4qhb@lakrids.cambridge.arm.com>
 <20180515181136.GR12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515181136.GR12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:11:36PM +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 06:53:08PM +0100, Mark Rutland wrote:
> > On Tue, May 15, 2018 at 07:10:21PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 15, 2018 at 04:43:33PM +0100, Mark Rutland wrote:
> > > > I *think* the table can encode enough info to generate atomic-long.h,
> > > > atomic-instrumented.h, and the atomic.h ordering fallbacks. I'll need to
> > > > flesh out the table and check that we don't end up clashing with
> > > > some of the regular fallbacks.
> > > 
> > > Yes, details details ;-)
> > > 
> > > > # name	meta	args...
> > > > #
> > > > # Where meta contains a string of:
> > > > # * B - bool: returns bool, fully ordered
> > > > # * V - void: returns void, fully ordered
> > > 
> > > void retuns are relaxed
> > 
> > How about:
> > 
> >   V - void: returns void, no ordering variants (implicitly relaxed)
> 
> Works for me.
> 
> > > > # * I - int: returns base type, all orderings
> > > > # * R - return: returns base type, all orderings
> > > > # * F - fetch: returns base type, all orderings
> > > > # * T - try: returns bool, all orderings
> > > 
> > > Little more verbose than mine, I think we can get there with X and XB
> > > instead of I and T, but whatever :-)
> > 
> > Mhmm. I found it easier to do switch-like things this way, but it works
> > regardless.
> 
> I'm a minimalist, but yeah whatever ;-)
> 
> > > > # Where args contains list of type[:name], where type is:
> > > > # * v - pointer to atomic base type (atomic or atomic64)
> > > > # * i - base type (int or long)
> > > > # * I - pointer to base type (int or long)
> > > > #
> > > > add		VRF	i	v
> > > > sub		VRF	i	v
> > > > inc		VRF	v
> > > > dec		VRF	v
> > > > or		VF	i	v
> > > > and		VF	i	v
> > > > andnot		VF	i	v
> > > > xor		VF	i	v
> > > > xchg		I	v	i
> > > > cmpxchg		I	v	i:old	i:new
> > > > try_cmpxchg	T	v	I:old	i:new
> > > > add_and_test	B	i	v
> > > > sub_and_test	B	i	v
> > > > dec_and_test	B	v
> > > > inc_and_test	B	v
> 
> we might also want:
> 
> set		V	v	i
> set_release	V	v	i
> read		I	v
> read_acquire	I	v

Indeed!

I concurrently fiddled with this and came to the below. I special-cased
set and read for the purpose of preserving the acquire/release semantics
in the meta table, but either way works.

----
# name	meta	args...
#
# Where meta contains a string of variants to generate.
# Upper-case implies _{acquire,release,relaxed} variants.
# Valid meta values are:
# * B/b	- bool: returns bool
# * v	- void: returns void
# * I/i	- int: returns base type
# * R	- return: returns base type (has _return variants)
# * F	- fetch: returns base type (has fetch_ variants)
# * l	- load: returns base type (has _acquire order variant)
# * s	- store: returns void (has _release order variant)
#
# Where args contains list of type[:name], where type is:
# * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
# * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
# * i	- base type (int/s64/long)
# * I	- pointer to base type (int/s64/long)
#
read		l	cv
set		s	v	i
add		vRF	i	v
sub		vRF	i	v
inc		vRF	v
dec		vRF	v
and		vF	i	v
andnot		vF	i	v
or		vF	i	v
xor		vF	i	v
xchg		I	v	i
cmpxchg		I	v	i:old	i:new
try_cmpxchg	B	v	I:old	i:new
sub_and_test	b	i	v
dec_and_test	b	v
inc_and_test	b	v
add_negative	i	i	v
add_unless	i	v	i:a	i:u
inc_not_zero	i	v
----

... which seems to be sufficient to give me a working atomic-long.h
using [1,2].

I have *most* of the atomic.h ordering variant generation, and most of
atomic-instrumented.h, modulo a few special cases to be handled.

I'm also not sure which functions are intended to be mandatory. I had
hoped I could just wrap every atomic_foo in an ifdef, but not all arches
have a #define for all functions, so that needs to be handled somehow.

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/generated&id=6b44ecd77dbb7c3e518260d2e223a29c64c85740
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/generated&id=432d8259040a67b7234c869c9298d042515958a2
