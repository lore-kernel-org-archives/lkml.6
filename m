Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C577C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2320827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF2320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeKHAfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:35:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbeKHAfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:35:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49C880D;
        Wed,  7 Nov 2018 07:04:35 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D0C3F5BD;
        Wed,  7 Nov 2018 07:04:32 -0800 (PST)
Date:   Wed, 7 Nov 2018 15:04:30 +0000
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
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107150430.GL14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107133504.GQ9781@hirez.programming.kicks-ass.net>
 <20181107144809.GH14309@e110439-lin>
 <20181107145527.GI9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107145527.GI9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 15:55, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 02:48:09PM +0000, Patrick Bellasi wrote:
> > On 07-Nov 14:35, Peter Zijlstra wrote:
> > You mean se_count overflow ?
> 
> Yah..
> 
> > > And I'm not really a fan of hiding that error in a define like you keep
> > > doing.
> > 
> > The #define is not there to mask an overflow, it's there to catch the
> 
> +#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"
> 
> Is what I was talking about.
> 
> > > What's wrong with something like:
> > > 
> > > 	if (SCHED_WARN(free_group_id == UCLAMP_GROUPS))
> > > 		return;
> > 
> > Right, the flow should be:
> > 
> >   1. try to find a valid clamp group
> >   2. if you don't find one, the data structures are corrupted
> >      warn once for data corruption
> >      do not map this scheduling entity and return
> >   3. map the scheduling entity
> > 
> > Is that ok ?
> 
> That's what the proposed does.
> 
> > > and
> > > 
> > > > +	uc_map_new.se_count = uc_map_old.se_count + 1;
> > > 
> > > 	if (SCHED_WARN(!new.se_count))
> > > 		new.se_count = -1;
> > 
> > Mmm... not sure we can recover from a corrupted refcount or an
> > overflow.
> > 
> > What should we do on these cases, disable uclamp completely ?
> 
> You can teach put to never decrement -1 (aka. all 1s).

Still we don't know when re-enable -1 again...

But, with bucketization, this will eventually turns into a small
performance penalty at run-time when a CPU clamp group is going to be
empty (since we will end up scanning an array with some holes to find
out the new max)...  maybe still acceptable...

Will look into that for v6!

Thanks

> But its all SCHED_DEBUG stuff anyway, so who really cares.


-- 
#include <best/regards.h>

Patrick Bellasi
