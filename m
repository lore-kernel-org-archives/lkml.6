Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF5CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3160A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3160A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeIFV6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:58:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeIFV6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:58:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF307A9;
        Thu,  6 Sep 2018 10:21:53 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6D13F557;
        Thu,  6 Sep 2018 10:21:50 -0700 (PDT)
Date:   Thu, 6 Sep 2018 18:21:45 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180906172145.GA20623@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180906145936.GF27626@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906145936.GF27626@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Sep 16:59, Juri Lelli wrote:
> On 06/09/18 15:40, Patrick Bellasi wrote:
> > On 04-Sep 15:47, Juri Lelli wrote:
> 
> [...]
> 
> > > Wondering if you want to fold the check below inside the
> > > 
> > >  if (user && !capable(CAP_SYS_NICE)) {
> > >    ...
> > >  }
> > > 
> > > block. It would also save you from adding another parameter to the
> > > function.
> > 
> > So, there are two reasons for that:
> > 
> > 1) _I think_ we don't want to depend on capable(CAP_SYS_NICE) but
> >    instead on capable(CAP_SYS_ADMIN)
> > 
> >    Does that make sense ?
> > 
> >    If yes, the I cannot fold it in the block you reported above
> >    because we will not check for users with CAP_SYS_NICE.
> 
> Ah, right, not sure though. Looks like CAP_SYS_NICE is used for settings
> that relates to priorities, affinity, etc.: CPU related stuff. Since
> here you are also dealing with something that seems to fall into the
> same realm, it might actually fit more than CAP_SYS_ADMIN?

Yes and no... from the functional standpoint if a task is running in
the root cgroup, or cgroups are not in use at all, with this API a
task can always ask for the max OPP. Which is what CAP_SYS_NICE is
there for AFAIU... but...

... this check was meant also to fix the issue of the limited number
of clamp groups. That's why I'm now asking for CAP_SYS_ADMIN.

However, I would say that if we condsider to get in also the
discretization support introduced in:

   [PATCH v4 15/16] sched/core: uclamp: add clamp group discretization support
   https://lore.kernel.org/lkml/20180828135324.21976-16-patrick.bellasi@arm.com/

then yes, we remain with the "nice" semantics to cover, and
CAP_SYS_NICE could be just enough.

> Now that I think more about it, would it actually make sense to allow
> unpriviledged users to lower their assigned umin/umax properties if they
> want? Something alike what happens for nice values or RT priorities.

Yes... if we fix the issue with the limited clamp groups, i.e. we take
discretization in.

> > 2) Then we could move it after that block, where there is another
> >    set of checks with just:
> > 
> >       if (user) {
> > 
> >    We can potentially add the check there yes... but when uclamp is
> >    not enabled we will still perform those checks or we have to add
> >    some compiler guards...
> > 
> > 3) ... or at least check for:
> > 
> >      if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> > 
> >    Which is what I'm doing right after the block above (2).
> > 
> >    But, at this point, by passing in the parameter to the
> >    __setscheduler_uclamp() call, I get the benefits of:
> > 
> >    a) reducing uclamp specific code in the caller
> >    b) avoiding the checks on !CONFIG_UCLAMP_TASK build
> > 
> > > >  {
> > > >  	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > > >  	int lower_bound, upper_bound;
> > > >  	struct uclamp_se *uc_se;
> > > >  	int result = 0;
> > > >  
> > > > +	if (!capable(CAP_SYS_ADMIN) &&
> > > > +	    user && !uclamp_user_allowed) {
> > > > +		return -EPERM;
> > > > +	}
> > > > +
> > 
> > Does all the above makes sense ?
> 
> If we agree on CAP_SYS_ADMIN, however, your approach looks cleaner yes.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
