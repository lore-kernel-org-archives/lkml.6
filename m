Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeBZJBq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:01:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55672 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeBZJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:00:58 -0500
Date: Mon, 26 Feb 2018 10:00:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180226090050.GE25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
 <20180223123732.acxbavnf2ktd4lzl@tardis>
 <20180224053250.ketrlbq4gtx573qo@tardis>
 <20180224063005.efbowkoq2v4qndan@tardis>
 <20180224083807.GB25201@hirez.programming.kicks-ass.net>
 <20180224090019.3smjampkk4zoacb3@tardis>
 <20180224092651.hjxznghmuiyj4rnp@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224092651.hjxznghmuiyj4rnp@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 05:26:52PM +0800, Boqun Feng wrote:
> > This is for case like:
> > 
> > 	TASK1:
> > 		read_lock(A);
> > 		read_lock(B);
> > 	
> > 	TASK2:
> > 		write_lock(B);
> > 		read_lock(C);
> > 	
> > 	TASK3:
> > 		read_lock(B);
> > 		write_lock(C);
> > 
> > 	TASK4:
> > 		read_lock(C);
> > 		write_lock(A);
> > 
> > , which is not a deadlock.
> > 
> 
> After TASK 1,2,3 have executed, we have A -(RR)-> B, B -(RN/NR)-> C, and
> when TASK4 executed, we will try to add C -(RN)-> A into the graph.
> Before that we need to check whether we have a A -> ... -(*N)-> C path
> in the graph already, so we search from A (@prev is C and @this is A):
> 
> *	we set A->have_xr to false, because the dependency we are adding
> 	is a RN.
> 
> *	we find A -(RR)-> B, and since have_xr (= A->have_xr) is false,
> 	we can pick this dependency, and since for A -> B, we only have
> 	RR, so we set B->have_xr to true.
> 
> *	we then find B -(RN/NR)-> C, and since have_xr (= B->have_xr) is
> 	true, we will pick it only only_rx(C->dep) return false,
> 	otherwise we skip. Because we have RN and NR for B -> C,
> 	therefore we won't skip B -> C.
> 
> *	Now we try to set C->have_xr, if we set it to only_xr(C->dep),
> 	we will set it to false, right? Because B -> C has RN.
> 
> *	Since we now find a entry equal to @prev, we go into the
> 	hlock_conflict() logic and for expression
> 		
> 		hlock->read != 2 || !entry->have_xr 
> 	
> 	@hlock is the C in TASK4, so hlock->read == 2, and @entry is the
> 	C whose ->have_xr we just set, so entry->have_xr is false.
> 	Therefore hlock_conflict() returns true. And that indicates we
> 	find a deadlock in the search. But the above senario can not
> 	introduce a deadlock.
> 
> Could this help you, or I miss something?

Yes, although it took me forever to grasp because I have snot for brains
atm :-(

Would something like:


	dep = entry->dep;

	/* Mask out all *R -> R* relations. */
	if (have_xr)
		dep &= ~(RR_MASK | RN_MASK);

	/* If nothing left, we're done. */
	if (!dep)
		continue;

	/* If there are (only) *R left, set that for the next step. */
	entry->have_xr = !(dep & (RN_MASK | NN_MASK));


Work? I think that reads fairly simple.
