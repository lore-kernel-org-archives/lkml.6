Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A2D215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A2D215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHQRtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:49:24 -0400
Received: from foss.arm.com ([217.140.101.70]:48088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbeHQRtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:49:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DD7E80D;
        Fri, 17 Aug 2018 07:45:45 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A234D3F5B3;
        Fri, 17 Aug 2018 07:45:42 -0700 (PDT)
Date:   Fri, 17 Aug 2018 15:45:40 +0100
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
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Message-ID: <20180817144540.GL2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Aug 15:43, Dietmar Eggemann wrote:
> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> >In order to properly support hierarchical resources control, the cgroup
> >delegation model requires that attribute writes from a child group never
> >fail but still are (potentially) constrained based on parent's assigned
> >resources. This requires to properly propagate and aggregate parent
> >attributes down to its descendants.
> 
> I don't understand the reason mentioned here:
> 
> IMHO, a write to a child's (tg1/tg11) cpu.rt_runtime_us can fail if the
> value is restricted by the parents value:

Well... that's my interpretation after this discussion:

  https://lore.kernel.org/lkml/20180410200514.GA793541@devbig577.frc2.facebook.com/

AFAIU, what has not to fail is a write to a parent, which wants to enforce
more restrictive constraints to child groups. Thus, if we have for example:

   tg1:         util_max=100%
   tg1/tg11:    util_max=80%

It should be possible without errors to set:

   tg1:         util_max=50%

and then enforce a 50% util_max to tg1/tg11 tasks too and eventually
use "effective" attributes to expose the effective value used at each
level of the hierarchy.

> root@juno:/sys/fs/cgroup/cpu# cat cpu.rt_*
> 1000000
> 950000
> root@juno:/sys/fs/cgroup/cpu# cat tg1/cpu.rt_*
> 1000000
> 0
> root@juno:/sys/fs/cgroup/cpu# cat tg1/tg11/cpu.rt_*
> 1000000
> 0
> root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
> -bash: echo: write error: Invalid argument
> root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/cpu.rt_runtime_us
> root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
> root@juno:/sys/fs/cgroup/cpu#

This example is using the legacy hierarcy (cgroups v1).

AFAIK the default hierarcy (cgroups v2) has a much more stricy set of
requirements for the "delegation model".

> >Let's implement this mechanism by adding a new "effective" clamp value
> >for each task group. The effective clamp value is defined as the smaller
> >value between the clamp value of a group and the effective clamp value
> >of its parent. This represent also the clamp value which is actually
> >used to clamp tasks in each task group.
> >
> >Since it can be interesting for tasks in a cgroup to know exactly what
> >is the currently propagated/enforced configuration, the effective clamp
> >values are exposed to user-space by means of a new pair of read-only
> >attributes: cpu.util.{min,max}.effective.
> 
> I assume here that the cpu.util.{min,max} of the child will not be used any
> more because the 'effective' counterparts are taken instead.

Yes, the "effective" attributes are the one used in kernel space for
the actual clamping.

However, the cpu.util.{min,max} of a child are still required as soon
as the parent relax its constraints... when we use their value to
set the "effective" value.

> I wonder if this propagation not been provided with only cpu.util.{min,max}?

In the example before, if we use the same variables we miss the
opportunity to reset:

   tg1/tg11:    util_max=80%

as soon as tg1's util_max goes back to 100%.

-- 
#include <best/regards.h>

Patrick Bellasi
