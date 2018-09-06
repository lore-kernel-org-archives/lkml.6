Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594C520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIFQ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:26:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeIFQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:26:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 04:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="89472342"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 04:50:59 -0700
Received: from [10.125.252.28] (abudanko-mobl.ccr.corp.intel.com [10.125.252.28])
        by linux.intel.com (Postfix) with ESMTP id 0A9645803D7;
        Thu,  6 Sep 2018 04:50:57 -0700 (PDT)
Subject: Re: [PATCH v7 1/2]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <cf6cd6ca-12dd-9ee8-8e18-ee02f289c45e@linux.intel.com>
 <20180906110407.GE8248@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <50fea767-6424-44b5-0e68-f12a2d2c96cc@linux.intel.com>
Date:   Thu, 6 Sep 2018 14:50:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906110407.GE8248@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.09.2018 14:04, Jiri Olsa wrote:
> On Wed, Sep 05, 2018 at 10:19:56AM +0300, Alexey Budankov wrote:
>>
>> The map->data buffers are used to preserve map->base profiling data 
>> for writing to disk. AIO map->cblocks are used to queue corresponding 
>> map->data buffers for asynchronous writing. map->cblocks objects are 
>> located in the last page of every map->data buffer.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  Changes in v7:
>>   - implemented handling record.aio setting from perfconfig file
>>  Changes in v6:
>>   - adjusted setting of priorities for cblocks;
>>  Changes in v5:
>>   - reshaped layout of data structures;
>>   - implemented --aio option;
>>  Changes in v4:
>>   - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management 
>>  Changes in v2:
>>   - converted zalloc() to calloc() for allocation of mmap_aio array,
>>   - cleared typo and adjusted fallback branch code;
>> ---
>>  tools/perf/builtin-record.c | 15 ++++++++++++-
>>  tools/perf/perf.h           |  1 +
>>  tools/perf/util/evlist.c    |  7 +++---
>>  tools/perf/util/evlist.h    |  3 ++-
>>  tools/perf/util/mmap.c      | 53 +++++++++++++++++++++++++++++++++++++++++++++
>>  tools/perf/util/mmap.h      |  6 ++++-
>>  6 files changed, 79 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 22ebeb92ac51..f17a6f9cb1ba 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -326,7 +326,8 @@ static int record__mmap_evlist(struct record *rec,
>>  
>>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>>  				 opts->auxtrace_mmap_pages,
>> -				 opts->auxtrace_snapshot_mode) < 0) {
>> +				 opts->auxtrace_snapshot_mode,
>> +				 opts->nr_cblocks) < 0) {
>>  		if (errno == EPERM) {
>>  			pr_err("Permission error mapping pages.\n"
>>  			       "Consider increasing "
>> @@ -1287,6 +1288,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>>  		var = "call-graph.record-mode";
>>  		return perf_default_config(var, value, cb);
>>  	}
>> +	if (!strcmp(var, "record.aio"))
>> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
>>  
>>  	return 0;
>>  }
>> @@ -1519,6 +1522,7 @@ static struct record record = {
>>  			.default_per_cpu = true,
>>  		},
>>  		.proc_map_timeout     = 500,
>> +		.nr_cblocks	      = 2
>>  	},
>>  	.tool = {
>>  		.sample		= process_sample_event,
>> @@ -1678,6 +1682,8 @@ static struct option __record_options[] = {
>>  			  "signal"),
>>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>>  		    "Parse options then exit"),
>> +	OPT_INTEGER(0, "aio", &record.opts.nr_cblocks,
>> +		    "asynchronous trace write operations (min: 1, max: 32, default: 2)"),
> 
> ok, so this got silently added in recent versions and I couldn't
> find any justification for it.. why do we use more aio blocks for
> single map now? also why the default is 2?

Having more blocks may improve thruput from kernel to userspace for 
cases when we get more data at map->base but the started AIO is not 
finished yet. That can easily happen between calls of 
record__mmap_read_evlist().

> 
> the option should be more specific like 'aio-blocks'

ok.

> 
> the change is difficult enough.. we should start simple and add
> these additions with proper justification in separate patches

Setting default to 1 gives the simplest solution. I could provide 
justification where spinning at record__aio_sync() becomes the hotspot.

> 
> thanks,
> jirka
> 
