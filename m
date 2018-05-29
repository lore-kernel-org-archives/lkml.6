Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936736AbeE2PE5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:04:57 -0400
Received: from foss.arm.com ([217.140.101.70]:42272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935490AbeE2PEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:04:49 -0400
Date: Tue, 29 May 2018 16:04:46 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 01/10] sched/pelt: Move pelt related code in a
 dedicated file
Message-ID: <20180529150445.GG15173@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-2-git-send-email-vincent.guittot@linaro.org>
 <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
 <20180525180455.GF30654@e110439-lin>
 <20180529145506.GF15173@e108498-lin.cambridge.arm.com>
 <CAKfTPtCrPfpREESbH+D7h71yupchcm-TQ8nx=TADuzVysqNfSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCrPfpREESbH+D7h71yupchcm-TQ8nx=TADuzVysqNfSA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 May 2018 at 17:02:29 (+0200), Vincent Guittot wrote:
> Hi Quentin,
> 
> On 29 May 2018 at 16:55, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Friday 25 May 2018 at 19:04:55 (+0100), Patrick Bellasi wrote:
> > > On 25-May 15:26, Quentin Perret wrote:
> > > > And also, I understand these functions are large, but if we _really_
> > > > want to inline them even though they're big, why not putting them in
> > > > sched-pelt.h ?
> > >
> > > Had the same tought at first... but then I recalled that header is
> > > generated from a script. Thus, eventually, it should be a different one.
> >
> > Ah, good point. This patch already introduces a pelt.h so I guess that
> > could work as well.
> >
> > >
> > > > We probably wouldn't accept that for everything, but
> > > > those PELT functions are used all over the place, including latency
> > > > sensitive code paths (e.g. task wake-up).
> > >
> > > We should better measure the overheads, if any, and check what
> > > (a modern) compiler does. Maybe some hackbench run could help on the
> > > first point.
> >
> > FWIW, I ran a few hackbench tests today on my Intel box:
> >  - Intel i7-6700 (4 cores / 8 threads) @ 3.40GHz
> >  - Base kernel: today's tip/sched/core "2539fc82aa9b sched/fair: Update
> >    util_est before updating schedutil"
> >  - Compiler: GCC 7.3.0
> 
> Which cpufreq governor are you using ?

powersave, with the intel_pstate driver.

> 
> >
> > The tables below summarize the results for:
> > perf stat --repeat 10 perf bench sched messaging --pipe --thread -l 50000 --group G
> >
> > Without patch:
> >   +---+-------+----------+---------+
> >   | G | Tasks | Duration | Stddev  |
> >   +---+-------+----------+---------+
> >   | 1 | 40    | 3.906    | +-0.84% |
> >   | 2 | 80    | 8.569    | +-0.77% |
> >   | 4 | 160   | 16.384   | +-0.46% |
> >   | 8 | 320   | 33.686   | +-0.42% |
> >   +---+-------+----------+---------+
> >
> > With patch:
> 
> Just to make sure. You mean only this patch and not the whole patchset ?

That's right, I applied only this patch.

> 
> >   +---+-------+----------------+---------+
> >   | G | Tasks | Duration       | Stddev  |
> >   +---+-------+----------------+---------+
> >   | 1 | 40    | 3.953 (+1.2%)  | +-1.43% |
> >   | 2 | 80    | 8.646 (+0.9%)  | +-0.32% |
> >   | 4 | 160   | 16.390 (+0.0%) | +-0.38% |
> >   | 8 | 320   | 33.992 (+0.9%) | +-0.27% |
> >   +---+-------+----------------+---------+
> >
> > So there is (maybe) a little something on my box, but not so significant
> > IMHO ... :)
> >
> > Thanks,
> > Quentin
