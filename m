Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BC721534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BC721534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHBSva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:51:30 -0400
Received: from foss.arm.com ([217.140.101.70]:60786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeHBSva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:51:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D817615A2;
        Thu,  2 Aug 2018 09:59:31 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29463F5D0;
        Thu,  2 Aug 2018 09:59:27 -0700 (PDT)
Date:   Thu, 2 Aug 2018 17:59:26 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
References: <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
 <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin>
 <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
 <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
 <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 18:38:01 (+0200), Vincent Guittot wrote:
> On Thu, 2 Aug 2018 at 18:10, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Thursday 02 Aug 2018 at 18:07:49 (+0200), Vincent Guittot wrote:
> > > On Thu, 2 Aug 2018 at 18:00, Quentin Perret <quentin.perret@arm.com> wrote:
> > > >
> > > > On Thursday 02 Aug 2018 at 17:55:24 (+0200), Vincent Guittot wrote:
> > > > > On Thu, 2 Aug 2018 at 17:30, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > >
> > > > > > On Thursday 02 Aug 2018 at 17:14:15 (+0200), Vincent Guittot wrote:
> > > > > > > On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > > > > Good point, setting the util_avg to 0 for new tasks should help
> > > > > > > > filtering out those tiny tasks too. And that would match with the idea
> > > > > > > > of letting tasks build their history before looking at their util_avg ...
> > > > > > > >
> > > > > > > > But there is one difference w.r.t frequency selection. The current code
> > > > > > > > won't mark the system overutilized, but will let sugov raise the
> > > > > > > > frequency when a new task is enqueued. So in case of a fork bomb, we
> > > > > > >
> > > > > > > If the initial value of util_avg is 0, we should not have any impact
> > > > > > > on the util_avg of the cfs rq on which the task is attached, isn't it
> > > > > > > ? so this should not impact both the over utilization state and the
> > > > > > > frequency selected by sugov or I'm missing something ?
> > > > > >
> > > > > > What I tried to say is that setting util_avg to 0 for new tasks will
> > > > > > prevent schedutil from raising the frequency in case of a fork bomb, and
> > > > > > I think that could be an issue. And I think this isn't an issue with the
> > > > > > patch as-is ...
> > > > >
> > > > > ok. So you also want to deal with fork bomb
> > > > > Not sure that you don't have some problem with current proposal too
> > > > > because select_task_rq_fair will always return prev_cpu because
> > > > > util_avg and util_est are 0 at that time
> > > >
> > > > But find_idlest_cpu() should select a CPU using load in case of a forkee
> > > > no ?
> > >
> > > So you have to wait for the next tick that will set the overutilized
> > > and disable the want_energy. Until this point, all new tasks will be
> > > put on the current cpu
> >
> > want_energy should always be false for forkees, because we set it only
> > for SD_BALANCE_WAKE.
> 
> Ah yes I forgot that point.
> But doesn't this break the EAS policy ? I mean each time a new task is
> created, we use the load to select the best CPU

If you really keep spawning new tasks all the time, yes EAS won't help
you, but there isn't a lot we can do :/. We need to have an idea of how
big a task is for EAS, and we obviously don't know that for new tasks, so
it's hard/dangerous to make assumptions.

So the proposal here is that if you only have forkees once in a while,
then those new tasks (and those new tasks only) will be placed using load
the first time, and then they'll fall under EAS control has soon as they
have at least a little bit of history. This _should_ happen without
re-enabling load balance spuriously too often, and that _should_ prevent
it from ruining the placement of existing tasks ...

As Peter already mentioned, a better way of solving this issue would be
to try to find the moment when the utilization signal has converged to
something stable (assuming that it converges), but that, I think, isn't
straightforward at all ...

Does that make any sense ?

Thanks,
Quentin
