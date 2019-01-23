Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC54C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDBF2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wg4QR/xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfAWTKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:10:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWTKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WR9PUrRzUHma+Z7YOmuyL5asuyyyFMfZUNkzeEZT7Xw=; b=Wg4QR/xKdD2VqbA6sZua2U0vF
        83H5qKeRVt47aKzlbF/c8UanYJUfK29oMo6RcF+lgzon7fd/upEUrB0WA6xdiFWcLc2CsOAUH3Tni
        hS2Ch0x0gHznAUuxQVXq/oN+vT5yEk1qyU2L36nHCwEzp2Mh2esTB61qsdQzWf/bMwlbbCP474HHr
        A/QIjzgtBWyRKzq5EX/XEJ7mMw6Hvf0oOumGjJyAI8rs5Br+WBPrgChkGtZZdhKCmvkBxN4iz6yRu
        fqLDZj8659YgC5NINqmyuFNYewf76J8bAYZHW1vPraOq7jKJf3HDWZ9+uZGwF+JKMkT8wSlP/+AZF
        arYpJc2ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmNub-0008GK-IG; Wed, 23 Jan 2019 19:10:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02C90236EC0DA; Wed, 23 Jan 2019 20:10:07 +0100 (CET)
Date:   Wed, 23 Jan 2019 20:10:07 +0100
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
Subject: Re: [PATCH v6 07/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190123191007.GG17749@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-8-patrick.bellasi@arm.com>
 <20190122135644.GP27931@hirez.programming.kicks-ass.net>
 <20190122144329.ziimv6fejwvky7yb@e110439-lin>
 <20190122151317.GH13777@hirez.programming.kicks-ass.net>
 <20190122154129.mxnpgaoxnccbjbch@e110439-lin>
 <20190123092210.GU27931@hirez.programming.kicks-ass.net>
 <20190123141924.x36iqxh42lkssrxl@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123141924.x36iqxh42lkssrxl@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:19:24PM +0000, Patrick Bellasi wrote:
> On 23-Jan 10:22, Peter Zijlstra wrote:
> > On Tue, Jan 22, 2019 at 03:41:29PM +0000, Patrick Bellasi wrote:
> > > On 22-Jan 16:13, Peter Zijlstra wrote:
> > > > On Tue, Jan 22, 2019 at 02:43:29PM +0000, Patrick Bellasi wrote:
> > 
> > > > > Do you think that could be acceptable?
> > > > 
> > > > Think so, it's a sysctl poke, 'nobody' ever does that.
> > > 
> > > Cool, so... I'll keep lazy update for system default.
> > 
> > Ah, I think I misunderstood. I meant to say that since nobody ever pokes
> > at sysctl's it doesn't matter if its a little more expensive and iterate
> > everything.
> 
> Here I was more worried about the code complexity/overhead... for
> something actually not very used/useful.
> 
> > Also; if you always keep everything up-to-date, you can avoid doing that
> > duplicate accounting.
> 
> To update everything we will have to walk all the CPUs and update all
> the RUNNABLE tasks currently enqueued, which are either RT or CFS.
> 
> That's way more expensive both in code and time then what we do for
> cgroups, where at least we have a limited scope since the cgroup
> already provides a (usually limited) list of tasks to consider.
> 
> Do you think it's really worth to have ?

Dunno; the whole double bucket thing seems a bit weird to me; but maybe
it will all look better without the mapping stuff.
