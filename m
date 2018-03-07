Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeCGPno (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933502AbeCGPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:43:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07CE2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 12:43:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Show zero counters as well in 'perf report
 --stat'
Message-ID: <20180307154338.GM3701@kernel.org>
References: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:24:30PM +0100, Ingo Molnar escreveu:
> 
> When recently using 'perf report --stat' it was not clear to me from the output 
> whether a particular statistics field (LOST_SAMPLES) was not present, or just 
> zero:
> 
>   fomalhaut:~> perf report --stat
> 
>   Aggregated stats:
>            TOTAL events:     495984
>             MMAP events:         85
>             COMM events:       3389
>             EXIT events:       1605
>         THROTTLE events:          2
>       UNTHROTTLE events:          2
>             FORK events:       3377
>           SAMPLE events:     472629
>            MMAP2 events:      14753
>   FINISHED_ROUND events:        139
>       THREAD_MAP events:          1
>          CPU_MAP events:          1
>        TIME_CONV events:          1
> 
> I had to check the output several times to ascertain that I'm not misreading the 
> output, that the field didn't change and that I didn't misremember the name. In 
> fact I had to look into the perf source to make sure that zero fields are indeed 
> not shown.
> 
> With the patch applied:
> 
>   fomalhaut:~> perf report --stat
> 
>   Aggregated stats:
>            TOTAL events:     495984
>             MMAP events:         85
>             LOST events:          0
>             COMM events:       3389
>             EXIT events:       1605
>         THROTTLE events:          2
>       UNTHROTTLE events:          2
>             FORK events:       3377
>             READ events:          0
>           SAMPLE events:     472629
>            MMAP2 events:      14753
>              AUX events:          0
>     ITRACE_START events:          0
>     LOST_SAMPLES events:          0
>           SWITCH events:          0
>  SWITCH_CPU_WIDE events:          0
>       NAMESPACES events:          0
>             ATTR events:          0
>       EVENT_TYPE events:          0
>     TRACING_DATA events:          0
>         BUILD_ID events:          0
>   FINISHED_ROUND events:        139
>         ID_INDEX events:          0
>    AUXTRACE_INFO events:          0
>         AUXTRACE events:          0
>   AUXTRACE_ERROR events:          0
>       THREAD_MAP events:          1
>          CPU_MAP events:          1
>      STAT_CONFIG events:          0
>             STAT events:          0
>       STAT_ROUND events:          0
>     EVENT_UPDATE events:          0
>        TIME_CONV events:          1
>          FEATURE events:          0
> 
> It's pretty clear at a glance that LOST_SAMPLES is present but zero.

Your wording confused me a bit, that "is present" part, because there
are some PERF_RECORD_ events that will only be "present" if we actually
explicitely ask them to be, by setting flags in perf_event_attr, like:

				mmap           :  1, /* include mmap data     */
				comm	       :  1, /* include comm data     */
				task           :  1, /* trace fork/exit       */
				mmap_data      :  1, /* non-exec mmap data    */
				sample_id_all  :  1, /* sample_type all events */
				mmap2          :  1, /* include mmap with inode data     */
				comm_exec      :  1, /* flag comm events that are due to an exec */
				context_switch :  1, /* context switch data */
				namespaces     :  1, /* include namespaces data */

So, for PERF_RECORD_MMAP2 events, one can say that it is "present but
zero" if we have an event with perf_event_attr.mmap2 = 1 and no
PERF_RECORD_MMAP2 events recorded.

But for PERF_RECORD_LOST, that will always be present, if we lose
records.

So perhaps to make all this clean we can add your patch, and on top of
it another that shows the perf_record_attr flag for the ones that are
not on all the time, something like:

   fomalhaut:~> perf report --stat
 
   Aggregated stats:
            TOTAL events:     495984
             MMAP events:         85	attr.mmap: 1
             LOST events:          0
             COMM events:       3389	attr.comm: 1, attr.comm_exec: 0
             EXIT events:       1605    attr.task: 1
         THROTTLE events:          2
       UNTHROTTLE events:          2
             FORK events:       3377	attr.task: 1
             READ events:          0
           SAMPLE events:     472629
            MMAP2 events:      14753	attr.mmap2: 1
              AUX events:          0    have to look at what enables this, etc
     ITRACE_START events:          0	ditto
     LOST_SAMPLES events:          0
           SWITCH events:          0	attr.context_switch: 0
  SWITCH_CPU_WIDE events:          0	attr.context_switch: 0
       NAMESPACES events:          0	attr.namespaces: 0
             ATTR events:          0
       EVENT_TYPE events:          0
     TRACING_DATA events:          0
         BUILD_ID events:          0	this implies disabling in 'perf record' command line
   FINISHED_ROUND events:        139
         ID_INDEX events:          0
    AUXTRACE_INFO events:          0
         AUXTRACE events:          0
   AUXTRACE_ERROR events:          0
       THREAD_MAP events:          1
          CPU_MAP events:          1
      STAT_CONFIG events:          0
             STAT events:          0
       STAT_ROUND events:          0
     EVENT_UPDATE events:          0
        TIME_CONV events:          1	have to check
          FEATURE events:          0

 
> The original output can still be gotten via:
> 
>   fomalhaut:~> perf report --stat | grep -vw 0
> 
>   Aggregated stats:
>            TOTAL events:     495984
>             MMAP events:         85
>             COMM events:       3389
>             EXIT events:       1605
>         THROTTLE events:          2
>       UNTHROTTLE events:          2
>             FORK events:       3377
>           SAMPLE events:     472629
>            MMAP2 events:      14753
>   FINISHED_ROUND events:        139
>       THREAD_MAP events:          1
>          CPU_MAP events:          1
>        TIME_CONV events:          1
> 
> So I don't think there's any real loss in functionality.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  tools/perf/ui/stdio/hist.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Index: linux/tools/perf/ui/stdio/hist.c
> ===================================================================
> --- linux.orig/tools/perf/ui/stdio/hist.c
> +++ linux/tools/perf/ui/stdio/hist.c
> @@ -840,15 +840,11 @@ size_t events_stats__fprintf(struct even
>  	for (i = 0; i < PERF_RECORD_HEADER_MAX; ++i) {
>  		const char *name;
>  
> -		if (stats->nr_events[i] == 0)
> -			continue;
> -
>  		name = perf_event__name(i);
>  		if (!strcmp(name, "UNKNOWN"))
>  			continue;
>  
> -		ret += fprintf(fp, "%16s events: %10d\n", name,
> -			       stats->nr_events[i]);
> +		ret += fprintf(fp, "%16s events: %10d\n", name, stats->nr_events[i]);
>  	}
>  
>  	return ret;
