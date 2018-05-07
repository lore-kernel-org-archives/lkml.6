Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeEGPE3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751912AbeEGPE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:04:27 -0400
Date: Mon, 7 May 2018 12:04:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf tools: Fix parser for empty pmu terms case
Message-ID: <20180507150424.GA3259@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
 <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
 <20180504160228.GA25229@krava>
 <87a7tdphyo.fsf@linux.intel.com>
 <20180506142830.GA18865@krava>
 <97dc8045-0136-0c9b-8413-1957ceeae5d3@intel.com>
 <20180507081203.GA26443@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507081203.GA26443@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 07, 2018 at 10:12:03AM +0200, Jiri Olsa escreveu:
> On Mon, May 07, 2018 at 10:21:42AM +0300, Adrian Hunter wrote:
> > On 06/05/18 17:28, Jiri Olsa wrote:
> > > On Sat, May 05, 2018 at 08:43:11PM -0700, Andi Kleen wrote:
> > >> Jiri Olsa <jolsa@redhat.com> writes:
> > >>
> > >> Please fix this quickly, PT is currently totally non functional in Linus
> > >> mainline.
> > > 
> > > attached.. Kan, could you please test it wrt your latest changes?
> > > 
> > > thanks,
> > > jirka
> > > 
> > > 
> > > ---
> > > Adrian reported broken event parsing for Intel PT:
> > > 
> > >   $ perf record -e intel_pt//u uname
> > >   event syntax error: 'intel_pt//u'
> > >                                \___ parser error
> > >   Run 'perf list' for a list of valid events
> > > 
> > > It's caused by recent change in parsing grammar
> > > (see Fixes: for commit).
> > > 
> > > Adding special rule with empty terms config to handle
> > > the reported case and moving the common rule code into
> > > new parse_events_pmu function.
> > 
> > Hi
> > 
> > Can you explain why that is needed instead of just changing the grammar e.g.
> 
> well, for one, mine is working ;-)
> 
> [jolsa@krava perf]$ sudo ./perf record -e intel_pt//u uname
> event syntax error: 'intel_pt//u'
>                               \___ parser error
> Run 'perf list' for a list of valid events
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> 
> 
> but yep, it's better solution.. with extra changes like below

So, can I get a final patch, with an Ack from Adrian, please?

- Arnaldo
 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 47f6399a309a..155d2570274f 100644
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
> @@ -224,15 +225,15 @@ event_def: event_pmu |
>  	   event_bpf_file
>  
>  event_pmu:
> -PE_NAME '/' event_config '/'
> +PE_NAME opt_pmu_config
>  {
>  	struct list_head *list, *orig_terms, *terms;
>  
> -	if (parse_events_copy_term_list($3, &orig_terms))
> +	if (parse_events_copy_term_list($2, &orig_terms))
>  		YYABORT;
>  
>  	ALLOC_LIST(list);
> -	if (parse_events_add_pmu(_parse_state, list, $1, $3, false, false)) {
> +	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
>  		char *pattern;
> @@ -262,7 +263,7 @@ PE_NAME '/' event_config '/'
>  		if (!ok)
>  			YYABORT;
>  	}
> -	parse_events_terms__delete($3);
> +	parse_events_terms__delete($2);
>  	parse_events_terms__delete(orig_terms);
>  	$$ = list;
>  }
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
