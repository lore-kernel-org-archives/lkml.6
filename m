Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18811C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64B42083C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64B42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeH1SJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:09:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:20693 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeH1SJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:09:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 07:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="65801918"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2018 07:17:44 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 02EC35802AD;
        Tue, 28 Aug 2018 07:17:42 -0700 (PDT)
Subject: Re: [PATCH v3 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <20180828085904.GH23727@krava>
 <d250a62d-8dcc-4309-3c7d-38f6d9900da4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b7451edc-8261-a75d-226c-c8d419c5a8b4@linux.intel.com>
Date:   Tue, 28 Aug 2018 17:17:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d250a62d-8dcc-4309-3c7d-38f6d9900da4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.2018 14:58, Alexey Budankov wrote:
> Hi Andi,
> 
> On 28.08.2018 11:59, Jiri Olsa wrote:
>> On Mon, Aug 27, 2018 at 08:03:21PM +0300, Alexey Budankov wrote:
>>>
>>> Currently in record mode the tool implements trace writing serially. 
>>> The algorithm loops over mapped per-cpu data buffers and stores ready 
>>> data chunks into a trace file using write() system call.
>>>
>>> At some circumstances the kernel may lack free space in a buffer 
>>> because the other buffer's half is not yet written to disk due to 
>>> some other buffer's data writing by the tool at the moment.
>>>
>>> Thus serial trace writing implementation may cause the kernel 
>>> to loose profiling data and that is what observed when profiling 
>>> highly parallel CPU bound workloads on machines with big number 
>>> of cores.
>>>
>>> Experiment with profiling matrix multiplication code executing 128 
>>> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
>>> demonstrates data loss metrics value of 98%:
>>>
>>> /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
>>>     --call-graph dwarf,1024 --user-regs=IP,SP,BP \
>>>     --switch-events -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
>>>     matrix.gcc
>>>
>>> Data loss metrics is the ratio lost_time/elapsed_time where 
>>> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
>>> records and elapsed_time is the elapsed application run time 
>>> under profiling.
>>
>> I like the idea and I think it's good direction to go, but could
>> you please share some from perf stat or whatever you used to meassure
>> the new performance?
> 
> Is it ok to share VTune GUI screenshots I sent you the last time 
> to demonstrate the advantage of AIO trace streaming?

VTune release manager permitted to share it, well, sorry for bothering.

> 
> Thanks,
> Alexey
> 
> 
>>
>> thanks,
>> jirka
>>
> 
