Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeCCOek (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 09:34:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751863AbeCCOej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 09:34:39 -0500
Date: Sat, 3 Mar 2018 15:34:36 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180303143436.GA14563@krava>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 06:41:30PM -0500, Agustin Vega-Frias wrote:

SNIP

> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 655ecff..a1a01b1 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -175,7 +175,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
>  num_dec		[0-9]+
>  num_hex		0x[a-fA-F0-9]+
>  num_raw_hex	[a-fA-F0-9]+
> -name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
> +name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
>  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
>  /* If you add a modifier you need to update check_modifier() */
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index e81a20e..c528469 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -8,6 +8,7 @@
> 
>  #define YYDEBUG 1
> 
> +#include <fnmatch.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
> @@ -241,7 +242,7 @@ PE_NAME opt_event_config
>  			if (!strncmp(name, "uncore_", 7) &&
>  			    strncmp($1, "uncore_", 7))
>  				name += 7;
> -			if (!strncmp($1, name, strlen($1))) {
> +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {

could we now get rid of the strncmp in here and keep the
glob matching only? I find it confusing now that following
commands give me same results:

	- [root@krava perf]# ./perf stat -e 'cbox/clockticks/' --no-merge -a sleep 1

	 Performance counter stats for 'system wide':

	   <not supported>      uncore_cbox_1/clockticks/                                   
	281,474,957,674,239      uncore_cbox_0/clockticks/                                   

	       1.000958335 seconds time elapsed

	- [root@krava perf]# ./perf stat -e '*cbox*/clockticks/' --no-merge -a sleep 1

	 Performance counter stats for 'system wide':

	   <not supported>      uncore_cbox_1/clockticks/                                   
		 5,427,337      uncore_cbox_0/clockticks/                                   

	       1.000962724 seconds time elapsed

	- [root@krava perf]# ./perf stat -e 'cbox*/clockticks/' --no-merge -a sleep 1

	 Performance counter stats for 'system wide':

	   <not supported>      uncore_cbox_1/clockticks/                                   
	281,474,969,621,374      uncore_cbox_0/clockticks/                                   

	       1.001026179 seconds time elapsed

and this one fails:

	- [root@krava perf]# ./perf stat -e '*cbox/clockticks/' --no-merge -a sleep 1
	event syntax error: '*cbox/clockticks/'
			     \___ Cannot find PMU `*cbox'. Missing kernel support?
	Run 'perf list' for a list of valid events

	 Usage: perf stat [<options>] [<command>]

	    -e, --event <event>   event selector. use 'perf list' to list available events


despite the fact that it makes as much sense as the previous one: perf stat -e 'cbox*/clockticks/'


I'd think let's keep just the glob matching, so it's clear
you what you use wildcards for.. thoughts?

thanks,
jirka
