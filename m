Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeCFOKa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932147AbeCFOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:09:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C69920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Mar 2018 11:09:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf sched: move thread::shortname to
 thread_runtime
Message-ID: <20180306140919.GF10176@kernel.org>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
 <1520307457-23668-2-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520307457-23668-2-git-send-email-changbin.du@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 11:37:36AM +0800, changbin.du@intel.com escreveu:
> From: Changbin Du <changbin.du@intel.com>
> 
> The thread::shortname only used by sched command, so move it
> to sched private structure.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/perf/builtin-sched.c | 95 +++++++++++++++++++++++++++-------------------
>  tools/perf/util/thread.h   |  1 -
>  2 files changed, 55 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 83283fe..5bfc8d5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -255,6 +255,8 @@ struct thread_runtime {
>  
>  	int last_state;
>  	u64 migrations;
> +
> +	char shortname[3];
>  };

So, what we have for this struct right now is:

[root@jouet perf]# pahole -C thread_runtime ~/bin/perf
struct thread_runtime {
	u64                        last_time;            /*     0     8 */
	u64                        dt_run;               /*     8     8 */
	u64                        dt_sleep;             /*    16     8 */
	u64                        dt_iowait;            /*    24     8 */
	u64                        dt_preempt;           /*    32     8 */
	u64                        dt_delay;             /*    40     8 */
	u64                        ready_to_run;         /*    48     8 */
	struct stats               run_stats;            /*    56    40 */
	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
	u64                        total_run_time;       /*    96     8 */
	u64                        total_sleep_time;     /*   104     8 */
	u64                        total_iowait_time;    /*   112     8 */
	u64                        total_preempt_time;   /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	u64                        total_delay_time;     /*   128     8 */
	int                        last_state;           /*   136     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        migrations;           /*   144     8 */

	/* size: 152, cachelines: 3, members: 15 */
	/* sum members: 148, holes: 1, sum holes: 4 */
	/* last cacheline: 24 bytes */
};
[root@jouet perf]#

So I'll move this shortname member to just before 'migrations', then the
bool you'll add on the second patch to right after 'shortname' so that
this gets optimally packed.

Thanks,

- Arnaldo
  
