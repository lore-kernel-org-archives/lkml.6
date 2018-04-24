Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDXSq2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:46:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeDXSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:46:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6688F6034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] kthread/smpboot: Serialize kthread parking against wakeup
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, dzickus@redhat.com,
        mingo@kernel.org, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
References: <1524562105-31026-1-git-send-email-gkohli@codeaurora.org>
 <20180424182628.GW4043@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <75ced7f3-e596-1942-f843-d43cf162103b@codeaurora.org>
Date: Wed, 25 Apr 2018 00:16:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424182628.GW4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/2018 11:56 PM, Peter Zijlstra wrote:

> On Tue, Apr 24, 2018 at 02:58:25PM +0530, Gaurav Kohli wrote:
>> The control cpu thread which initiates hotplug calls kthread_park()
>> for hotplug thread and sets KTHREAD_SHOULD_PARK. After this control
>> thread wakes up the hotplug thread. There is a chance that wakeup
>> code sees the hotplug thread (running on AP core) in INTERRUPTIBLE
>> state, but sets its state to RUNNING after hotplug thread has entered
>> kthread_parkme() and changed its state to TASK_PARKED. This can result
>> in panic later on in kthread_unpark(), as it sees KTHREAD_IS_PARKED
>> flag set but fails to rebind the kthread, due to it being not in
>> TASK_PARKED state. Fix this, by serializing wakeup state change,
>> against state change before parking the kthread.
>>
>> Below is the possible race:
>>
>> Control thread				      Hotplug Thread
>>
>> kthread_park()
>> set KTHREAD_SHOULD_PARK
>> 					      smpboot_thread_fn
>> 					      set_current_state(TASK_INTERRUPTIBLE);
>> 					      kthread_parkme
>>
>> wake_up_process()
>>
>> raw_spin_lock_irqsave(&p->pi_lock, flags);
>> if (!(p->state & state)) -> this will fail
>>              goto out;
>>
>> 					      __kthread_parkme
>> 					       __set_current_state(TASK_PARKED);
>>
>> if (p->on_rq && ttwu_remote(p, wake_flags))
>>      ttwu_remote()
>>          p->state = TASK_RUNNING;
>> 						schedule();
>>
>> So to avoid this race, take pi_lock to serial state changes.
>>
>> Suggested-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
>> Co-developed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>>
>> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
>> index 1650578..514b232 100644
>> --- a/kernel/smpboot.c
>> +++ b/kernel/smpboot.c
>> @@ -121,7 +121,9 @@ static int smpboot_thread_fn(void *data)
>>   		}
>>   
>>   		if (kthread_should_park()) {
>> +			raw_spin_lock(&current->pi_lock);
>>   			__set_current_state(TASK_RUNNING);
>> +			raw_spin_unlock(&current->pi_lock);
>>   			preempt_enable();
>>   			if (ht->park && td->status == HP_THREAD_ACTIVE) {
>>   				BUG_ON(td->cpu != smp_processor_id());
> Note how in your scenario above you didn't actually need the
> TASK_RUNNING state; so how is this change going to fix anything?

Hi Peter,

As with help of this , if kthread_should_park run first so wake_up call of controller

get exited as task is already set as running, otherwise if controller runs first

then we will block here and set running and then sets TASK_PARKED .

So no chance of cpuhp set as running during  kthread_parkme call.

But as we discussed this can be fix by 2nd patch as well, So once you get time and able to

see , Please let us know or do you want me to try your 2nd patch

for testing first?

>
> But yes, I suspect it is right, but it definitely needs a comment
> explaining wth we take that lock there.
>
> Like I said earlier, my brain is entirely fried for the day; but I'll
> have a try tomorrow.
>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
