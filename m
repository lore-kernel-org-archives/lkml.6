Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeCIPRk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932095AbeCIPRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:17:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD5D21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 12:17:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Fix core dump when flag T is used
Message-ID: <20180309151734.GC8347@kernel.org>
References: <20180308145735.64717-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308145735.64717-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 08, 2018 at 03:57:35PM +0100, Thomas Richter escreveu:
> Executing command 'perf stat -T -- ls' dumps core on x86 and s390.
> Here is the call back chain (done on x86):
>  # gdb ./perf
>  ....
>  (gdb) r stat -T -- ls
> ...
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff56d1963 in vasprintf () from /lib64/libc.so.6
> (gdb) where
>  #0  0x00007ffff56d1963 in vasprintf () from /lib64/libc.so.6
>  #1  0x00007ffff56ae484 in asprintf () from /lib64/libc.so.6
>  #2  0x00000000004f1982 in __parse_events_add_pmu (parse_state=0x7fffffffd580,
>     list=0xbfb970, name=0xbf3ef0 "cpu",
>     head_config=0xbfb930, auto_merge_stats=false) at util/parse-events.c:1233
>  #3  0x00000000004f1c8e in parse_events_add_pmu (parse_state=0x7fffffffd580,
>     list=0xbfb970, name=0xbf3ef0 "cpu",
>     head_config=0xbfb930) at util/parse-events.c:1288
>  #4  0x0000000000537ce3 in parse_events_parse (_parse_state=0x7fffffffd580,
>     scanner=0xbf4210) at util/parse-events.y:234
>  #5  0x00000000004f2c7a in parse_events__scanner (str=0x6b66c0
>     "task-clock,{instructions,cycles,cpu/cycles-t/,cpu/tx-start/}",
>     parse_state=0x7fffffffd580, start_token=258) at util/parse-events.c:1673
>  #6  0x00000000004f2e23 in parse_events (evlist=0xbe9990, str=0x6b66c0
>     "task-clock,{instructions,cycles,cpu/cycles-t/,cpu/tx-start/}", err=0x0)
>     at util/parse-events.c:1713
>  #7  0x000000000044e137 in add_default_attributes () at builtin-stat.c:2281
>  #8  0x000000000044f7b5 in cmd_stat (argc=1, argv=0x7fffffffe3b0) at
>     builtin-stat.c:2828
>  #9  0x00000000004c8b0f in run_builtin (p=0xab01a0 <commands+288>, argc=4,
>     argv=0x7fffffffe3b0) at perf.c:297
>  #10 0x00000000004c8d7c in handle_internal_command (argc=4,
>     argv=0x7fffffffe3b0) at perf.c:349
>  #11 0x00000000004c8ece in run_argv (argcp=0x7fffffffe20c,
>    argv=0x7fffffffe200) at perf.c:393
>  #12 0x00000000004c929c in main (argc=4, argv=0x7fffffffe3b0) at perf.c:537
> (gdb)
> 
> It turns out that a NULL pointer is referenced. Here are the
> function calls:
> 
>   ...
>   cmd_stat()
>   +---> add_default_attributes()
> 	+---> parse_events(evsel_list, transaction_attrs, NULL);
> 	             3rd parameter set to NULL
> 
> Function parse_events(xx, xx, struct parse_events_error *err) dives
> into a bison generated scanner and creates
> parser state information for it first:
> 
>    struct parse_events_state parse_state = {
>                 .list   = LIST_HEAD_INIT(parse_state.list),
>                 .idx    = evlist->nr_entries,
>                 .error  = err,   <--- NULL POINTER !!!
>                 .evlist = evlist,
>         };
> 
> Now various functions inside the bison scanner are called to end up
> in __parse_events_add_pmu(struct parse_events_state *parse_state, ..)
> with first parameter being a pointer to above structure definition.
> 
> Now the PMU event name is not found (because being executed in a VM)
> and this function tries to create an error message with
>    asprintf(&parse_state->error.str, ....)
> which references a NULL pointer and dumps core.
> 
> Fix this by providing a pointer to the necessary error information
> instead of NULL. Technically only the else part is needed to avoid
> the core dump, just lets be save...
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-stat.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 98bf9d32f222..86c8c8a9229c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2274,11 +2274,16 @@ static int add_default_attributes(void)
>  		return 0;
>  
>  	if (transaction_run) {
> +		struct parse_events_error errinfo;
> +
>  		if (pmu_have_event("cpu", "cycles-ct") &&
>  		    pmu_have_event("cpu", "el-start"))
> -			err = parse_events(evsel_list, transaction_attrs, NULL);
> +			err = parse_events(evsel_list, transaction_attrs,
> +					   &errinfo);
>  		else
> -			err = parse_events(evsel_list, transaction_limited_attrs, NULL);
> +			err = parse_events(evsel_list,
> +					   transaction_limited_attrs,
> +					   &errinfo);
>  		if (err) {
>  			fprintf(stderr, "Cannot set up transaction events\n");
>  			return -1;

Ok, I'm applying this, but then I think some other patch, on top of
this, is in demand to actually use that errinfo filled struct to tell
something more descriptive to the user in that fprintf() call?

- Arnaldo
