Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeEQQ14 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeEQQ1z (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:27:55 -0400
Date: Thu, 17 May 2018 13:27:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support multiple events without group
Message-ID: <20180517162750.GB18538@kernel.org>
References: <1525960762-19520-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525960762-19520-1-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 10, 2018 at 09:59:22PM +0800, Jin Yao escreveu:
> See example,
> 
> perf record -e cycles,branches ./div
> perf annotate main --stdio or
> perf annotate main --stdio2 or
> perf annotate main
> 
> The "perf annotate" should show both cycles and branches on the
> left side, but actually it only shows one event cycles.
> 
> It works with events group like:
> perf record -e "{cycles,branches}" ./div
> 
> It should work too even without group.

Humm, I think that this should be done the way it is for perf report,
i.e. you select the group output by using --group, no?

Jiri, isn't that how it is done in 'perf report' for non-explicit
groups?

- Arnaldo
 
> This patch uses 'symbol_conf.nr_events > 1' to check if it's the
> multiple events case.
> 
> With this patch,
> 
> perf record -e cycles,branches ./div
> perf annotate main --stdio2
> 
>   ......
>                            for (i = 0; i < 2000000000; i++) {
>                                    flag = compute_flag();
>   4.85   5.83  38:   xor    %eax,%eax
>   0.01   0.01      → callq  compute_flag
> 
>                                    count++;
>   4.44   2.27        mov    count,%edx
>   0.00   0.00        add    $0x1,%edx
>   ......
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/annotate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5d74a30..ca8d4b1 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1054,6 +1054,8 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
>  
>  	if (perf_evsel__is_group_event(evsel))
>  		nr = evsel->nr_members;
> +	else if (symbol_conf.nr_events > nr)
> +		nr = symbol_conf.nr_events;
>  
>  	size += sizeof(al->samples[0]) * nr;
>  
> @@ -1326,6 +1328,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>  
>  		if (perf_evsel__is_group_event(evsel))
>  			width *= evsel->nr_members;
> +		else if (symbol_conf.nr_events > 1)
> +			width *= symbol_conf.nr_events;
>  
>  		if (!*al->line)
>  			printf(" %*s:\n", width, " ");
> @@ -1967,6 +1971,8 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
>  
>  	if (perf_evsel__is_group_event(evsel))
>  		width *= evsel->nr_members;
> +	else if (symbol_conf.nr_events > 1)
> +		width *= symbol_conf.nr_events;
>  
>  	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
>  				  width, width, symbol_conf.show_total_period ? "Period" :
> @@ -2578,6 +2584,8 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
>  
>  	if (perf_evsel__is_group_event(evsel))
>  		nr_pcnt = evsel->nr_members;
> +	else if (symbol_conf.nr_events > nr_pcnt)
> +		nr_pcnt = symbol_conf.nr_events;
>  
>  	err = symbol__annotate(sym, map, evsel, 0, parch);
>  	if (err)
> -- 
> 2.7.4
