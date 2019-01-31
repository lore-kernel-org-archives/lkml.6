Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D61CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A552086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfAaXfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:35:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58520 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfAaXfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:35:43 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a08ce94b43690ac3; Fri, 1 Feb 2019 00:35:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Date:   Fri, 01 Feb 2019 00:34:32 +0100
Message-ID: <3268787.3OZuCagV1k@aspire.rjw.lan>
In-Reply-To: <20190131183730.GN81583@google.com>
References: <20190131015139.126890-1-mka@chromium.org> <CAJZ5v0gp2tqMR1vOvzakhMRmG15OqMZ=ndKoAkmxLbzohn8VbA@mail.gmail.com> <20190131183730.GN81583@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 31, 2019 7:37:30 PM CET Matthias Kaehlcke wrote:
> On Thu, Jan 31, 2019 at 11:14:03AM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 31, 2019 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 31-01-19, 11:03, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> > > > > > When fast switching is enabled currently no cpufreq stats are
> > > > > > recorded and the corresponding sysfs attributes appear empty (see
> > > > > > also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> > > > > > non-modular")).
> > > > > >
> > > > > > Record the stats after a successful fast switch and re-enable access
> > > > > > through sysfs when fast switching is enabled. Since
> > > > > > cpufreq_stats_update() can now be called in interrupt context (during
> > > > > > a fast switch) disable local IRQs while holding the stats spinlock.
> > > > > >
> > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > > ---
> > > > > > The change is so simple that I wonder if I'm missing some important
> > > > > > reason why the stats can't/shouldn't be updated during/after a fast
> > > > > > switch ...
> > > > > >
> > > > > > I would expect that holding the stats spinlock briefly in
> > > > > > cpufreq_stats_update() shouldn't be a problem. In theory it would
> > > > > > also be an option to have a per stats lock, though it seems overkill
> > > > > > from my (possibly ignorant) point of view.
> > > > > > ---
> > > > > >  drivers/cpufreq/cpufreq.c       |  8 +++++++-
> > > > > >  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
> > > > > >  2 files changed, 10 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > > index e35a886e00bcf..63aadb0bbddfe 100644
> > > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > > @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > > > > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > > > >                                       unsigned int target_freq)
> > > > > >  {
> > > > > > +     unsigned int freq;
> > > > > > +
> > > > > >       target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > > > >
> > > > > > -     return cpufreq_driver->fast_switch(policy, target_freq);
> > > > > > +     freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > > > > +     if (freq)
> > > > > > +             cpufreq_stats_record_transition(policy, freq);
> > > > > > +
> > > > > > +     return freq;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > > > > >
> > > > > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > > > > index 1572129844a5b..21b919bfaeccf 100644
> > > > > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > > > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > > > > @@ -30,11 +30,12 @@ struct cpufreq_stats {
> > > > > >  static void cpufreq_stats_update(struct cpufreq_stats *stats)
> > > > > >  {
> > > > > >       unsigned long long cur_time = get_jiffies_64();
> > > > > > +     unsigned long flags;
> > > > > >
> > > > > > -     spin_lock(&cpufreq_stats_lock);
> > > > > > +     spin_lock_irqsave(&cpufreq_stats_lock, flags);
> > > > > >       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> > > > > >       stats->last_time = cur_time;
> > > > > > -     spin_unlock(&cpufreq_stats_lock);
> > > > > > +     spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
> > > > > >  }
> > > > >
> > > > > The only problem that I can think of (or recall) is that this routine
> > > > > also gets called when time_in_state sysfs file is read and that can
> > > > > end up taking lock which the scheduler's hotpath will wait for.
> > > >
> > > > What about the extra locking overhead in the scheduler context?
> > >
> > > What about using READ_ONCE/WRITE_ONCE here ? Not sure if we really
> > > need locking in this particular case.
> > 
> > If that works, then fine, but ISTR some synchronization issues related to that.
> 
> I also think there would be synchronization issues :(
> 
> Is your main concern with the spin lock the contention case or the
> general overhead of locking?

The general overhead is bad enough.  The contention case would be a
disaster.

> It would be really nice to have cpufreq stats with schedutil. We
> initially considered a sysfs attribute to allow to temporarily disable
> fast switching, but at closer sight this seems messy (would require
> quite some rework in cpufreq_schedutil.c), besides not recording the
> actual behavior.
> 
> If another (rarely and only shortly held) lock in scheduler context

This is a global spinlock and you'd like to take it on every frequency
change for each policy.  On x86, as a rule, there is a policy per logical
CPU and systems with hundreds of these are not uncommon.  Come on.

> is a no-go deferred recording could be an option, if that can be
> implemented without locks in scheduler context.

Why do you need the stats at all in the fast switch case?

There is the cpu_frequency tracepoint that can be used to callect
all data that you need.  Why can't that be used?

