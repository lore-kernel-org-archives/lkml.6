Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756731AbeDZPxj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:53:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756589AbeDZPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:53:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A934360FED
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
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
Date: Thu, 26 Apr 2018 21:23:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426085719.GW4129@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2018 2:27 PM, Peter Zijlstra wrote:

> On Thu, Apr 26, 2018 at 10:41:31AM +0200, Peter Zijlstra wrote:
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index cd50e99202b0..4b6503c6a029 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -177,12 +177,13 @@ void *kthread_probe_data(struct task_struct *task)
>>   
>>   static void __kthread_parkme(struct kthread *self)
>>   {
>> -	__set_current_state(TASK_PARKED);
>> -	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
>> +	for (;;) {
>> +		__set_task_state(TASK_PARKED);
> 		set_current_state(TASK_PARKED);
>
> of course..

Hi Peter,

Maybe i am missing something , but still that race can come as we don't put task_parked on special state.

Controller                                                                       Hotplug

                                                                                  Loop

                                                                                  Task_Interruptible

Set SHOULD_PARK

wakeup -> Proceeds

                                                                                   Set Running

                                                                                   kthread_parkme

                                                                                   SET TASK_PARKED

                                                                                   schedule

Set TASK_RUNNING

Can you please correct ME, if I misunderstood this.

>
>> +		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>> +			break;
>>   		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
>>   			complete(&self->parked);
>>   		schedule();
>> -		__set_current_state(TASK_PARKED);
>>   	}
>>   	clear_bit(KTHREAD_IS_PARKED, &self->flags);
>>   	__set_current_state(TASK_RUNNING);
>>
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
