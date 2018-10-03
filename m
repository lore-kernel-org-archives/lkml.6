Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195412082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195412082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJCU5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:57:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbeJCU5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:57:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 000B1C08D1602;
        Wed,  3 Oct 2018 22:08:23 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 3 Oct 2018
 22:08:18 +0800
Subject: Re: [PATCH] perf tools: Allocate id array in
 perf_event__synthesize_event_update_cpus
To:     Jiri Olsa <jolsa@redhat.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava> <20181003113643.GA31725@krava>
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
Message-ID: <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
Date:   Wed, 3 Oct 2018 15:08:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181003113643.GA31725@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 12:36, Jiri Olsa wrote:
> On Tue, Oct 02, 2018 at 01:16:21PM +0200, Jiri Olsa wrote:
>> On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:
>>
>> SNIP
>>
>>>>
>>>>
>>>> ---
>>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>>> index 1ec1d9bc2d63..fb2a0dab3978 100644
>>>> --- a/tools/perf/util/header.c
>>>> +++ b/tools/perf/util/header.c
>>>> @@ -29,6 +29,7 @@
>>>>  #include "symbol.h"
>>>>  #include "debug.h"
>>>>  #include "cpumap.h"
>>>> +#include "thread_map.h"
>>>>  #include "pmu.h"
>>>>  #include "vdso.h"
>>>>  #include "strbuf.h"
>>>> @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
>>>> 	if (!evsel->own_cpus)
>>>> 		return 0;
>>>>
>>>> +	if (!evsel->id ||
>>>
>>> for my test, evsel->id is NULL
>>>
>>>> +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
>>>> +				 thread_map__nr(evsel->threads)))
>>>
>>> and then this function is not called as we return immediately. So did you
>>> really want this:
>>>
>>> if (!evsel->id && perf_evsel__alloc_id(...))
>>> 	return -ENOMEM;
>>
>> ugh.. yes ;-) thanks for the fix.. I'll double
>> check the logic and post the patch this week
>
> actualy, we also need to populate those ids ;-)
> so calling perf_evsel__store_ids instead..
> attaching the full patch
>
> thanks,
> jirka
>

Hi Jirka,

Can you please double-check your new patch, as I'm getting this now:
root@localhost:~# ./perf_debug record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
root@localhost:~# ./perf_debug report
0xe8 [0]: failed to process type: 461
Error:
failed to process sample
# To display the perf.data header info, please use 
--header/--header-only option
#
root@localhost:~#

Thanks,
John

>
> ---
> John reported crash when recording on an event under
> pmu with cpumask defined:
>
>   root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
>   perf: Segmentation fault
>   Obtained 9 stack frames.
>   ./perf_debug_() [0x4c5ef8]
>   [0xffff82ba267c]
>   ./perf_debug_() [0x4bc5a8]
>   ./perf_debug_() [0x419550]
>   ./perf_debug_() [0x41a928]
>   ./perf_debug_() [0x472f58]
>   ./perf_debug_() [0x473210]
>   ./perf_debug_() [0x4070f4]
>   /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
>   Segmentation fault (core dumped)
>
> We synthesize an update event that needs to touch the evsel
> id array, which is not defined at that time. Fixing this
> by allocating the array and getting IDs before it's used.
>
> Reported-by: John Garry <john.garry@huawei.com>
> Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/header.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 1ec1d9bc2d63..14ca27f79d4a 100644
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
> @@ -3579,6 +3580,9 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
>  	if (!evsel->own_cpus)
>  		return 0;
>
> +	if (!evsel->id && perf_evsel__store_ids(evsel, evsel->evlist))
> +		return -ENOMEM;
> +
>  	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
>  	if (!ev)
>  		return -ENOMEM;
>


