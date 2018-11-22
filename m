Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E148C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DA020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DA020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437979AbeKWCf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:35:29 -0500
Received: from foss.arm.com ([217.140.101.70]:52734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437920AbeKWCf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:35:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F0A1684;
        Thu, 22 Nov 2018 07:55:32 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B948B3F575;
        Thu, 22 Nov 2018 07:55:28 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:55:27 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Message-ID: <20181122155524.7wawdnuognnhyauj@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
 <20181121151444.t3zye5l5iycfni2s@queper01-lin>
 <20181122091715.6kvhcbgoqrd54nbs@queper01-lin>
 <20181122093237.goxmr4p5l4h2izid@queper01-lin>
 <20181122102545.GQ2131@hirez.programming.kicks-ass.net>
 <20181122152538.jvgh3uvuo5a6lfs7@queper01-lin>
 <CAJZ5v0iV9oKVHjPdv4UzEJbZt0gumd3a2=cJtFw04FHGbi73kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iV9oKVHjPdv4UzEJbZt0gumd3a2=cJtFw04FHGbi73kA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Nov 2018 at 16:51:41 (+0100), Rafael J. Wysocki wrote:
> On Thu, Nov 22, 2018 at 4:25 PM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Thursday 22 Nov 2018 at 11:25:45 (+0100), Peter Zijlstra wrote:
> > > On Thu, Nov 22, 2018 at 09:32:39AM +0000, Quentin Perret wrote:
> > > > Hmm, I went too fast, that's totally broken. But there's still something
> > > > we can do with static_branch_{inc,dec} I think. I'll come back later
> > > > with a better solution.
> > >
> > > Right; if you count the rd's that have pd set, it should work-ish. Yes,
> > > much cleaner if you can get it to work.
> >
> > So, I came up with the following code which seems to work OK. It's not
> > as I clean as I'd like, though. The fact that free_pd() can be called in
> > softirq context is annoying to manipulate the static key ...
> >
> > An alternative to this work item workaround is to do static_branch_dec()
> > from build_perf_domains() and next to the three call sites of
> > free_rootdomain() in order to avoid the call_rcu() context. Not very
> > pretty either.
> >
> > Or we can just stick with your original suggestion to carry a boolean
> > around.
> 
> What's problematic with carrying a boolean around?

Nothing, I was just trying to see if I could find a more elegant way to
increment/decrement the static key as we create/destroy the perf
domains.

I would not describe the work item thing I came up with as particularly
elegant, though :-)

So, all in all, the boolean is fine by me if we all agree it is nicer.

Thanks,
Quentin
