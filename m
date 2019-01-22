Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FFBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBF720879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B5YqQXIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfAVJpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:45:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfAVJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sZa+wKfGdynh6C+yxUM26dT34VAjzflHBGafSA9mNMU=; b=B5YqQXIG576tSTDwoUMJmgz5G
        FyVJeHm2zNsIM5xj3A1pn+HfU/gqLaMS/+qPsm62Vqg3zf+mjK21mgRhz/b60FqcFiEc0u5V4gopX
        lWNFtjtFrq/y8tNieeBl9rzG9637Ge5bzWARbQ4LjOOFn72K32jgUVvCRWabjFsU+rvbhBRDgd29g
        n2A0I/IJWoGm1HtsVTEpTuXyzcJvVkkOXjNl7d25Y8+j5g2ug/2WI7lEZvi4ypRCf86bwD6Qj770I
        v3VarhTZ9FWARJXmSeqPN0lMNomG9oFzZX/9IDScdEW9Xcsma/4FP+BQzcoJ++76cisUOJ3PKZWwP
        YRJvMYsVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glscH-0005pG-8W; Tue, 22 Jan 2019 09:45:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB2EC211A59B4; Tue, 22 Jan 2019 10:45:07 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:45:07 +0100
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
Message-ID: <20190122094507.GN27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
 <20190121145929.GI27931@hirez.programming.kicks-ass.net>
 <20190121152311.7u7bwbjopuptnzcy@e110439-lin>
 <20190121161237.GB13777@hirez.programming.kicks-ass.net>
 <20190121163337.6l7hkggicndtpzjs@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121163337.6l7hkggicndtpzjs@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:33:38PM +0000, Patrick Bellasi wrote:
> On 21-Jan 17:12, Peter Zijlstra wrote:
> > On Mon, Jan 21, 2019 at 03:23:11PM +0000, Patrick Bellasi wrote:

> > > and keep all
> > > the buckets in use at the beginning of a cache line.
> > 
> > That; is that the rationale for all this? Note that per the defaults
> > everything is in a single line already.
> 
> Yes, that's because of the loop in:
> 
>    dequeue_task()
>      uclamp_cpu_dec()
>        uclamp_cpu_dec_id()
>          uclamp_cpu_update()
> 
> where buckets needs sometimes to be scanned to find a new max.
> 
> Consider also that, with mapping, we can more easily increase the
> buckets count to 20 in order to have a finer clamping granularity if
> needed without warring too much about performance impact especially
> when we use anyway few different clamp values.
> 
> So, I agree that mapping adds (code) complexity but it can also save
> few cycles in the fast path... do you think it's not worth the added
> complexity?

Then maybe split this out in a separate patch? Do the trivial linear
bucket thing first and then do this smarty pants thing on top.

One problem with the scheme is that it doesn't defrag; so if you get a
peak usage, you can still end up with only two active buckets in
different lines.

Also; if it is it's own patch, you get a much better view of the
additional complexity and a chance to justify it ;-)

Also; would it make sense to do s/cpu/rq/ on much of this? All this
uclamp_cpu_*() stuff really is per rq and takes rq arguments, so why
does it have cpu in the name... no strong feelings, just noticed it and
thought is a tad inconsistent.
