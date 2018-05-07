Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeEGHW6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:22:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:53786 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeEGHWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:22:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,373,1520924400";
   d="scan'208,217";a="53759036"
Subject: Re: [PATCH] perf tools: Fix parser for empty pmu terms case
To: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, kan.liang@linux.intel.com
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
 <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
 <20180504160228.GA25229@krava> <87a7tdphyo.fsf@linux.intel.com>
 <20180506142830.GA18865@krava>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <97dc8045-0136-0c9b-8413-1957ceeae5d3@intel.com>
Date: Mon, 7 May 2018 10:21:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506142830.GA18865@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/18 17:28, Jiri Olsa wrote:
> On Sat, May 05, 2018 at 08:43:11PM -0700, Andi Kleen wrote:
>> Jiri Olsa <jolsa@redhat.com> writes:
>>
>> Please fix this quickly, PT is currently totally non functional in Linus
>> mainline.
> 
> attached.. Kan, could you please test it wrt your latest changes?
> 
> thanks,
> jirka
> 
> 
> ---
> Adrian reported broken event parsing for Intel PT:
> 
>   $ perf record -e intel_pt//u uname
>   event syntax error: 'intel_pt//u'
>                                \___ parser error
>   Run 'perf list' for a list of valid events
> 
> It's caused by recent change in parsing grammar
> (see Fixes: for commit).
> 
> Adding special rule with empty terms config to handle
> the reported case and moving the common rule code into
> new parse_events_pmu function.

Hi

Can you explain why that is needed instead of just changing the grammar e.g.

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7afeb80cc39e..28806e0c7950 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -73,6 +73,7 @@ static void inc_group_count(struct list_head *list,
 %type <num> value_sym
 %type <head> event_config
 %type <head> opt_event_config
+%type <head> opt_pmu_config
 %type <term> event_term
 %type <head> event_pmu
 %type <head> event_legacy_symbol
@@ -224,7 +225,7 @@ event_def: event_pmu |
 	   event_bpf_file

 event_pmu:
-PE_NAME opt_event_config
+PE_NAME opt_pmu_config
 {
 	struct list_head *list, *orig_terms, *terms;

@@ -496,6 +497,17 @@ opt_event_config:
 	$$ = NULL;
 }

+opt_pmu_config:
+'/' event_config '/'
+{
+	$$ = $2;
+}
+|
+'/' '/'
+{
+	$$ = NULL;
+}
+
 start_terms: event_config
 {
 	struct parse_events_state *parse_state = _parse_state;



> 
> Fixes: 9a4a931ce847 ("perf pmu: Fix pmu events parsing rule")
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Link: http://lkml.kernel.org/n/tip-uorb0azuem7b7ydace7cf6vc@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 46 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/parse-events.h |  3 +++
>  tools/perf/util/parse-events.y | 51 +++++++++++++-----------------------------
>  3 files changed, 65 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 3576aaaa9e4c..7cf326a8effe 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -8,6 +8,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <sys/param.h>
> +#include <fnmatch.h>
>  #include "term.h"
>  #include "../perf.h"
>  #include "evlist.h"
> @@ -1294,6 +1295,51 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	return evsel ? 0 : -ENOMEM;
>  }
>  
> +int parse_events_pmu(struct parse_events_state *parse_state,
> +		     struct list_head *list, char *name,
> +		     struct list_head *head_config)
> +{
> +	struct list_head *orig_terms;
> +	struct perf_pmu *pmu = NULL;
> +	char *pattern = NULL;
> +	int ok = 0;
> +
> +	if (!parse_events_add_pmu(parse_state, list, name,
> +				  head_config, false, false))
> +		return 0;
> +
> +	if (parse_events_copy_term_list(head_config, &orig_terms))
> +		return -1;
> +
> +	if (asprintf(&pattern, "%s*", name) < 0)
> +		goto out;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		char *tmp = pmu->name;
> +
> +		if (!strncmp(tmp, "uncore_", 7) &&
> +		    strncmp(name, "uncore_", 7))
> +			tmp += 7;
> +		if (!fnmatch(pattern, tmp, 0)) {
> +			struct list_head *terms;
> +
> +			if (parse_events_copy_term_list(orig_terms, &terms)) {
> +				ok = 0;
> +				goto out;
> +			}
> +			if (!parse_events_add_pmu(parse_state, list, pmu->name,
> +						  terms, true, false))
> +				ok++;
> +			parse_events_terms__delete(terms);
> +		}
> +	}
> +
> +out:
> +	parse_events_terms__delete(orig_terms);
> +	free(pattern);
> +	return ok ? 0 : -1;
> +}
> +
>  int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  			       char *str, struct list_head **listp)
>  {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 4473dac27aee..553fcaf5d23e 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -170,6 +170,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			 struct list_head *head_config,
>  			 bool auto_merge_stats,
>  			 bool use_alias);
> +int parse_events_pmu(struct parse_events_state *parse_state,
> +		     struct list_head *list, char *name,
> +		     struct list_head *head_config);
>  
>  int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  			       char *str,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 47f6399a309a..d44599bece43 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -8,7 +8,6 @@
>  
>  #define YYDEBUG 1
>  
> -#include <fnmatch.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
> @@ -226,44 +225,26 @@ event_def: event_pmu |
>  event_pmu:
>  PE_NAME '/' event_config '/'
>  {
> -	struct list_head *list, *orig_terms, *terms;
> +	struct list_head *list;
> +
> +	ALLOC_LIST(list);
>  
> -	if (parse_events_copy_term_list($3, &orig_terms))
> +	if (parse_events_pmu(_parse_state, list, $1, $3))
>  		YYABORT;
>  
> -	ALLOC_LIST(list);
> -	if (parse_events_add_pmu(_parse_state, list, $1, $3, false, false)) {
> -		struct perf_pmu *pmu = NULL;
> -		int ok = 0;
> -		char *pattern;
> -
> -		if (asprintf(&pattern, "%s*", $1) < 0)
> -			YYABORT;
> -
> -		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> -			char *name = pmu->name;
> -
> -			if (!strncmp(name, "uncore_", 7) &&
> -			    strncmp($1, "uncore_", 7))
> -				name += 7;
> -			if (!fnmatch(pattern, name, 0)) {
> -				if (parse_events_copy_term_list(orig_terms, &terms)) {
> -					free(pattern);
> -					YYABORT;
> -				}
> -				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> -					ok++;
> -				parse_events_terms__delete(terms);
> -			}
> -		}
> -
> -		free(pattern);
> -
> -		if (!ok)
> -			YYABORT;
> -	}
>  	parse_events_terms__delete($3);
> -	parse_events_terms__delete(orig_terms);
> +	$$ = list;
> +}
> +|
> +PE_NAME '/' '/'
> +{
> +	struct list_head *list;
> +
> +	ALLOC_LIST(list);
> +
> +	if (parse_events_pmu(_parse_state, list, $1, NULL))
> +		YYABORT;
> +
>  	$$ = list;
>  }
>  |
> 
