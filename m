Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34888208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34888208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeHWUWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:22:49 -0400
Received: from foss.arm.com ([217.140.101.70]:49154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeHWUWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:22:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFB57A9;
        Thu, 23 Aug 2018 09:52:13 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F5843F2EA;
        Thu, 23 Aug 2018 09:52:10 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Miguel de Dios <migueldedios@google.com>,
        Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
Date:   Thu, 23 Aug 2018 18:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/21/2018 01:54 AM, Miguel de Dios wrote:
> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>> From: John Dias <joaodias@google.com>
>>
>> When rt_mutex_setprio changes a task's scheduling class to RT,
>> we're seeing cases where the task's vruntime is not updated
>> correctly upon return to the fair class.
>> Specifically, the following is being observed:
>> - task is deactivated while still in the fair class
>> - task is boosted to RT via rt_mutex_setprio, which changes
>>    the task to RT and calls check_class_changed.
>> - check_class_changed leads to detach_task_cfs_rq, at which point
>>    the vruntime_normalized check sees that the task's state is 
>> TASK_WAKING,
>>    which results in skipping the subtraction of the rq's min_vruntime
>>    from the task's vruntime
>> - later, when the prio is deboosted and the task is moved back
>>    to the fair class, the fair rq's min_vruntime is added to
>>    the task's vruntime, even though it wasn't subtracted earlier.
>> The immediate result is inflation of the task's vruntime, giving
>> it lower priority (starving it if there's enough available work).
>> The longer-term effect is inflation of all vruntimes because the
>> task's vruntime becomes the rq's min_vruntime when the higher
>> priority tasks go idle. That leads to a vicious cycle, where
>> the vruntime inflation repeatedly doubled.
>>
>> The change here is to detect when vruntime_normalized is being
>> called when the task is waking but is waking in another class,
>> and to conclude that this is a case where vruntime has not
>> been normalized.
>>
>> Signed-off-by: John Dias <joaodias@google.com>
>> Signed-off-by: Steve Muckle <smuckle@google.com>
>> ---
>>   kernel/sched/fair.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b39fb596f6c1..14011d7929d8 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct 
>> task_struct *p)
>>        * - A task which has been woken up by try_to_wake_up() and
>>        *   waiting for actually being woken up by sched_ttwu_pending().
>>        */
>> -    if (!se->sum_exec_runtime || p->state == TASK_WAKING)
>> +    if (!se->sum_exec_runtime ||
>> +        (p->state == TASK_WAKING && p->sched_class == 
>> &fair_sched_class))
>>           return true;
>>       return false;
> The normalization of vruntime used to exist in task_waking but it was 
> removed and the normalization was moved into migrate_task_rq_fair. The 
> reasoning being that task_waking_fair was only hit when a task is queued 
> onto a different core and migrate_task_rq_fair should do the same work.
> 
> However, we're finding that there's one case which migrate_task_rq_fair 
> doesn't hit: that being the case where rt_mutex_setprio changes a task's 
> scheduling class to RT when its scheduled out. The task never hits 
> migrate_task_rq_fair because it is switched to RT and migrates as an RT 
> task. Because of this we're getting an unbounded addition of 
> min_vruntime when the task is re-attached to the CFS runqueue when it 
> loses the inherited priority. The patch above works because now the 
> kernel specifically checks for this case and normalizes accordingly.
> 
> Here's the patch I was talking about: 
> https://lore.kernel.org/patchwork/patch/677689/. In our testing we were 
> seeing vruntimes nearly double every time after rt_mutex_setprio boosts 
> the task to RT.
> 
> Signed-off-by: Miguel de Dios <migueldedios@google.com>
> Tested-by: Miguel de Dios <migueldedios@google.com>

I tried to catch this issue on my Arm64 Juno board using pi_test (and a 
slightly adapted pip_test (usleep_val = 1500 and keep low as cfs)) from 
rt-tests but wasn't able to do so.

# pi_stress --inversions=1 --duration=1 --groups=1 --sched id=low,policy=cfs

Starting PI Stress Test
Number of thread groups: 1
Duration of test run: 1 seconds
Number of inversions per group: 1
      Admin thread SCHED_FIFO priority 4
1 groups of 3 threads will be created
       High thread SCHED_FIFO priority 3
        Med thread SCHED_FIFO priority 2
        Low thread SCHED_OTHER nice 0

# ./pip_stress

In both cases, the cfs task entering  rt_mutex_setprio() is queued, so 
dequeue_task_fair()->dequeue_entity(), which subtracts 
cfs_rq->min_vruntime from se->vruntime, is called on it before it gets 
the rt prio.

Maybe it requires a very specific use of the pthread library to provoke 
this issue by making sure that the cfs tasks really blocks/sleeps?
