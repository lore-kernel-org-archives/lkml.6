Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD06C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD81521872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTTZfobR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfAWTWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:22:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfAWTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+6SD0OYNOxnHcBdEztiu/3ECz9rNk+lEt4oyxeaJ9o0=; b=RTTZfobRMRLvGBkjLrP3btZ+p
        SGnOfIp9xN3aGJvABwFTVUacBcoEMIFpFQ5bOx5mKrDqEV7p4g+6oXmZZyLlZxGlKqGliPoGYxJkV
        FqrY6+5B4z5P6R0oukK3ysCSEmFoKR71qN5p+sLSRZv8li/HwtNHKRQgpZ5qiimXgzMDHch9/GQiJ
        Wpqdfpu1jH2opc7OaAT5EBlJ3Q37dbZ8yZacuk76mhxZhte86YtC5Cv1bWNFpiX1QSqsRVWGRzuJ8
        PFdX21K2RHU2+TMzV/z2eC/LFetFxf2whH8nmhzV+l8nX3bIb9jsewzqcLtKTs/UqkNXecQ4Ohylm
        2YUQwfjtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmO66-0003Gj-QI; Wed, 23 Jan 2019 19:22:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49C51236EC0D9; Wed, 23 Jan 2019 20:22:01 +0100 (CET)
Date:   Wed, 23 Jan 2019 20:22:01 +0100
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
Subject: Re: [PATCH v6 10/16] sched/core: Add uclamp_util_with()
Message-ID: <20190123192201.GK13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-11-patrick.bellasi@arm.com>
 <20190123133324.GY27931@hirez.programming.kicks-ass.net>
 <20190123145106.zaqb3d6l65rs5lg6@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123145106.zaqb3d6l65rs5lg6@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:51:06PM +0000, Patrick Bellasi wrote:
> On 23-Jan 14:33, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:15:07AM +0000, Patrick Bellasi wrote:
> > > +static __always_inline
> > > +unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> > > +			      struct task_struct *p)
> > >  {
> > >  	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> > >  	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> > >  
> > > +	if (p) {
> > > +		min_util = max(min_util, uclamp_effective_value(p, UCLAMP_MIN));
> > > +		max_util = max(max_util, uclamp_effective_value(p, UCLAMP_MAX));
> > > +	}
> > > +
> > 
> > Like I think you mentioned earlier; this doesn't look right at all.
> 
> What we wanna do here is to compute what _will_ be the clamp values of
> a CPU if we enqueue *p on it.
> 
> The code above starts from the current CPU clamp value and mimics what
> uclamp will do in case we move the task there... which is always a max
> aggregation.

Ah, then I misunderstood the purpose of this function.

> > Should that not be something like:
> > 
> > 	lo = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> > 	hi = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> > 
> > 	min_util = clamp(uclamp_effective(p, UCLAMP_MIN), lo, hi);
> > 	max_util = clamp(uclamp_effective(p, UCLAMP_MAX), lo, hi);
> 
> Here you end up with a restriction of the task clamp (effective)
> clamps values considering the CPU clamps... which is different.
> 
> Why do you think we should do that?... perhaps I'm missing something.

I was left with the impression from patch 7 that we don't compose clamps
right and throught that was what this code was supposed to do.

I'll have another look at this patch.
