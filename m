Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032840AbeBONj0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031533AbeBONjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:39:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6F321776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 10:39:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com,
        arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH v4 2/2] perf stat: Add support to print counts after a
 period of time
Message-ID: <20180215133921.GC22818@kernel.org>
References: <1517217923-8302-1-git-send-email-ufo19890607@gmail.com>
 <1517217923-8302-3-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517217923-8302-3-git-send-email-ufo19890607@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 29, 2018 at 10:25:23AM +0100, ufo19890607 escreveu:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> Introduce a new option to print counts after N milliseconds

This doesn't just print counts after N ms, it _stops_ the workload after
that time _and_ prints the counts, right?

Can you please send a followup patch fixing the description and
documentation?

I've applied this already, but clarifying what this option does is in
demand.

- Arnaldo

> and update perf-stat documentation accordingly.
> 
> Show below is the output of the new option for perf stat.
> 
>         $ perf stat --time 2000 -e cycles -a
>         Performance counter stats for 'system wide':
> 
>                 157,260,423      cycles
> 
>                 2.003060766 seconds time elapsed
> 
> We can print the count deltas after N milliseconds with this new
> introduced option. This option is not supported with "-I" option.
> In addition, according to Kangliang's patch(19afd10410957), the
> monitoring overhead for system-wide core event could be very high
> if the interval-print parameter was below 100ms, and the limitation
> value is 10ms. So the same warning will be displayed when the time
> is set between 10ms to 100ms, and the minimal time is limited to
> 10ms. Users can make a decision according to their spcific cases.
> 
> Changes since v3:
> - none.
> 
> Changes since v2:
> - modify the time check in __run_perf_stat func to keep some consistency
>   with the workload case.
> - add the warning when the time is set between 10ms to 100ms.
> - add the pr_err when the time is set below 10ms.
> 
> Changes since v1:
> - none.
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  5 +++++
>  tools/perf/builtin-stat.c              | 33 +++++++++++++++++++++++++++++++--
>  tools/perf/util/stat.h                 |  1 +
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 47a21645f60c..c822f374c99a 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -151,6 +151,11 @@ Print count deltas for fixed number of times.
>  This option should be used together with "-I" option.
>  	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
>  
> +--time msecs::
> +Print count deltas after N milliseconds (minimum: 10 ms).
> +This option is not supported with "-I" option.
> +	example: 'perf stat --time 2000 -e cycles -a'
> +
>  --metric-only::
>  Only print computed metrics. Print them in a single line.
>  Don't show any raw values. Not supported with --per-thread.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7d1d7613bf56..582db3897374 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -573,6 +573,7 @@ static int __run_perf_stat(int argc, const char **argv)
>  {
>  	int interval = stat_config.interval;
>  	int times = stat_config.times;
> +	int time = stat_config.time;
>  	char msg[BUFSIZ];
>  	unsigned long long t0, t1;
>  	struct perf_evsel *counter;
> @@ -586,6 +587,9 @@ static int __run_perf_stat(int argc, const char **argv)
>  	if (interval) {
>  		ts.tv_sec  = interval / USEC_PER_MSEC;
>  		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
> +	} else if (time) {
> +		ts.tv_sec  = time / USEC_PER_MSEC;
> +		ts.tv_nsec = (time % USEC_PER_MSEC) * NSEC_PER_MSEC;
>  	} else {
>  		ts.tv_sec  = 1;
>  		ts.tv_nsec = 0;
> @@ -698,9 +702,11 @@ static int __run_perf_stat(int argc, const char **argv)
>  		perf_evlist__start_workload(evsel_list);
>  		enable_counters();
>  
> -		if (interval) {
> +		if (interval || time) {
>  			while (!waitpid(child_pid, &status, WNOHANG)) {
>  				nanosleep(&ts, NULL);
> +				if (time)
> +					break;
>  				process_interval();
>  				if (interval_count && !(--times))
>  					break;
> @@ -720,6 +726,8 @@ static int __run_perf_stat(int argc, const char **argv)
>  		enable_counters();
>  		while (!done) {
>  			nanosleep(&ts, NULL);
> +			if (time)
> +				break;
>  			if (interval) {
>  				process_interval();
>  				if (interval_count && !(--times))
> @@ -1900,6 +1908,8 @@ static const struct option stat_options[] = {
>  		    "print counts at regular interval in ms (>= 10)"),
>  	OPT_INTEGER(0, "interval-count", &stat_config.times,
>  		    "print counts for fixed number of times"),
> +	OPT_UINTEGER(0, "time", &stat_config.time,
> +		    "print counts after a period of time in ms (>= 10)"),
>  	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
>  		     "aggregate counts per processor socket", AGGR_SOCKET),
>  	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
> @@ -2697,7 +2707,7 @@ int cmd_stat(int argc, const char **argv)
>  	int status = -EINVAL, run_idx;
>  	const char *mode;
>  	FILE *output = stderr;
> -	unsigned int interval;
> +	unsigned int interval, time;
>  	const char * const stat_subcommands[] = { "record", "report" };
>  
>  	setlocale(LC_ALL, "");
> @@ -2728,6 +2738,7 @@ int cmd_stat(int argc, const char **argv)
>  		return __cmd_report(argc, argv);
>  
>  	interval = stat_config.interval;
> +	time = stat_config.time;
>  
>  	/*
>  	 * For record command the -o is already taken care of.
> @@ -2879,6 +2890,7 @@ int cmd_stat(int argc, const char **argv)
>  				   "The overhead percentage could be high in some cases. "
>  				   "Please proceed with caution.\n");
>  	}
> +
>  	if (stat_config.times && interval)
>  		interval_count = true;
>  	else if (stat_config.times && !interval) {
> @@ -2889,6 +2901,23 @@ int cmd_stat(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	if (time && time < 100) {
> +		if (time < 10) {
> +			pr_err("time must be >= 10ms.\n");
> +			parse_options_usage(stat_usage, stat_options, "time", 0);
> +			goto out;
> +		} else
> +			pr_warning("time < 100ms. "
> +				   "The overhead percentage could be high in some cases. "
> +				   "Please proceed with caution.\n");
> +	}
> +	if (time && interval) {
> +		pr_err("time option is not supported with interval-print.\n");
> +		parse_options_usage(stat_usage, stat_options, "time", 0);
> +		parse_options_usage(stat_usage, stat_options, "I", 1);
> +		goto out;
> +	}
> +
>  	if (perf_evlist__alloc_stats(evsel_list, interval))
>  		goto out;
>  
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 540fbb350e53..fc1ab635f7e0 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -90,6 +90,7 @@ struct perf_stat_config {
>  	bool		scale;
>  	FILE		*output;
>  	unsigned int	interval;
> +	unsigned int	time;
>  	int		times;
>  	struct runtime_stat *stats;
>  	int		stats_num;
> -- 
> 2.14.1
