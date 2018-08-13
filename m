Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0937C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6032221725
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6032221725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeHMO4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:56:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbeHMO4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:56:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FB818A;
        Mon, 13 Aug 2018 05:14:46 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9C3B3F5D0;
        Mon, 13 Aug 2018 05:14:43 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:14:41 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180813121441.GC2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807095905.GB2288@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807095905.GB2288@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Aug 11:59, Juri Lelli wrote:
> Hi,
> 
> Minor comments below.
> 
> On 06/08/18 17:39, Patrick Bellasi wrote:
> 
> [...]
> 
> > + *
> > + * Task Utilization Attributes
> > + * ===========================
> > + *
> > + * A subset of sched_attr attributes allows to specify the utilization which
> > + * should be expected by a task. These attributes allows to inform the
>                                                        ^
> 						     allow
> 
> > + * scheduler about the utilization boundaries within which is safe to schedule
> 
> Isn't all this more about providing hints than safety?

Yes, it's "just" hints... will rephrase to make it more clear.

> > + * the task. These utilization boundaries are valuable information to support
> > + * scheduler decisions on both task placement and frequencies selection.
> > + *
> > + *  @sched_util_min	represents the minimum utilization
> > + *  @sched_util_max	represents the maximum utilization
> > + *
> > + * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
> > + * represents the percentage of CPU time used by a task when running at the
> > + * maximum frequency on the highest capacity CPU of the system. Thus, for
> > + * example, a 20% utilization task is a task running for 2ms every 10ms.
> > + *
> > + * A task with a min utilization value bigger then 0 is more likely to be
> > + * scheduled on a CPU which can provide that bandwidth.
> > + * A task with a max utilization value smaller then 1024 is more likely to be
> > + * scheduled on a CPU which do not provide more then the required bandwidth.
> 
> Isn't s/bandwidth/capacity/ here, above, and in general where you use
> the term "bandwidth" more appropriate? I wonder if overloading this term
> (w.r.t. how is used with DEADLINE) might create confusion. In this case
> we are not providing any sort of guarantees, it's a hint.

Yes, you right... here we are not really granting any bandwidth but
just "improving" the bandwidth provisioning by hinting the scheduler
about a certain min/max capacity required.

The problem related to using capacity is that, from kernel space,
capacity is defined as a static quantity/property of CPUs. Still, I
think it makes sense to argue that util_{min,max} are hints on the
min/max capacity required for a task.

I'll update comments and text to avoid using bandwidth in favour of
capacity.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
