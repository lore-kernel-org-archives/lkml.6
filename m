Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16BEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945DC21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945DC21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbeHBRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:52:04 -0400
Received: from foss.arm.com ([217.140.101.70]:59984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeHBRwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:52:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4E180D;
        Thu,  2 Aug 2018 09:00:17 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B8C3F5B3;
        Thu,  2 Aug 2018 09:00:13 -0700 (PDT)
Date:   Thu, 2 Aug 2018 17:00:11 +0100
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
Message-ID: <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
References: <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
 <20180802130801.GL2494@hirez.programming.kicks-ass.net>
 <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
 <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin>
 <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
 <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 17:55:24 (+0200), Vincent Guittot wrote:
> On Thu, 2 Aug 2018 at 17:30, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Thursday 02 Aug 2018 at 17:14:15 (+0200), Vincent Guittot wrote:
> > > On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > Good point, setting the util_avg to 0 for new tasks should help
> > > > filtering out those tiny tasks too. And that would match with the idea
> > > > of letting tasks build their history before looking at their util_avg ...
> > > >
> > > > But there is one difference w.r.t frequency selection. The current code
> > > > won't mark the system overutilized, but will let sugov raise the
> > > > frequency when a new task is enqueued. So in case of a fork bomb, we
> > >
> > > If the initial value of util_avg is 0, we should not have any impact
> > > on the util_avg of the cfs rq on which the task is attached, isn't it
> > > ? so this should not impact both the over utilization state and the
> > > frequency selected by sugov or I'm missing something ?
> >
> > What I tried to say is that setting util_avg to 0 for new tasks will
> > prevent schedutil from raising the frequency in case of a fork bomb, and
> > I think that could be an issue. And I think this isn't an issue with the
> > patch as-is ...
> 
> ok. So you also want to deal with fork bomb
> Not sure that you don't have some problem with current proposal too
> because select_task_rq_fair will always return prev_cpu because
> util_avg and util_est are 0 at that time

But find_idlest_cpu() should select a CPU using load in case of a forkee
no ?

Thanks,
Quentin
