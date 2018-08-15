Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B962C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD012168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD012168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeHOM2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:28:44 -0400
Received: from foss.arm.com ([217.140.101.70]:53128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbeHOM2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:28:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF16718A;
        Wed, 15 Aug 2018 02:37:18 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BDAC3F5BD;
        Wed, 15 Aug 2018 02:37:15 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
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
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
Date:   Wed, 15 Aug 2018 11:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814164905.GG2605@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 06:49 PM, Patrick Bellasi wrote:
> Hi Dietmar!
> 
> On 14-Aug 17:44, Dietmar Eggemann wrote:
>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

>> This one indicates that there are some holes in your ref-counting.
> 
> Not really, this has been added not because I've detected a refcount
> issue... but because it was suggested as a possible safety check in a
> previous code review comment:
> 
>     https://lore.kernel.org/lkml/20180720151156.GA31421@e110439-lin/
> 
>> It's probably easier to debug that there is still a task but the
>> uc_grp[group_id].tasks value == 0 (A). I assume the other problem exists as
>> well, i.e. last task and uc_grp[group_id].tasks > 1 (B)?
>>
>> You have uclamp_cpu_[get/put](_id)() in [enqueue/dequeue]_task.
>>
>> Patch 04/14 introduces its use in uclamp_task_update_active().
>>
>> Do you know why (A) (and (B)) are happening?
> 
> I've never saw that warning in my tests so far so, again, the warning
> is there just to support testing/debugging when refcounting code
> is/will be touched in the future. That's also the reason why is
> SCHED_DEBUG protected.

Ah, OK, I thought you really see it more often and that it also relate 
to Pavan's comment on 02/14 about the missing treatment of exiting tasks.

If this is only for testing/debugging, I would suggest a simple one line 
BUG_ON()

You find CONFIG_SCHED_DEBUG=y in production kernels as well.

[...]

> Here you right, I would say that it should always be:
> 
>      clamp_value <= uc_cpu->value[clamp_id]
> 
> since this matches the update done at the end of uclamp_cpu_get_id():
> 
>     if (uc_cpu->value[clamp_id] < clamp_value)
>          uc_cpu->value[clamp_id] = clamp_value;
> 
> Perhaps we can add another safety check here, similar to the one
> above, to have something like:
> 
>      clamp_value = uc_grp[group_id].value;
> #ifdef SCHED_DEBUG
>      if (unlikely(clamp_value > uc_cpu->value[clamp_id])) {
>          WARN(1, "invalid CPU[%d] clamp group [%d:%d] value\n",
>                  cpu_of(rq), clamp_id, group_id);
> #endif
>      if (clamp_value == uc_cpu->value[clamp_id])
>          uclamp_cpu_update(rq, clamp_id);

Yes, but I would prefer a BUG_ON() one liner.
