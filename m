Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8124CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B577208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B577208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeH1Nab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:30:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:55063 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbeH1Nab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 02:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="252512584"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2018 02:39:35 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 071195803DA;
        Tue, 28 Aug 2018 02:39:33 -0700 (PDT)
Subject: Re: [PATCH v3 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
 <20180828085022.GE23727@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e75ae90b-2ea6-0047-2045-31609c17db47@linux.intel.com>
Date:   Tue, 28 Aug 2018 12:39:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828085022.GE23727@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.2018 11:50, Jiri Olsa wrote:
> On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:
>>
>> Trace file offset are linearly calculated by perf_mmap__push() code 
>> for the next possible write operation, but file position is updated by 
>> the kernel only in the second lseek() syscall after the loop. 
>> The first lseek() syscall reads that file position for 
>> the next loop iterations.
>>
>> record__mmap_read_sync implements sort of a barrier between spilling 
>> ready profiling data to disk.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v3:
>> - written comments about nanosleep(0.5ms) call prior aio_suspend()
>>   to cope with intrusiveness of its implementation in glibc;
>> - written comments about rationale behind coping profiling data 
>>   into mmap->data buffer;
>> ---
>>  tools/perf/builtin-record.c | 125 +++++++++++++++++++++++++++++++++++++++++---
>>  tools/perf/util/mmap.c      |  36 ++++++++-----
>>  tools/perf/util/mmap.h      |   2 +-
>>  3 files changed, 143 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 22ebeb92ac51..4ac61399a09a 100644
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
>> +	cblock->aio_fildes = trace_fd;
>> +	cblock->aio_buf    = buf;
>> +	cblock->aio_nbytes = size;
>> +	cblock->aio_offset = off;
>> +	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
>> +
>> +	if (aio_write(cblock) == -1) {
>> +		pr_err("failed to queue perf data, error: %m\n");
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int process_synthesized_event(struct perf_tool *tool,
>>  				     union perf_event *event,
>>  				     struct perf_sample *sample __maybe_unused,
>> @@ -130,12 +148,14 @@ static int process_synthesized_event(struct perf_tool *tool,
>>  	return record__write(rec, event, event->header.size);
>>  }
>>  
>> -static int record__pushfn(void *to, void *bf, size_t size)
>> +static int record__pushfn(void *to, void *bf, size_t size, off_t off)
>>  {
>>  	struct record *rec = to;
>> +	struct perf_mmap *map = bf;
> 
> the argument needs to change for record__pushfn,
> now with your changes, it's no longer 'void *bf',
> but 'struct perf_mmap *map'

Ok. Included into [PATCH v4 2/2].

> 
> also I'm little confused why we have '*to' and cast
> it back to 'struct record', but so be it ;-)

Supported. :)

> 
> thanks,
> jirka
> 
