Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeDFLeY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:34:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbeDFLeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:34:23 -0400
Date: Fri, 6 Apr 2018 12:34:36 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
Message-ID: <20180406113436.GC27619@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
 <20180405172808.GG4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405172808.GG4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 07:28:08PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> > @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  		goto release;
> >  
> >  	/*
> > +	 * Ensure that the initialisation of @node is complete before we
> > +	 * publish the updated tail and potentially link @node into the
> > +	 * waitqueue.
> > +	 */
> > +	smp_wmb();
> 
> Maybe an explicit note to where the matching barrier lives..

Oh man, that's not a simple thing to write: there isn't a matching barrier!

Instead, we rely on dependency ordering for two cases:

  * We access a node by decoding the tail we get back from the xchg

- or -

  * We access a node by following our own ->next pointer

I could say something like:

  "Pairs with dependency ordering from both xchg_tail and explicit
   dereferences of node->next"

but it's a bit cryptic :(

Will
