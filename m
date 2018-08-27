Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B87FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFBC208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFBC208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeH0Mow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:44:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeH0Mov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:44:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 01:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="257517465"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2018 01:59:00 -0700
Received: from [10.125.252.155] (abudanko-mobl.ccr.corp.intel.com [10.125.252.155])
        by linux.intel.com (Postfix) with ESMTP id 13B755803DA;
        Mon, 27 Aug 2018 01:58:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/2]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
 <20180827082819.GC24695@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e4a206a2-882b-c37f-e68d-80e7ed39596a@linux.intel.com>
Date:   Mon, 27 Aug 2018 11:58:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827082819.GC24695@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 27.08.2018 11:28, Jiri Olsa wrote:
> On Thu, Aug 23, 2018 at 07:42:09PM +0300, Alexey Budankov wrote:
>>
>> The data buffer and accompanying AIO control block are allocated at 
>> perf_mmap object and the mapped data buffer size is equal to 
>> the kernel one.
>>
>> The buffer is then used to preserve profiling data ready for dumping 
>> and queue it for asynchronous writing into perf trace thru implemented 
>> record__aio_write() function.
>>
>> mmap_aio control structure of the size equal to the number of per-cpu 
>> kernel buffers is used to keep pointers to enqueued AIO control 
>> blocks for monitoring of completed AIO operations.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v2:
>> - converted zalloc() to calloc() for allocation of mmap_aio array,
>> - cleared typo and adjusted fallback branch code;
>> ---
>> tools/perf/builtin-record.c | 18 ++++++++++++++++++
>>  tools/perf/util/evlist.c    |  7 +++++++
>>  tools/perf/util/evlist.h    |  2 ++
>>  tools/perf/util/mmap.c      | 12 ++++++++++++
>>  tools/perf/util/mmap.h      |  3 +++
>>  5 files changed, 42 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 22ebeb92ac51..a35675e9f3aa 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -53,6 +53,7 @@
>>  #include <sys/mman.h>
>>  #include <sys/wait.h>
>>  #include <linux/time64.h>
>> +#include <aio.h>
>>  
>>  struct switch_output {
>>  	bool		 enabled;
>> @@ -121,6 +122,23 @@ static int record__write(struct record *rec, void *bf, size_t size)
>>  	return 0;
>>  }
>>  
>> +static int record__aio_write(int trace_fd, struct aiocb *cblock,
>> +		void *buf, size_t size, off_t off)
>> +{
> 
> this breaks bisection:
> 
> builtin-record.c:125:12: error: ‘record__aio_write’ defined but not used [-Werror=unused-function]
>  static int record__aio_write(int trace_fd, struct aiocb *cblock,

Moving it to [PATCH v3 2/2]. Thanks!

> 
> jirka
> 
