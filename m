Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeECI02 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:26:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:40160 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbeECI00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:26:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,357,1520924400";
   d="scan'208";a="36521343"
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
Date: Thu, 3 May 2018 11:25:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425160008.3407-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This breaks Intel PT i.e.

$ perf record -e intel_pt//u uname
event syntax error: 'intel_pt//u'
                             \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available events

See below for cause.

On 25/04/18 19:00, Arnaldo Carvalho de Melo wrote:
> From: Jiri Olsa <jolsa@kernel.org>
> 
> Currently all the event parsing fails end up in the event_pmu rule, and
> display misleading help like:
> 
>   $ perf stat -e inst kill
>   event syntax error: 'inst'
>                        \___ Cannot find PMU `inst'. Missing kernel support?
>   ...
> 
> The reason is that the event_pmu is too strong and match also single
> string. Changing it to force the '/' separators to be part of the rule,
> and getting the proper error now:
> 
>   $ perf stat -e inst kill
>   event syntax error: 'inst'
>                        \___ parser error
>   Run 'perf list' for a list of valid events
>   ...
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180423090823.32309-5-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/parse-events.y | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 7afeb80cc39e..d14464c42714 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -224,15 +224,15 @@ event_def: event_pmu |
>  	   event_bpf_file
>  
>  event_pmu:
> -PE_NAME opt_event_config
> +PE_NAME '/' event_config '/'

These are not equivalent because opt_event_config allows '//'
but event_config cannot be an empty string.

>  {
>  	struct list_head *list, *orig_terms, *terms;
>  
> -	if (parse_events_copy_term_list($2, &orig_terms))
> +	if (parse_events_copy_term_list($3, &orig_terms))
>  		YYABORT;
>  
>  	ALLOC_LIST(list);
> -	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
> +	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
>  		char *pattern;
> @@ -262,7 +262,7 @@ PE_NAME opt_event_config
>  		if (!ok)
>  			YYABORT;
>  	}
> -	parse_events_terms__delete($2);
> +	parse_events_terms__delete($3);
>  	parse_events_terms__delete(orig_terms);
>  	$$ = list;
>  }
> 
