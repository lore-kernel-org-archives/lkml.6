Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426386AbeCBOnT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426299AbeCBOnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:43:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B40206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 2 Mar 2018 11:43:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RESEND PATCH] perf sched map: re-annotate shortname if thread
 comm changed
Message-ID: <20180302144312.GC4086@kernel.org>
References: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 23, 2018 at 07:40:40PM +0800, changbin.du@intel.com escreveu:
> From: Changbin Du <changbin.du@intel.com>
> 
> This is to show the real name of thread that created via fork-exec.
> See below example for shortname *A0*.

Can you ellaborate a bit more and perhaps provide before and after
outputs?

- Arnaldo
 
> $ sudo ./perf sched map
>               *A0   80393.050639 secs A0 => perf:22368
>           *.   A0   80393.050748 secs .  => swapper:0
>            .  *.    80393.050887 secs
>       *B0  .   .    80393.052735 secs B0 => rcu_sched:8
>       *.   .   .    80393.052743 secs
>        .  *C0  .    80393.056264 secs C0 => kworker/2:1H:287
>        .  *A0  .    80393.056270 secs
>        .  *D0  .    80393.056769 secs D0 => ksoftirqd/2:22
>        .  *A0  .    80393.056804 secs A0 => pi:22368
>        .  *.   .    80393.056854 secs
>       *B0  .   .    80393.060727 secs
>       ...
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/perf/builtin-sched.c | 4 +++-
>  tools/perf/util/thread.c   | 1 +
>  tools/perf/util/thread.h   | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 83283fe..53bb8df 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1580,7 +1580,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  
>  	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
>  	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
> -	if (new_shortname || (verbose > 0 && sched_in->tid)) {
> +	if (new_shortname || sched_in->comm_changed || (verbose > 0 && sched_in->tid)) {
>  		const char *pid_color = color;
>  
>  		if (thread__has_color(sched_in))
> @@ -1588,6 +1588,8 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
>  
>  		color_fprintf(stdout, pid_color, "%s => %s:%d",
>  		       sched_in->shortname, thread__comm_str(sched_in), sched_in->tid);
> +
> +		sched_in->comm_changed = false;
>  	}
>  
>  	if (sched->map.comp && new_cpu)
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 68b65b1..c660fe6 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -212,6 +212,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
>  			unwind__flush_access(thread);
>  	}
>  
> +	thread->comm_changed = true;
>  	thread->comm_set = true;
>  
>  	return 0;
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 40cfa36..b9a328b 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -27,6 +27,7 @@ struct thread {
>  	int			cpu;
>  	refcount_t		refcnt;
>  	char			shortname[3];
> +	bool			comm_changed;
>  	bool			comm_set;
>  	int			comm_len;
>  	bool			dead; /* if set thread has exited */
> -- 
> 2.7.4
