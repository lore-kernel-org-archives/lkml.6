Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE64720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE64720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIEWKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:10:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:37774 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:10:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 10:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="78228466"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2018 10:37:37 -0700
Received: from [10.252.23.215] (unknown [10.252.23.215])
        by linux.intel.com (Postfix) with ESMTP id EEA9E5801AB;
        Wed,  5 Sep 2018 10:37:34 -0700 (PDT)
Subject: Re: [PATCH v7 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <20180905112851.GA29759@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <34e2f944-f5f3-094a-5997-899cea92d206@linux.intel.com>
Date:   Wed, 5 Sep 2018 20:37:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905112851.GA29759@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.09.2018 14:28, Jiri Olsa wrote:
> On Wed, Sep 05, 2018 at 10:16:42AM +0300, Alexey Budankov wrote:
>>
>> Currently in record mode the tool implements trace writing serially. 
>> The algorithm loops over mapped per-cpu data buffers and stores 
>> ready data chunks into a trace file using write() system call.
>>
>> At some circumstances the kernel may lack free space in a buffer 
>> because the other buffer's half is not yet written to disk due to 
>> some other buffer's data writing by the tool at the moment.
>>
>> Thus serial trace writing implementation may cause the kernel 
>> to loose profiling data and that is what observed when profiling 
>> highly parallel CPU bound workloads on machines with big number 
>> of cores.
>>
>> Experiment with profiling matrix multiplication code executing 128 
>> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
>> demonstrates data loss metrics value of 98%:
>>
>> /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
>>     --call-graph dwarf,1024 --user-regs=IP,SP,BP \
>>     --switch-events -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
>>     matrix.gcc
>>
>> Data loss metrics is the ratio lost_time/elapsed_time where 
>> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
>> records and elapsed_time is the elapsed application run time 
>> under profiling.
>>
>> Applying asynchronous trace streaming thru Posix AIO API
>> (http://man7.org/linux/man-pages/man7/aio.7.html) 
>> lowers data loss metrics value providing 2x improvement -
>> lowering 98% loss to almost 0%.
>>
>> ---
>>  Alexey Budankov (2):
>>         perf util: map data buffer for preserving collected data
>> 	perf record: enable asynchronous trace writing
>>  
>>  tools/perf/builtin-record.c | 197 +++++++++++++++++++++++++++++++++++++++++++-
>>  tools/perf/perf.h           |   1 +
>>  tools/perf/util/evlist.c    |   7 +-
>>  tools/perf/util/evlist.h    |   3 +-
>>  tools/perf/util/mmap.c      | 110 +++++++++++++++++++++----
>>  tools/perf/util/mmap.h      |  10 ++-
>>  6 files changed, 302 insertions(+), 26 deletions(-)
>>
>> ---
>>  Changes in v7:
>>  - implemented handling record.aio setting from perfconfig file
> 
> can't apply this version on Arnaldo's perf/core...

my git remote -v

origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (fetch)
origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (push)

branch is perf/core, according to MAINTAINERS content.

What is Arnaldo's perf/core? This one?

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux

and branch is perf/core?

> 
> [jolsa@krava linux-perf]$ git am /tmp/ab/
> Applying: perf util: map data buffer for preserving collected data
> error: patch failed: tools/perf/util/mmap.c:166
> error: tools/perf/util/mmap.c: patch does not apply
> 
> thanks,
> jirka
> 
