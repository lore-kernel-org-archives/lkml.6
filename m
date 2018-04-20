Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755886AbeDTPuf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:50:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755714AbeDTPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:50:34 -0400
Date: Fri, 20 Apr 2018 17:50:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: tglx@linutronix.de, mingo@kernel.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbues@suse.de>
Subject: Re: [PATCH 2/2] rtmutex: Reduce top-waiter blocking on a lock
Message-ID: <20180420155028.GO4064@hirez.programming.kicks-ass.net>
References: <20180410162750.8290-1-dave@stgolabs.net>
 <20180410162750.8290-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410162750.8290-2-dave@stgolabs.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:27:50AM -0700, Davidlohr Bueso wrote:
> By applying well known spin-on-lock-owner techniques, we can avoid the
> blocking overhead during the process of when the task is trying to take
> the rtmutex. The idea is that as long as the owner is running, there is a
> fair chance it'll release the lock soon, and thus a task trying to acquire
> the rtmutex will better off spinning instead of blocking immediately after
> the fastpath. This is similar to what we use for other locks, borrowed
> from -rt. The main difference (due to the obvious realtime constraints)
> is that top-waiter spinning must account for any new higher priority waiter,
> and therefore cannot steal the lock and avoid any pi-dance. As such there
> will be at most only one spinner waiter upon contended lock.
> 
> Conditions to stop spinning and block are simple:
> 
> (1) Upon need_resched()
> (2) Current lock owner blocks
> (3) The top-waiter has changed while spinning.
> 
> The unlock side remains unchanged as wake_up_process can safely deal with
> calls where the task is not actually blocked (TASK_NORMAL). As such, there
> is only unnecessary overhead dealing with the wake_q, but this allows us not
> to miss any wakeups between the spinning step and the unlocking side.
> 
> Passes running the pi_stress program with increasing thread-group counts.

Is this similar to what we have in RT (which, IIRC, has an optimistic
spinning implementation as well)?

ISTR there being some contention over the exact semantics of (3) many
years ago. IIRC the question was if an equal priority task was allowed
to steal; because lock stealing can lead to fairness issues. One would
expect two FIFO-50 tasks to be 'fair' wrt lock acquisition and not
starve one another.

Therefore I think we only allowed higher prio tasks to steal and kept
FIFO order for equal prioty tasks.
