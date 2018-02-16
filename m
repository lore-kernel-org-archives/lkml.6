Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162810AbeBPSGd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:06:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161668AbeBPSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:06:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00AA460558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
Subject: Re: [PATCH 1/1] perf: Add CPU hotplug support for events
To: Peter Zijlstra <peterz@infradead.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, cme@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, skannan@codeaurora.org
References: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
 <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
 <20180216082139.GF25181@hirez.programming.kicks-ass.net>
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
Message-ID: <361ffd6f-3eec-4be6-de2f-40beb588c65e@codeaurora.org>
Date: Fri, 16 Feb 2018 10:06:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180216082139.GF25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/16/2018 12:21 AM, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 03:01:41PM -0800, Raghavendra Rao Ananta wrote:
>> Perf framework doesn't allow prevserving CPU events across
>> CPU hotplugs. The events are scheduled out as and when the
>> CPU walks offline. Moreover, the framework also doesn't
>> allow the clients to create events on an offline CPU. As
>> a result, the clients have to keep on monitoring the CPU
>> state until it comes back online.
>>
>> Therefore, introducing the perf framework to support creation
>> and preserving of (CPU) events for offline CPUs. Through
>> this, the CPU's online state would be transparent to the
>> client and it not have to worry about monitoring the CPU's
>> state. Success would be returned to the client even while
>> creating the event on an offline CPU. If during the lifetime
>> of the event the CPU walks offline, the event would be
>> preserved and would continue to count as soon as (and if) the
>> CPU comes back online.
>>
>> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
>> ---
>>   include/linux/perf_event.h |   7 +++
>>   kernel/events/core.c       | 123 +++++++++++++++++++++++++++++++++------------
>>   2 files changed, 97 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 7546822..bc07f16 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -489,6 +489,7 @@ struct perf_addr_filters_head {
>>    * enum perf_event_state - the states of a event
>>    */
>>   enum perf_event_state {
>> +	PERF_EVENT_STATE_DORMANT	= -5,
>>   	PERF_EVENT_STATE_DEAD		= -4,
>>   	PERF_EVENT_STATE_EXIT		= -3,
>>   	PERF_EVENT_STATE_ERROR		= -2,
>> @@ -687,6 +688,12 @@ struct perf_event {
>>   #endif
>>   
>>   	struct list_head		sb_list;
>> +
>> +	/* Entry into the list that holds the events whose CPUs
>> +	 * are offline. These events will be removed from the
>> +	 * list and installed once the CPU wakes up.
>> +	 */
>> +	struct list_head		dormant_entry;
> 
> No this is absolutely disguisting. You can simply keep the events in the
> dead CPU's context. It's really not that hard.
Keeping the events in the dead CPU's context was also an idea that we 
had. However, detaching that event from the PMU when the CPU is offline 
would be a pain. Consider the scenario in which an event is about to be 
destroyed when the CPU is offline (yet still attached to the CPU). 
During it's destruction, a cross-cpu call is made (from 
perf_remove_from_context()) to the offlined CPU to detach the event from 
the CPU's PMU. As the CPU is offline, that would not be possible, and 
again a separate logic has to be written for cleaning up the events 
whose CPUs are offlined. Hence, I thought it would be a cleaner way to 
maintain the events.
> 
> Also, you _still_ don't explain why you care about dead CPUs.
> 

It's just not only about dead CPUs. It's the fact that the CPUs can come 
and go online. The embedded world, specifically Android mobile SoCs, 
rely on CPU hotplugs to manage power and thermal constraints. These 
hotplugs can happen at a very rapid pace. Adjacently, they also rely on 
many perf event counters for its management. Therefore, there is
a need to preserve these events across hotplugs.
In such a scenario, a perf client (kernel or user-space) can create
events even when the CPU is offline. If the CPU comes online during
the lifetime of the event, the registered event can start counting
spontaneously. As an extension to this, the events' count can also
be preserved across CPU hotplugs. This takes the burden off of the
clients to monitor the state of the CPU.

-- Raghavendra

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
