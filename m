Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A132084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAVKbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:31:13 -0500
Received: from foss.arm.com ([217.140.101.70]:50298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfAVKbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:31:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F8AEBD;
        Tue, 22 Jan 2019 02:31:12 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24903F6A8;
        Tue, 22 Jan 2019 02:31:09 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:31:07 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v6 04/16] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190122103107.vulmhrucl3vtjiop@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
 <20190121145929.GI27931@hirez.programming.kicks-ass.net>
 <20190121152311.7u7bwbjopuptnzcy@e110439-lin>
 <20190121161237.GB13777@hirez.programming.kicks-ass.net>
 <20190121163337.6l7hkggicndtpzjs@e110439-lin>
 <20190122094507.GN27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122094507.GN27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jan 10:45, Peter Zijlstra wrote:
> On Mon, Jan 21, 2019 at 04:33:38PM +0000, Patrick Bellasi wrote:
> > On 21-Jan 17:12, Peter Zijlstra wrote:
> > > On Mon, Jan 21, 2019 at 03:23:11PM +0000, Patrick Bellasi wrote:
> 
> > > > and keep all
> > > > the buckets in use at the beginning of a cache line.
> > > 
> > > That; is that the rationale for all this? Note that per the defaults
> > > everything is in a single line already.
> > 
> > Yes, that's because of the loop in:
> > 
> >    dequeue_task()
> >      uclamp_cpu_dec()
> >        uclamp_cpu_dec_id()
> >          uclamp_cpu_update()
> > 
> > where buckets needs sometimes to be scanned to find a new max.
> > 
> > Consider also that, with mapping, we can more easily increase the
> > buckets count to 20 in order to have a finer clamping granularity if
> > needed without warring too much about performance impact especially
> > when we use anyway few different clamp values.
> > 
> > So, I agree that mapping adds (code) complexity but it can also save
> > few cycles in the fast path... do you think it's not worth the added
> > complexity?
> 
> Then maybe split this out in a separate patch? Do the trivial linear
> bucket thing first and then do this smarty pants thing on top.
> 
> One problem with the scheme is that it doesn't defrag; so if you get a
> peak usage, you can still end up with only two active buckets in
> different lines.

You right, that was saved for a later optimization. :/

Mainly in consideration of the fact that, at least for the main usage
we have in mind on Android, we will likely configure all the required
clamps once for all at boot time.

> Also; if it is it's own patch, you get a much better view of the
> additional complexity and a chance to justify it ;-)

What about ditching the mapping for the time being and see if we
get a real overhead hit in the future ?

At that point we will revamp the mapping patch with also a proper
defrag support.

> Also; would it make sense to do s/cpu/rq/ on much of this? All this
> uclamp_cpu_*() stuff really is per rq and takes rq arguments, so why
> does it have cpu in the name... no strong feelings, just noticed it and
> thought is a tad inconsistent.

The idea behind using "cpu" instead of "rq" was that we use those only at
root rq level and the clamps are aggregated per-CPU.

I remember one of the first versions used "cpu" instead of "rq" as a
parameter name and you proposed to change it as an optimization since
we call it from dequeue_task() where we already have a *rq.

... but, since we have those uclamp data within struct rq, I think you
are right: it makes more sense to rename the functions.

Will do it in v7, thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
