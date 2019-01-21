Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ACCC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DE62089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IueQTxVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfAUMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:51:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfAUMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=40LtdF75kj72Y8+CkoBmhdcWUTk8s4S5td/po7h0f9g=; b=IueQTxVQlRfmyC3kFHMmAS/P1
        D/J+fyyk07alK8ls5REqklkc6k4ku32YspFmkqFrpjAW8GCpAzvLNsFxRxDBCsuRgAbrZDq9kp/j3
        F+ojYEeEOqvG/X7It63++rAOmy68/GtJkDEqOF3h5vLJMWw8KVr8gLop8LQACd6LioC3A+X6m6M2B
        BVZnNNERaTcEyaWvsBfg/QpF32KWL4O7onVrO5vXNYebfCLHEKbg8H6nHrkBAGZLnQPhJDMshg0eY
        KEZswwO12chIuHXo7WHReGFStwI7kDSIomyMQLnYS15E8wGbY0+6LNagsMyKfeO1M+aHblope2tnS
        IX61Sf3Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glZ2x-0003jR-SV; Mon, 21 Jan 2019 12:51:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C43A2846CE22; Mon, 21 Jan 2019 13:51:20 +0100 (CET)
Date:   Mon, 21 Jan 2019 13:51:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20190121125120.GB17749@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-4-patrick.bellasi@arm.com>
 <20190121101508.GH27931@hirez.programming.kicks-ass.net>
 <20190121122659.if6f4ubw2wgblxwi@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121122659.if6f4ubw2wgblxwi@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:27:10PM +0000, Patrick Bellasi wrote:
> On 21-Jan 11:15, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:15:00AM +0000, Patrick Bellasi wrote:
> > > +/*
> > > + * Number of utilization clamp buckets.
> > > + *
> > > + * The first clamp bucket (bucket_id=0) is used to track non clamped tasks, i.e.
> > > + * util_{min,max} (0,SCHED_CAPACITY_SCALE). Thus we allocate one more bucket in
> > > + * addition to the compile time configured number.
> > > + */
> > > +#define UCLAMP_BUCKETS (CONFIG_UCLAMP_BUCKETS_COUNT + 1)
> > > +
> > > +/*
> > > + * Utilization clamp bucket
> > > + * @value:		clamp value tracked by a clamp bucket
> > > + * @bucket_id:		the bucket index used by the fast-path
> > > + * @mapped:		the bucket index is valid
> > > + *
> > > + * A utilization clamp bucket maps a:
> > > + *   clamp value (value), i.e.
> > > + *   util_{min,max} value requested from userspace
> > > + * to a:
> > > + *   clamp bucket index (bucket_id), i.e.
> > > + *   index of the per-cpu RUNNABLE tasks refcounting array
> > > + *
> > > + * The mapped bit is set whenever a task has been mapped on a clamp bucket for
> > > + * the first time. When this bit is set, any:
> > > + *   uclamp_bucket_inc() - for a new clamp value
> > > + * is matched by a:
> > > + *   uclamp_bucket_dec() - for the old clamp value
> > > + */
> > > +struct uclamp_se {
> > > +	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
> > > +	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
> > > +	unsigned int mapped		: 1;
> > > +};
> > 
> > Do we want something like:
> > 
> > 	BUILD_BUG_ON(sizeof(struct uclamp_se) == sizeof(unsigned int));
> 
> Mmm... isn't "!=" what you mean ?

Quite.

> We cannot use less then an unsigned int for the fields above... am I
> missing something?

I wanted to ensure we don't accidentally use more.

> > And/or put a limit on CONFIG_UCLAMP_BUCKETS_COUNT that guarantees that ?
> 
> The number of buckets is currently KConfig limited to a max of 20, which gives:
> 
>    UCLAMP_BUCKETS: 21 => 5bits
> 
> Thus, even on 32 bit targets and assuming 21bits for an "extended"
> SCHED_CAPACITY_SCALE range we should always fit into an unsigned int
> and have at least 6 bits for flags.
> 
> Are you afraid of some compiler magic related to bitfields packing ?

Nah, I missed the Kconfig limit and was afraid that some weird configs
would end up with massively huge structures.
