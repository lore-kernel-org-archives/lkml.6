Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED39C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F17217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfAVPlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:41:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfAVPlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:41:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE1BA78;
        Tue, 22 Jan 2019 07:41:35 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB013F589;
        Tue, 22 Jan 2019 07:41:32 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:41:29 +0000
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
Subject: Re: [PATCH v6 07/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190122154129.mxnpgaoxnccbjbch@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-8-patrick.bellasi@arm.com>
 <20190122135644.GP27931@hirez.programming.kicks-ass.net>
 <20190122144329.ziimv6fejwvky7yb@e110439-lin>
 <20190122151317.GH13777@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122151317.GH13777@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jan 16:13, Peter Zijlstra wrote:
> On Tue, Jan 22, 2019 at 02:43:29PM +0000, Patrick Bellasi wrote:
> > On 22-Jan 14:56, Peter Zijlstra wrote:
> > > On Tue, Jan 15, 2019 at 10:15:04AM +0000, Patrick Bellasi wrote:
> > > 
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index 84294925d006..c8f391d1cdc5 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -625,6 +625,11 @@ struct uclamp_se {
> > > >  	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
> > > >  	unsigned int mapped		: 1;
> > > >  	unsigned int active		: 1;
> > > > +	/* Clamp bucket and value actually used by a RUNNABLE task */
> > > > +	struct {
> > > > +		unsigned int value	: bits_per(SCHED_CAPACITY_SCALE);
> > > > +		unsigned int bucket_id	: bits_per(UCLAMP_BUCKETS);
> > > > +	} effective;
> > > 
> > > I am confuzled by this thing..  so uclamp_se already has a value,bucket,
> > > which per the prior code is the effective one.
> > > 
> > > Now; I think I see why you want another value; you need the second to
> > > store the original value for when the system limits change and we must
> > > re-evaluate.
> > 
> > Yes, that's one reason, the other one being to properly support
> > CGroup when we add them in the following patches.
> > 
> > Effective will always track the value/bucket in which the task has
> > been refcounted at enqueue time and it depends on the aggregated
> > value.
> 
> > > Should you not update all tasks?
> > 
> > That's true, but that's also an expensive operation, that's why now
> > I'm doing only lazy updates at next enqueue time.
> 
> Aaah, so you refcount on the original value, which allows you to skip
> fixing up all tasks. I missed that bit.

Right, effective is always tracking the bucket we refcounted at
enqueue time.

We can still argue that, the moment we change a clamp, a task should
be updated without waiting for a dequeue/enqueue cycle.

IMO, that could be a limitation only for tasks which never sleep, but
that's a very special case.

Instead, as you'll see, in the cgroup integration we force update all
RUNNABLE tasks. Although that's expensive, since we are in the domain
of the "delegation model" and "containers resources control", there
it's probably more worth to pay than here.

> > Do you think that could be acceptable?
> 
> Think so, it's a sysctl poke, 'nobody' ever does that.

Cool, so... I'll keep lazy update for system default.

-- 
#include <best/regards.h>

Patrick Bellasi
