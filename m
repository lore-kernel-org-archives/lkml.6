Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeCEO2c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:28:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:25227 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbeCEO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:28:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39322687"
Subject: Re: [PATCH 02/14] perf trace: Apply new perf_mmap__read_event()
 interface
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
 <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
 <20180302233014.GA8970@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f31785d9-b12d-4826-d790-b41686135280@linux.intel.com>
Date: Mon, 5 Mar 2018 09:28:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302233014.GA8970@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/2018 6:30 PM, Jiri Olsa wrote:
> On Thu, Mar 01, 2018 at 06:08:59PM -0500, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The perf trace still use the legacy interface.
>>
>> Apply the new perf_mmap__read_event() interface for perf trace.
>>
>> No functional change.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/builtin-trace.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
>> index e7f1b18..a46644f 100644
>> --- a/tools/perf/builtin-trace.c
>> +++ b/tools/perf/builtin-trace.c
>> @@ -2472,8 +2472,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   
>>   	for (i = 0; i < evlist->nr_mmaps; i++) {
>>   		union perf_event *event;
>> +		struct perf_mmap *md;
>> +		u64 end, start;
>>   
>> -		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
>> +		md = &evlist->mmap[i];
>> +		if (perf_mmap__read_init(md, 0, &start, &end) < 0)
>> +			continue;
> 
> should we break the loop if this returns -EINVAL?
>

It only means the ring buffer is broken for current mmaps.
For others, the data should still be good.
I don't think we should drop them by breaking the loop.

Also, the -EINVAL is only valid for overwrite mode. It is impossible to 
return -EINVAL in current code.

Thanks,
Kan

> jirka
> 
>> +
>> +		while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
>>   			struct perf_sample sample;
>>   
>>   			++trace->nr_events;
>> @@ -2486,7 +2492,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   
>>   			trace__handle_event(trace, event, &sample);
>>   next_event:
>> -			perf_evlist__mmap_consume(evlist, i);
>> +			perf_mmap__consume(md, 0);
>>   
>>   			if (interrupted)
>>   				goto out_disable;
>> @@ -2496,6 +2502,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   				draining = true;
>>   			}
>>   		}
>> +		perf_mmap__read_done(md);
>>   	}
>>   
>>   	if (trace->nr_events == before) {
>> -- 
>> 2.4.11
>>
