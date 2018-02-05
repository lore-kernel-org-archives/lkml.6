Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeBERtY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:49:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752722AbeBERtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:49:16 -0500
Date: Mon, 5 Feb 2018 17:49:11 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v3 1/3] sched/fair: add util_est on top of PELT
Message-ID: <20180205174911.GE5739@e110439-lin>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-2-patrick.bellasi@arm.com>
 <20180129163642.GF2228@hirez.programming.kicks-ass.net>
 <20180130124632.GC5739@e110439-lin>
 <20180130130432.GC2269@hirez.programming.kicks-ass.net>
 <20180130140132.GI2295@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130140132.GI2295@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Jan 15:01, Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 02:04:32PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 30, 2018 at 12:46:33PM +0000, Patrick Bellasi wrote:
> > > > Aside from that being whitespace challenged, did you also try:
> > > > 
> > > > 	if ((unsigned)((util_est - util_last) + LIM - 1) < (2 * LIM - 1))
> > > 
> > > No, since the above code IMO is so much "easy to parse for humans" :)
> > 
> > Heh, true. Although that's fixable by wrapping it in some helper with a
> > comment.
> > 
> > > But, mainly because since the cache alignment update, also while testing on a
> > > "big" Intel machine I cannot see regressions on hackbench.
> > > 
> > > This is the code I get on my Xeon E5-2690 v2:
> > > 
> > >        if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> > >    6ba0:       8b 86 7c 02 00 00       mov    0x27c(%rsi),%eax
> > >    6ba6:       48 29 c8                sub    %rcx,%rax
> > >    6ba9:       48 99                   cqto
> > >    6bab:       48 31 d0                xor    %rdx,%rax
> > >    6bae:       48 29 d0                sub    %rdx,%rax
> > >    6bb1:       48 83 f8 0a             cmp    $0xa,%rax
> > >    6bb5:       7e 1d                   jle    6bd4 <dequeue_task_fair+0x7e4>
> > > 
> > > Does it look so bad?
> > 
> > Its not terrible, and I think your GCC is far more clever than the one I
> 
> To clarify; my GCC at the time generated conditional branches to compute
> the absolute value; and in that case the thing I proposed wins hands
> down because its unconditional.
> 
> However the above is also unconditional and then the difference is much
> less important.

I've finally convinced myself that we can live with the "parsing
complexity" of your proposal... and wrapped into an inline it turned
out to be not so bad.

> > used at the time. But that's 4 dependent instructions (cqto,xor,sub,cmp)
> > whereas the one I proposed uses only 2 (add,cmp).

The ARM64 generated code is also simpler.

> > Now, my proposal is, as you say, somewhat hard to read, and it also
> > doesn't work right when our values are 'big' (which they will not be in
> > our case, because util has a very definite bound), and I suspect you're
> > right that ~2 cycles here will not be measurable.

Indeed, I cannot see noticeable differences if not just a slightly
improvement...

> > 
> > So yeah.... whatever ;-)

... I'm going to post a v4 using your proposal ;-)

Thanks Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
