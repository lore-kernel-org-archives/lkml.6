Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeDZEEq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 00:04:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeDZEEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 00:04:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E2C160594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <f18c42e4-ead7-fbcd-b7da-6677e8485be9@codeaurora.org>
Date: Thu, 26 Apr 2018 09:34:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2018 1:39 AM, Peter Zijlstra wrote:

> On Wed, Apr 25, 2018 at 02:03:19PM +0530, Gaurav Kohli wrote:
>> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
>> index 5043e74..c5c5184 100644
>> --- a/kernel/smpboot.c
>> +++ b/kernel/smpboot.c
>> @@ -122,7 +122,45 @@ static int smpboot_thread_fn(void *data)
>>   		}
>>   
>>   		if (kthread_should_park()) {
>> +			/*
>> +			 * Serialize against wakeup.
> 			 *
> 			 * Prior wakeups must complete and later wakeups
> 			 * will observe TASK_RUNNING.
> 			 *
> 			 * This avoids the case where the TASK_RUNNING
> 			 * store from ttwu() competes with the
> 			 * TASK_PARKED store from kthread_parkme().
> 			 *
> 			 * If the TASK_PARKED store looses that
> 			 * competition, kthread_unpark() will go wobbly.
>> +			 */
>> +			raw_spin_lock(&current->pi_lock);
>>   			__set_current_state(TASK_RUNNING);
>> +			raw_spin_unlock(&current->pi_lock);
>>   			preempt_enable();
>>   			if (ht->park && td->status == HP_THREAD_ACTIVE) {
>>   				BUG_ON(td->cpu != smp_processor_id());
> Does that work for you?

We have given patch for testing, usually it takes around 2-3 days for reproduction(we will update for the same).

>
> But looking at this a bit more; don't we have the exact same problem
> with the TASK_RUNNING store in the !ht->thread_should_run() case?
> Suppose a ttwu() happens concurrently there, it can end up competing
> against the TASK_INTERRUPTIBLE store, no?
>
> Of course, that race is not fatal, we'll just end up going around the
> loop once again I suppose. Maybe a comment there too?
>
> 			/*
> 			 * A similar race is possible here, but loosing
> 			 * the TASK_INTERRUPTIBLE store is harmless and
> 			 * will make us go around the loop once more.
> 			 */

Actually instead of race, i am seeing wakeup miss problem which is very rare, if we take case of hotplug thread

Controller                                           Hotplug

                                                              Loop start

                                                              set_current_state(TASK_INTERRUPTIBLE);

                                                              if (kthread_should_park()) { -> fails

Set Should_park

then wake_up

                                                             if (!ht->thread_should_run(td->cpu)) {

                                                             preempt_enable_no_resched();

                                                             schedule(); Again went to schedule(which is very rare to occur,not sure whether it hits)

                                           

>
> And of course, I suspect we actually want to use TASK_IDLE, smpboot
> threads don't want signals do they? But that probably ought to be a
> separate patch.

Yes I agree, we can control race from here as well,  Please suggest would below change be any help here:

  } else {

                         __set_current_state(TASK_RUNNING);

                         preempt_enable();

                         ht->thread_fn(td->cpu);

                        + set_current_state(TASK_INTERRUPTIBLE);

                        + schedule();

                 }

>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
