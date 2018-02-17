Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeBQBsZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 20:48:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeBQBsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 20:48:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 649156043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
Subject: Re: [PATCH 1/1] perf: Add CPU hotplug support for events
To: Peter Zijlstra <peterz@infradead.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org, skannan@codeaurora.org
References: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
 <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
 <20180216082139.GF25181@hirez.programming.kicks-ass.net>
 <361ffd6f-3eec-4be6-de2f-40beb588c65e@codeaurora.org>
 <20180216203953.GL25201@hirez.programming.kicks-ass.net>
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
Message-ID: <aee872be-c34d-729b-575d-df488a46f2cf@codeaurora.org>
Date: Fri, 16 Feb 2018 17:48:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180216203953.GL25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/16/2018 12:39 PM, Peter Zijlstra wrote:
> On Fri, Feb 16, 2018 at 10:06:29AM -0800, Raghavendra Rao Ananta wrote:
>>> No this is absolutely disguisting. You can simply keep the events in the
>>> dead CPU's context. It's really not that hard.
>> Keeping the events in the dead CPU's context was also an idea that we had.
>> However, detaching that event from the PMU when the CPU is offline would be
>> a pain. Consider the scenario in which an event is about to be destroyed
>> when the CPU is offline (yet still attached to the CPU). During it's
>> destruction, a cross-cpu call is made (from perf_remove_from_context()) to
>> the offlined CPU to detach the event from the CPU's PMU. As the CPU is
>> offline, that would not be possible, and again a separate logic has to be
>> written for cleaning up the events whose CPUs are offlined.
> 
> That is actually really simple to deal with. The real problems are with
> semantics, is an event enabled when the CPU is dead? Can you
> disable/enable an event on a dead CPU.
> 
> The below patch (_completely_ untested) should do most of it, but needs
> help with the details. I suspect we want to allow enable/disable on
> events that are on a dead CPU, and equally I think we want to account
> the time an enabled event spends on a dead CPU to go towards the
> 'enabled' bucket.
I've gone through your diff, and it gave me a hint of similar texture 
what we are trying to do (except for maintaining an offline event list). 
Nevertheless, I tried to test your patch. I created an hw event, and 
tried to offline the CPU in parallel, and I immediately hit a watchdog 
soft lockup bug! Tried the same this by first switching off the CPU 
(without any event created), and I hit into similar issue. I am sure we 
can fix it, but apart from the "why we are doing hotplug?" question, was 
was there specifically any issue with our patch?

> 
>>> Also, you _still_ don't explain why you care about dead CPUs.
>>>
I wanted to understand, if we no longer care about hotplugging of CPUs, 
then why do we still have exported symbols such as cpu_up() and 
cpu_down()? Moreover, we also have the hotplug interface exposed to 
users-space as well (through sysfs). As long as these interfaces exist, 
there's always a potential chance of bringing the CPU up/down. Can you 
please clear this thing up for me?

-- Raghavendra

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
