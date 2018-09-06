Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD18C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516EA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516EA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIFPjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:39:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbeIFPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:39:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16AED402332F;
        Thu,  6 Sep 2018 11:04:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id C4FD410FD2BE;
        Thu,  6 Sep 2018 11:04:07 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:04:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2]: perf util: map data buffer for preserving
 collected data
Message-ID: <20180906110407.GE8248@krava>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <cf6cd6ca-12dd-9ee8-8e18-ee02f289c45e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6cd6ca-12dd-9ee8-8e18-ee02f289c45e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 11:04:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 11:04:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:19:56AM +0300, Alexey Budankov wrote:
> 
> The map->data buffers are used to preserve map->base profiling data 
> for writing to disk. AIO map->cblocks are used to queue corresponding 
> map->data buffers for asynchronous writing. map->cblocks objects are 
> located in the last page of every map->data buffer.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  Changes in v7:
>   - implemented handling record.aio setting from perfconfig file
>  Changes in v6:
>   - adjusted setting of priorities for cblocks;
>  Changes in v5:
>   - reshaped layout of data structures;
>   - implemented --aio option;
>  Changes in v4:
>   - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management 
>  Changes in v2:
>   - converted zalloc() to calloc() for allocation of mmap_aio array,
>   - cleared typo and adjusted fallback branch code;
> ---
>  tools/perf/builtin-record.c | 15 ++++++++++++-
>  tools/perf/perf.h           |  1 +
>  tools/perf/util/evlist.c    |  7 +++---
>  tools/perf/util/evlist.h    |  3 ++-
>  tools/perf/util/mmap.c      | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/mmap.h      |  6 ++++-
>  6 files changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 22ebeb92ac51..f17a6f9cb1ba 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -326,7 +326,8 @@ static int record__mmap_evlist(struct record *rec,
>  
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
> -				 opts->auxtrace_snapshot_mode) < 0) {
> +				 opts->auxtrace_snapshot_mode,
> +				 opts->nr_cblocks) < 0) {
>  		if (errno == EPERM) {
>  			pr_err("Permission error mapping pages.\n"
>  			       "Consider increasing "
> @@ -1287,6 +1288,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  		var = "call-graph.record-mode";
>  		return perf_default_config(var, value, cb);
>  	}
> +	if (!strcmp(var, "record.aio"))
> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
>  
>  	return 0;
>  }
> @@ -1519,6 +1522,7 @@ static struct record record = {
>  			.default_per_cpu = true,
>  		},
>  		.proc_map_timeout     = 500,
> +		.nr_cblocks	      = 2
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -1678,6 +1682,8 @@ static struct option __record_options[] = {
>  			  "signal"),
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>  		    "Parse options then exit"),
> +	OPT_INTEGER(0, "aio", &record.opts.nr_cblocks,
> +		    "asynchronous trace write operations (min: 1, max: 32, default: 2)"),

ok, so this got silently added in recent versions and I couldn't
find any justification for it.. why do we use more aio blocks for
single map now? also why the default is 2?

the option should be more specific like 'aio-blocks'

the change is difficult enough.. we should start simple and add
these additions with proper justification in separate patches

thanks,
jirka
