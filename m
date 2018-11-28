Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3206FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAFD2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAFD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeK2CXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:23:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbeK2CXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:23:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57942379;
        Wed, 28 Nov 2018 07:21:38 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9C63F5AF;
        Wed, 28 Nov 2018 07:21:36 -0800 (PST)
Date:   Wed, 28 Nov 2018 15:21:33 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181128152133.GD23094@e110439-lin>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net>
 <20181128115336.GB23094@e110439-lin>
 <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com>
 <20181128144039.GC23094@e110439-lin>
 <CAKfTPtAR7otTTwKYbg5OWbgrUYNKBNsUnOcMS9CfQtbYspvO5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAR7otTTwKYbg5OWbgrUYNKBNsUnOcMS9CfQtbYspvO5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-Nov 15:55, Vincent Guittot wrote:
> On Wed, 28 Nov 2018 at 15:40, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > On 28-Nov 14:33, Vincent Guittot wrote:
> > > On Wed, 28 Nov 2018 at 12:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > >
> > > > On 28-Nov 11:02, Peter Zijlstra wrote:
> > > > > On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:
> > > > >
> > > > > > Is there anything else that I should do for these patches ?
> > > > >
> > > > > IIRC, Morten mention they break util_est; Patrick was going to explain.
> > > >
> > > > I guess the problem is that, once we cross the current capacity,
> > > > strictly speaking util_avg does not represent anymore a utilization.
> > > >
> > > > With the new signal this could happen and we end up storing estimated
> > > > utilization samples which will overestimate the task requirements.
> > > >
> > > > We will have a spike in estimated utilization at next wakeup, since we
> > > > use MAX(util_avg@dequeue_time, ewma). Potentially we also inflate the EWMA in
> > > > case we collect multiple samples above the current capacity.
> > >
> > > TBH I don't see how it's different from current implementation with a
> > > task that was scheduled on big core and now wakes up on little core.
> > > The util_est is overestimated as well.
> >
> > While running below the capacity of a CPU, either big or LITTLE, we
> > can still measure the actual used bandwidth as long as we have idle
> > time. If the task is then moved into a lower capacity core, I think
> > it's still safe to assume that, likely, it would need more capacity.
> >
> > Why do you say it's the same ?
> 
> In the example of a task that runs 39ms in period of 80ms that we used
> during previous version,
> the utilization on the big core will reach 709 so will util_est too
> When the task migrates on little core (512), util_est is higher than
> current cpu capacity

Right, and what's the problem ?

1) We know that PELT is calibrated to 32ms period task and in your
   example, since the runtime is higher then the half-life, it's
   correct to estimate a utilization higher then 50%.

   PELT utilization is defined _based on the half-life_: thus
   your task having a 50% duty cycle does not mean we are not correct
   if report a utilization != 50%.
   It would be as broken as reporting 10% utilization for a task
   running 100ms every 1s.

2) If it was a 70% task on a previous activation, once it's moved into
   a lower capacity CPU it's still correct to assume that it's likely
   going to require the same bandwidth and thus will be
   under-provisioned.

I still don't see where we are wrong in this case :/

To me it looks different then the problem I described.

> > With your new signal instead, once we cross the current capacity,
> > utilization is just not anymore utilization. Thus, IMHO it make sense
> > avoid to accumulate a sample for what we call "estimated utilization".
> >
> > I would also say that, with the current implementation which caps
> > utilization to the current capacity, we get better estimation in
> > general. At least we can say with absolute precision:
> >
> >    "the task needs _at least_ that amount of capacity".
> >
> > Potentially we can also flag the task as being under-provisioned, in
> > case there was not idle time, and _let a policy_ decide what to do
> > with it and the granted information we have.
> >
> > While, with your new signal, once we are over the current capacity,
> > the "utilization" is just a sort of "random" number at best useful to
> > drive some conclusions about how long the task has been delayed.
> >
> > IOW, I fear that we are embedding a policy within a signal which is
> > currently representing something very well defined: how much cpu
> > bandwidth a task used. While, latency/under-provisioning policies
> > perhaps should be better placed somewhere else.
> >
> > Perhaps I've missed it in some of the previous discussions:
> > have we have considered/discussed this signal-vs-policy aspect ?

What's your opinion on the above instead ?

-- 
#include <best/regards.h>

Patrick Bellasi
