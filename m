Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723BE21524
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723BE21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeHILid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:38:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbeHILid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:38:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA80C18A;
        Thu,  9 Aug 2018 02:14:37 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEDF3F5D4;
        Thu,  9 Aug 2018 02:14:32 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:14:27 +0100
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
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180809091427.4p2c4fbxocpkjaby@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807123550.GA3062@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807123550.GA3062@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Aug 14:35, Juri Lelli wrote:
> On 06/08/18 17:39, Patrick Bellasi wrote:
> 
> [...]
> 
> > @@ -4218,6 +4245,13 @@ static int __sched_setscheduler(struct task_struct *p,
> >  			return retval;
> >  	}
> >  
> > +	/* Configure utilization clamps for the task */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> > +		retval = __setscheduler_uclamp(p, attr);
> > +		if (retval)
> > +			return retval;
> > +	}
> > +
> 
> IIUC, this is available to root and non-root users. In the latter case,
> how do we cope with the fact that some user might occupy all the
> available clamping groups configured for the system?

That's a very good point, glad you noticed it.

What concern me most is that we set constraints to the cgroups
delegation model. If all clamp groups have been used it could be
not possible for a parent group to shrink resources for its subgroups.

In both cases however, in principle, I think we can live with the idea
that the "System Management Software" (SMS) can pre-allocate all the
required boost groups at boot time;  malicious tasks and dependent
groups will eventually get an -ENOSPC error.

These are the main reason why I did not posted a more "safe" solution:
this series is already big enough, a properly (pre)configured system
is still reasonably functional safe and  this feature can be added in
a second step.

However, I already have a couple of possible extensions/fixes which I
can add on top on the next respin. They are along these lines:
1) make CAP_SYS_NICE protected the clamp groups, with an optional boot
   time parameter to relax this check
2) add discretization support to clamp groups allocation

This second feature specifically, will ensure that clamp values are
always mapped into one of the available clamp groups. While the exact
clamp value can always be used for tasks placement biasing, when it
comes to frequency selection biasing, depending on concurrently
running tasks, you can end up with an effective clamp value which is a
rounded up.

Will likely add a couple of additional patches on v4 posting.
Do you have any other possible idea?

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
