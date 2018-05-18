Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeERVaF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:30:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:53274 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbeERVaE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:30:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,416,1520924400";
   d="scan'208";a="229869543"
Subject: Re: [PATCH v3 1/3] perf evlist: Create a new function
 perf_evlist_forced_leader
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
 <1526659234-1556-2-git-send-email-yao.jin@linux.intel.com>
 <20180518141858.GC32141@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c85a0647-0815-1d2a-235b-a31ed26192d0@linux.intel.com>
Date: Sat, 19 May 2018 05:30:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518141858.GC32141@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2018 10:18 PM, Arnaldo Carvalho de Melo wrote:
> Em Sat, May 19, 2018 at 12:00:32AM +0800, Jin Yao escreveu:
>> For non-explicit group, perf report supports a option '--group'
>> which can enable group output. We also need to support perf annotate
>> with the same '--group'.
>>
>> Create a new function perf_evlist_forced_leader which contains
>> common code to force setting the group leader.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/evlist.c | 15 +++++++++++++++
>>   tools/perf/util/evlist.h |  3 +++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index a59281d..6983f6a 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1795,3 +1795,18 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
>>   
>>   	return true;
>>   }
>> +
>> +/*
>> + * Events in data file are not collect in groups, but we still want
>> + * the group display. Set the artificial group and set the leader's
>> + * forced_leader flag to notify the display code.
>> + */
>> +void perf_evlist_forced_leader(struct perf_evlist *evlist)
> 
> This should've been:
> 
> void perf_evlist__forced_leader(struct perf_evlist *evlist)
> 
> But then, by the verb conjugation, I thought that this would be a query,
> i.e. "is this a forced leader?", but then, it returning void didn't
> match that expectation, which leads me having to actually _read_ that
> code to understand what is that this function does, which I would, but
> just to check that it matches what it seems to be, now I'm trying to do
> it to figure it out what is it that this thing does :-\
> 
> 
> I see, its a 'd' to many, this should be:
> 
> void perf_evlist__force_leader(struct perf_evlist *evlist)
> 
> Please confirm that this is what you intend by posting a v4, so far,
> just for this specific patch and any other in the series that uses this
> function, ok?
> 
> - Arnaldo
> 

Yes, the function is not a query, it's just to setup the forced_leader.

Maybe we can use the name "perf_evlist__setup_forced_leader". But it 
looks the name is long so the name "perf_evlist__force_leader" is also good.

I will use the name "perf_evlist__force_leader" in v4.

Thanks
Jin Yao



>> +{
>> +	if (!evlist->nr_groups) {
>> +		struct perf_evsel *leader = perf_evlist__first(evlist);
>> +
>> +		perf_evlist__set_leader(evlist);
>> +		leader->forced_leader = true;
>> +	}
>> +}
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 6c41b2f..d77d514 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -309,4 +309,7 @@ struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
>>   					    union perf_event *event);
>>   
>>   bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
>> +
>> +void perf_evlist_forced_leader(struct perf_evlist *evlist);
>> +
>>   #endif /* __PERF_EVLIST_H */
>> -- 
>> 2.7.4
