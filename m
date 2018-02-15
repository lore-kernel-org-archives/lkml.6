Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967910AbeBOLtr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:49:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967814AbeBOLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:49:45 -0500
Date: Thu, 15 Feb 2018 12:49:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180215114927.GV25201@hirez.programming.kicks-ass.net>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 06:53:44PM +0000, Mathieu Desnoyers wrote:
> However, given the scenario involves multiples CPUs (one doing exit_mm(),
> the other doing context switch), the actual order of perceived load/store
> can be shuffled. And AFAIU nothing prevents the CPU from ordering the
> atomic_inc() done by mmgrab(mm) _after_ the store to current->mm.
> 
> I wonder if we should not simply add a smp_mb__after_atomic() into
> mmgrab() instead ? I see that e.g. futex.c does:

Don't think so, the futex case is really rather special and I suspect
this one is too. I would much rather have explicit comments rather than
implicit works by magic.

As per the rationale used for refcount_t, increments should be
unordered, because you ACQUIRE your object _before_ you can do the
increment.

The futex thing is simply abusing a bunch of implied barriers and
patching up the holes in paths that didn't already imply a barrier in
order to avoid having to add explicit barriers (which had measurable
performance issues).

And here we have explicit ordering outside of the reference counting
too, we want to ensure the reference is incremented before we modify
a second object.

This ordering is not at all related to acquiring the reference, so
bunding it seems odd.
