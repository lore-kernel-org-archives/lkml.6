Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ABFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC93420685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC93420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395487AbeKWBA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:00:26 -0500
Received: from foss.arm.com ([217.140.101.70]:50258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389042AbeKWBAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:00:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B03C36B4;
        Thu, 22 Nov 2018 06:20:51 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4F43F5AF;
        Thu, 22 Nov 2018 06:20:48 -0800 (PST)
Date:   Thu, 22 Nov 2018 14:20:45 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 04/15] sched/core: uclamp: add CPU's clamp groups
 refcounting
Message-ID: <20181122142045.GM14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-6-patrick.bellasi@arm.com>
 <20181111164754.GA3038@worktop>
 <20181113151127.GA7681@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181113151127.GA7681@darkstar>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Nov 07:11, Patrick Bellasi wrote:
> On 11-Nov 17:47, Peter Zijlstra wrote:
> > On Mon, Oct 29, 2018 at 06:32:59PM +0000, Patrick Bellasi wrote:

[...]

> > > +		/* Both min and max clamps are MAX aggregated */
> > > +		if (max_value < rq->uclamp.group[clamp_id][group_id].value)
> > > +			max_value = rq->uclamp.group[clamp_id][group_id].value;
> > 
> > 		max_value = max(max_value, rq->uclamp.group[clamp_id][group_id].value);
> 
> Right, I get used to this pattern to avoid write instructions.
> I guess that here, being just a function local variable, we don't
> really care much...

The above does not work also because we now use bitfields:

In file included from ./include/linux/list.h:9:0,
                 from ./include/linux/rculist.h:10,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from kernel/sched/sched.h:5,
                 from kernel/sched/core.c:8:
   kernel/sched/core.c: In function ‘uclamp_cpu_update’:
   kernel/sched/core.c:867:5: error: ‘typeof’ applied to a bit-field
           rq->uclamp.group[clamp_id][group_id].value);
           ^

[...]

> > > +	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
> > > +		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
> > 
> > 	rq->uclamp.value[clamp_id] = max(rq->uclamp.value[clamp_id],
> > 					 p->uclamp[clamp_id].value);
> 
> In this case instead, since we are updating a variable visible from
> other CPUs, should not be preferred to avoid assignment when not
> required ?

And what about this ?

> Is the compiler is smart enough to optimize the code above?
> ... will check better.

Did not really checked what the compiler does in the two cases but,
given also the above, for consistency I would probably prefer to keep
both max aggregation as originally defined.

What do you think ?

-- 
#include <best/regards.h>

Patrick Bellasi
