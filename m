Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08705C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DDB2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m/NQA0DF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UxRwfLq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DDB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbeHAJvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:51:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbeHAJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:51:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C376606AC; Wed,  1 Aug 2018 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533110824;
        bh=DvRWMWTLnHP1lQ6Sh0uCi6L8rkneR069gy+uSJrzukc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/NQA0DFBn4nZvGy2rggYdU3GZPLQVnfB1uRV/IZ18M3BHG0goUfzegi16g86HFWQ
         wucIqyLWaj6N9OoyGjkVZ153u8gFVl0lPX7AdTNDis9zPf+8PdIQF6iDpfjk96IqHh
         XIAX2UTUyWTmQkdH45D183HFLqK84phXt8HrbLx8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1A3B1606AC;
        Wed,  1 Aug 2018 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533110823;
        bh=DvRWMWTLnHP1lQ6Sh0uCi6L8rkneR069gy+uSJrzukc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UxRwfLq0YUKKvhI7M5BNsKhK/fx9anSbTwaSragAY0nYrfOXcJ7q0aaV36qn0g0k6
         hRbZ17EKv+XpIyxSis57FPaNeM44Utrnt3oyqPDbsGzpyfMkGWUs7hu+EByYCL5qO2
         Pjb6owYSChqwJGOOR4fPgiw2j+xLhp1u6eHgLlB8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 01:07:03 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        isaacm@codeaurora.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        pkondeti@codeaurora.org, stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
In-Reply-To: <20180730210728.GQ2494@hirez.programming.kicks-ass.net>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
 <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
 <20180724062350.nlem2suuy5wlxpts@linutronix.de>
 <alpine.DEB.2.21.1807301220280.2518@nanos.tec.linutronix.de>
 <20180730112140.GH2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807301440340.2518@nanos.tec.linutronix.de>
 <109d0e70606ccd34861a80525d6d11aa@codeaurora.org>
 <20180730210728.GQ2494@hirez.programming.kicks-ass.net>
Message-ID: <52a34ed365cd560457e9abf5877c5b37@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-30 14:07, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 10:12:43AM -0700, Sodagudi Prasad wrote:
>> How about including below change as well?  Currently, there is no way 
>> to
>> identify thread migrations completed or not.  When we observe this 
>> issue,
>> the symptom was work queue lock up. It is better to have some timeout 
>> here
>> and induce the bug_on.
> 
> You'd trigger the soft-lockup or hung-task detector I think. And if 
> not,
> we ought to look at making it trigger at least one of those.
> 
>> There is no way to identify the migration threads stuck or not.
> 
> Should be pretty obvious from the splat generated by the above, no?
Hi Peter and Thomas,

Thanks for your support.
I have another question on this flow and retry mechanism used in this 
cpu_stop_queue_two_works() function using the global variable 
stop_cpus_in_progress.

This variable is getting used in various paths, such as task migration, 
set task affinity, and CPU hotplug.

For example cpu hotplug path, stop_cpus_in_progress variable getting set 
with true with out checking.
takedown_cpu()
--stop_machine_cpuslocked()
---stop_cpus()
---__stop_cpus()
----queue_stop_cpus_work()
setting stop_cpus_in_progress to true directly.

But in the task migration path only, the stop_cpus_in_progress  variable 
is used for retry.

I am thinking that stop_cpus_in_progress variable lead race conditions, 
where CPU hotplug and task migration happening simultaneously. Please 
correct me If my understanding wrong.

-Thanks, Prasad

> 
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -290,6 +290,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int 
>> cpu2,
>> cpu_stop_fn_t fn, void *
>>         struct cpu_stop_done done;
>>         struct cpu_stop_work work1, work2;
>>         struct multi_stop_data msdata;
>> +       int ret;
>> 
>>         msdata = (struct multi_stop_data){
>>                 .fn = fn,
>> @@ -312,7 +313,10 @@ int stop_two_cpus(unsigned int cpu1, unsigned int 
>> cpu2,
>> cpu_stop_fn_t fn, void *
>>         if (cpu_stop_queue_two_works(cpu1, &work1, cpu2, &work2))
>>                 return -ENOENT;
>> 
>> -       wait_for_completion(&done.completion);
>> +       ret = wait_for_completion_timeout(&done.completion,
>> msecs_to_jiffies(1000));
>> +       if (!ret)
>> +               BUG_ON(1);
>> +
> 
> That's a random timeout, which if you spuriously trigger it, will take
> down your machine. That seems like a cure worse than the disease.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
