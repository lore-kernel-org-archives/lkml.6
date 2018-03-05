Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbeCEGNz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 01:13:55 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38871 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeCEGNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 01:13:52 -0500
X-Google-Smtp-Source: AG47ELtnNC6bFAOjixGeqWPJRLtEbedh+fOqH+UahvjT2TBswHAsGrg30jhCKQ3IPPYXvMRuzEaorQ==
Date: Mon, 5 Mar 2018 11:43:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Message-ID: <20180305061349.GF23018@vireshk-i7>
References: <1519815970-5686-1-git-send-email-claudio@evidence.eu.com>
 <CAJZ5v0g5SS7A6xNQo=GNaMudRgFC8BL9wP1C4Nh8T-+NygYS+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g5SS7A6xNQo=GNaMudRgFC8BL9wP1C4Nh8T-+NygYS+A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-02-18, 12:22, Rafael J. Wysocki wrote:
> On Wed, Feb 28, 2018 at 12:06 PM, Claudio Scordino
> <claudio@evidence.eu.com> wrote:
> > When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> > we should not wait for the rate limit, otherwise we may miss some
> > deadline.
> >
> > Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
> > shown reductions of even 10% of deadline misses with a negligible
> > increase of energy consumption (measured through Baylibre Cape).
> >
> > Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Patrick Bellasi <patrick.bellasi@arm.com>
> > CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > CC: Morten Rasmussen <morten.rasmussen@arm.com>
> > CC: Juri Lelli <juri.lelli@redhat.com>
> > CC: Viresh Kumar <viresh.kumar@linaro.org>
> > CC: Vincent Guittot <vincent.guittot@linaro.org>
> > CC: Todd Kjos <tkjos@android.com>
> > CC: Joel Fernandes <joelaf@google.com>
> > CC: linux-pm@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> > Changes from v1:
> >  - Logic moved from sugov_should_update_freq() to
> >    sugov_update_single()/_shared() to not duplicate data structures
> >  - Rate limit not ignored in case of "fast switch"
> 
> I'm not sure about this last bit.
> 
> IMO you can set sg_policy->need_freq_update even in the "fast switch"
> case to start with and special case it in the future if that turns out
> to be problematic.  That is, unless you have data indicating that it
> already is problematic, of course. :-)
> 
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 7936f54..ca6ce72 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -273,6 +273,14 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >         sugov_set_iowait_boost(sg_cpu, time);
> >         sg_cpu->last_update = time;
> >
> > +       /*
> > +        * Make sugov_should_update_freq() ignore the rate limit when DL
> > +        * has increased the utilization.
> > +        */
> > +       if ((cpu_util_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->util_dl) &&
> > +                       !(sg_policy->policy->fast_switch_enabled))
> > +               sg_policy->need_freq_update = true;
> > +

And a new routine for this block would be good as well.

-- 
viresh
