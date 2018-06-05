Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeFENZR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeFENZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:25:16 -0400
Date: Tue, 5 Jun 2018 10:25:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf tools: Fix pmu events parsing rule
Message-ID: <20180605132514.GD4899@kernel.org>
References: <20180605121416.31645-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605121416.31645-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 05, 2018 at 02:14:16PM +0200, Jiri Olsa escreveu:
> Currently all the event parsing fails end up
> in the event_pmu rule, and display misleading
> help like:
> 
>   $ perf stat -e inst kill
>   event syntax error: 'inst'
>                        \___ Cannot find PMU `inst'. Missing kernel support?
>   ...
> 
> The reason is that the event_pmu is too strong
> and match also single string. Changing it to
> force the '/' separators to be part of the rule,
> and getting the proper error now:
> 
>   $ perf stat -e inst kill
>   event syntax error: 'inst'
>                        \___ parser error
>   Run 'perf list' for a list of valid events
>   ...
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: http://lkml.kernel.org/n/tip-vgf5a8wk0eyayo7omvutwhqo@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to acme/perf/core, will let it brew there for a while,
if we have time then I'll try getting it to perf/urgent, better error
messages are important :-)

- Arnaldo

> ---
>  tools/perf/util/parse-events.y | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index e37608a87dba..155d2570274f 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -73,6 +73,7 @@ static void inc_group_count(struct list_head *list,
>  %type <num> value_sym
>  %type <head> event_config
>  %type <head> opt_event_config
> +%type <head> opt_pmu_config
>  %type <term> event_term
>  %type <head> event_pmu
>  %type <head> event_legacy_symbol
> @@ -224,7 +225,7 @@ event_def: event_pmu |
>  	   event_bpf_file
>  
>  event_pmu:
> -PE_NAME opt_event_config
> +PE_NAME opt_pmu_config
>  {
>  	struct list_head *list, *orig_terms, *terms;
>  
> @@ -496,6 +497,17 @@ opt_event_config:
>  	$$ = NULL;
>  }
>  
> +opt_pmu_config:
> +'/' event_config '/'
> +{
> +	$$ = $2;
> +}
> +|
> +'/' '/'
> +{
> +	$$ = NULL;
> +}
> +
>  start_terms: event_config
>  {
>  	struct parse_events_state *parse_state = _parse_state;
> -- 
> 2.13.6
