Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427369AbeCBRKO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424699AbeCBRKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:10:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950872133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 2 Mar 2018 14:10:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf record: Fix crash in pipe mode
Message-ID: <20180302171007.GA30054@kernel.org>
References: <20180302161354.30192-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302161354.30192-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 02, 2018 at 05:13:54PM +0100, Jiri Olsa escreveu:
> Currently we can crash perf record when running in pipe mode, like:
> 
>   $ perf record ls | perf report
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   perf: Segmentation fault
>   Error:
>   The - file has no samples!
> 
> The callstack of the crash is:

Thanks, reproduced the problem, applied the patch, tested, fixed, simple
enough, applied.

- Arnaldo
 
>     0x0000000000515242 in perf_event__synthesize_event_update_name
>   3513            ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->id[0]);
>   (gdb) bt
>   #0  0x0000000000515242 in perf_event__synthesize_event_update_name
>   #1  0x00000000005158a4 in perf_event__synthesize_extra_attr
>   #2  0x0000000000443347 in record__synthesize
>   #3  0x00000000004438e3 in __cmd_record
>   #4  0x000000000044514e in cmd_record
>   #5  0x00000000004cbc95 in run_builtin
>   #6  0x00000000004cbf02 in handle_internal_command
>   #7  0x00000000004cc054 in run_argv
>   #8  0x00000000004cc422 in main
> 
> The reason of the crash is that the evsel does not have ids array
> allocated and the pipe's synthesize code tries to access it.
> 
> We don't force evsel ids allocation when we have single event,
> because it's not needed. However we need it when we are in pipe
> mode even for single event as a key for evsel update event.
> 
> Fixing this by forcing evsel ids allocation event for single
> event, when we are in pipe mode.
> 
> Link: http://lkml.kernel.org/n/tip-xbh5ca1azdcdqyep653vba7w@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c | 9 +++++++++
>  tools/perf/perf.h           | 1 +
>  tools/perf/util/record.c    | 8 ++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a60f398cbc24..eeef1143bae3 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -881,6 +881,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		}
>  	}
>  
> +	/*
> +	 * If we have just single event and are sending data
> +	 * through pipe, we need to force the ids allocation,
> +	 * because we synthesize event name through the pipe
> +	 * and need the id for that.
> +	 */
> +	if (data->is_pipe && rec->evlist->nr_entries == 1)
> +		rec->opts.sample_id = true;
> +
>  	if (record__open(rec) != 0) {
>  		err = -1;
>  		goto out_child;
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 007e0dfd5ce3..8fec1abd0f1f 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -62,6 +62,7 @@ struct record_opts {
>  	bool	     overwrite;
>  	bool	     ignore_missing_thread;
>  	bool	     strict_freq;
> +	bool	     sample_id;
>  	unsigned int freq;
>  	unsigned int mmap_pages;
>  	unsigned int auxtrace_mmap_pages;
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 3878c503f464..867f5937ebb7 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -138,6 +138,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
>  	struct perf_evsel *evsel;
>  	bool use_sample_identifier = false;
>  	bool use_comm_exec;
> +	bool sample_id = opts->sample_id;
>  
>  	/*
>  	 * Set the evsel leader links before we configure attributes,
> @@ -164,8 +165,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
>  		 * match the id.
>  		 */
>  		use_sample_identifier = perf_can_sample_identifier();
> -		evlist__for_each_entry(evlist, evsel)
> -			perf_evsel__set_sample_id(evsel, use_sample_identifier);
> +		sample_id = true;
>  	} else if (evlist->nr_entries > 1) {
>  		struct perf_evsel *first = perf_evlist__first(evlist);
>  
> @@ -175,6 +175,10 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
>  			use_sample_identifier = perf_can_sample_identifier();
>  			break;
>  		}
> +		sample_id = true;
> +	}
> +
> +	if (sample_id) {
>  		evlist__for_each_entry(evlist, evsel)
>  			perf_evsel__set_sample_id(evsel, use_sample_identifier);
>  	}
> -- 
> 2.13.6
