Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633D6218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBHLnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:43:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHLnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:43:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 509AB80D;
        Fri,  8 Feb 2019 03:43:19 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA42E3F719;
        Fri,  8 Feb 2019 03:43:17 -0800 (PST)
Date:   Fri, 8 Feb 2019 11:43:15 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tj@kernel.org, longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
Message-ID: <20190208114315.GD6972@fuggles.cambridge.arm.com>
References: <20190111124835.GP1900@hirez.programming.kicks-ass.net>
 <1547222103.83374.72.camel@acm.org>
 <20190111165529.GA14054@worktop.programming.kicks-ass.net>
 <1547226101.83374.80.camel@acm.org>
 <20190114125235.GB20726@hirez.programming.kicks-ass.net>
 <1547484753.83374.109.camel@acm.org>
 <20190118094808.GA27931@hirez.programming.kicks-ass.net>
 <1250147c-27bc-92e1-3ff5-211f3ba56891@acm.org>
 <20190201121510.GC31516@hirez.programming.kicks-ass.net>
 <3c533b0e-b079-79ad-4935-cd61af000ce6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c533b0e-b079-79ad-4935-cd61af000ce6@acm.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart, Peter,

On Sun, Feb 03, 2019 at 09:36:38AM -0800, Bart Van Assche wrote:
> On 2/1/19 4:15 AM, Peter Zijlstra wrote:
> > On Fri, Jan 18, 2019 at 06:34:20PM -0800, Bart Van Assche wrote:
> > > I agree with what you wrote. The only code I know of that accesses list
> > > entries using RCU is the __bfs() function. In that function I found the
> > > following loop:
> > > 
> > > 	list_for_each_entry_rcu(entry, head, entry) { [ ... ] }
> > 
> > Thing is; I can't seem to find any __bfs() usage outside of graph_lock.
> > 
> >    count_{fwd,bwd}_deps() - takes graph lock
> > 
> >    check_{noncircular,redudant}() - called from check_prev_add() <-
> >    check_prevs_add() <- validate_chain() which takes graph lock
> > 
> >    find_usage{,_fwd,_bwd}
> >      <- check_usage() <- check_irq_usage() <- check_prev_add_irq() <-
> >      check_prev_add <- check_prevs_add() <- validate_chain() which takes
> >      graph lock
> > 
> >      <- check_usage_{fwd,bdw}() <- mark_lock_irq() <- mark_lock() which
> >      takes graph lock
> > 
> > Or did I miss something? If there are no __bfs() users outside of graph
> > lock, then we can simply remove that _rcu from the iteration, and
> > simplify all that.
> 
> Every time I make a single change to the lockdep code I have to rerun my
> test case for a week to make sure that no regressions have been introduced.
> In other words, I can make further changes but that could take some time. Do
> you want me to look into this simplification now or after this patch series
> went upstream?
> 
> > > Since zap_class() calls list_del_rcu(&entry->entry), since a grace period
> > > occurs between the call_rcu() invocation and the RCU callback function,
> > > since at least an RCU reader lock must be held around RCU loops and since
> > > sleeping is not allowed while holding an RCU read lock I think there is
> > > no risk that __bfs() will examine a list entry after it has been freed.
> > 
> > So you agree that list_entry_being_freed() should only check the current
> > pf?
> 
> Sorry if I wasn't clear enough. In a previous e-mail I tried to explain that
> both pf's have to be checked. Another way to explain that is as follows:
> - Each list entry has one of the following states: free, in use or being
>   freed.
> - "Free" means that the corresponding bit in the list_entries_in_use
>   bitmap has not been set.
> - "In use" means that the corresponding bit in the list_entries_in_use
>   bitmap has been set and that none of the corresponding bits in the
>   list_entries_being_freed bitmaps have been set.
> - "Being freed" means that the corresponding bit in one of the
>   list_entries_being_freed bitmaps has been set.
> 
> Since it can happen that multiple elements of the pending_free[] array are
> in the state where call_rcu() has been called but the RCU callback function
> has not yet been called, I think that zap_class() must check the
> list_entries_being_freed bitmaps in all pending_free[] array elements.

I've also been trying to understand why it's necessary to check both of the
pending_free entries, and I'm still struggling somewhat. It's true that the
wakeup in get_pending_free_lock() could lead to both entries being used
without the RCU call back running in between, however in this scenario then
any list entries marked for freeing in the first pf will have been unhashed
and therefore made unreachable to look_up_lock_class().

So I think the concern remains that entries are somehow remaining visible
after being zapped.

You mentioned earlier in the thread that people actually complained about
list corruption if you only checked the current pf:

  | The list_del_rcu() call must only happen once. I ran into complaints
  | reporting that the list_del_rcu() call triggered list corruption. This
  | change made these complaints disappear.

Do you have any more details about these complaints (e.g. kernel logs etc)?
Failing that, any idea how to reproduce them?

Thanks,

Will
