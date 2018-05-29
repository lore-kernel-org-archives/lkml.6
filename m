Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeE2JwN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:52:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54022 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbeE2JwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:52:07 -0400
X-Google-Smtp-Source: ADUXVKLtGKAz1mfljfHn6ThYcVtsmziH5AtCitUXEGygWXqlVbMATID6mSl3vxLBhgGxjvvP7BMKLw==
Date: Tue, 29 May 2018 11:52:03 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180529095203.GD8985@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180529084009.GE15173@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529084009.GE15173@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/18 09:40, Quentin Perret wrote:
> Hi Vincent,
> 
> On Friday 25 May 2018 at 15:12:26 (+0200), Vincent Guittot wrote:
> > Now that we have both the dl class bandwidth requirement and the dl class
> > utilization, we can use the max of the 2 values when agregating the
> > utilization of the CPU.
> > 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/sched.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 4526ba6..0eb07a8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2194,7 +2194,11 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> >  static inline unsigned long cpu_util_dl(struct rq *rq)
> >  {
> > -	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> > +	unsigned long util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> > +
> > +	util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
> 
> Would it make sense to use a UTIL_EST version of that signal here ? I
> don't think that would make sense for the RT class with your patch-set
> since you only really use the blocked part of the signal for RT IIUC,
> but would that work for DL ?

Well, UTIL_EST for DL looks pretty much what we already do by computing
utilization based on dl.running_bw. That's why I was thinking of using
that as a starting point for dl.util_avg decay phase.
