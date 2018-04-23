Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755611AbeDWPar (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:30:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755184AbeDWPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:30:46 -0400
Date: Mon, 23 Apr 2018 17:30:42 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 9/9] perf stat: Display user and system time
Message-ID: <20180423153042.GC8331@krava>
References: <20180423090823.32309-1-jolsa@kernel.org>
 <20180423090823.32309-10-jolsa@kernel.org>
 <20180423145120.GH30324@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423145120.GH30324@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:51:20AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 23, 2018 at 11:08:23AM +0200, Jiri Olsa escreveu:
> > Adding the support to read rusage data once the
> > workload is finished and display the system/user
> > time values:
> > 
> >   $ perf stat --null ./perf bench sched pipe
> >   ...
> > 
> >    Performance counter stats for './perf bench sched pipe':
> > 
> >        5.342599256 seconds time elapsed
> > 
> >        2.544434000 seconds user
> >        4.549691000 seconds sys
> 
> Please write a setence or two explaining the above three timings, do it
> nicely so that we can add it to the man page and avoid people scratching
> heads :-)

will do  ;-)

> 
> All the other patches were applied, some to perf/urgent (fixes) the
> remaining ones, new features, added to perf/core, up to Ingo to decide
> where to merge when I get to ask him to pull.

cool, thanks

jirka

> 
> - Arnaldo
>  
> > It works only in non -r mode.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Link: http://lkml.kernel.org/n/tip-t8k6d3gs8sz8zqnz3aslk5ro@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 2137c7d11767..9c987617c8e7 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -80,6 +80,9 @@
> >  #include <sys/stat.h>
> >  #include <sys/wait.h>
> >  #include <unistd.h>
> > +#include <sys/time.h>
> > +#include <sys/resource.h>
> > +#include <sys/wait.h>
> >  
> >  #include "sane_ctype.h"
> >  
> > @@ -174,6 +177,8 @@ static const char		*output_name;
> >  static int			output_fd;
> >  static int			print_free_counters_hint;
> >  static u64			*walltime_run;
> > +static bool			ru_display			= false;
> > +static struct rusage		ru_data;
> >  
> >  struct perf_stat {
> >  	bool			 record;
> > @@ -725,7 +730,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >  					break;
> >  			}
> >  		}
> > -		waitpid(child_pid, &status, 0);
> > +		wait4(child_pid, &status, 0, &ru_data);
> >  
> >  		if (workload_exec_errno) {
> >  			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> > @@ -1773,6 +1778,11 @@ static void print_table(FILE *output, int precision, double avg)
> >  	fprintf(output, "\n%*s# Final result:\n", indent, "");
> >  }
> >  
> > +static double timeval2double(struct timeval *t)
> > +{
> > +	return t->tv_sec + (double) t->tv_usec/USEC_PER_SEC;
> > +}
> > +
> >  static void print_footer(void)
> >  {
> >  	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
> > @@ -1784,6 +1794,15 @@ static void print_footer(void)
> >  
> >  	if (run_count == 1) {
> >  		fprintf(output, " %17.9f seconds time elapsed", avg);
> > +
> > +		if (ru_display) {
> > +			double utime = timeval2double(&ru_data.ru_utime);
> > +			double stime = timeval2double(&ru_data.ru_stime);
> > +
> > +			fprintf(output, "\n\n");
> > +			fprintf(output, " %17.9f seconds user\n", utime);
> > +			fprintf(output, " %17.9f seconds sys\n", stime);
> > +		}
> >  	} else {
> >  		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
> >  		/*
> > @@ -2869,6 +2888,13 @@ int cmd_stat(int argc, const char **argv)
> >  		goto out;
> >  	}
> >  
> > +	/*
> > +	 * Display user/system times only for single
> > +	 * run and when there's specified tracee.
> > +	 */
> > +	if ((run_count == 1) && target__none(&target))
> > +		ru_display = true;
> > +
> >  	if (output_fd < 0) {
> >  		fprintf(stderr, "argument to --log-fd must be a > 0\n");
> >  		parse_options_usage(stat_usage, stat_options, "log-fd", 0);
> > -- 
> > 2.13.6
