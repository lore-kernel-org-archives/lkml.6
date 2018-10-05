Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D766BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E620875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeJEOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:20:18 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:41054 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeJEOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:20:17 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 5 Oct 2018 16:22:49 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 5 Oct 2018 16:22:48 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 5 Oct 2018 16:22:48 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v9 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181005072248.GD3768@sejong>
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
 <6cf496d7-60b6-2ba3-7c40-26caeec81837@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6cf496d7-60b6-2ba3-7c40-26caeec81837@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:17:01PM +0300, Alexey Budankov wrote:
> 
> Multi AIO trace writing allows caching more kernel data into userspace 
> memory postponing trace writing for the sake of overall profiling data 
> thruput increase. It could be seen as kernel data buffer extension into
> userspace memory.
> 
> With aio-cblocks option value different from 0, current default value, 
> tool has capability to cache more and more data into user space
> along with delegating spill to AIO.
> 
> That allows avoiding suspend at record__aio_sync() between calls of 
> record__mmap_read_evlist() and increase profiling data thruput for 
> the cost of userspace memory.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 59 +++++++++++++++++++++++++++------
>  tools/perf/util/evlist.c    |  7 ++--
>  tools/perf/util/evlist.h    |  3 +-
>  tools/perf/util/mmap.c      | 79 ++++++++++++++++++++++++++++++++-------------
>  tools/perf/util/mmap.h      |  7 ++--
>  5 files changed, 115 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index c63fe8c021a2..7b67574be5b7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -196,16 +196,35 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
>  	return rc;
>  }
>  
> -static void record__aio_sync(struct perf_mmap *md)
> +static int record__aio_sync(struct perf_mmap *md, bool sync_all)
>  {
> -	struct aiocb *cblock = &md->cblock;
> +	struct aiocb **aiocb = md->aiocb;
> +	struct aiocb *cblocks = md->cblocks;
>  	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
> +	int i, do_suspend;
>  
>  	do {
> -		if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
> -			return;
> +		do_suspend = 0;
> +		for (i = 0; i < md->nr_cblocks; ++i) {
> +			if (cblocks[i].aio_fildes == -1 || record__aio_complete(md, &cblocks[i])) {
> +				if (sync_all)
> +					aiocb[i] = NULL;
> +				else
> +					return i;
> +			} else {
> +				/*
> +				 * Started aio write is not complete yet
> +				 * so it has to be waited before the
> +				 * next allocation.
> +				 */
> +				aiocb[i] = &cblocks[i];
> +				do_suspend = 1;
> +			}
> +		}
> +		if (!do_suspend)
> +			return -1;
>  
> -		while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
> +		while (aio_suspend((const struct aiocb **)aiocb, md->nr_cblocks, &timeout)) {
>  			if (!(errno == EAGAIN || errno == EINTR))
>  				pr_err("failed to sync perf data, error: %m\n");
>  		}
> @@ -436,11 +455,15 @@ static int record__mmap_evlist(struct record *rec,
>  			       struct perf_evlist *evlist)
>  {
>  	struct record_opts *opts = &rec->opts;
> +	int nr_cblocks = 0;
>  	char msg[512];
> -
> +#ifdef HAVE_AIO_SUPPORT
> +	nr_cblocks = opts->nr_cblocks;
> +#endif
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
> -				 opts->auxtrace_snapshot_mode) < 0) {
> +				 opts->auxtrace_snapshot_mode,
> +				 nr_cblocks) < 0) {
>  		if (errno == EPERM) {
>  			pr_err("Permission error mapping pages.\n"
>  			       "Consider increasing "
> @@ -637,7 +660,7 @@ static void record__mmap_read_sync(struct record *rec __maybe_unused)
>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>  		struct perf_mmap *map = &maps[i];
>  		if (map->base)
> -			record__aio_sync(map);
> +			record__aio_sync(map, true);
>  	}
>  #endif
>  }
> @@ -676,12 +699,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  					goto out;
>  				}
>  			} else {
> +				int idx;
>  				/*
>  				 * Call record__aio_sync() to wait till map->data buffer
>  				 * becomes available after previous aio write request.
>  				 */
> -				record__aio_sync(map);
> -				if (perf_mmap__aio_push(map, rec, record__aio_pushfn) != 0) {
> +				idx = record__aio_sync(map, false);
> +				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn) != 0) {
>  					rc = -1;
>  					goto out;
>  				}
> @@ -1442,6 +1466,10 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  		var = "call-graph.record-mode";
>  		return perf_default_config(var, value, cb);
>  	}
> +#ifdef HAVE_AIO_SUPPORT
> +	if (!strcmp(var, "record.aio-cblocks"))
> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
> +#endif
>  
>  	return 0;
>  }
> @@ -1833,6 +1861,10 @@ static struct option __record_options[] = {
>  			  "signal"),
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>  		    "Parse options then exit"),
> +#ifdef HAVE_AIO_SUPPORT
> +	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
> +		    "Max number of simultaneous per-mmap trace writes (default: 0 - serial, max: 4)"),
> +#endif
>  	OPT_END()
>  };

Please update the documentation for the new option and config
variable.  Perhaps it can provide the option always and check the
availability at runtime (with a warning message if not enabled).

Thanks,
Namhyung


>  
> @@ -2025,6 +2057,13 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +#ifdef HAVE_AIO_SUPPORT
> +	if (rec->opts.nr_cblocks > 4)
> +		rec->opts.nr_cblocks = 4;
> +	if (verbose > 0)
> +		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> +#endif
> +
>  	err = __cmd_record(&record, argc, argv);
>  out:
>  	perf_evlist__delete(rec->evlist);
