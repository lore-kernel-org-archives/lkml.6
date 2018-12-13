Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC98520873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC98520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeLMG0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:26:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:30189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeLMG0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:26:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 22:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="127487097"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2018 22:26:16 -0800
Received: from [10.125.251.221] (abudanko-mobl.ccr.corp.intel.com [10.125.251.221])
        by linux.intel.com (Postfix) with ESMTP id 8681558079C;
        Wed, 12 Dec 2018 22:26:14 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 1/3] perf record: allocate affinity masks
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <afb88628-7a04-3c36-2bc9-b5f5774f8e8f@linux.intel.com>
 <20181212121524.GC25240@krava>
Organization: Intel Corp.
Message-ID: <96c375bb-764e-56f7-bd89-edeabb720b1b@linux.intel.com>
Date:   Thu, 13 Dec 2018 09:26:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212121524.GC25240@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 12.12.2018 15:15, Jiri Olsa wrote:
> On Wed, Dec 12, 2018 at 10:38:23AM +0300, Alexey Budankov wrote:
>>
>> Allocate affinity option and masks for mmap data buffers and
>> record thread as well as initialize allocated objects.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 11 ++++++++++-
>>  tools/perf/perf.h           |  5 +++++
>>  tools/perf/util/evlist.c    |  6 +++---
>>  tools/perf/util/evlist.h    |  2 +-
>>  tools/perf/util/mmap.c      |  2 ++
>>  tools/perf/util/mmap.h      |  3 ++-
>>  6 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 882285fb9f64..4979719e54ae 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -81,6 +81,7 @@ struct record {
>>  	bool			timestamp_boundary;
>>  	struct switch_output	switch_output;
>>  	unsigned long long	samples;
>> +	cpu_set_t		affinity_mask;
>>  };
>>  
>>  static volatile int auxtrace_record__snapshot_started;
>> @@ -533,7 +534,8 @@ static int record__mmap_evlist(struct record *rec,
>>  
>>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>>  				 opts->auxtrace_mmap_pages,
>> -				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
>> +				 opts->auxtrace_snapshot_mode,
>> +				 opts->nr_cblocks, opts->affinity) < 0) {
>>  		if (errno == EPERM) {
>>  			pr_err("Permission error mapping pages.\n"
>>  			       "Consider increasing "
>> @@ -1980,6 +1982,9 @@ int cmd_record(int argc, const char **argv)
>>  # undef REASON
>>  #endif
>>  
>> +	CPU_ZERO(&rec->affinity_mask);
>> +	rec->opts.affinity = PERF_AFFINITY_SYS;
>> +
>>  	rec->evlist = perf_evlist__new();
>>  	if (rec->evlist == NULL)
>>  		return -ENOMEM;
>> @@ -2143,6 +2148,10 @@ int cmd_record(int argc, const char **argv)
>>  	if (verbose > 0)
>>  		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>>  
>> +	pr_debug("affinity (UNSET:%d, NODE:%d, CPU:%d) = %d\n",
>> +		 PERF_AFFINITY_SYS, PERF_AFFINITY_NODE,
>> +		 PERF_AFFINITY_CPU, rec->opts.affinity);
> 
> please make this user friendly and display the actual string like "UNSET/NODE/CPU"

Implemented in v2.

> 
>> +
>>  	err = __cmd_record(&record, argc, argv);
>>  out:
>>  	perf_evlist__delete(rec->evlist);
>> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
>> index 388c6dd128b8..08e75815de2f 100644
>> --- a/tools/perf/perf.h
>> +++ b/tools/perf/perf.h
>> @@ -83,8 +83,13 @@ struct record_opts {
>>  	clockid_t    clockid;
>>  	u64          clockid_res_ns;
>>  	int	     nr_cblocks;
>> +	int	     affinity;
>>  };
>>  
>> +#define PERF_AFFINITY_SYS  0
>> +#define PERF_AFFINITY_NODE 1
>> +#define PERF_AFFINITY_CPU  2
> 
> please put those to enum

Implemented in v2.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
