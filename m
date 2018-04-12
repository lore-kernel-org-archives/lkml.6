Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDLJMc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:12:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDLJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:12:31 -0400
Date: Thu, 12 Apr 2018 11:12:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC tip/locking/lockdep v6 19/20] rcu: Equip sleepable RCU with
 lockdep dependency graph checks
Message-ID: <20180412091217.GY4082@hirez.programming.kicks-ass.net>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
 <20180411135647.21496-1-boqun.feng@gmail.com>
 <20180411185730.GU3948@linux.vnet.ibm.com>
 <20180412021233.ewncg5jjuzjw3x62@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412021233.ewncg5jjuzjw3x62@tardis>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:12:33AM +0800, Boqun Feng wrote:
> A trivial fix/hack would be adding local_irq_disable() and
> local_irq_enable() around srcu_lock_sync() like:
> 
> 	static inline void srcu_lock_sync(struct lockdep_map *map)
> 	{
> 		local_irq_disable();
> 		lock_map_acquire(map);
> 		lock_map_release(map);
> 		local_irq_enable();
> 	}
> 
> However, it might be better, if lockdep could provide some annotation
> API for such an empty critical section to say the grap-and-drop is
> atomic. Something like:
> 
> 	/*
> 	 * Annotate a wait point for all previous critical section to
> 	 * go out.
> 	 * 
> 	 * This won't make @map a irq unsafe lock, no matter it's called
> 	 * w/ or w/o irq disabled.
> 	 */
> 	lock_wait_unlock(struct lockdep_map *map, ..)
> 
> And in this primitive, we do something similar like
> lock_acquire()+lock_release(). This primitive could be used elsewhere,
> as I bebieve we have several empty grab-and-drop critical section for
> lockdep annotations, e.g. in start_flush_work().
> 
> Thoughts?
> 
> This cerntainly requires a bit more work, in the meanwhile, I will add
> another self testcase which has a srcu_read_lock() called in irq.

Yeah, I've never really bothered to clean those things up, but I don't
see any reason to stop you from doing it ;-)

As to the initial pattern with disabling IRQs, I think I've seen code
like that before, and in general performance isn't a top priority
(within reason) when you're running lockdep kernels, so I've usually let
it be.
