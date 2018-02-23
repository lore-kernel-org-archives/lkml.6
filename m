Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBWLgw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:36:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeBWLgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:36:51 -0500
Date: Fri, 23 Feb 2018 12:36:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 08/17] lockdep: Fix recursive read
 lock related safe->unsafe detection
Message-ID: <20180223113643.GX25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-9-boqun.feng@gmail.com>
 <20180222174654.GW25201@hirez.programming.kicks-ass.net>
 <20180223082134.ykkbzqj2h7glxrqn@tardis>
 <20180223085812.22u7o6z2gcg272jn@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223085812.22u7o6z2gcg272jn@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:58:12PM +0800, Boqun Feng wrote:
> Hmm... think again, maybe I can combine case 1 with 3, and case 2 with
> 4, because each of them could share the same find_usage_backwards(), and
> find_usage_forwards() uses a usage_match_forwards() as follow for the
> match function:
> 
> 	static inline int usage_match_forwards(struct lock_list *entry, void *bit)
> 	{
> 		enum lock_usage_bit ub = (enum lock_usage_bit)bit;
> 		unsigned long mask;
> 		unsigned long read_mask;
> 
> 		/* mask out the read bit */
> 		ub &= ~1;
> 
> 		mask = 1ULL << ub;
> 		read_mask = 1ULL << (ub + 1);
> 
> 		return (entry->class->usage_mask & mask) ||  // *-> L2 and L2 is an irq-unsafe lock
> 		       ((entry->class->usage_mask & read_mask) && !entry->is_rr); // N-> L2 and L2 is an irq-read-unsafe lock
> 	}
> 
> Got a bus to catch, I can explain this later, if you need ;-)

Right, that's about what I was thinking of. Clearly that needs a wee
comment but it's much better.
