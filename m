Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19021C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F8320827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F8320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeKGURD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:17:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48906 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKGURD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:17:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834B1EBD;
        Wed,  7 Nov 2018 02:47:14 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D5A3F718;
        Wed,  7 Nov 2018 02:47:11 -0800 (PST)
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com>
 <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <28af1313-8153-624d-1ae9-1554bb2db474@arm.com>
Date:   Wed, 7 Nov 2018 11:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 10:10 AM, Vincent Guittot wrote:
> On Fri, 2 Nov 2018 at 16:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 10/26/18 6:11 PM, Vincent Guittot wrote:

[...]

>> Thinking about this new approach on a big.LITTLE platform:
>>
>> CPU Capacities big: 1024 LITTLE: 512, performance CPUfreq governor
>>
>> A 50% (runtime/period) task on a big CPU will become an always running
>> task on the little CPU. The utilization signal of the task and the
>> cfs_rq of the little CPU converges to 1024.
>>
>> With contrib scaling the utilization signal of the 50% task converges to
>> 512 on the little CPU, even it is always running on it, and so does the
>> one of the cfs_rq.
>>
>> Two 25% tasks on a big CPU will become two 50% tasks on a little CPU.
>> The utilization signal of the tasks converges to 512 and the one of the
>> cfs_rq of the little CPU converges to 1024.
>>
>> With contrib scaling the utilization signal of the 25% tasks converges
>> to 256 on the little CPU, even they run each 50% on it, and the one of
>> the cfs_rq converges to 512.
>>
>> So what do we consider system-wide invariance? I thought that e.g. a 25%
>> task should have a utilization value of 256 no matter on which CPU it is
>> running?
>>
>> In both cases, the little CPU is not going idle whereas the big CPU does.
> 
> IMO, the key point here is that there is no idle time. As soon as
> there is no idle time, you don't know if a task has enough compute
> capacity so you can't make difference between the 50% running task or
> an always running task on the little core.

Agreed. My '2 25% tasks on a 512 cpu' was a special example in the sense 
that the tasks would stay invariant since they are not restricted by the 
cpu capacity yet. '2 35% tasks' would also have 256 utilization each 
with contrib scaling so that's not invariant either.

Could we say that in the overutilized case with contrib scaling each of 
the n tasks get cpu_cap/n utilization where with time scaling they get 
1024/n utilization? Even though there is no value in this information 
because of the over-utilized state.

> That's also interesting to noticed that the task will reach the always
> running state after more than 600ms on little core with utilization
> starting from 0.
> 
> Then considering the system-wide invariance, the task are not really
> invariant. If we take a 50% running task that run 40ms in a period of
> 80ms, the max utilization of the task will be 721 on the big core and
> 512 on the little core.

Agreed, the utilization of the task on the big CPU oscillates between 
721 and 321 so the average is still ~512.

> Then, if you take a 39ms running task instead, the utilization on the
> big core will reach 709 but it will be 507 on little core. So your
> utilization depends on the current capacity.

OK, but the average should be ~ 507 on big as well. There is idle time 
now even on the little CPU. But yeah, with longer period value, there 
are quite big amplitudes.

> With the new proposal, the max utilization will be 709 on big and
> little cores for the 39ms running task. For the 40ms running task, the
> utilization will be 721 on big core. then if the task moves on the
> little, it will reach the value 721 after 80ms,  then 900 after more
> than 160ms and 1000 after 320ms

We consider max values here? In this case, agreed. So this is a reminder 
that even if the average utilization of a task compared to the CPU 
capacity would mark the system as non-overutilized (39ms/80ms on a 512 
CPU), the utilization of that task looks different because of the 
oscillation which is pretty noticeable with long periods.

The important bit for EAS is that it only uses utilization in the 
non-overutilized case. Here, utilization signals should look the same 
between the two approaches, not considering tasks with long periods like 
the 39/80ms example above.
There are also some advantages for EAS with time scaling: (1) faster 
overutilization detection when a big task runs on a little CPU, (2) 
higher (initial) task utilization value when this task migrates from 
little to big CPU.

We should run our EAS task placement tests with your time scaling patches.
