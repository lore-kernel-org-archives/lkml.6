Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8DC2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfAXMil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:38:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56102 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfAXMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:38:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D12B6EBD;
        Thu, 24 Jan 2019 04:38:40 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3FC3F237;
        Thu, 24 Jan 2019 04:38:37 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:38:35 +0000
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
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190124123835.nliwk2onvrhe5aqf@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
 <20190123104944.GX27931@hirez.programming.kicks-ass.net>
 <20190123144011.iid3avb63r5v4r2c@e110439-lin>
 <20190123201146.GH17749@hirez.programming.kicks-ass.net>
 <20190124123009.2yulcf25ld66popd@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124123009.2yulcf25ld66popd@e110439-lin>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Jan 12:30, Patrick Bellasi wrote:
> On 23-Jan 21:11, Peter Zijlstra wrote:
> > On Wed, Jan 23, 2019 at 02:40:11PM +0000, Patrick Bellasi wrote:
> > > On 23-Jan 11:49, Peter Zijlstra wrote:
> > > > On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:

[...]

> > I'm thikning that if we haz a single bit, say:
> > 
> >   struct uclamp_se {
> > 	...
> > 	unsigned int	changed : 1;
> >   };
> > 
> > We can update uclamp_se::value and set uclamp_se::changed, and then the
> > next enqueue will (unlikely) test-and-clear changed and recompute the
> > bucket_id.
> 
> This mean will lazy update the "requested" bucket_id by deferring its
> computation at enqueue time. Which saves us a copy of the bucket_id,
> i.e. we will have only the "effective" value updated at enqueue time.
> 
> But...
> 
> > Would that not be simpler?
> 
> ... although being simpler it does not fully exploit the slow-path,
> a syscall which is usually running from a different process context
> (system management software).
> 
> It also fits better for lazy updates but, in the cgroup case, where we
> wanna enforce an update ASAP for RUNNABLE tasks, we will still have to
> do the updates from the slow-path.
> 
> Will look better into this simplification while working on v7, perhaps
> the linear mapping can really help in that too.

Actually, I forgot to mention that:

    uclamp_se::effective::{
        value, bucket_id
    }

will be still required to proper support the cgroup delegation model,
where a child group could be restricted by the parent but we want to
keep track of the original "requested" value for when the parent
should relax the restriction.

Thus, since effective values are already there, why not using them
also to pre-compute the new requested bucket_id from the slow path?

-- 
#include <best/regards.h>

Patrick Bellasi
