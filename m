Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeEAKlE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:41:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeEAKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:41:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBEEA607E4
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
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
 <20180501101845.GE12217@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <f134c8d8-e56f-bf29-0177-e6702ae79f2b@codeaurora.org>
Date: Tue, 1 May 2018 16:10:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501101845.GE12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 3:48 PM, Peter Zijlstra wrote:
> On Tue, May 01, 2018 at 01:20:26PM +0530, Kohli, Gaurav wrote:
>> But In our older case, where we have seen failure below is the wake up path
>> and ftraces, Wakeup occured  and completed before schedule call only.
>>
>> So final state of CPUHP is running not parked. I have also pasted debug
>> ftraces that we got during issue reproduction.
>>
>> Here wakeup for cpuhp is below:
>>
>> takedown_cpu-> kthread_park-> wake_up_process
>>
>>
>>   39,034,311,742,395  apps (10240)        Trace Printk cpuhp/0  (16)  [000]
>> 39015.625000: <debug> __kthread_parkme state=512 task=ffffffcc7458e680
>> flags: 0x5 -> state 5 -> state is parked inside parkme function
>>
>> 39,034,311,846,510  apps (10240)        Trace Printk cpuhp/0  (16)  [000]
>> 39015.625000: <debug> before schedule __kthread_parkme state=0
>> task=ffffffcc7458e680 flags: 0xd  ->  just before schedule call, state is
>> running
>>
>> tatic void __kthread_parkme(struct kthread *self)
>>
>> {
>>
>>          __set_current_state(TASK_PARKED);
>>
>>          while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
>>
>>                  if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
>>
>>                          complete(&self->parked);
>>
>>                  schedule();
>>
>>                  __set_current_state(TASK_PARKED);
>>
>>          }
>>
>>          clear_bit(KTHREAD_IS_PARKED, &self->flags);
>>
>>          __set_current_state(TASK_RUNNING);
>>
>> }
>>
>> So my point is here also, if it is reschedule then it can set TASK_PARKED,
>> but it seems after takedown_cpu call this thread never get a chance to run,
>> So final state is TASK_RUNNING.
>>
>> In our current fix also can't we observe same scenario where final state is
>> TASK_RUNNING.
> 
> I'm not sure I understand your concern. Loosing the TASK_PARKED store
> with the above code is obviously bad. But with the loop as proposed I
> don't see a problem.

Yes with loop, it will reset TASK_PARKED but that is not happening in 
the dumps we have seen. Here before schedule state is RUNNING and cpuhp
got migrate to some core but never get a chance to run so state is running.
> 
> takedown_cpu() can proceed beyond smpboot_park_threads() and kill the
> CPU before any of the threads are parked -- per having the complete()
> before hitting schedule().
> 
> And, afaict, that is harmless. When we go offline, sched_cpu_dying() ->
> migrate_tasks() will migrate any still runnable threads off the cpu.
> But because at this point the thread must be in the PARKED wait-loop, it
> will hit schedule() and go to sleep eventually.
> 
> Also note that kthread_unpark() does __kthread_bind() to rebind the
> threads.
> 
> Aaaah... I think I've spotted a problem there. We clear SHOULD_PARK
> before we rebind, so if the thread lost the first PARKED store,
> does the completion, gets migrated, cycles through the loop and now
> observes !SHOULD_PARK and bails the wait-loop, then __kthread_bind()
> will forever wait.
> 

So during next unpark
__kthread_unpark -> __kthread_bind -> wait_task_inactive (this got 
failed, as current state is running so failed on below call:


  while (task_running(rq, p)) {
                         if (match_state && unlikely(p->state != 
match_state))
                                 return 0;
                         cpu_relax();
                 }

and gives warning:


         if (!wait_task_inactive(p, state)) {
                 WARN_ON(1);
                 return; -> return from here, and further binding call 
fail which is after this code.
         }


finally it is giving bug_on here as we failed to rebind hotplug to our core:
                         }
                         kthread_parkme();
                         /* We might have been woken for stop */
                         continue;
                 }

                 BUG_ON(td->cpu != smp_processor_id()); panic occured.


So it seems we always have to be in PARKED state only , not miss any 
single instance.
> Is that what you had in mind?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
