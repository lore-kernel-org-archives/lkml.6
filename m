Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E282186B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E282186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeHMRn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:43:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60794 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbeHMRnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:43:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F8380D;
        Mon, 13 Aug 2018 08:01:18 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7F43F5D0;
        Mon, 13 Aug 2018 08:01:15 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:01:12 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180813150112.GE2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
 <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin>
 <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
 <20180813124911.GD2605@e110439-lin>
 <CAKfTPtDgXdQso94DOwJ4+nyRpJwigEwf7JmNZcgFOg3z6iUWyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDgXdQso94DOwJ4+nyRpJwigEwf7JmNZcgFOg3z6iUWyw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Aug 16:06, Vincent Guittot wrote:
> On Mon, 13 Aug 2018 at 14:49, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > On 13-Aug 14:07, Vincent Guittot wrote:
> > > On Mon, 13 Aug 2018 at 12:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:

[...]

> > Yes I agree that the current behavior is not completely clean... still
> > the question is: do you reckon the problem I depicted above, i.e. RT
> > workloads eclipsing the min_util required by lower priority classes?
> 
> As said above, I don't think that there is a problem that is specific
> to cross class scheduling that can't also happen in the same class.
> 
> Regarding your example:
> task TA util=40% with uclamp_min 50%
> task TB util=10% with uclamp_min 0%
> 
> If TA and TB are cfs, util=50% and it doesn't seem to be a problem
> whereas TB will steal some bandwidth to TA and delay it (and i even
> don't speak about the impact of the nice priority of TB)
> If TA is cfs and TB is rt, Why util=50% is now a problem for TA ?

You right, in the current implementation, where we _do not_
distinguish among scheduling classes it's not possible to get a
reasonable implementation of a per sched class clamping.

> > To a certain extend I see this problem similar to the rt/dl/irq pressure
> > in defining cpu_capacity, isn't it?

However, I still think that higher priority classes eclipsing the
clamping of lower priority classes can still be a problem.

In your example above, the main difference between TA and TB being on
the same class or different classes is that in the second case TB
is granted to always preempt TA. We can end up with a non boosted RT
task consuming all the boosted bandwidth required by a CFS task.

This does not happen, apart maybe for the corner case of really
different nice values, if the tasks are both CFS, since the fair
scheduler will grant some progress for both of them.

Thus, given the current implementation, I think it makes sense to drop
the UCLAMP_SCHED_CLASS policy and stick with a more clean and
consistent design.

I'll then see if it makes sense to add a dedicated patch on top of the
series to add a proper per-class clamp tracking.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
