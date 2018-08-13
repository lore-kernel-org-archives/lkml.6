Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E446C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BD02172A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BD02172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeHMPbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:31:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58120 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMPbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:31:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B8518A;
        Mon, 13 Aug 2018 05:49:16 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976E53F5D0;
        Mon, 13 Aug 2018 05:49:13 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:49:11 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Cc: Steve Muckle" <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180813124911.GD2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
 <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin>
 <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Aug 14:07, Vincent Guittot wrote:
> On Mon, 13 Aug 2018 at 12:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > Hi Vincent!
> >
> > On 09-Aug 18:03, Vincent Guittot wrote:
> > > > On 07-Aug 15:26, Juri Lelli wrote:
> >
> > [...]
> >
> > > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > > +           util = 0;
> > > > > > +           if (util_cfs)
> > > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > > +           if (util_rt)
> > > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > > +   } else {
> > > > > > +           util  = cpu_util_cfs(rq);
> > > > > > +           util += cpu_util_rt(rq);
> > > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > > +   }
> > > >
> > > > Regarding the two policies, do you have any comment?
> > >
> > > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > > make sense as it is ?
> > > I mean, uclamp_util doesn't make any difference between rt and cfs
> > > tasks when clamping the utilization so why should be add twice the
> > > returned value ?
> > > IMHO, this policy would make sense if there were something like
> > > uclamp_util_rt() and a uclamp_util_cfs()
> >
> > The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> > low-priority classese, especially when we have high RT utilization.
> >
> > Let say we have:
> >
> >  util_rt  = 40%, util_min=0%
> >  util_cfs = 10%, util_min=50%
> >
> > the two policies will select:
> >
> >   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
> >  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
> >
> > Which means that, despite the CPU's util_min will be set to 50% when
> > CFS is running, these tasks will have almost no boost at all, since
> > their bandwidth margin is eclipsed by RT tasks.
> 
> Hmm ... At the opposite, even if there is no running rt task but only
> some remaining blocked rt utilization,
> even if util_rt  = 10%, util_min=0%
> and  util_cfs = 40%, util_min=50%
> the UCLAMP_SCHED_CLASS: util = uclamp(10) + uclamp(40) = 50 + 50   = 100%

Yes, that's true... since now I clamp util_rt if it's non zero.
Perhaps this can be fixed by clamping util_rt only:
  if (rt_rq_is_runnable(&rq->rt))
?

> So cfs task can get double boosted by a small rt task.

Well, in principle we don't know if the 50% clamp was asserted by the
RT or the CFS task, since in the current implementation we max
aggregate clamp values across all RT and CFS tasks.

> Furthermore, if there is no rt task but 2 cfs tasks of 40% and 10%
> the UCLAMP_SCHED_CLASS: util = uclamp(0) + uclamp(40) = 50   = 50%

True, but here we are within the same class and what utilization
clamping aims to do is to defined the minimum capacity to run _all_
the RUNNABLE tasks... not the minimum capacity for _each_ one of them.

> So in this case cfs tasks don't get more boost and have to share the
> bandwidth and you don't ensure 50% for each unlike what you try to do
> for rt.

Above I'm not trying to fix a per-task issue. The UCLAMP_SCHED_CLASS
policy is just "trying" to fix a cross-class issue... if we agree
there can be a cross-class issue worth to be fixed.

> You create a difference in the behavior depending of the class of the
> others co-schedule tasks which is not sane IMHO

Yes I agree that the current behavior is not completely clean... still
the question is: do you reckon the problem I depicted above, i.e. RT
workloads eclipsing the min_util required by lower priority classes?

To a certain extend I see this problem similar to the rt/dl/irq pressure
in defining cpu_capacity, isn't it?

Maybe we can make use of (cpu_capacity_orig - cpu_capacity) to factor
in a util_min compensation for CFS tasks?

-- 
#include <best/regards.h>

Patrick Bellasi
