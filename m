Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeEORKa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:10:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEORK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:10:29 -0400
Date: Tue, 15 May 2018 19:10:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515171021.GI12217@hirez.programming.kicks-ass.net>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net>
 <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 04:43:33PM +0100, Mark Rutland wrote:
> I put together the following while trying to avoid bash magic (i.e the
> arrays, and keeping the option of naming the params. My local copy of
> dash seems happy with it.

Very nice; clearly your sh foo is stronger than mine ;-)

> I *think* the table can encode enough info to generate atomic-long.h,
> atomic-instrumented.h, and the atomic.h ordering fallbacks. I'll need to
> flesh out the table and check that we don't end up clashing with
> some of the regular fallbacks.

Yes, details details ;-)

> # name	meta	args...
> #
> # Where meta contains a string of:
> # * B - bool: returns bool, fully ordered
> # * V - void: returns void, fully ordered

void retuns are relaxed

> # * I - int: returns base type, all orderings
> # * R - return: returns base type, all orderings
> # * F - fetch: returns base type, all orderings
> # * T - try: returns bool, all orderings

Little more verbose than mine, I think we can get there with X and XB
instead of I and T, but whatever :-)

> # Where args contains list of type[:name], where type is:
> # * v - pointer to atomic base type (atomic or atomic64)
> # * i - base type (int or long)
> # * I - pointer to base type (int or long)
> #
> add		VRF	i	v
> sub		VRF	i	v
> inc		VRF	v
> dec		VRF	v
> or		VF	i	v
> and		VF	i	v
> andnot		VF	i	v
> xor		VF	i	v
> xchg		I	v	i
> cmpxchg		I	v	i:old	i:new
> try_cmpxchg	T	v	I:old	i:new
> add_and_test	B	i	v
> sub_and_test	B	i	v
> dec_and_test	B	v
> inc_and_test	B	v

Cute, that [:name].
