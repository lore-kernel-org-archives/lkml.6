Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbeDTK6n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:58:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDTK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:58:41 -0400
Date: Fri, 20 Apr 2018 12:58:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] kernel/sched/core: busy wait before going idle
Message-ID: <20180420105827.GK4064@hirez.programming.kicks-ass.net>
References: <20180415133149.24112-1-npiggin@gmail.com>
 <20180420074456.GA4064@hirez.programming.kicks-ass.net>
 <20180420190126.1644f4cd@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420190126.1644f4cd@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 07:01:47PM +1000, Nicholas Piggin wrote:
> On Fri, 20 Apr 2018 09:44:56 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Apr 15, 2018 at 11:31:49PM +1000, Nicholas Piggin wrote:
> > > This is a quick hack for comments, but I've always wondered --
> > > if we have a short term polling idle states in cpuidle for performance
> > > -- why not skip the context switch and entry into all the idle states,
> > > and just wait for a bit to see if something wakes up again.  
> > 
> > Is that context switch so expensive?
> 
> I guess relatively much more than taking one branch mispredict on the
> loop exit when the task wakes. 10s of cycles vs 1000s?

Sure, just wondering how much. And I'm assuming you're looking at Power
here, right?

> > And what kernel did you test on? We recently merged a bunch of patches
> > from Rafael that avoided disabling the tick for short idle predictions.
> > This also has a performance improvements for such workloads.  Did your
> > kernel include those?
> 
> Yes that actually improved profiles quite a lot, but these numbers were
> with those changes. I'll try to find some fast disks or network and get
> some more more interesting numbers.

OK, good that you have those patches in. That ensures you're not trying
to fix something that's possibly already addressed elsewhere.

> > > It's not uncommon to see various going-to-idle work in kernel profiles.
> > > This might be a way to reduce that (and just the cost of switching
> > > registers and kernel stack to idle thread). This can be an important
> > > path for single thread request-response throughput.  
> > 
> > So I feel that _if_ we do a spin here, it should only be long enough to
> > amortize the schedule switch context.
> > 
> > However, doing busy waits here has the downside that the 'idle' time is
> > not in fact fed into the cpuidle predictor.
> 
> That's why I cc'ed Rafael :)
> 
> Yes the latency in my hack is probably too long, but I think if we did
> this, the cpuile predictor could become involved here. There is no
> fundamental reason it has to wait for the idle task to be context
> switched for that... it's already become involved in core scheduler
> code.

Yes, cpuidle/cpufreq are getting more and more intergrated so there is
no objection from that point.

Growing multiple 'idle' points otoh is a little dodgy and could cause
some maintenance issues.

Of course, this loop would have the same idle-duration problems as the
poll_state.c one. We should probably use that code. Also, do we want to
ask the estimator before doing this? If it predicts a very long idle
time, spinning here is just wasting cycles.
