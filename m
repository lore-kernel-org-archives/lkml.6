Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC94ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD16C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD16C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeIQQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:55:34 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:59022 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727134AbeIQQze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:55:34 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 17 Sep 2018 20:28:37 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 17 Sep 2018 20:28:37 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 17 Sep 2018 20:28:37 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 38/48] perf record: Read record thread's mmaps
Message-ID: <20180917112837.GC18395@sejong>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-39-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-39-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:54:40PM +0200, Jiri Olsa wrote:
> Switch the maps source from evlist into thread data.
> 
> Link: http://lkml.kernel.org/n/tip-2r6hn6shl185j66b4vl1k4pr@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 5c6b56f164a9..d6fef646b67f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -96,6 +96,8 @@ struct record {
>  	int			threads_cnt;
>  };
>  
> +static __thread struct record_thread *thread;
> +
>  static volatile int auxtrace_record__snapshot_started;
>  static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
>  static DEFINE_TRIGGER(switch_output_trigger);
> @@ -561,24 +563,24 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  				    bool overwrite)
>  {
>  	u64 bytes_written = rec->bytes_written;
> -	int i;
> +	int i, nr;
>  	int rc = 0;
> -	struct perf_mmap *maps;
> +	struct perf_mmap **maps;
>  
>  	if (!evlist)
>  		return 0;
>  
> -	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
> +	maps = overwrite ? thread->ovw_mmap : thread->mmap;
>  	if (!maps)
>  		return 0;
>  
>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>  		return 0;
>  
> -	for (i = 0; i < evlist->nr_mmaps; i++) {
> -		struct perf_mmap *map = &maps[i];
> -		struct perf_mmap *track_map =  evlist->track_mmap ?
> -					      &evlist->track_mmap[i] : NULL;
> +	nr = overwrite ? thread->ovw_mmap_nr : thread->mmap_nr;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct perf_mmap *map = maps[i];
>  
>  		if (map->base) {
>  			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> @@ -592,21 +594,20 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  			rc = -1;
>  			goto out;
>  		}
> -
> -		if (track_map && track_map->base) {
> -			if (perf_mmap__push(track_map, rec, record__pushfn) != 0) {
> -				rc = -1;
> -				goto out;
> -			}
> -		}
>  	}
>  
>  	/*
>  	 * Mark the round finished in case we wrote
>  	 * at least one event.
>  	 */
> -	if (bytes_written != rec->bytes_written)
> -		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
> +	if (bytes_written != rec->bytes_written) {
> +		/*
> +		 * All maps of the threads point to a single file,
> +		 * so we can just pick first one.
> +		 */
> +		rc = record__write(rec, thread->mmap[0], &finished_round_event,

Shouldn't it be maps[0] ?

Thanks,
Namhyung


> +				   sizeof(finished_round_event));
> +	}
>  
>  	if (overwrite)
>  		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
> @@ -1222,6 +1223,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			goto out_child;
>  	}
>  
> +	thread = &rec->threads[0];
> +
>  	err = bpf__apply_obj_config();
>  	if (err) {
>  		char errbuf[BUFSIZ];
> @@ -1415,7 +1418,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		if (hits == rec->samples) {
>  			if (done || draining)
>  				break;
> -			err = perf_evlist__poll(rec->evlist, -1);
> +			err = fdarray__poll(&thread->pollfd, -1);
>  			/*
>  			 * Propagate error, only if there's any. Ignore positive
>  			 * number of returned events and interrupt error.
> -- 
> 2.17.1
> 
