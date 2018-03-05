Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeCEOuS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:50:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:13441 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932165AbeCEOuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:50:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="32508074"
Subject: Re: [PATCH 02/14] perf trace: Apply new perf_mmap__read_event()
 interface
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
 <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
 <20180302233022.GB8970@krava> <20180305130339.GE30054@kernel.org>
 <20180305134652.GF30054@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <44636157-9aaf-4e50-c12a-a2e60e01e415@linux.intel.com>
Date: Mon, 5 Mar 2018 09:50:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305134652.GF30054@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2018 8:46 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 05, 2018 at 10:03:39AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Sat, Mar 03, 2018 at 12:30:22AM +0100, Jiri Olsa escreveu:
>>> On Thu, Mar 01, 2018 at 06:08:59PM -0500, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>> The perf trace still use the legacy interface.
>>>> +++ b/tools/perf/builtin-trace.c
>>>> @@ -2472,8 +2472,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>>>   
>>>>   	for (i = 0; i < evlist->nr_mmaps; i++) {
>>>>   		union perf_event *event;
>>>> +		struct perf_mmap *md;
>>>> +		u64 end, start;
>>>>   
>>>> -		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
>>>> +		md = &evlist->mmap[i];
>>>> +		if (perf_mmap__read_init(md, 0, &start, &end) < 0)
>>>> +			continue;
>>>> +
>>>> +		while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
>>>>   			struct perf_sample sample;
>>>>   
>>>>   			++trace->nr_events;
>>>> @@ -2486,7 +2492,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>>>   
>>>>   			trace__handle_event(trace, event, &sample);
>>>>   next_event:
>>>> -			perf_evlist__mmap_consume(evlist, i);
>>>> +			perf_mmap__consume(md, 0);
>>>
>>> could you call this with 'false' instead of 0, it's 'bool overwrite'
>>> applies also to the rest of the patchset
>>
>> I'm doing this, the argument is 'bool', so the value should be false or
>> true, even '0' being way shorter...
> 
> While doing that I wonder why is that we can't do it without those
> explicit start/end variables in all the call sites and passing
> overwrite, start and end as parameters...
> 
> Can't we just add 'overwrite, 'start' and 'end' to struct perf_mmap,
> then have perf_mmap__read_init() with just 'md' and 'overwrite' as
> parameters, initialize md->{start,end} and set md->overwrite to the
> 'overwrite' parameter in 'perf_mmap__read_init()' and then use just
> md as parameters for both perf_mmap__read_event() and
> perf_mmap__consume()?
>

I don't see any reason we cannot do this.
I will do some test. If it works well, I will submit the follow-up patch 
to clean up the interface.

Thanks,
Kan

> What am I missing to have this much simpler without all this
> boilerplate?
> 
> Anyway, finishing the s/0/false/g, will leave this for later, but please
> comment on it.
> 
> - Arnaldo
> 
