Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB9321868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB9321868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeHQQrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:47:37 -0400
Received: from foss.arm.com ([217.140.101.70]:47478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeHQQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:47:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3672F80D;
        Fri, 17 Aug 2018 06:44:11 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62B353F5BC;
        Fri, 17 Aug 2018 06:44:02 -0700 (PDT)
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
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
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
Date:   Fri, 17 Aug 2018 15:43:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806163946.28380-10-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> In order to properly support hierarchical resources control, the cgroup
> delegation model requires that attribute writes from a child group never
> fail but still are (potentially) constrained based on parent's assigned
> resources. This requires to properly propagate and aggregate parent
> attributes down to its descendants.

I don't understand the reason mentioned here:

IMHO, a write to a child's (tg1/tg11) cpu.rt_runtime_us can fail if the 
value is restricted by the parents value:

root@juno:/sys/fs/cgroup/cpu# cat cpu.rt_*
1000000
950000
root@juno:/sys/fs/cgroup/cpu# cat tg1/cpu.rt_*
1000000
0
root@juno:/sys/fs/cgroup/cpu# cat tg1/tg11/cpu.rt_*
1000000
0
root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
-bash: echo: write error: Invalid argument
root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/cpu.rt_runtime_us
root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
root@juno:/sys/fs/cgroup/cpu#

> Let's implement this mechanism by adding a new "effective" clamp value
> for each task group. The effective clamp value is defined as the smaller
> value between the clamp value of a group and the effective clamp value
> of its parent. This represent also the clamp value which is actually
> used to clamp tasks in each task group.
> 
> Since it can be interesting for tasks in a cgroup to know exactly what
> is the currently propagated/enforced configuration, the effective clamp
> values are exposed to user-space by means of a new pair of read-only
> attributes: cpu.util.{min,max}.effective.

I assume here that the cpu.util.{min,max} of the child will not be used 
any more because the 'effective' counterparts are taken instead.

I wonder if this propagation not been provided with only 
cpu.util.{min,max}?

[...]
