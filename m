Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeDTM24 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:28:56 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:41149 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbeDTM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:28:54 -0400
X-Google-Smtp-Source: AIpwx4+1JyoQjMu3lzXJlDAWR1D1K0eh8jYB9o/4I/PRH+ExW1bBmB9dDnOR3cEQIKAfwxQ5K2rjpg==
Date: Fri, 20 Apr 2018 22:28:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] kernel/sched/core: busy wait before going idle
Message-ID: <20180420222842.33dc5b33@roar.ozlabs.ibm.com>
In-Reply-To: <20180420105827.GK4064@hirez.programming.kicks-ass.net>
References: <20180415133149.24112-1-npiggin@gmail.com>
        <20180420074456.GA4064@hirez.programming.kicks-ass.net>
        <20180420190126.1644f4cd@roar.ozlabs.ibm.com>
        <20180420105827.GK4064@hirez.programming.kicks-ass.net>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 12:58:27 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 20, 2018 at 07:01:47PM +1000, Nicholas Piggin wrote:
> > On Fri, 20 Apr 2018 09:44:56 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Sun, Apr 15, 2018 at 11:31:49PM +1000, Nicholas Piggin wrote:  
> > > > This is a quick hack for comments, but I've always wondered --
> > > > if we have a short term polling idle states in cpuidle for performance
> > > > -- why not skip the context switch and entry into all the idle states,
> > > > and just wait for a bit to see if something wakes up again.    
> > > 
> > > Is that context switch so expensive?  
> > 
> > I guess relatively much more than taking one branch mispredict on the
> > loop exit when the task wakes. 10s of cycles vs 1000s?  
> 
> Sure, just wondering how much. And I'm assuming you're looking at Power
> here, right?

Well I'll try to get more numbers.

Yes, talking about power. It trails x86 on context switches by a bit,
but similar orders of magnitude. My skylake is doing ~1900 cycles
syscall + context switch with a distro kernel. POWER9 is ~2500.

> > > And what kernel did you test on? We recently merged a bunch of patches
> > > from Rafael that avoided disabling the tick for short idle predictions.
> > > This also has a performance improvements for such workloads.  Did your
> > > kernel include those?  
> > 
> > Yes that actually improved profiles quite a lot, but these numbers were
> > with those changes. I'll try to find some fast disks or network and get
> > some more more interesting numbers.  
> 
> OK, good that you have those patches in. That ensures you're not trying
> to fix something that's possibly already addressed elsewhere.

Yep.

> 
> > > > It's not uncommon to see various going-to-idle work in kernel profiles.
> > > > This might be a way to reduce that (and just the cost of switching
> > > > registers and kernel stack to idle thread). This can be an important
> > > > path for single thread request-response throughput.    
> > > 
> > > So I feel that _if_ we do a spin here, it should only be long enough to
> > > amortize the schedule switch context.
> > > 
> > > However, doing busy waits here has the downside that the 'idle' time is
> > > not in fact fed into the cpuidle predictor.  
> > 
> > That's why I cc'ed Rafael :)
> > 
> > Yes the latency in my hack is probably too long, but I think if we did
> > this, the cpuile predictor could become involved here. There is no
> > fundamental reason it has to wait for the idle task to be context
> > switched for that... it's already become involved in core scheduler
> > code.  
> 
> Yes, cpuidle/cpufreq are getting more and more intergrated so there is
> no objection from that point.
> 
> Growing multiple 'idle' points otoh is a little dodgy and could cause
> some maintenance issues.

Right, it should be done a bit better than my patch, which is
just a hack.

> Of course, this loop would have the same idle-duration problems as the
> poll_state.c one. We should probably use that code. Also, do we want to
> ask the estimator before doing this? If it predicts a very long idle
> time, spinning here is just wasting cycles.

I would say so, yes. I think if we did go this route, it should
take over the the existing polling idle states, so it would make
sense to control it in a similar way.

(Unless polling idle is the only state available of course we need
to switch to it eventually, and we must immediately switch in case
of do_task_dead, etc)

Anyway I'll wait for the merge window to settle and try to get some
more numbers. I basically just wanted to see if there were any
fundamental problems with the concept.

Thanks,
Nick
