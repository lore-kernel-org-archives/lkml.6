Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937127AbeBUNoK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:44:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:64978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936663AbeBUNoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:44:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="176944773"
Subject: Re: [PATCH V4 1/5] perf/x86/intel: Fix event update for auto-reload
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
 <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
 <20180221103247.GL25181@hirez.programming.kicks-ass.net>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cac32cb6-e99a-2df7-e756-0498cf06598d@linux.intel.com>
Date: Wed, 21 Feb 2018 08:43:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221103247.GL25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2018 5:32 AM, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 02:20:31PM -0800, kan.liang@linux.intel.com wrote:
>> @@ -1389,8 +1456,22 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
>>   
>>   	ds->pebs_index = ds->pebs_buffer_base;
>>   
>> -	if (unlikely(base >= top))
>> +	if (unlikely(base >= top)) {
>> +		/*
>> +		 * The drain_pebs() could be called twice in a short period
>> +		 * for auto-reload event in pmu::read(). There are no
>> +		 * overflows have happened in between.
>> +		 * It needs to call intel_pmu_save_and_restart_reload() to
>> +		 * update the event->count for this case.
>> +		 */
>> +		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
>> +				 x86_pmu.max_pebs_events) {
>> +			event = cpuc->events[bit];
>> +			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>> +				intel_pmu_save_and_restart_reload(event, 0);
>> +		}
>>   		return;
>> +	}
>>   
>>   	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
>>   		struct pebs_record_nhm *p = at;
> 
> Is there a reason you didn't do intel_pmu_drain_pebs_core() ?
>

Right, I forgot that the drain_pebs_core() also has auto_reload support.
Sorry for that.
I will re-send all patches.

Thanks,
Kan

> 
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1435,8 +1435,11 @@ static void intel_pmu_drain_pebs_core(st
>   		return;
>   
>   	n = top - at;
> -	if (n <= 0)
> +	if (n <= 0) {
> +		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
> +			intel_pmu_save_and_restart_reload(event, 0);
>   		return;
> +	}
>   
>   	__intel_pmu_pebs_event(event, iregs, at, top, 0, n);
>   }
> 
