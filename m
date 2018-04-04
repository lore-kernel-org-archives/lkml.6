Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDDK2P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:28:15 -0400
Received: from ozlabs.org ([103.22.144.67]:39549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDDK2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:28:14 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from arch_spin_is_locked()
In-Reply-To: <20180328110436.GR4043@hirez.programming.kicks-ass.net>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com> <1522109216.7364.30.camel@kernel.crashing.org> <20180327102521.GA7347@andrea> <87a7us3h66.fsf@concordia.ellerman.id.au> <20180328110436.GR4043@hirez.programming.kicks-ass.net>
Date: Wed, 04 Apr 2018 20:28:11 +1000
Message-ID: <87woxnmfk4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Mar 28, 2018 at 04:25:37PM +1100, Michael Ellerman wrote:
>> That was tempting, but it leaves unfixed all the other potential
>> callers, both in in-tree and out-of-tree and in code that's yet to be
>> written.
>
> So I myself don't care one teeny tiny bit about out of tree code, they
> get to keep their pieces :-)

I agree, but somehow I still end up seeing the pieces from time to time :)

>> Looking today nearly all the callers are debug code, where we probably
>> don't need the barrier but we also don't care about the overhead of the
>> barrier.
>
> Still, code like:
>
> 	WARN_ON_ONCE(!spin_is_locked(foo));
>
> will unconditionally emit that SYNC. So you might want to be a little
> careful.
>
>> Documenting it would definitely be good, but even then I'd be inclined
>> to leave the barrier in our implementation. Matching the documented
>> behaviour is one thing, but the actual real-world behaviour on well
>> tested platforms (ie. x86) is more important.
>
> By that argument you should switch your spinlock implementation to RCpc
> and include that SYNC in either lock or unlock already ;-)

Yes!

Unfortunately performance is also a thing :/

I ran the numbers again, switching to sync on unlock is a 30% hit for an
uncontended lock/unlock loop. Which is not going to make me any friends.

> Ideally we'd completely eradicate the *_is_locked() crud from the
> kernel, not sure how feasable that really is, but it's a good goal. At
> that point the whole issue of the barrier becomes moot of course.

Yeah that would be good. The majority of them could/should be using
lockdep_is_held(), though there are still a handful that are actually
using it in non-debug logic.

cheers
