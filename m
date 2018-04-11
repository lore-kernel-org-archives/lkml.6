Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeDKQAJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:00:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeDKQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:00:08 -0400
Date: Wed, 11 Apr 2018 18:00:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Message-ID: <20180411160000.GO4082@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin>
 <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net>
 <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 05:41:24PM +0200, Vincent Guittot wrote:
> Yes. and to be honest I don't have any clues of the root cause :-(
> Heiner mentioned that it's much better in latest linux-next but I
> haven't seen any changes related to the code of those patches

Yeah, it's a bit of a puzzle. Now you touch nohz, and the patches in
next that are most likely to have affected this are rjw's
cpuidle-vs-nohz patches. The common demoninator being nohz.

Now I think rjw's patches will ensure we enter nohz _less_, they avoid
stopping the tick when we expect to go idle for a short period only.

So if your patch makes nohz go wobbly, going nohz less will make that
better.

Of course, I've no actual clue as to what that patch (it's the last one
in the series, right?:

  31e77c93e432 ("sched/fair: Update blocked load when newly idle")

) does that is so offensive to that one machine. You never did manage to
reproduce, right?

Could is be that for some reason the nohz balancer now takes a very long
time to run?

Could something like the following happen (and this is really flaky
thinking here):

last CPU goes idle, we enter idle_balance(), that kicks ilb, ilb runs,
which somehow again triggers idle_balance and around we go?

I'm not immediately seeing how that could happen, but if we do something
daft like that we can tie up the CPU for a while, mostly with IRQs
disabled, and that would be visible as that latency he sees.
