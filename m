Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeEAHuy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 03:50:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 03:50:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AEF5601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
Date: Tue, 1 May 2018 13:20:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430111744.GE4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for spam, Adding list

On 4/30/2018 4:47 PM, Peter Zijlstra wrote:
> On Thu, Apr 26, 2018 at 09:23:25PM +0530, Kohli, Gaurav wrote:
>> On 4/26/2018 2:27 PM, Peter Zijlstra wrote:
>>
>>> On Thu, Apr 26, 2018 at 10:41:31AM +0200, Peter Zijlstra wrote:
>>>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>>>> index cd50e99202b0..4b6503c6a029 100644
>>>> --- a/kernel/kthread.c
>>>> +++ b/kernel/kthread.c
>>>> @@ -177,12 +177,13 @@ void *kthread_probe_data(struct task_struct *task)
>>>>    static void __kthread_parkme(struct kthread *self)
>>>>    {
>>>> -	__set_current_state(TASK_PARKED);
>>>> -	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
>>>> +	for (;;) {
>>>> +		__set_task_state(TASK_PARKED);
>>> 		set_current_state(TASK_PARKED);
>>>
>>> of course..
>>
>> Hi Peter,
>>
>> Maybe i am missing something , but still that race can come as we don't put task_parked on special state.
>>
>> Controller                                                                       Hotplug
>>
>>                                                                                   Loop
>>
>>                                                                                   Task_Interruptible
>>
>> Set SHOULD_PARK
>>
>> wakeup -> Proceeds
>>
>>                                                                                    Set Running
>>
>>                                                                                    kthread_parkme
>>
>>                                                                                    SET TASK_PARKED
>>
>>                                                                                    schedule
>>
>> Set TASK_RUNNING
>>
>> Can you please correct ME, if I misunderstood this.
> 
> If that could happen, all wait-loops would be broken. However,
> AFAICT that cannot happen, because ttwu_remote() and schedule()
> serialize on rq->lock. See:
> 
> 
> A						B
> 
> for (;;) {
> 	set_current_state(UNINTERRUPTIBLE);
> 
> 						cond1 = true;
> 						wake_up_process(A)
> 						  lock(A->pi_lock)
> 						  smp_mb__after_spinlock()
> 						  if (A->state & TASK_NORMAL)
> 						    A->on_rq && ttwu_remote()
> 	if (cond1) // true
> 		break;
> 	schedule();
> }
> __set_current_state(RUNNING);
> 

Hi Peter,

Sorry for the late reply and i was on leave.

Thanks for the new patches, We will apply and test for issue reproduction.

But In our older case, where we have seen failure below is the wake up 
path and ftraces, Wakeup occured  and completed before schedule call only.

So final state of CPUHP is running not parked. I have also pasted debug 
ftraces that we got during issue reproduction.

Here wakeup for cpuhp is below:

takedown_cpu-> kthread_park-> wake_up_process


  39,034,311,742,395  apps (10240)        Trace Printk 
cpuhp/0  (16)  [000]  39015.625000: <debug> __kthread_parkme state=512 
task=ffffffcc7458e680 flags: 0x5 -> state 5 -> state is parked inside 
parkme function

39,034,311,846,510  apps (10240)        Trace Printk 
cpuhp/0  (16)  [000]  39015.625000: <debug> before schedule 
__kthread_parkme state=0 task=ffffffcc7458e680 flags: 0xd  ->  just 
before schedule call, state is running

tatic void __kthread_parkme(struct kthread *self)

{

         __set_current_state(TASK_PARKED);

         while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {

                 if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))

                         complete(&self->parked);

                 schedule();

                 __set_current_state(TASK_PARKED);

         }

         clear_bit(KTHREAD_IS_PARKED, &self->flags);

         __set_current_state(TASK_RUNNING);

}

So my point is here also, if it is reschedule then it can set 
TASK_PARKED, but it seems after takedown_cpu call this thread never get 
a chance to run, So final state is TASK_RUNNING.

In our current fix also can't we observe same scenario where final state 
is TASK_RUNNING.

Regards

Gaurav

> for (;;) {
> 	set_current_state(UNINTERRUPTIBLE);
> 	if (cond2)
> 		break;
> 
> 	schedule();
> 	  lock(rq->lock)
> 	  smp_mb__after_spinlock();
> 	  deactivate_task(A);
> 	  <sched-out>
> 	  unlock(rq->lock);
> 						      rq = __task_rq_lock(A)
> 						      if (A->on_rq) // false
> 						        A->state = TASK_RUNNING;
> 						      __task_rq_unlock(rq)
> 
> 
> Either A's schedule() must observe RUNNING (not shown) or B must
> observe !A->on_rq (shown) and not issue the store.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
