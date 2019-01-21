Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E0C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E94A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbseC1Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfAUQMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:12:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAUQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=goDf/S+73Gxd3RHhen0nzqCzpgPoOwg9sSQWL8cjuwU=; b=pbseC1XltAPqeTTHg2HT393G+
        DgIYpJuqZJnU6SbNUbxQpUkSWaprQAfh52cvLH0KpoQkJbFifXYWE5dR1C3GAiFBXfTKpHInS4gPY
        z4rz4cGkeiO5OXt0lpf+q4Oz+nSrFtqmuBWUpZ34LEKzSwjGIsfMBt4budaR0j8aqJBpxJyfvvOzo
        7V1GfBpy8HoH3cLGouk5sMYRMhZD2LWG98NsQsqlXg8rZFozPqlgrecB7NNy7rPevkj/MWgaxvPtl
        DeLRrHk4U3EGEaBvqUxNlMsm0XsEtVCfA7AME2ZSRJlxPWJnn8wbEAl5qtvCYdUjqIDZKXk2dw0g0
        bC3e5OxPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glcBk-000296-Bb; Mon, 21 Jan 2019 16:12:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E345E28470710; Mon, 21 Jan 2019 17:12:37 +0100 (CET)
Date:   Mon, 21 Jan 2019 17:12:37 +0100
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
Subject: Re: [PATCH v6 04/16] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190121161237.GB13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
 <20190121145929.GI27931@hirez.programming.kicks-ass.net>
 <20190121152311.7u7bwbjopuptnzcy@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121152311.7u7bwbjopuptnzcy@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:23:11PM +0000, Patrick Bellasi wrote:
> On 21-Jan 15:59, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:15:01AM +0000, Patrick Bellasi wrote:
> > > @@ -835,6 +954,28 @@ static void uclamp_bucket_inc(struct uclamp_se *uc_se, unsigned int clamp_id,
> > >  	} while (!atomic_long_try_cmpxchg(&uc_maps[bucket_id].adata,
> > >  					  &uc_map_old.data, uc_map_new.data));
> > >  
> > > +	/*
> > > +	 * Ensure each CPU tracks the correct value for this clamp bucket.
> > > +	 * This initialization of per-CPU variables is required only when a
> > > +	 * clamp value is requested for the first time from a slow-path.
> > > +	 */
> > 
> > I'm confused; why is this needed?
> 
> That's a lazy initialization of the per-CPU uclamp data for a given
> bucket, i.e. the clamp value assigned to a bucket, which happens only
> when new clamp values are requested... usually only at system
> boot/configuration time.
> 
> For example, let say we have these buckets mapped to given clamp
> values:
> 
>  bucket_#0: clamp value: 10% (mapped)
>  bucket_#1: clamp value: 20% (mapped)
>  bucket_#2: clamp value: 30% (mapped)
> 
> and then let's assume all the users of bucket_#1 are "destroyed", i.e.
> there are no more tasks, system defaults or cgroups asking for a
> 20% clamp value. The corresponding bucket will become free:
> 
>  bucket_#0: clamp value: 10% (mapped)
>  bucket_#1: clamp value: 20% (free)
>  bucket_#2: clamp value: 30% (mapped)
> 
> If, in the future, we ask for a new clamp value, let say a task ask
> for a 40% clamp value, then we need to map that value into a bucket.
> Since bucket_#1 is free we can use it to fill up the hold and keep all
> the buckets in use at the beginning of a cache line.
> 
> However, since now bucket_#1 tracks a different clamp value (40
> instead of 20) we need to walk all the CPUs and updated the cached
> value:
> 
>  bucket_#0: clamp value: 10% (mapped)
>  bucket_#1: clamp value: 40% (mapped)
>  bucket_#2: clamp value: 30% (mapped)
> 
> Is that more clear ?

Yes, and I realized this a little while after sending this; but I'm not
sure I have an answer to why though.

That is; why isn't the whole thing hard coded to have:

 bucket_n: clamp value: n*UCLAMP_BUCKET_DELTA

We already do that division anyway (clamp_value / UCLAMP_BUCKET_DELTA),
and from that we instantly have the right bucket index. And that allows
us to initialize all this beforehand.

> and keep all
> the buckets in use at the beginning of a cache line.

That; is that the rationale for all this? Note that per the defaults
everything is in a single line already.


