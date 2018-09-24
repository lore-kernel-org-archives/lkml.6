Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89495ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CD22148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CD22148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbeIXTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:11:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:5229 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIXTLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:11:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 06:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="75477804"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2018 06:09:13 -0700
Received: from [10.125.252.28] (abudanko-mobl.ccr.corp.intel.com [10.125.252.28])
        by linux.intel.com (Postfix) with ESMTP id A8B405801CD;
        Mon, 24 Sep 2018 06:09:11 -0700 (PDT)
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
Organization: Intel Corp.
Message-ID: <c37d1c7d-9f98-4aed-e621-6b3b76d3d3d9@linux.intel.com>
Date:   Mon, 24 Sep 2018 16:09:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15042139-23ee-3bb7-4307-276e505a4607@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24.09.2018 10:02, Alexey Budankov wrote:
> Hi,
> 
> On 23.09.2018 22:30, Jiri Olsa wrote:
>> On Fri, Sep 21, 2018 at 09:13:08AM +0300, Alexey Budankov wrote:
>>
>> SNIP
>>
>>> Events:
>>> cpu/period=P,event=0x3c/Duk;CPU_CLK_UNHALTED.THREAD
>>> cpu/period=P,umask=0x3/Duk;CPU_CLK_UNHALTED.REF_TSC
>>> cpu/period=P,event=0xc0/Duk;INST_RETIRED.ANY
>>> cpu/period=0xaae61,event=0xc2,umask=0x10/uk;UOPS_RETIRED.ALL
>>> cpu/period=0x11171,event=0xc2,umask=0x20/uk;UOPS_RETIRED.SCALAR_SIMD
>>> cpu/period=0x11171,event=0xc2,umask=0x40/uk;UOPS_RETIRED.PACKED_SIMD
>>>
>>> =================================================
>>>
>>> Command:
>>> /usr/bin/time /tmp/vtune_amplifier_2019.574715/bin64/perf.thr record --threads=T \
>>> 	-a -N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
>>>         -e cpu/period=P,event=0x3c/Duk,\
>>>            cpu/period=P,umask=0x3/Duk,\
>>>            cpu/period=P,event=0xc0/Duk,\
>>>            cpu/period=0x30d40,event=0xc2,umask=0x10/uk,\
>>>            cpu/period=0x4e20,event=0xc2,umask=0x20/uk,\
>>>            cpu/period=0x4e20,event=0xc2,umask=0x40/uk \
>>>          --clockid=monotonic_raw -- ./matrix.(icc|gcc)
>>
>> hum, so I guess the results suck because of the -a option,
>> getting extra samples for all the perf record threads
>>
>> could you try without the -a? you monitor only user events,
>> so you're interested only in ./matrix.* samples, right?
> 
> Ok, trying without -a, in per-process mode. 

Command:

/usr/bin/time ./perf.thr record --threads=T \
	-N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
	-e cpu/period=P,event=0x3c/Duk,\
	   cpu/period=P,umask=0x3/Duk,\
	   cpu/period=P,event=0xc0/Duk,\
	   cpu/period=0xaae61,event=0xc2,umask=0x10/uk,\
	   cpu/period=0x11171,event=0xc2,umask=0x20/uk,\
	   cpu/period=0x11171,event=0xc2,umask=0x40/uk \
	--clockid=monotonic_raw -- ./matrix.gcc

Workload: matrix multiplication in 128 threads

T : 272
	P (period, ms)       : 0.35 
	runtime overhead (%) : 13x ~ 87.73 / 6.81
	data loss (%)        : 0
	LOST events          : 36
	SAMPLE events        : 8048542
        perf.data size (GiB) : 10

T : 128
	P (period, ms)       : 0.35 
	runtime overhead (%) : 10x ~ 71.12 / 6.81
	data loss (%)        : 0
	LOST events          : 2
	SAMPLE events        : 6524363
        perf.data size (GiB) : 8

T : 64
	P (period, ms)       : 0.35 
	runtime overhead (%) : 10x ~ 71.89 / 6.81
	data loss (%)        : 0
	LOST events          : 2
	SAMPLE events        : 7160623
        perf.data size (GiB) : 9

=================================================

Command:

/usr/bin/time ./perf.aio record --aio=N \
	-N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
	-e cpu/period=P,event=0x3c/Duk,\
	   cpu/period=P,umask=0x3/Duk,\
           cpu/period=P,event=0xc0/Duk,\
           cpu/period=0xaae61,event=0xc2,umask=0x10/uk,\
           cpu/period=0x11171,event=0xc2,umask=0x20/uk,\
           cpu/period=0x11171,event=0xc2,umask=0x40/uk \
        --clockid=monotonic_raw ./matrix.gcc

Workload: matrix multiplication in 128 threads

N : 512
        P (period, ms)       : 1.5
 	runtime overhead (%) : 2.8x ~ 19.20 / 6.81
 	data loss (%)        : 0
 	LOST events          : 0
 	SAMPLE events        : 1094976
        perf.data size (GiB) : 1.3

N : 272
  	P (period, ms)       : 1.5
 	runtime overhead (%) : 3.3x ~ 22.34 / 6.81
 	data loss (%)        : 0
 	LOST events          : 0
 	SAMPLE events        : 1089252
        perf.data size (GiB) : 1.3
  
N : 128
 	P (period, ms)       : 1.5
 	runtime overhead (%) : 2.6x ~ 15.15 / 6.81
 	data loss (%)        : 1
 	LOST events          : 1
 	SAMPLE events        : 1094102
        perf.data size (GiB) : 1.3
 
N : 64
 	P (period, ms)       : 1.5
 	runtime overhead (%) : 2.4x ~ 16.23 / 6.81
 	data loss (%)        : 2
 	LOST events          : 18
 	SAMPLE events        : 1105986
        perf.data size (GiB) : 1.3

Thanks,
Alexey

> VTune collects as user as kernel mode samples, using /uk modifiers set.
> The set can be extended to collect in VM host and guests as well.
> 
> Thanks,
> Alexey
> 
>>
>> thanks,
>> jirka
>>
> 
