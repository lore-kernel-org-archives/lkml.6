Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2C2C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91FE214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91FE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeJMABq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:01:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:63308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJMABp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:01:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="94701036"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Oct 2018 09:28:28 -0700
Received: from [10.252.3.227] (abudanko-mobl.ccr.corp.intel.com [10.252.3.227])
        by linux.intel.com (Postfix) with ESMTP id 90A2F580144;
        Fri, 12 Oct 2018 09:28:25 -0700 (PDT)
Subject: Re: [PATCH v13 3/3]: perf record: extend trace writing to multi AIO
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
 <6e4badbc-4c6d-b0f9-75fe-8f897d31b9f6@linux.intel.com>
 <20181012141736.GB30156@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2e62d730-df83-19f4-6289-3e67583ea54d@linux.intel.com>
Date:   Fri, 12 Oct 2018 19:28:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012141736.GB30156@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.10.2018 17:17, Jiri Olsa wrote:
> On Thu, Oct 11, 2018 at 09:59:19PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -1490,6 +1514,13 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>>  		var = "call-graph.record-mode";
>>  		return perf_default_config(var, value, cb);
>>  	}
>> +#ifdef HAVE_AIO_SUPPORT
>> +	if (!strcmp(var, "record.aio")) {
>> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
>> +		if (!rec->opts.nr_cblocks)
>> +			rec->opts.nr_cblocks = 1;
>> +	}
>> +#endif
>>  
>>  	return 0;
>>  }
>> @@ -1882,8 +1913,8 @@ static struct option __record_options[] = {
>>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>>  		    "Parse options then exit"),
>>  #ifdef HAVE_AIO_SUPPORT
>> -	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
>> -		     NULL, "Enable asynchronous trace writing mode",
>> +	OPT_CALLBACK(0, "aio", &record.opts,
>> +		     "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>>  		     record__aio_parse),
> 
> it stoped work with no argument:
> 
> [jolsa@krava perf]$ ./perf record --aio ls
> Error:
> You may not have permission to collect system-wide stats.

This is the fix below. However, perf record --aio -- ls works without it.
I will resend the whole patch kit.

Thanks,
Alexey

---
 tools/perf/builtin-record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b048ede546d4..935adec937d9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -284,13 +284,15 @@ static int record__aio_parse(const struct option *opt,
        if (unset) {
                opts->nr_cblocks = 0;
        } else {
-               opts->nr_cblocks = strtol(str, NULL, 0);
+               if (str)
+                       opts->nr_cblocks = strtol(str, NULL, 0);
                if (!opts->nr_cblocks)
                        opts->nr_cblocks = 1;
        }
 
        return 0;
 }
+static int nr_cblocks_default = 1;
 #else /* HAVE_AIO_SUPPORT */
 static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all __maybe_unused)
 {
@@ -1913,8 +1915,8 @@ static struct option __record_options[] = {
        OPT_BOOLEAN(0, "dry-run", &dry_run,
                    "Parse options then exit"),
 #ifdef HAVE_AIO_SUPPORT
-       OPT_CALLBACK(0, "aio", &record.opts,
-                    "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
+       OPT_CALLBACK_OPTARG(0, "aio", &record.opts,
+                    &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
                     record__aio_parse),
 #endif
        OPT_END()
