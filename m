Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A921473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5A921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeHPU0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:26:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbeHPU0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:26:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7917A9;
        Thu, 16 Aug 2018 10:27:08 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E1E23F5B3;
        Thu, 16 Aug 2018 10:27:05 -0700 (PDT)
Date:   Thu, 16 Aug 2018 18:27:02 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
Message-ID: <20180816172702.GH2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-8-patrick.bellasi@arm.com>
 <2366fe11-db1f-4f39-df03-960535611319@arm.com>
 <20180816164745.GF2960@e110439-lin>
 <e99cef73-3bd8-9982-1d09-17de7ec8f76a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99cef73-3bd8-9982-1d09-17de7ec8f76a@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-Aug 19:10, Dietmar Eggemann wrote:
> On 08/16/2018 06:47 PM, Patrick Bellasi wrote:
> >On 16-Aug 17:43, Dietmar Eggemann wrote:
> >>On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> >>>When a util_max clamped task sleeps, its clamp constraints are removed
> >>>from the CPU. However, the blocked utilization on that CPU can still be
> >>>higher than the max clamp value enforced while that task was running.
> >>>This max clamp removal when a CPU is going to be idle could thus allow
> >>>unwanted CPU frequency increases, right while the task is not running.
> >>
> >>So 'rq->uclamp.flags == UCLAMP_FLAG_IDLE' means CPU is IDLE because
> >>non-clamped tasks are tracked as well ((group_id = 0)).
> >
> >Right, but... with (group_id = 0) you mean that "non-clamped tasks are
> >tracked" in the first clamp group?
> 
> Yes. I was asking myself what will happen if there are only non-clamped
> tasks runnable ...

Non clamped tasks is kind-of ambiguous, since you can have:
a) tasks with util_max = UCLAMP_NOT_VALID (the default for all tasks)
b) tasks with util_max = SCHED_CAPACITY_SCALE as a task specific
    clamp value

They are both technically not clamped but, for case b there should not
be issue, since we will track SCHED_CAPACITY_SCALE as idle hold value.

For case a instead is a bit different, especially when they mix with
tasks with a valid task specific clamp value, as I've just commented
in this posting:

   Message-ID: <20180816172016.GG2960@e110439-lin>

> 
> >
> >>Maybe this is worth mentioning here?
> >
> >Maybe I can explicitely say that we detect that there are not RUNNABLE
> >tasks because all the clamp groups are in UCLAMP_NOT_VALID status.
> 
> Yes, would have helped me the grasp this earlier ...

Right, I'm going to add a bit of text on that.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
