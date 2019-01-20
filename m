Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB3C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367A020989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfAUHbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfAUHbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:31:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE28585A07;
        Sun, 20 Jan 2019 22:01:24 +0000 (UTC)
Received: from krava (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 94BD81048124;
        Sun, 20 Jan 2019 22:01:22 +0000 (UTC)
Date:   Sun, 20 Jan 2019 23:01:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Jin Yao <yao.jin@linux.intel.com>, ak@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: fix crash when processing recorded stat data
Message-ID: <20190120220121.GE8591@krava>
References: <20190120191414.12925-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120191414.12925-1-tonyj@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 20 Jan 2019 22:01:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 11:14:14AM -0800, Tony Jones wrote:
> While updating Perf to work with Python3 and Python2 I noticed that the 
> stat-cpi script was dumping core.
> 
> $ perf  stat -e cycles,instructions record -o /tmp/perf.data /bin/false
> 
>  Performance counter stats for '/bin/false':
> 
>            802,148      cycles
> 
>            604,622      instructions                                                       802,148      cycles
>            604,622      instructions
> 
>        0.001445842 seconds time elapsed
> 
> $ perf script -i /tmp/perf.data -s scripts/python/stat-cpi.py
> Segmentation fault (core dumped)
> ...
> ...
>     rblist=rblist@entry=0xb2a200 <rt_stat>,
>     new_entry=new_entry@entry=0x7ffcb755c310) at util/rblist.c:33
>     ctx=<optimized out>, type=<optimized out>, create=<optimized out>,
>     cpu=<optimized out>, evsel=<optimized out>) at util/stat-shadow.c:118
>     ctx=<optimized out>, type=<optimized out>, st=<optimized out>)
>     at util/stat-shadow.c:196
>     count=count@entry=727442, cpu=cpu@entry=0, st=0xb2a200 <rt_stat>)
>     at util/stat-shadow.c:239
>     config=config@entry=0xafeb40 <stat_config>,
>     counter=counter@entry=0x133c6e0) at util/stat.c:372
> ...
> ...
> 
> The issue is that since 1fcd03946b52 perf_stat__update_shadow_stats now calls
> update_runtime_stat passing rt_stat rather than calling update_stats but
> perf_stat__init_shadow_stats has never been called to initialize rt_stat in
> the script path processing recorded stat data.
> 
> Since I can't see any reason why perf_stat__init_shadow_stats() is presently
> initialized like it is in builtin-script.c::perf_sample__fprint_metric()
> [4bd1bef8bba2f] I'm proposing it instead be initialized once in __cmd_script
> 
> Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
> Signed-off-by: Tony Jones <tonyj@suse.de>
> ---
>  tools/perf/builtin-script.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d079f36d342d..9a6dd86e606f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1681,13 +1681,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  		.force_header = false,
>  	};
>  	struct perf_evsel *ev2;
> -	static bool init;
>  	u64 val;
>  
> -	if (!init) {
> -		perf_stat__init_shadow_stats();
> -		init = true;
> -	}

well, there's no need to use shadow stats until stat
data is processed.. but it's actually just a static
initialization, so there's no need for late init

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  	if (!evsel->stats)
>  		perf_evlist__alloc_stats(script->session->evlist, false);
>  	if (evsel_script(evsel->leader)->gnum++ == 0)
> @@ -2359,6 +2354,8 @@ static int __cmd_script(struct perf_script *script)
>  
>  	signal(SIGINT, sig_handler);
>  
> +	perf_stat__init_shadow_stats();
> +
>  	/* override event processing functions */
>  	if (script->show_task_events) {
>  		script->tool.comm = process_comm_event;
> -- 
> 2.18.0
> 
