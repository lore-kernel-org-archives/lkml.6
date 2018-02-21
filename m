Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937747AbeBUOdR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:33:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934488AbeBUOdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:33:14 -0500
Date: Wed, 21 Feb 2018 15:33:11 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf, tools, stat: Use xyarray dimensions to iterate
 fds
Message-ID: <20180221143311.GC2565@krava>
References: <20171006020029.13339-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006020029.13339-1-andi@firstfloor.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2017 at 07:00:28PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now that the xyarray stores the dimensions we can use those
> to iterate over the FDs for a evsel.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-stat.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index dd525417880a..3c697118e44b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -557,14 +557,13 @@ static int perf_stat_synthesize_config(bool is_pipe)
>  
>  #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
>  
> -static int __store_counter_ids(struct perf_evsel *counter,
> -			       struct cpu_map *cpus,
> -			       struct thread_map *threads)
> +static int __store_counter_ids(struct perf_evsel *counter)
>  {
>  	int cpu, thread;
>  
> -	for (cpu = 0; cpu < cpus->nr; cpu++) {
> -		for (thread = 0; thread < threads->nr; thread++) {
> +	for (cpu = 0; cpu < xyarray__max_x(counter->fd); cpu++) {
> +		for (thread = 0; thread < xyarray__max_y(counter->fd);
> +		     thread++) {
>  			int fd = FD(counter, cpu, thread);
>  
>  			if (perf_evlist__id_add_fd(evsel_list, counter,
> @@ -584,7 +583,7 @@ static int store_counter_ids(struct perf_evsel *counter)
>  	if (perf_evsel__alloc_id(counter, cpus->nr, threads->nr))
>  		return -ENOMEM;
>  
> -	return __store_counter_ids(counter, cpus, threads);
> +	return __store_counter_ids(counter);
>  }
>  
>  static bool perf_evsel__should_store_id(struct perf_evsel *counter)
> -- 
> 2.13.6
> 
