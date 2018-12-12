Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46362C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F562086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F562086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeLLMP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:15:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbeLLMP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:15:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E285C0495BB;
        Wed, 12 Dec 2018 12:15:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id A508D60C61;
        Wed, 12 Dec 2018 12:15:25 +0000 (UTC)
Date:   Wed, 12 Dec 2018 13:15:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] perf record: allocate affinity masks
Message-ID: <20181212121524.GC25240@krava>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <afb88628-7a04-3c36-2bc9-b5f5774f8e8f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb88628-7a04-3c36-2bc9-b5f5774f8e8f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 12 Dec 2018 12:15:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:23AM +0300, Alexey Budankov wrote:
> 
> Allocate affinity option and masks for mmap data buffers and
> record thread as well as initialize allocated objects.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 11 ++++++++++-
>  tools/perf/perf.h           |  5 +++++
>  tools/perf/util/evlist.c    |  6 +++---
>  tools/perf/util/evlist.h    |  2 +-
>  tools/perf/util/mmap.c      |  2 ++
>  tools/perf/util/mmap.h      |  3 ++-
>  6 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 882285fb9f64..4979719e54ae 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -81,6 +81,7 @@ struct record {
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
> +	cpu_set_t		affinity_mask;
>  };
>  
>  static volatile int auxtrace_record__snapshot_started;
> @@ -533,7 +534,8 @@ static int record__mmap_evlist(struct record *rec,
>  
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
> -				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
> +				 opts->auxtrace_snapshot_mode,
> +				 opts->nr_cblocks, opts->affinity) < 0) {
>  		if (errno == EPERM) {
>  			pr_err("Permission error mapping pages.\n"
>  			       "Consider increasing "
> @@ -1980,6 +1982,9 @@ int cmd_record(int argc, const char **argv)
>  # undef REASON
>  #endif
>  
> +	CPU_ZERO(&rec->affinity_mask);
> +	rec->opts.affinity = PERF_AFFINITY_SYS;
> +
>  	rec->evlist = perf_evlist__new();
>  	if (rec->evlist == NULL)
>  		return -ENOMEM;
> @@ -2143,6 +2148,10 @@ int cmd_record(int argc, const char **argv)
>  	if (verbose > 0)
>  		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>  
> +	pr_debug("affinity (UNSET:%d, NODE:%d, CPU:%d) = %d\n",
> +		 PERF_AFFINITY_SYS, PERF_AFFINITY_NODE,
> +		 PERF_AFFINITY_CPU, rec->opts.affinity);

please make this user friendly and display the actual string like "UNSET/NODE/CPU"

> +
>  	err = __cmd_record(&record, argc, argv);
>  out:
>  	perf_evlist__delete(rec->evlist);
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 388c6dd128b8..08e75815de2f 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -83,8 +83,13 @@ struct record_opts {
>  	clockid_t    clockid;
>  	u64          clockid_res_ns;
>  	int	     nr_cblocks;
> +	int	     affinity;
>  };
>  
> +#define PERF_AFFINITY_SYS  0
> +#define PERF_AFFINITY_NODE 1
> +#define PERF_AFFINITY_CPU  2

please put those to enum

thanks,
jirka
