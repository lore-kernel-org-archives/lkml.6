Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeC1LE7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:04:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC1LE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:04:58 -0400
Date: Wed, 28 Mar 2018 13:04:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from
 arch_spin_is_locked()
Message-ID: <20180328110436.GR4043@hirez.programming.kicks-ass.net>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1522109216.7364.30.camel@kernel.crashing.org>
 <20180327102521.GA7347@andrea>
 <87a7us3h66.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7us3h66.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 04:25:37PM +1100, Michael Ellerman wrote:
> That was tempting, but it leaves unfixed all the other potential
> callers, both in in-tree and out-of-tree and in code that's yet to be
> written.

So I myself don't care one teeny tiny bit about out of tree code, they
get to keep their pieces :-)

> Looking today nearly all the callers are debug code, where we probably
> don't need the barrier but we also don't care about the overhead of the
> barrier.

Still, code like:

	WARN_ON_ONCE(!spin_is_locked(foo));

will unconditionally emit that SYNC. So you might want to be a little
careful.

> Documenting it would definitely be good, but even then I'd be inclined
> to leave the barrier in our implementation. Matching the documented
> behaviour is one thing, but the actual real-world behaviour on well
> tested platforms (ie. x86) is more important.

By that argument you should switch your spinlock implementation to RCpc
and include that SYNC in either lock or unlock already ;-)

Ideally we'd completely eradicate the *_is_locked() crud from the
kernel, not sure how feasable that really is, but it's a good goal. At
that point the whole issue of the barrier becomes moot of course.
