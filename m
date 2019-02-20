Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88169C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A4D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfBTONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:13:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:47568 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTONI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:13:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="117664371"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2019 06:13:07 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 53C5858028E;
        Wed, 20 Feb 2019 06:13:05 -0800 (PST)
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
 <20190212130811.GA775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <00529125-4d10-1294-e984-e365e6020bac@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:13:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130811.GA775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:08, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  static int process_synthesized_event(struct perf_tool *tool,
>>  				     union perf_event *event,
>>  				     struct perf_sample *sample __maybe_unused,

<SNIP>

>>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>> +		u64 flush = MMAP_FLUSH_DEFAULT;
>>  		struct perf_mmap *map = &maps[i];
>>  
>>  		if (map->base) {
>>  			record__adjust_affinity(rec, map);
>> +			if (sync) {
>> +				flush = map->flush;
>> +				map->flush = MMAP_FLUSH_DEFAULT;
>> +			}
>>  			if (!record__aio_enabled(rec)) {
>>  				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> +					if (sync)
>> +						map->flush = flush;
>>  					rc = -1;
>>  					goto out;
>>  				}
>> @@ -775,10 +814,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  				idx = record__aio_sync(map, false);
>>  				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>>  					record__aio_set_pos(trace_fd, off);
>> +					if (sync)
>> +						map->flush = flush;
>>  					rc = -1;
>>  					goto out;
>>  				}
>>  			}
>> +			if (sync)
>> +				map->flush = flush;
>>  		}
> 
> what's 'flush' and 'sync' for? also the above handling seems confusing,
> why would you set it temporarily for default value if you let it set
> by user command line option?

flush is the threshold postponing and triggering the move of data to a 
trace file from the memory buffers. sync is the mean to force that move 
independently from the threshold value.

Despite a user provides flush value from the command line, the tool has 
to drain memory buffers, at least in the end of the collection, so that 
it is technically implemented like this.

> 
> SNIP
> 
>> -static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
>>  

<SNIP>

>> @@ -492,7 +518,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
>>  	md->start = md->overwrite ? head : old;
>>  	md->end = md->overwrite ? old : head;
>>  
>> -	if (md->start == md->end)
>> +	if ((md->end - md->start) < md->flush)
>>  		return -EAGAIN;
> 
> we need document and explain this change in changelog in separate patch

Moved --mmap-flush option implementation into a separate patch.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
