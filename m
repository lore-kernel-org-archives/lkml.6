Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbeEALqY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:46:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEALqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:46:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFC7D601A1
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
 <f134c8d8-e56f-bf29-0177-e6702ae79f2b@codeaurora.org>
 <20180501113132.GF12217@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <745d762d-9ab3-0749-9b87-9bb03d913071@codeaurora.org>
Date: Tue, 1 May 2018 17:16:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501113132.GF12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 5:01 PM, Peter Zijlstra wrote:
> On Tue, May 01, 2018 at 04:10:53PM +0530, Kohli, Gaurav wrote:
>> Yes with loop, it will reset TASK_PARKED but that is not happening in the
>> dumps we have seen.
> 
> But was that with or without the fixed wait-loop? I don't care about
> stuff you might have seen with the current code, that is clearly broken.
> 
>>> takedown_cpu() can proceed beyond smpboot_park_threads() and kill the
>>> CPU before any of the threads are parked -- per having the complete()
>>> before hitting schedule().
>>>
>>> And, afaict, that is harmless. When we go offline, sched_cpu_dying() ->
>>> migrate_tasks() will migrate any still runnable threads off the cpu.
>>> But because at this point the thread must be in the PARKED wait-loop, it
>>> will hit schedule() and go to sleep eventually.
>>>
>>> Also note that kthread_unpark() does __kthread_bind() to rebind the
>>> threads.
>>>
>>> Aaaah... I think I've spotted a problem there. We clear SHOULD_PARK
>>> before we rebind, so if the thread lost the first PARKED store,
>>> does the completion, gets migrated, cycles through the loop and now
>>> observes !SHOULD_PARK and bails the wait-loop, then __kthread_bind()
>>> will forever wait.
>>>
>>
>> So during next unpark
>> __kthread_unpark -> __kthread_bind -> wait_task_inactive (this got failed,
>> as current state is running so failed on below call:
> 
> Aah, yes, I seem to have mis-remembered how wait_task_inactive() works.
> And it is indeed still a problem..
> 
> Let me ponder what the best solution is, it's a bit of a mess.
> 

Sure , Thanks a lot.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
