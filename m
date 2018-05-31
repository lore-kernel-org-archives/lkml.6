Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbeEaNg6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:36:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755053AbeEaNgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:36:52 -0400
Date: Thu, 31 May 2018 15:36:49 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1]: perf record: enable arbitrary event names thru name=
 modifier
Message-ID: <20180531133649.GC10491@krava>
References: <ca21ebcd-3119-a75e-aff3-3684ebc61a68@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca21ebcd-3119-a75e-aff3-3684ebc61a68@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 12:43:50PM +0300, Alexey Budankov wrote:
> 
> Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> trace using name= modifier e.g. like this:
> 
> perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> 
> Below is how it looks like in the report output. Please note explicit escaped 
> quoting at cmdline string in the header so that thestring can be directly reused
> for another collection in shell:
> 
> perf report --header
> 
> # ========
> ...
> # cmdline : /root/abudanko/kernel/tip/tools/perf/perf record -v -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex 
> # event : name = OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM, , type = 4, size = 112, config = 0x100003c, { sample_period, sample_freq } = 3500000, sample_type = IP|TID|TIME, disabled = 1, inh

nice ;-)

> ...
> # ========
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 24K of event 'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM'
> # Event count (approx.): 86492000000
> #
> # Overhead  Command  Shared Object     Symbol                                        
> # ........  .......  ................  ..............................................
> #
>     14.75%  futex    [kernel.vmlinux]  [k] __entry_trampoline_start
> ...
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/header.c       | 19 +++++++++++++++++--
>  tools/perf/util/parse-events.l |  8 +++++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a8bff2178fbc..e78700385a24 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1459,8 +1459,23 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
>  
>  	fprintf(fp, "# cmdline : ");
>  
> -	for (i = 0; i < nr; i++)
> -		fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
> +	for (i = 0; i < nr; i++) {
> +		char *argv_i = strdup(ff->ph->env.cmdline_argv[i]);
> +		if (!argv_i) {
> +			fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
> +		} else {
> +			char *mem = argv_i;
> +			do {
> +				char *quote = strchr(argv_i, '\'');
> +				if (!quote) break;

please put break on separate line

> +				*quote++ = '\0';
> +				fprintf(fp, "%s\\\'", argv_i);
> +				argv_i = quote;
> +			} while (1);
> +			fprintf(fp, "%s ", argv_i);
> +			free(mem);
> +		}
> +	}
>  	fputc('\n', fp);
>  }
>  
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index a1a01b1ac8b8..26c28faa0f62 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -53,7 +53,11 @@ static int str(yyscan_t scanner, int token)
>  	YYSTYPE *yylval = parse_events_get_lval(scanner);
>  	char *text = parse_events_get_text(scanner);
>  
> -	yylval->str = strdup(text);
> +	if (text[0] != '\'')
> +		yylval->str = strdup(text);
> +	 else
> +		yylval->str = strndup(&text[1], strlen(text) - 2);

could you please put in some comment exaplining that when
there's \' in the begining there must be one at the end

thanks,
jirka
