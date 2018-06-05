Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeFEJyK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:54:10 -0400
Received: from foss.arm.com ([217.140.101.70]:53990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeFEJyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:54:07 -0400
Date: Tue, 5 Jun 2018 10:53:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCHv2 05/16] atomics: prepare for atomic64_fetch_add_unless()
Message-ID: <20180605095357.64zgw3uq3py2pjs4@lakrids.cambridge.arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
 <20180529154346.3168-6-mark.rutland@arm.com>
 <20180605092637.GF12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605092637.GF12258@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:26:37AM +0200, Peter Zijlstra wrote:
> On Tue, May 29, 2018 at 04:43:35PM +0100, Mark Rutland wrote:
> >  /**
> > + * atomic64_add_unless - add unless the number is already a given value
> > + * @v: pointer of type atomic_t
> > + * @a: the amount to add to v...
> > + * @u: ...unless v is equal to u.
> > + *
> > + * Atomically adds @a to @v, so long as @v was not already @u.
> > + * Returns non-zero if @v was not @u, and zero otherwise.
> 
> I always get confused by that wording; would something like: "Returns
> true if the addition was done" not be more clear?

Sounds clearer to me; I just stole the wording from the existing
atomic_add_unless().

I guess you'll want similar for the conditional inc/dec ops, e.g.

/**
 * atomic_inc_not_zero - increment unless the number is zero
 * @v: pointer of type atomic_t
 *
 * Atomically increments @v by 1, so long as @v is non-zero.
 * Returns non-zero if @v was non-zero, and zero otherwise.
 */

> > + */
> > +#ifdef atomic64_fetch_add_unless
> > +static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
> 
> Do we want to make that a "bool' return?

I think so -- that's what the instrumented wrappers (and x86) do today
anyhow, and what I ended up using for the generated headers.

I'll spin a prep patch cleaning up the existing fallbacks in
<linux/atomic.h>, along with the comment fixup above, then rework the
additions likewise.

Thanks,
Mark.
