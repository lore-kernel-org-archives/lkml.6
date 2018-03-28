Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeC1FZl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 01:25:41 -0400
Received: from ozlabs.org ([103.22.144.67]:44029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeC1FZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 01:25:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from arch_spin_is_locked()
In-Reply-To: <20180327102521.GA7347@andrea>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com> <1522109216.7364.30.camel@kernel.crashing.org> <20180327102521.GA7347@andrea>
Date: Wed, 28 Mar 2018 16:25:37 +1100
Message-ID: <87a7us3h66.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <andrea.parri@amarulasolutions.com> writes:
> On Tue, Mar 27, 2018 at 11:06:56AM +1100, Benjamin Herrenschmidt wrote:
>> On Mon, 2018-03-26 at 12:37 +0200, Andrea Parri wrote:
>> > Commit 51d7d5205d338 ("powerpc: Add smp_mb() to arch_spin_is_locked()")
>> > added an smp_mb() to arch_spin_is_locked(), in order to ensure that
>> > 
>> > 	Thread 0			Thread 1
>> > 
>> > 	spin_lock(A);			spin_lock(B);
>> > 	r0 = spin_is_locked(B)		r1 = spin_is_locked(A);
>> > 
>> > never ends up with r0 = r1 = 0, and reported one example (in ipc/sem.c)
>> > relying on such guarantee.
>> > 
>> > It's however understood (and undocumented) that spin_is_locked() is not
>> > required to ensure such ordering guarantee,
>> 
>> Shouldn't we start by documenting it ?
>
> I do sympathize with your concern about the documentation! ;) The patch in
> [1] was my (re)action to this concern; the sort of the patch is unclear to
> me by this time (and I'm not aware of other proposals in this respect).
>> 
>> >  guarantee that is currently
>> > _not_ provided by all implementations/arch, and that callers relying on
>> > such ordering should instead use suitable memory barriers before acting
>> > on the result of spin_is_locked().
>> > 
>> > Following a recent auditing[1] of the callers of {,raw_}spin_is_locked()
>> > revealing that none of them are relying on this guarantee anymore, this
>> > commit removes the leading smp_mb() from the primitive thus effectively
>> > reverting 51d7d5205d338.
>> 
>> I would rather wait until it is properly documented. Debugging that IPC
>> problem took a *LOT* of time and energy, I wouldn't want these issues
>> to come and bite us again.
>
> I understand. And I'm grateful for this debugging as well as for the (IMO)
> excellent account of it you provided in 51d7d5205d338.

Thanks, you're welcome :)

> Said this ;) I cannot except myself from saying that I would probably have
> resisted that solution (adding an smp_mb() in my arch_spin_is_locked), and
> instead "blamed"/suggested that caller to fix his memory ordering...

That was tempting, but it leaves unfixed all the other potential
callers, both in in-tree and out-of-tree and in code that's yet to be
written.

Looking today nearly all the callers are debug code, where we probably
don't need the barrier but we also don't care about the overhead of the
barrier.

Documenting it would definitely be good, but even then I'd be inclined
to leave the barrier in our implementation. Matching the documented
behaviour is one thing, but the actual real-world behaviour on well
tested platforms (ie. x86) is more important.

cheers
