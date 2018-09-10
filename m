Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53433C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1390120645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1390120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeIJTnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:43:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:48758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbeIJTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:43:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 07:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="87502120"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 10 Sep 2018 07:48:49 -0700
Received: from [10.252.24.10] (abudanko-mobl.ccr.corp.intel.com [10.252.24.10])
        by linux.intel.com (Postfix) with ESMTP id 77D295803DA;
        Mon, 10 Sep 2018 07:48:47 -0700 (PDT)
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
 <20180910120643.GA4217@gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1ad36918-ddd0-aa3c-c52e-e4e419409dd4@linux.intel.com>
Date:   Mon, 10 Sep 2018 17:48:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910120643.GA4217@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 10.09.2018 15:06, Ingo Molnar wrote:
> 
> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>> Hi Ingo,
>>
>> On 10.09.2018 12:18, Ingo Molnar wrote:
>>>
>>> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
>>>
>>>>
>>>> Currently in record mode the tool implements trace writing serially. 
>>>> The algorithm loops over mapped per-cpu data buffers and stores 
>>>> ready data chunks into a trace file using write() system call.
>>>>
>>>> At some circumstances the kernel may lack free space in a buffer 
>>>> because the other buffer's half is not yet written to disk due to 
>>>> some other buffer's data writing by the tool at the moment.
>>>>
>>>> Thus serial trace writing implementation may cause the kernel 
>>>> to loose profiling data and that is what observed when profiling 
>>>> highly parallel CPU bound workloads on machines with big number 
>>>> of cores.
>>>
>>> Yay! I saw this frequently on a 120-CPU box (hw is broken now).
>>>
>>>> Data loss metrics is the ratio lost_time/elapsed_time where 
>>>> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
>>>> records and elapsed_time is the elapsed application run time 
>>>> under profiling.
>>>>
>>>> Applying asynchronous trace streaming thru Posix AIO API
>>>> (http://man7.org/linux/man-pages/man7/aio.7.html) 
>>>> lowers data loss metrics value providing 2x improvement -
>>>> lowering 98% loss to almost 0%.
>>>
>>> Hm, instead of AIO why don't we use explicit threads instead? I think Posix AIO will fall back 
>>> to threads anyway when there's no kernel AIO support (which there probably isn't for perf 
>>> events).
>>
>> Explicit threading is surely an option but having more threads 
>> in the tool that stream performance data is a considerable 
>> design complication.
>>
>> Luckily, glibc AIO implementation is already based on pthreads, 
>> but having a writing thread for every distinct fd only.
> 
> My argument is, we don't want to rely on glibc's choices here. They might
> use a different threading design in the future, or it might differ between
> libc versions.> 
> The basic flow of tracing/profiling data is something we should control explicitly,
> via explicit threading.

It may sound too optimistic but glibc API is expected to be backward compatible 
and for POSIX AIO API part too. Internal implementation also tends to evolve to 
better option overtime, more probably basing on modern kernel capabilities 
mentioned here: http://man7.org/linux/man-pages/man2/io_submit.2.html

Well, explicit threading in the tool for AIO, in the simplest case, means 
incorporating some POSIX API implementation into the tool, avoiding 
code reuse in the first place. That tends to be error prone and costly.

Regards,
Alexey

> 
> BTW., the usecase I was primarily concentrating on was a simpler one: 'perf record -a', not 
> inherited workflow tracing. For system-wide profiling the ideal tracing setup is clean per-CPU 
> separation, i.e. per CPU event fds, per CPU threads that read and then write into separate 
> per-CPU files.
> 
> Thanks,
> 
> 	Ingo
> 
