Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeFEN63 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:58:29 -0400
Received: from foss.arm.com ([217.140.101.70]:56282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeFEN62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:58:28 -0400
Date: Tue, 5 Jun 2018 14:58:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        will.deacon@arm.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        dvyukov@google.com, glider@google.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, parri.andrea@gmail.com
Subject: Re: [PATCH 0/7] atomics: generate atomic headers
Message-ID: <20180605135823.iqantmeuht6aqotg@lakrids.cambridge.arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180605132949.GL12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132949.GL12258@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:29:49PM +0200, Peter Zijlstra wrote:
> On Tue, May 29, 2018 at 07:07:39PM +0100, Mark Rutland wrote:
> > Longer-term, I think things could be simplified if we were to rework the
> > headers such that we have:
> > 
> > * arch/*/include/asm/atomic.h providing arch_atomic_*().
> > 
> > * include/linux/atomic-raw.h building raw_atomic_*() atop of the
> >   arch_atomic_*() definitions, filling in gaps in the API. Having
> >   separate arch_ and raw_ namespaces would simplify the ifdeffery.
> > 
> > * include/linux/atomic.h building atomic_*() atop of the raw_atomic_*()
> >   definitions, complete with any instrumentation. Instrumenting at this
> >   level would lower the instrumentation overhead, and would not require
> >   any ifdeffery as the whole raw_atomic_*() API would be available.
> > 
> > ... I've avoided this for the time being due to the necessary churn in
> > arch code.
> 
> I'm not entirely sure I get the point of raw_atomic, we only need to
> instrument the arch_atomic bits, right?

Well, we only *need* to instrument the top-level atomic. KASAN (and
KTSAN/KMSAN) only care that we're touching a memory location, and not
how many times we happen to touch it.

e.g. when we have fallbacks we might have:

static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
{
	int c = atomic_read(v);

	do {
		if (unlikely(c == u))
			break;
	} while (!atomic_try_cmpxchg(v, &c, c + a));

	return c;
}

... where:

* atomic_read() is a simple wrapper around arch_atomic_read(), with
  instrumentation.

* atomic_try_cmpxchg() might be a simple wrapper around
  arch_atomic_try_cmpxchg, or a wrapper around atomic_cmpxchg(), which
  calls arch_atomic_cmpxchg(). Either way, one of the two is
  instrumented.

... so each call to atomic_fetch_add_unless() calls the instrumentation
at least once for the read, and at least once per retry. Whereas if
implemented in arch code, it only calls the instrumentation once.

> When those are done, everything that's build on top will also
> automagically be instrumented.

Sure, it all works, it's just less than optimal as above, and also means
that we have to duplicate the ifdeffery for optional atomics -- once in
the instrumented atomics, then in the "real" atomics.

Whereas if we filled in the raw atomics atop of the arch atomics,
everything above that can assume the whole API is present, no ifdeffery
required.

Thanks,
Mark.
