Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC4C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19F221470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19F221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeJKX7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:59:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:45737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeJKX7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:59:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="240536414"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2018 09:31:19 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id ABD0A580496;
        Thu, 11 Oct 2018 09:31:16 -0700 (PDT)
Subject: Re: [PATCH v12 2/3]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
 <20181011141543.GF29634@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4d64961d-d3fd-3000-34d9-60be3c4627bf@linux.intel.com>
Date:   Thu, 11 Oct 2018 19:31:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011141543.GF29634@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.10.2018 17:15, Jiri Olsa wrote:
> On Tue, Oct 09, 2018 at 11:58:53AM +0300, Alexey Budankov wrote:
>>
>> Trace file offset is read once before mmaps iterating loop and written
>> back after all performance data enqueued for aio writing. Trace file offset 
>> is incremented linearly after every successful aio write operation. 
>>
>> record__aio_sync() blocks till completion of started AIO operation 
>> and then proceeds.
>>
>> record__mmap_read_sync() implements a barrier for all incomplete
>> aio write requests.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  Changes in v12:
>>  - implemented record__aio_get/set_pos(), record__aio_enabled()
>>  - implemented simple --aio option
>>  Changes in v11:
>>  - replacing the both lseek() syscalls in every loop iteration by the only 
>>    two syscalls just before and after the loop at record__mmap_read_evlist() 
>>    and advancing *in-flight* off file pos value at perf_mmap__aio_push()
>>  Changes in v10:
>>  - avoided lseek() setting file pos back in case of record__aio_write() failure
>>  - compacted code selecting between serial and AIO streaming
>>  - optimized call places of record__mmap_read_sync()
>>  Changes in v9:
>>  - enable AIO streaming only when --aio-cblocks option is specified explicitly
>>  Changes in v8:
>>  - split AIO completion check into separate record__aio_complete()
>>  Changes in v6:
>>  - handled errno == EAGAIN case from aio_write();
>>  Changes in v5:
>>  - data loss metrics decreased from 25% to 2x in trialed configuration;
>>  - avoided nanosleep() prior calling aio_suspend();
>>  - switched to per cpu multi record__aio_sync() aio
>>  - record_mmap_read_sync() now does global barrier just before 
>>    switching trace file or collection stop;
>>  - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
>>  Changes in v4:
>>  - converted void *bf to struct perf_mmap *md in signatures
>>  - written comment in perf_mmap__push() just before perf_mmap__get();
>>  - written comment in record__mmap_read_sync() on possible restarting 
>>    of aio_write() operation and releasing perf_mmap object after all;
>>  - added perf_mmap__put() for the cases of failed aio_write();
>>  Changes in v3:
>>  - written comments about nanosleep(0.5ms) call prior aio_suspend()
>>    to cope with intrusiveness of its implementation in glibc;
>>  - written comments about rationale behind coping profiling data 
>>    into mmap->data buffer;
>> ---
>>  tools/perf/Documentation/perf-record.txt |   5 +
>>  tools/perf/builtin-record.c              | 220 ++++++++++++++++++++++++++++++-
>>  tools/perf/perf.h                        |   1 +
>>  tools/perf/util/evlist.c                 |   6 +-
>>  tools/perf/util/evlist.h                 |   2 +-
>>  tools/perf/util/mmap.c                   |  86 +++++++++++-
>>  tools/perf/util/mmap.h                   |   5 +
>>  7 files changed, 316 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 246dee081efd..5cedb3e75434 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -435,6 +435,11 @@ Specify vmlinux path which has debuginfo.
>>  --buildid-all::
>>  Record build-id of all DSOs regardless whether it's actually hit or not.
>>  
>> +--aio::
>> +Enable asynchronous (Posix AIO) trace writing mode. 
> 
> nit, there's an extra whitespace at the end of above line,
> making the 'git am' to not apply your patch

Corrected trailing whitespace. Thanks!

- Alexey

> 
> thanks,
> jirka
> 
