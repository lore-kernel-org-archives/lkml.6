Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A618521527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A618521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbeHBRbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:31:08 -0400
Received: from foss.arm.com ([217.140.101.70]:59624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387577AbeHBRbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:31:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA29C80D;
        Thu,  2 Aug 2018 08:39:25 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B8743F5B3;
        Thu,  2 Aug 2018 08:39:21 -0700 (PDT)
Date:   Thu, 2 Aug 2018 16:39:19 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
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
        Steve Muckle <smuckle@google.com>, adharmap@quicinc.com,
        skannan@quicinc.com, Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Message-ID: <20180802153917.cpvls5hxkvevjh6s@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
 <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
 <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
 <20180801082353.egym4tsbr7ppql27@queper01-lin>
 <CAJZ5v0joYFXkXxoV8odPtrCNW=jAw3RVv3rTzMoabeYWGDnREw@mail.gmail.com>
 <20180801092325.g2upcivcvdo62hub@queper01-ThinkPad-T460s>
 <20180802130440.GW2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802130440.GW2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 15:04:40 (+0200), Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 10:23:27AM +0100, Quentin Perret wrote:
> > On Wednesday 01 Aug 2018 at 10:35:32 (+0200), Rafael J. Wysocki wrote:
> > > On Wed, Aug 1, 2018 at 10:23 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > On Wednesday 01 Aug 2018 at 09:32:49 (+0200), Rafael J. Wysocki wrote:
> > > >> On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
> > > >> >> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
> > > >> >>> If it's going to be a different aggregation from what's done for
> > > >> >>> frequency
> > > >> >>> guidance, I don't see the point of having this inside schedutil. Why not
> > > >> >>> keep it inside the scheduler files?
> > > >> >>
> > > >> >> This code basically results from a discussion we had with Peter on v4.
> > > >> >> Keeping everything centralized can make sense from a maintenance
> > > >> >> perspective, I think. That makes it easy to see the impact of any change
> > > >> >> to utilization signals for both EAS and schedutil.
> > > >> >
> > > >> > In that case, I'd argue it makes more sense to keep the code centralized in
> > > >> > the scheduler. The scheduler can let schedutil know about the utilization
> > > >> > after it aggregates them. There's no need for a cpufreq governor to know
> > > >> > that there are scheduling classes or how many there are. And the scheduler
> > > >> > can then choose to aggregate one way for task packing and another way for
> > > >> > frequency guidance.
> > > >>
> > > >> Also the aggregate utilization may be used by cpuidle governors in
> > > >> principle to decide how deep they can go with idle state selection.
> > > >
> > > > The only issue I see with this right now is that some of the things done
> > > > in this function are policy decisions which really belong to the governor,
> > > > I think.
> > > 
> > > Well, the scheduler makes policy decisions too, in quite a few places. :-)
> > 
> > That is true ... ;-) But not so much about frequency selection yet I guess
> 
> Well, sugov is part of the scheduler :-) It being so allows for the
> co-ordinated decision making required for EAS.
> 
> > > The really important consideration here is whether or not there may be
> > > multiple governors making different policy decisions in that respect.
> > > If not, then where exactly the single policy decision is made doesn't
> > > particularly matter IMO.
> > 
> > I think some users of the aggregated utilization signal do want to make
> > slightly different decisions (I'm thinking about the RT-go-to-max thing
> > again which makes perfect sense in sugov, but could possibly hurt EAS).
> > 
> > So the "hard" part of this work is to figure out what really is a
> > governor-specific policy decision, and what is common between all users.
> > I put "hard" between quotes because I only see the case of RT as truly
> > sugov-specific for now.
> > 
> > If we also want a special case for DL, Peter's enum should work OK, and
> > enable to add more special cases for new users (cpuidle ?) if needed.
> > But maybe that is something for later ?
> 
> Right, I don't mind moving the function. What I do oppose is having two
> very similar functions in different translation units -- because then
> they _will_ diverge and result in 'funny' things.

Sounds good :-) Would kernel/sched/pelt.c be the right place then ? It's
cross-class and kinda pelt-related I guess

Thanks,
Quentin
