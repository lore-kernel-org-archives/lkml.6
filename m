Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22852C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E668A204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E668A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJBRYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:24:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbeJBRYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:24:33 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2AC4ABD57E7A7;
        Tue,  2 Oct 2018 18:41:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Tue, 2 Oct 2018
 18:41:43 +0800
Subject: Re: perf segmentation fault from NULL dereference
To:     Jiri Olsa <jolsa@redhat.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
CC:     Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Will Deacon" <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
Date:   Tue, 2 Oct 2018 11:41:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180927160210.GF6916@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I am suspicious that this is a real issue, as this patch has been in
>> mainline for some time...
>>
>> This simple change fixes the issue me:
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 91e6d9c..f4fd826 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -3576,7 +3576,7 @@ int perf_event__process_feature(struct perf_tool
>> *tool,
>>      int max, err;
>>      u16 type;
>>
>> -    if (!evsel->own_cpus)
>> +    if (!evsel->own_cpus || !(evsel->attr.read_format & PERF_FORMAT_ID)) //
>> roundabout check for !evsel->id
>>          return 0;
>>
>>      ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
>>
>> It turns out that evsel->id is NULL on a call to
>> perf_event__process_feature(), which upsets this code:
>>
>>     ev->header.type = PERF_RECORD_EVENT_UPDATE;
>>     ev->header.size = (u16)size;
>>     ev->type = PERF_EVENT_UPDATE__CPUS;
>>     ev->id   = evsel->id[0];
>>
>> Please me let me know if a valid issue so we can get a fix in.
>
> yea, I can see how we can get here with event having
> its own CPUs, and we allocate the id array later at
> the time we map the event
>
> I wonder instead of skipping on this feature, we should
> allocate the id array, like below
>
> I did not test that.. need to find the server having event
> with its own cpus.. also need to make sure evsel->cpus is
> the way to go in here
>

Thanks for the fix, but I got this:
root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
Couldn't synthesize evsel cpus.
root@localhost:~#


> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 1ec1d9bc2d63..fb2a0dab3978 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -29,6 +29,7 @@
>  #include "symbol.h"
>  #include "debug.h"
>  #include "cpumap.h"
> +#include "thread_map.h"
>  #include "pmu.h"
>  #include "vdso.h"
>  #include "strbuf.h"
> @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> 	if (!evsel->own_cpus)
> 		return 0;
>
> +	if (!evsel->id ||

for my test, evsel->id is NULL

> +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> +				 thread_map__nr(evsel->threads)))

and then this function is not called as we return immediately. So did 
you really want this:

if (!evsel->id && perf_evsel__alloc_id(...))
	return -ENOMEM;

This looks to work:

root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (7 samples) ]
root@localhost:~# ./perf_debug_ report
# To display the perf.data header info, please use 
--header/--header-only option
#
#
# Total Lost Samples: 0
#
# Samples: 7  of event 'armv8_pmuv3_0/br_mis_pred/'
# Event count (approx.): 8260
#
# Overhead  Command  Shared Object      Symbol
# ........  .......  .................  ......................
#
     78.28%  sleep    libc-2.23.so       [.] 0x00000000000faef0
     20.53%  sleep    [kernel.kallsyms]  [k] vmacache_find
      1.09%  sleep    [kernel.kallsyms]  [k] find_vma
      0.10%  perf_de  [kernel.kallsyms]  [k] perf_event_exec


#
# (Cannot load tips.txt file, please install perf!)
#
root@localhost:~#


> +		return -ENOMEM;
> +
> 	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
> 	if (!ev)
> 		return -ENOMEM;
>
> .
>


Thanks,
John

