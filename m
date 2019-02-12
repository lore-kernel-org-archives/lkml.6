Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F87214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfBLNIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:08:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfBLNIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF6FFC070E2A;
        Tue, 12 Feb 2019 13:08:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5182A6019F;
        Tue, 12 Feb 2019 13:08:12 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:08:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
Message-ID: <20190212130811.GA775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 12 Feb 2019 13:08:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:

SNIP

>  static int process_synthesized_event(struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample __maybe_unused,
> @@ -543,7 +574,8 @@ static int record__mmap_evlist(struct record *rec,
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
>  				 opts->auxtrace_snapshot_mode,
> -				 opts->nr_cblocks, opts->affinity) < 0) {
> +				 opts->nr_cblocks, opts->affinity,
> +				 opts->mmap_flush) < 0) {
>  		if (errno == EPERM) {
>  			pr_err("Permission error mapping pages.\n"
>  			       "Consider increasing "
> @@ -734,7 +766,7 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
>  }
>  
>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
> -				    bool overwrite)
> +				    bool overwrite, bool sync)
>  {
>  	u64 bytes_written = rec->bytes_written;
>  	int i;
> @@ -757,12 +789,19 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  		off = record__aio_get_pos(trace_fd);
>  
>  	for (i = 0; i < evlist->nr_mmaps; i++) {
> +		u64 flush = MMAP_FLUSH_DEFAULT;
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
>  			record__adjust_affinity(rec, map);
> +			if (sync) {
> +				flush = map->flush;
> +				map->flush = MMAP_FLUSH_DEFAULT;
> +			}
>  			if (!record__aio_enabled(rec)) {
>  				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> +					if (sync)
> +						map->flush = flush;
>  					rc = -1;
>  					goto out;
>  				}
> @@ -775,10 +814,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  				idx = record__aio_sync(map, false);
>  				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>  					record__aio_set_pos(trace_fd, off);
> +					if (sync)
> +						map->flush = flush;
>  					rc = -1;
>  					goto out;
>  				}
>  			}
> +			if (sync)
> +				map->flush = flush;
>  		}

what's 'flush' and 'sync' for? also the above handling seems confusing,
why would you set it temporarily for default value if you let it set
by user command line option?

SNIP

> -static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
> +static void perf_mmap__aio_munmap_blocks(struct perf_mmap *map __maybe_unused)
>  {
>  }
>  #endif
> @@ -444,6 +468,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>  				&mp->auxtrace_mp, map->base, fd))
>  		return -1;
>  
> +	map->flush = mp->flush;
> +
>  	return perf_mmap__aio_mmap(map, mp);
>  }
>  
> @@ -492,7 +518,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
>  	md->start = md->overwrite ? head : old;
>  	md->end = md->overwrite ? old : head;
>  
> -	if (md->start == md->end)
> +	if ((md->end - md->start) < md->flush)
>  		return -EAGAIN;

we need document and explain this change in changelog in separate patch

thanks,
jirka
