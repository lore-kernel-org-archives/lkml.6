Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932314AbeCEUz7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:55:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:23929 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbeCEUz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:55:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32596877"
Subject: Re: [PATCH 1/7] perf mmap: Store mmap scope and type in struct
 perf_mmap
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
 <20180305202054.GA10176@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <47c9d29d-4b99-a9b6-4af6-2320900b2ef6@linux.intel.com>
Date: Mon, 5 Mar 2018 15:55:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305202054.GA10176@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2018 3:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 05, 2018 at 02:10:53PM -0500, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> There are too many boilerplates for the perf_mmap__read*() interfaces.
>>
>> Some of the data (e.g. 'start', 'end', 'overwrite') should be stored in
>> struct perf_mmap at initialization. They will be used later.
>>
>> No functional change.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/util/mmap.c | 11 ++++++++---
>>   tools/perf/util/mmap.h |  3 +++
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 4f27c46..642b479 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -250,11 +250,14 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
>>   
>>   	*startp = overwrite ? head : old;
>>   	*endp = overwrite ? old : head;
> 
> Why did you keep the above and haven't removed the startp/endp args? 

The startp/endp are used by perf_mmap__read_event().
I don't want to make all the changes in a single patch. I think it's 
hard to review.
So I modified the interface one by one.
Only changing one interface will break the usage.
So the old 'startp/endp' and new 'md->start/md->end' will exist 
simultaneously in the first few patches. They have the same value.

Patch 1,3,4 add the new 'md->start/md->end' for the three interfaces.
Patch 2 uses the new 'md->start/md->end' for perf record.
Patch 5,6,7 remove the old 'startp/endp' for other perf tools/test and 
refine the interfaces.

Thanks,
Kan
> to
> ease the conversion somehow? I'll look at the other patches, but I think
> we should change the function signature here and in the callers all at
> once.
> 
> Sometimes this is ok, and probably this is one case.
> 
> - Arnaldo
> 
>> +	md->overwrite = overwrite;
>> +	md->start = overwrite ? head : old;
>> +	md->end = overwrite ? old : head;
>>   
>> -	if (*startp == *endp)
>> +	if (md->start == md->end)
>>   		return -EAGAIN;
>>   
>> -	size = *endp - *startp;
>> +	size = md->end - md->start;
>>   	if (size > (unsigned long)(md->mask) + 1) {
>>   		if (!overwrite) {
>>   			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
>> @@ -268,8 +271,10 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
>>   		 * Backward ring buffer is full. We still have a chance to read
>>   		 * most of data from it.
>>   		 */
>> -		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
>> +		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
>>   			return -EINVAL;
>> +		*startp = md->start;
>> +		*endp = md->end;
>>   	}
>>   
>>   	return 0;
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index ec7d3a24..9359e93 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -20,6 +20,9 @@ struct perf_mmap {
>>   	int		 fd;
>>   	refcount_t	 refcnt;
>>   	u64		 prev;
>> +	u64		 start;
>> +	u64		 end;
>> +	bool		 overwrite;
>>   	struct auxtrace_mmap auxtrace_mmap;
>>   	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
>>   };
>> -- 
>> 2.4.11
