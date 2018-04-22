Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeDVCxx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 22:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55809 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753025AbeDVCxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 22:53:52 -0400
Date: Sat, 21 Apr 2018 19:39:35 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, longman@redhat.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbues@suse.de>
Subject: Re: [PATCH 2/2] rtmutex: Reduce top-waiter blocking on a lock
Message-ID: <20180422023935.twybmkfj3kdtwfuo@linux-n805>
References: <20180410162750.8290-1-dave@stgolabs.net>
 <20180410162750.8290-2-dave@stgolabs.net>
 <20180420155028.GO4064@hirez.programming.kicks-ass.net>
 <1524242934.5239.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1524242934.5239.1.camel@gmx.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Mike Galbraith wrote:

>On Fri, 2018-04-20 at 17:50 +0200, Peter Zijlstra wrote:
>> Is this similar to what we have in RT (which, IIRC, has an optimistic
>> spinning implementation as well)?
>
>For the RT spinlock replacement, the top waiter can spin.

Yeah and the difference with the rt-spinlock and this patch are points
(1) and (3). Probably worth mentioning and, at least at first thought,
the rt version might benefit from these breaking out of the spin loop;
lateral or normal, I doubt the rt-spinlock wants to adaptive_wait() if
the top_waiter changed.

>
>> ISTR there being some contention over the exact semantics of (3) many
>> years ago. IIRC the question was if an equal priority task was allowed
>> to steal; because lock stealing can lead to fairness issues. One would
>> expect two FIFO-50 tasks to be 'fair' wrt lock acquisition and not
>> starve one another.

Indeed.

>>
>> Therefore I think we only allowed higher prio tasks to steal and kept
>> FIFO order for equal prioty tasks.

Right. In fact this patch is a very limited version of optimistic spinning
because we have little room too break fairness and rt constraints (ie no
osq, etc).

So say waiter task A is spinning for the rtmutex when task B (with equal
prio) comes in and tries to take it as well. Because when B is being
enqueued we don't comply with rt_mutex_waiter_less(A, B), so we go rb_right.
As such the top-waiter pointer is not updated and therefore B blocks while
A keeps spinning and take the lock hopefully without blocking. And if we
do block we're still top-waiter so fifo wrt waiter B all the way.

>
>Yup, lateral steal is expressly forbidden for RT classes.

Only rt-spinlocks allow lateral stealing, this patch uses the same normal
stealing semantics as what rtmutex already provide. And either way I don't
see how rt_mutex_spin_on_owner() will influence on current rtmutex semantics
as all that changes is not calling schedule(), and we are already accounted
for and queued in the waiter tree.

Thanks,
Davidlohr
