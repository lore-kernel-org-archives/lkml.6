Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757230AbeBPCZg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 21:25:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:13723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757216AbeBPCZe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 21:25:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="20561974"
Subject: Re: [PATCH] perf report: Fix a memory corrupton issue when enabling
 --branch-history
From: "Jin, Yao" <yao.jin@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
 <20180213094551.GA26936@krava>
 <2bfe35a5-f671-90dc-4753-75c8b2215f30@linux.intel.com>
Message-ID: <9b3483ae-a612-9d69-9671-4ddfea2c440e@linux.intel.com>
Date: Fri, 16 Feb 2018 10:25:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2bfe35a5-f671-90dc-4753-75c8b2215f30@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2018 10:00 PM, Jin, Yao wrote:
> 
> 
> On 2/13/2018 5:45 PM, Jiri Olsa wrote:
>> On Tue, Feb 13, 2018 at 04:44:28PM +0800, Jin Yao wrote:
>>> Following command lines will cause perf crash.
>>>
>>> perf record -j call -g -a <application>
>>> perf report --branch-history
>>>
>>> *** Error in `perf': double free or corruption (!prev): 
>>> 0x00000000104aa040 ***
>>> ======= Backtrace: =========
>>> /lib/x86_64-linux-gnu/libc.so.6(+0x77725)[0x7f6b37254725]
>>> /lib/x86_64-linux-gnu/libc.so.6(+0x7ff4a)[0x7f6b3725cf4a]
>>> /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f6b37260abc]
>>> perf[0x51b914]
>>> perf(hist_entry_iter__add+0x1e5)[0x51f305]
>>> perf[0x43cf01]
>>> perf[0x4fa3bf]
>>> perf[0x4fa923]
>>> perf[0x4fd396]
>>> perf[0x4f9614]
>>> perf(perf_session__process_events+0x89e)[0x4fc38e]
>>> perf(cmd_report+0x15d2)[0x43f202]
>>> perf[0x4a059f]
>>> perf(main+0x631)[0x427b71]
>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f6b371fd830]
>>> perf(_start+0x29)[0x427d89]
>>>
>>> The memory corruption happens at:
>>>
>>> iter_add_next_cumulative_entry()
>>> {
>>>          ...
>>>          for (i = 0; i < iter->curr; i++) {
>>>          ...
>>> }
>>>
>>> Whatever in iter_next_cumulative_entry() or in 
>>> iter_add_next_cumulative_entry(),
>>> they all don't check if iter->curr exceeds the array 'he_cache[]'.
>>>
>>> If there are too many nodes in callchain, it's possible that 
>>> iter->curr >
>>> iter->max_stack, then memory corruption occurs.
>>>
>>> This patch will reallocate array 'he_cache[]' in 
>>> iter_next_cumulative_entry()
>>> if necessary (the case of too many nodes in callchain).
>>
>> right, the max_stack does not say how many nodes end up in
>> callchain_cursor at the end.. good catch, please mention
>> that also in the changelog
>>
> 
> max_stack looks only to limit the number of calls but not for other 
> branches.
> 
>> however we know the final count from callchain_cursor itself,
>> the attached patch might do the same job, right?
>>
> 
> I think the attached patch is ok.
> 
>> also could we now get rid of iter->max_stack?
>>
> 
>  From my opinion, the option '--max-stack' in perf report looks not very 
> necessary. While it's just my personal opinion, need to hear from more 
> people. :)
> 
> Thanks
> Jin Yao
> 
>> thanks,
>> jirka
>>
>>
>> ---
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index b6140950301e..b50b7b70dcca 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -879,7 +879,7 @@ iter_prepare_cumulative_entry(struct 
>> hist_entry_iter *iter,
>>        * cumulated only one time to prevent entries more than 100%
>>        * overhead.
>>        */
>> -    he_cache = malloc(sizeof(*he_cache) * (iter->max_stack + 1));
>> +    he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
>>       if (he_cache == NULL)
>>           return -ENOMEM;
>>

Hi Jiri,

I guess you will post this patch, right?

Thanks
Jin Yao