>  /* per event run time data */
> @@ -897,6 +899,37 @@ struct sort_dimension {
>  	struct list_head	list;
>  };
>  
> +/*
> + * handle runtime stats saved per thread
> + */
> +static struct thread_runtime *thread__init_runtime(struct thread *thread)
> +{
> +	struct thread_runtime *r;
> +
> +	r = zalloc(sizeof(struct thread_runtime));
> +	if (!r)
> +		return NULL;
> +
> +	init_stats(&r->run_stats);
> +	thread__set_priv(thread, r);
> +
> +	return r;
> +}
> +
> +static struct thread_runtime *thread__get_runtime(struct thread *thread)
> +{
> +	struct thread_runtime *tr;
> +
> +	tr = thread__priv(thread);
> +	if (tr == NULL) {
> +		tr = thread__init_runtime(thread);
> +		if (tr == NULL)
> +			pr_debug("Failed to malloc memory for runtime data.\n");
> +	}
> +
> +	return tr;
> +}
> +
>  static int
>  thread_lat_cmp(struct list_head *list, struct work_atoms *l, struct work_atoms *r)
>  {
> @@ -1480,6 +1513,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  {
>  	const u32 next_pid = perf_evsel__intval(evsel, sample, "next_pid");
>  	struct thread *sched_in;
> +	struct thread_runtime *tr;
>  	int new_shortname;
>  	u64 timestamp0, timestamp = sample->time;
>  	s64 delta;
> @@ -1519,22 +1553,28 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  	if (sched_in == NULL)
>  		return -1;
>  
> +	tr = thread__get_runtime(sched_in);
> +	if (tr == NULL) {
> +		thread__put(sched_in);
> +		return -1;
> +	}
> +
>  	sched->curr_thread[this_cpu] = thread__get(sched_in);
>  
>  	printf("  ");
>  
>  	new_shortname = 0;
> -	if (!sched_in->shortname[0]) {
> +	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
>  			/*
>  			 * Don't allocate a letter-number for swapper:0
>  			 * as a shortname. Instead, we use '.' for it.
>  			 */
> -			sched_in->shortname[0] = '.';
> -			sched_in->shortname[1] = ' ';
> +			tr->shortname[0] = '.';
> +			tr->shortname[1] = ' ';
>  		} else {
> -			sched_in->shortname[0] = sched->next_shortname1;
> -			sched_in->shortname[1] = sched->next_shortname2;
> +			tr->shortname[0] = sched->next_shortname1;
> +			tr->shortname[1] = sched->next_shortname2;
>  
>  			if (sched->next_shortname1 < 'Z') {
>  				sched->next_shortname1++;
> @@ -1552,6 +1592,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  	for (i = 0; i < cpus_nr; i++) {
>  		int cpu = sched->map.comp ? sched->map.comp_cpus[i] : i;
>  		struct thread *curr_thread = sched->curr_thread[cpu];
> +		struct thread_runtime *curr_tr;
>  		const char *pid_color = color;
>  		const char *cpu_color = color;
>  
> @@ -1569,9 +1610,14 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  		else
>  			color_fprintf(stdout, cpu_color, "*");
>  
> -		if (sched->curr_thread[cpu])
> -			color_fprintf(stdout, pid_color, "%2s ", sched->curr_thread[cpu]->shortname);
> -		else
> +		if (sched->curr_thread[cpu]) {
> +			curr_tr = thread__get_runtime(sched->curr_thread[cpu]);
> +			if (curr_tr == NULL) {
> +				thread__put(sched_in);
> +				return -1;
> +			}
> +			color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
> +		} else
>  			color_fprintf(stdout, color, "   ");
>  	}
>  
> @@ -1587,7 +1633,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  			pid_color = COLOR_PIDS;
>  
>  		color_fprintf(stdout, pid_color, "%s => %s:%d",
> -		       sched_in->shortname, thread__comm_str(sched_in), sched_in->tid);
> +		       tr->shortname, thread__comm_str(sched_in), sched_in->tid);
>  	}
>  
>  	if (sched->map.comp && new_cpu)
> @@ -2200,37 +2246,6 @@ static void save_idle_callchain(struct idle_thread_runtime *itr,
>  	callchain_cursor__copy(&itr->cursor, &callchain_cursor);
>  }
>  
> -/*
> - * handle runtime stats saved per thread
> - */
> -static struct thread_runtime *thread__init_runtime(struct thread *thread)
> -{
> -	struct thread_runtime *r;
> -
> -	r = zalloc(sizeof(struct thread_runtime));
> -	if (!r)
> -		return NULL;
> -
> -	init_stats(&r->run_stats);
> -	thread__set_priv(thread, r);
> -
> -	return r;
> -}
> -
> -static struct thread_runtime *thread__get_runtime(struct thread *thread)
> -{
> -	struct thread_runtime *tr;
> -
> -	tr = thread__priv(thread);
> -	if (tr == NULL) {
> -		tr = thread__init_runtime(thread);
> -		if (tr == NULL)
> -			pr_debug("Failed to malloc memory for runtime data.\n");
> -	}
> -
> -	return tr;
> -}
> -
>  static struct thread *timehist_get_thread(struct perf_sched *sched,
>  					  struct perf_sample *sample,
>  					  struct machine *machine,
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 40cfa36..14d44c3 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -26,7 +26,6 @@ struct thread {
>  	pid_t			ppid;
>  	int			cpu;
>  	refcount_t		refcnt;
> -	char			shortname[3];
>  	bool			comm_set;
>  	int			comm_len;
>  	bool			dead; /* if set thread has exited */
> -- 
> 2.7.4
