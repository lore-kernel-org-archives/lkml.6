Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD4C21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD4C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJDQNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:13:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49485 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbeJDQNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:13:16 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A48092CE3EFC;
        Thu,  4 Oct 2018 17:20:52 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Thu, 4 Oct 2018
 17:20:46 +0800
Subject: Re: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
To:     Jiri Olsa <jolsa@redhat.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava> <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava> <20181003212052.GA32371@krava>
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
Message-ID: <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
Date:   Thu, 4 Oct 2018 10:20:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181003212052.GA32371@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hi Jirka,
>>>
>>> Can you please double-check your new patch, as I'm getting this now:
>>> root@localhost:~# ./perf_debug record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
>>> root@localhost:~# ./perf_debug report
>>> 0xe8 [0]: failed to process type: 461
>>> Error:
>>> failed to process sample
>>> # To display the perf.data header info, please use --header/--header-only
>>> option
>>> #
>>> root@localhost:~#
>>
>> ok, I need to get a machine to test this.. but it looks like
>> any sample-able events with cpumask are in arm :-\ will try
>> to get some..
>
> got an arm server and patch below works for me.. could you please test?
>

Cool, so this works ok:
root@localhost:~# ./perf_debug record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (6 samples) ]
root@localhost:~# ./perf_debug report
# To display the perf.data header info, please use 
--header/--header-only option
#
#
# Total Lost Samples: 0
#
# Samples: 6  of event 'armv8_pmuv3_0/br_mis_pred/'
# Event count (approx.): 3369
#
# Overhead  Command  Shared Object      Symbol
# ........  .......  .................  ...................
#
     94.81%  sleep    [kernel.kallsyms]  [k] memcmp
      4.87%  sleep    [kernel.kallsyms]  [k] tlb_flush_mmu
      0.33%  perf_de  [kernel.kallsyms]  [k] perf_event_exec


#
# (Cannot load tips.txt file, please install perf!)
#
root@localhost:~#


> thanks,
> jirka
>
>
> ---
>
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
> id array, which is not defined at that time. Fixing this by
> forcing the id allocation for events with theeir own cpus.
>
> Reported-by: John Garry <john.garry@huawei.com>
> Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6@git.kernel.org

Tested-by: John Garry <john.garry@huawei.com>

In terms of adding to stable, LT v4.14 is not affected, but 4.18.x is.

Thanks,
John

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-report.c | 1 +
>  tools/perf/util/evsel.c     | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index c0703979c51d..257c9c18cb7e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -980,6 +980,7 @@ int cmd_report(int argc, const char **argv)
>  			.id_index	 = perf_event__process_id_index,
>  			.auxtrace_info	 = perf_event__process_auxtrace_info,
>  			.auxtrace	 = perf_event__process_auxtrace,
> +			.event_update	 = perf_event__process_event_update,
>  			.feature	 = process_feature_event,
>  			.ordered_events	 = true,
>  			.ordering_requires_timestamps = true,
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ac6cfb8b085e..7a0d5fbaf3c1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1088,6 +1088,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
>  		attr->exclude_user   = 1;
>  	}
>
> +	if (evsel->own_cpus)
> +		evsel->attr.read_format |= PERF_FORMAT_ID;
> +
>  	/*
>  	 * Apply event specific term settings,
>  	 * it overloads any global configuration.
>


