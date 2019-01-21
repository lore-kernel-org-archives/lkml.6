Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D58C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292CB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfAUM1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:27:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32970 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfAUM1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:27:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 624BD80D;
        Mon, 21 Jan 2019 04:27:23 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DAB53F614;
        Mon, 21 Jan 2019 04:27:20 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:27:10 +0000
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
Subject: Re: [PATCH v6 03/16] sched/core: uclamp: Map TASK's clamp values
 into CPU's clamp buckets
Message-ID: <20190121122659.if6f4ubw2wgblxwi@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-4-patrick.bellasi@arm.com>
 <20190121101508.GH27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121101508.GH27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Jan 11:15, Peter Zijlstra wrote:
> On Tue, Jan 15, 2019 at 10:15:00AM +0000, Patrick Bellasi wrote:
> > +/*
> > + * Number of utilization clamp buckets.
> > + *
> > + * The first clamp bucket (bucket_id=0) is used to track non clamped tasks, i.e.
> > + * util_{min,max} (0,SCHED_CAPACITY_SCALE). Thus we allocate one more bucket in
> > + * addition to the compile time configured number.
> > + */
> > +#define UCLAMP_BUCKETS (CONFIG_UCLAMP_BUCKETS_COUNT + 1)
> > +
> > +/*
> > + * Utilization clamp bucket
> > + * @value:		clamp value tracked by a clamp bucket
> > + * @bucket_id:		the bucket index used by the fast-path
> > + * @mapped:		the bucket index is valid
> > + *
> > + * A utilization clamp bucket maps a:
> > + *   clamp value (value), i.e.
> > + *   util_{min,max} value requested from userspace
> > + * to a:
> > + *   clamp bucket index (bucket_id), i.e.
> > + *   index of the per-cpu RUNNABLE tasks refcounting array
> > + *
> > + * The mapped bit is set whenever a task has been mapped on a clamp bucket for
> > + * the first time. When this bit is set, any:
> > + *   uclamp_bucket_inc() - for a new clamp value
> > + * is matched by a:
> > + *   uclamp_bucket_dec() - for the old clamp value
> > + */
> > +struct uclamp_se {
> > +	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
> > +	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
> > +	unsigned int mapped		: 1;
> > +};
> 
> Do we want something like:
> 
> 	BUILD_BUG_ON(sizeof(struct uclamp_se) == sizeof(unsigned int));

Mmm... isn't "!=" what you mean ?

We cannot use less then an unsigned int for the fields above... am I
missing something?

> And/or put a limit on CONFIG_UCLAMP_BUCKETS_COUNT that guarantees that ?

The number of buckets is currently KConfig limited to a max of 20, which gives:

   UCLAMP_BUCKETS: 21 => 5bits

Thus, even on 32 bit targets and assuming 21bits for an "extended"
SCHED_CAPACITY_SCALE range we should always fit into an unsigned int
and have at least 6 bits for flags.

Are you afraid of some compiler magic related to bitfields packing ?

-- 
#include <best/regards.h>

Patrick Bellasi
