Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CBAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C7020C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C7020C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeHPUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:10:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbeHPUKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:10:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC1D7A9;
        Thu, 16 Aug 2018 10:11:10 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506BF3F5B3;
        Thu, 16 Aug 2018 10:11:01 -0700 (PDT)
Subject: Re: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-8-patrick.bellasi@arm.com>
 <2366fe11-db1f-4f39-df03-960535611319@arm.com>
 <20180816164745.GF2960@e110439-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e99cef73-3bd8-9982-1d09-17de7ec8f76a@arm.com>
Date:   Thu, 16 Aug 2018 19:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816164745.GF2960@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 06:47 PM, Patrick Bellasi wrote:
> On 16-Aug 17:43, Dietmar Eggemann wrote:
>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
>>> When a util_max clamped task sleeps, its clamp constraints are removed
>> >from the CPU. However, the blocked utilization on that CPU can still be
>>> higher than the max clamp value enforced while that task was running.
>>> This max clamp removal when a CPU is going to be idle could thus allow
>>> unwanted CPU frequency increases, right while the task is not running.
>>
>> So 'rq->uclamp.flags == UCLAMP_FLAG_IDLE' means CPU is IDLE because
>> non-clamped tasks are tracked as well ((group_id = 0)).
> 
> Right, but... with (group_id = 0) you mean that "non-clamped tasks are
> tracked" in the first clamp group?

Yes. I was asking myself what will happen if there are only non-clamped 
tasks runnable ...

> 
>> Maybe this is worth mentioning here?
> 
> Maybe I can explicitely say that we detect that there are not RUNNABLE
> tasks because all the clamp groups are in UCLAMP_NOT_VALID status.

Yes, would have helped me the grasp this earlier ...

[...]

>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index bc2beedec7bf..ff76b000bbe8 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -906,7 +906,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
>>>    * For the specified clamp index, this method computes the new CPU utilization
>>>    * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
>>>    */
>>> -static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>>> +static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
>>> +				     unsigned int last_clamp_value)
>>>   {
>>>   	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
>>>   	int max_value = UCLAMP_NOT_VALID;
>>> @@ -924,6 +925,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>>
>> The condition:
>>
>>      if (!uclamp_group_active(uc_grp, group_id))
>>          continue;
>>
>> in 'for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id)
>> {}' makes sure that 'max_value == UCLAMP_NOT_VALID' is true for the if
>> condition (*):
>>
>>
>>>   		if (max_value >= SCHED_CAPACITY_SCALE)
>>>   			break;
>>>   	}
>>> +
>>> +	/*
>>> +	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
>>> +	 * task, we keep the CPU clamped to the last task's clamp value.
>>> +	 * This avoids frequency spikes to MAX when one CPU, with an high
>>> +	 * blocked utilization, sleeps and another CPU, in the same frequency
>>> +	 * domain, do not see anymore the clamp on the first CPU.
>>> +	 */
>>> +	if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NOT_VALID) {
>>> +		rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
>>> +		max_value = last_clamp_value;
>>> +	}
>>> +
>>
>> (*): So the uc_grp[group_id].value stays last_clamp_value?
> 
> A bit confusing... but I think you've got the point.

OK.

> 
>> What do you do when the blocked utilization decays below this enforced
>> last_clamp_value on that CPU?
> 
> This is done _just_ for max_util:
> - it clamps a blocked utilization bigger then last_clamp_value
>    thus avoiding the selection of an OPP bigger then the one enforced
>    while the task was runnable
> - it has not effect on a blocked utilization smaller then last_clamp_value
>    thus allowing to reduce gracefully the OPP as long as the blocked
>    utilization is decayed

Ah correct, max_util is about capping, not boosting.

> 
>> I assume there are plenty of this kind of corner cases because we have
>> blocked signals (including all tasks) and clamping (including runnable
>> tasks).
> 
> This is a pretty compelling one I've noticed in my tests and thus
> worth a fix... I don't have on hand other similar corner cases, do
> you?

No not right now, will continue to watch out for them ...
