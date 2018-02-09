Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeBIPtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:49:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:8548 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbeBIPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:49:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,483,1511856000";
   d="scan'208";a="17259741"
Subject: Re: [PATCH V3 1/5] perf/x86/intel: fix event update for auto-reload
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <1517243373-355481-2-git-send-email-kan.liang@linux.intel.com>
 <20180206150648.GK2249@hirez.programming.kicks-ass.net>
 <ae4c7aff-da12-8cb3-4fac-4637ab001060@linux.intel.com>
 <20180209140905.GG25181@hirez.programming.kicks-ass.net>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cafc7994-bb39-14a3-ad20-1357d688a7ff@linux.intel.com>
Date: Fri, 9 Feb 2018 10:49:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209140905.GG25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/2018 9:09 AM, Peter Zijlstra wrote:
> On Tue, Feb 06, 2018 at 12:58:23PM -0500, Liang, Kan wrote:
>>
>>
>>> With the exception of handling 'empty' buffers, I ended up with the
>>> below. Please try again.
>>>
>>
>> There are two small errors. After fixing them, the patch works well.
> 
> Well, it still doesn't do A, two read()s without PEBS record in between.
> So that needs fixing. What 3/5 does, call x86_perf_event_update() after
> drain_pebs() is actively wrong after this patch.
>

As my understanding, for case A, drain_pebs() will return immediately. 
It cannot reach the patch.
Because there is no PEBS record ready. So the ds->pebs_index should be 
the same as ds->pebs_buffer_base.

3/5 is to handle case A.

Thanks,
Kan

>>> +
>>> +	/*
>>> +	 * Careful, not all hw sign-extends above the physical width
>>> +	 * of the counter.
>>> +	 */
>>> +	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>>> +	delta >>= shift;
>>
>> new_raw_count could be smaller than prev_raw_count.
>> The sign bit will be set. The delta>> could be wrong.
>>
>> I think we can add a period here to prevent it.
>> +       delta = (period << shift) + (new_raw_count << shift) -
>> +               (prev_raw_count << shift);
>> +       delta >>= shift;
>> ......
>> +       local64_add(delta + period * (count - 1), &event->count);
>>
> 
> Right it does, but that wrecks case A again, because then we get here
> with !@count.
> 
> Maybe something like:
> 
> 
> 	s64 new, old;
> 
> 	new = ((s64)(new_raw_count << shift) >> shift);
> 	old = ((s64)(old_raw_count << shift) >> shift);
> 
> 	local64_add(new - old + count * period, &event->count);
> 
> 
> And then make intel_pmu_drain_pebs_*(), call this function even when !n.
> 
