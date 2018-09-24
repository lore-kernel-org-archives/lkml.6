Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC30DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8887C2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8887C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeIYBP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:15:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:50804 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbeIYBP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:15:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 12:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="91520468"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2018 12:12:20 -0700
Received: from [10.252.24.57] (abudanko-mobl.ccr.corp.intel.com [10.252.24.57])
        by linux.intel.com (Postfix) with ESMTP id 36461580117;
        Mon, 24 Sep 2018 12:12:16 -0700 (PDT)
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava> <20180914082858.GH24224@krava>
 <71153c79-f0b9-4bf7-7491-202f46c6b5ed@linux.intel.com>
 <4f63c3d5-2a33-28ed-4e45-086045e9ab50@linux.intel.com>
 <20180923193001.GD30923@krava>
 <15042139-23ee-3bb7-4307-276e505a4607@linux.intel.com>
 <c37d1c7d-9f98-4aed-e621-6b3b76d3d3d9@linux.intel.com>
 <20180924142927.GA22809@krava>
 <5ac85264-50a5-8e70-0c12-7cb0da433a42@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3227b88a-5607-596c-3ade-74e0b21988e6@linux.intel.com>
Date:   Mon, 24 Sep 2018 22:12:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ac85264-50a5-8e70-0c12-7cb0da433a42@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24.09.2018 21:32, Alexey Budankov wrote:
> Hi,
> 
> On 24.09.2018 17:29, Jiri Olsa wrote:
>> On Mon, Sep 24, 2018 at 04:09:09PM +0300, Alexey Budankov wrote:
>>> Hi,
>>>
>>> On 24.09.2018 10:02, Alexey Budankov wrote:
>>>> Hi,
>>>>
>>>> On 23.09.2018 22:30, Jiri Olsa wrote:
>>>>> On Fri, Sep 21, 2018 at 09:13:08AM +0300, Alexey Budankov wrote:
>>>>>
>>>>> SNIP
>>>>>
>>>>>> Events:
>>>>>> cpu/period=P,event=0x3c/Duk;CPU_CLK_UNHALTED.THREAD
>>>>>> cpu/period=P,umask=0x3/Duk;CPU_CLK_UNHALTED.REF_TSC
>>>>>> cpu/period=P,event=0xc0/Duk;INST_RETIRED.ANY
>>>>>> cpu/period=0xaae61,event=0xc2,umask=0x10/uk;UOPS_RETIRED.ALL
>>>>>> cpu/period=0x11171,event=0xc2,umask=0x20/uk;UOPS_RETIRED.SCALAR_SIMD
>>>>>> cpu/period=0x11171,event=0xc2,umask=0x40/uk;UOPS_RETIRED.PACKED_SIMD
>>>>>>
>>>>>> =================================================
>>>>>>
>>>>>> Command:
>>>>>> /usr/bin/time /tmp/vtune_amplifier_2019.574715/bin64/perf.thr record --threads=T \
>>>>>> 	-a -N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
>>>>>>         -e cpu/period=P,event=0x3c/Duk,\
>>>>>>            cpu/period=P,umask=0x3/Duk,\
>>>>>>            cpu/period=P,event=0xc0/Duk,\
>>>>>>            cpu/period=0x30d40,event=0xc2,umask=0x10/uk,\
>>>>>>            cpu/period=0x4e20,event=0xc2,umask=0x20/uk,\
>>>>>>            cpu/period=0x4e20,event=0xc2,umask=0x40/uk \
>>>>>>          --clockid=monotonic_raw -- ./matrix.(icc|gcc)
>>>>>
>>>>> hum, so I guess the results suck because of the -a option,
>>>>> getting extra samples for all the perf record threads
>>>>>
>>>>> could you try without the -a? you monitor only user events,
>>>>> so you're interested only in ./matrix.* samples, right?
>>>>
>>>> Ok, trying without -a, in per-process mode. 
>>>
>>> Command:
>>>
>>> /usr/bin/time ./perf.thr record --threads=T \
>>> 	-N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
>>> 	-e cpu/period=P,event=0x3c/Duk,\
>>> 	   cpu/period=P,umask=0x3/Duk,\
>>> 	   cpu/period=P,event=0xc0/Duk,\
>>> 	   cpu/period=0xaae61,event=0xc2,umask=0x10/uk,\
>>> 	   cpu/period=0x11171,event=0xc2,umask=0x20/uk,\
>>> 	   cpu/period=0x11171,event=0xc2,umask=0x40/uk \
>>> 	--clockid=monotonic_raw -- ./matrix.gcc
>>>
>>> Workload: matrix multiplication in 128 threads
>>>
>>> T : 272
>>> 	P (period, ms)       : 0.35 
>>> 	runtime overhead (%) : 13x ~ 87.73 / 6.81
>>
>> how do you meassure this?
> 
> This is the ratio of elapsed times:
> runtime overhead (%) : elapsed_time_under_profiling / elapsed_time
> i.e.
> 
> /usr/bin/time ./matrix.gcc
> ...
> 767.03user 11.17system 0:06.81elapsed 11424%CPU (0avgtext+0avgdata 100756maxresident)k
> 88inputs+0outputs (0major+139898minor)pagefaults 0swaps
> 
> so elapsed_time = 6.81 sec
> 
> elapsed_time_uder_profiling is elapsed value from output of 
> 
> /usr/bin/time ./perf.thr record --threads=T ...
> 
>>
>>> 	data loss (%)        : 0
>>> 	LOST events          : 36
>>> 	SAMPLE events        : 8048542
>>>         perf.data size (GiB) : 10
>>
>> any idea why does it have some much more samples?
> 
> Presumably, this is because period is 350us and this is the smallest 
> one that perf.thr manages to capture data without data loss (=0) when T=272.
> However, during collection, I get message that max sampling frequency 
> is lowered to 3KHz.

Lowering default frequency rate to 3000.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.

Thanks,
Alexey

> 
> Thanks,
> Alexey
> 
>>
>> thanks,
>> jirka
>>
> 
