Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D35C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550C52159D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550C52159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeHMMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:54:05 -0400
Received: from foss.arm.com ([217.140.101.70]:56458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbeHMMyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97F417A9;
        Mon, 13 Aug 2018 03:12:30 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED3363F5D0;
        Mon, 13 Aug 2018 03:12:27 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:12:21 +0100
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
        "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180813101221.GA2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
 <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent!

On 09-Aug 18:03, Vincent Guittot wrote:
> > On 07-Aug 15:26, Juri Lelli wrote:

[...]

> > > > +   util_cfs = cpu_util_cfs(rq);
> > > > +   util_rt  = cpu_util_rt(rq);
> > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > +           util = 0;
> > > > +           if (util_cfs)
> > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > +           if (util_rt)
> > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > +   } else {
> > > > +           util  = cpu_util_cfs(rq);
> > > > +           util += cpu_util_rt(rq);
> > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > +   }
> >
> > Regarding the two policies, do you have any comment?
> 
> Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> make sense as it is ?
> I mean, uclamp_util doesn't make any difference between rt and cfs
> tasks when clamping the utilization so why should be add twice the
> returned value ?
> IMHO, this policy would make sense if there were something like
> uclamp_util_rt() and a uclamp_util_cfs()

The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
low-priority classese, especially when we have high RT utilization.

Let say we have:

 util_rt  = 40%, util_min=0%
 util_cfs = 10%, util_min=50%

the two policies will select:

  UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
 !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%

Which means that, despite the CPU's util_min will be set to 50% when
CFS is running, these tasks will have almost no boost at all, since
their bandwidth margin is eclipsed by RT tasks.

> > We had an internal discussion and we found pro/cons for both... but

The UCLAMP_SCHED_CLASS policy is thus less energy efficiency but it
should grant a better "isolation" in terms of what is the expected
speed-up a task will get at run-time, independently from higher
priority classes.

Does that make sense?

> > I'm not sure keeping the sched_feat is a good solution on the long
> > run, i.e. mainline merge ;)

This problem still stands...

-- 
#include <best/regards.h>

Patrick Bellasi
