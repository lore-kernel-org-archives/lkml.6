Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0492F215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0492F215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeI0SgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:36:01 -0400
Received: from foss.arm.com ([217.140.101.70]:33862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeI0SgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:36:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A31018A;
        Thu, 27 Sep 2018 05:17:59 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05493F5B3;
        Thu, 27 Sep 2018 05:17:54 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:17:49 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Message-ID: <20180927121749.urdqtayq6ll4k7qn@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-3-quentin.perret@arm.com>
 <CAJZ5v0gL+NurA8UcN5oweqwxfgS10HgO1Zjh_cod4_Sr5nWQHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gL+NurA8UcN5oweqwxfgS10HgO1Zjh_cod4_Sr5nWQHQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Very sorry for the late reply ...

On Tuesday 18 Sep 2018 at 23:33:22 (+0200), Rafael J. Wysocki wrote:
[...]
> The new "type" argument should be documented.
> 
> Also IMO using the special enum for it is quite confusing, because you
> ever only check one value from it directly.  What would be wrong with
> using a plain "bool" instead?

So, this part of the code was originally proposed by Peter. I basically
took it from the following message (hence the Suggested-by) which was
fine by me:

https://lore.kernel.org/lkml/20180709120138.GQ2494@hirez.programming.kicks-ass.net/

Also, one of the things that has been mentioned during reviews was that
other clients (such as cpuidle, IIRC) could potentially be interested
in a 'global' cpu util value. And since those clients might have
different needs than EAS or sugov, they might need a new entry in the
enum.

So that's probably the main argument for the enum, it is easy to extend.

[...]
> > +static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> > +{
> > +       struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +       unsigned long util = cpu_util_cfs(rq);
> > +
> > +       sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> > +       sg_cpu->bw_dl = cpu_bw_dl(rq);
> > +
> > +       return schedutil_freq_util(sg_cpu->cpu, util, FREQUENCY_UTIL);
> 
> If you add a "max" argument to schedutil_freq_util(), you can avoid
> the second (and arguably redundant) evaluation of
> arch_scale_cpu_capacity() in there.

OK

[...]
> > +enum schedutil_type {
> > +       FREQUENCY_UTIL,
> > +       ENERGY_UTIL,
> > +};
> 
> As I said above, I would just use "bool" instead of this new enum (it
> has two values too) or the new type needs to be documented.

As I said above, the enum has the good side of being easier to extend.
So, if we care about that, I guess I'd rather add a doc for the new
type.

> > +
> >  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > +unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> > +                                 enum schedutil_type type);
> > +
> >  static inline unsigned long cpu_bw_dl(struct rq *rq)
> >  {
> >         return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> > @@ -2199,6 +2207,12 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
> >  {
> >         return READ_ONCE(rq->avg_rt.util_avg);
> >  }
> > +#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> > +static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
> > +                                 enum schedutil_type type)
> > +{
> > +       return util;
> > +}
> >  #endif
> 
> And I would add a wrapper around schedutil_freq_util(), called say
> schedutil_energy_util(), that would pass a specific value as the
> "type".

OK, that's fine by me.

Other than that, do you think these changes could be done later ? Or do
you see that as mandatory before the patches can be picked up ?

Thanks,
Quentin
