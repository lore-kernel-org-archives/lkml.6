Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20280C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBF82082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBF82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeKEEmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 23:42:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbeKEEmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 23:42:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EA5D308421A;
        Sun,  4 Nov 2018 19:26:19 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0838719749;
        Sun,  4 Nov 2018 19:26:16 +0000 (UTC)
Date:   Sun, 4 Nov 2018 20:26:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: replace automatic const char[] variables by statics
Message-ID: <20181104192615.GC18517@krava>
References: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 04 Nov 2018 19:26:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 12:06:23AM +0100, Rasmus Villemoes wrote:
> An automatic const char[] variable gets initialized at runtime, just
> like any other automatic variable. For long strings, that uses a lot of
> stack and wastes time building the string; e.g. for the "No %s
> allocation events..." case one has
> 
>   444516:       48 b8 4e 6f 20 25 73 20 61 6c   movabs $0x6c61207325206f4e,%rax # "No %s al"
>   ...
>   444674:       48 89 45 80                     mov    %rax,-0x80(%rbp)
>   444678:       48 b8 6c 6f 63 61 74 69 6f 6e   movabs $0x6e6f697461636f6c,%rax # "location"
>   444682:       48 89 45 88                     mov    %rax,-0x78(%rbp)
>   444686:       48 b8 20 65 76 65 6e 74 73 20   movabs $0x2073746e65766520,%rax # " events "
>   444690:       66 44 89 55 c4                  mov    %r10w,-0x3c(%rbp)
>   444695:       48 89 45 90                     mov    %rax,-0x70(%rbp)
>   444699:       48 b8 66 6f 75 6e 64 2e 20 20   movabs $0x20202e646e756f66,%rax
> 
> Make them all static so that the compiler just references objects in .rodata.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

sounds good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-c2c.c        | 4 ++--
>  tools/perf/builtin-kmem.c       | 4 ++--
>  tools/perf/builtin-report.c     | 6 +++---
>  tools/perf/builtin-sched.c      | 2 +-
>  tools/perf/ui/browsers/header.c | 2 +-
>  tools/perf/ui/browsers/hists.c  | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f3aa9d02a5ab..ab6a89e5393c 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2343,7 +2343,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>  	struct c2c_cacheline_browser *cl_browser;
>  	struct hist_browser *browser;
>  	int key = -1;
> -	const char help[] =
> +	static const char help[] =
>  	" ENTER         Toggle callchains (if present) \n"
>  	" n             Toggle Node details info \n"
>  	" s             Toggle full length of symbol and source line columns \n"
> @@ -2424,7 +2424,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
>  {
>  	struct hist_browser *browser;
>  	int key = -1;
> -	const char help[] =
> +	static const char help[] =
>  	" d             Display cacheline details \n"
>  	" ENTER         Toggle callchains (if present) \n"
>  	" q             Quit \n";
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index b63bca4b0c2a..088705c167bf 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -334,7 +334,7 @@ static int build_alloc_func_list(void)
>  	struct alloc_func *func;
>  	struct machine *machine = &kmem_session->machines.host;
>  	regex_t alloc_func_regex;
> -	const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
> +	static const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
>  
>  	ret = regcomp(&alloc_func_regex, pattern, REG_EXTENDED);
>  	if (ret) {
> @@ -1924,7 +1924,7 @@ int cmd_kmem(int argc, const char **argv)
>  		NULL
>  	};
>  	struct perf_session *session;
> -	const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
> +	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
>  	int ret = perf_config(kmem_config, NULL);
>  
>  	if (ret)
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 257c9c18cb7e..ff615c624784 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -955,9 +955,9 @@ int cmd_report(int argc, const char **argv)
>  	int branch_mode = -1;
>  	bool branch_call_mode = false;
>  #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
> -	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> -					     CALLCHAIN_REPORT_HELP
> -					     "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
> +	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> +						    CALLCHAIN_REPORT_HELP
> +						    "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
>  	char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
>  	const char * const report_usage[] = {
>  		"perf report [<options>]",
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index cbf39dab19c1..2e0f0c65964a 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3336,7 +3336,7 @@ static int __cmd_record(int argc, const char **argv)
>  
>  int cmd_sched(int argc, const char **argv)
>  {
> -	const char default_sort_order[] = "avg, max, switch, runtime";
> +	static const char default_sort_order[] = "avg, max, switch, runtime";
>  	struct perf_sched sched = {
>  		.tool = {
>  			.sample		 = perf_sched__process_tracepoint_sample,
> diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
> index d75492189acb..5aeb663dd184 100644
> --- a/tools/perf/ui/browsers/header.c
> +++ b/tools/perf/ui/browsers/header.c
> @@ -35,7 +35,7 @@ static int list_menu__run(struct ui_browser *menu)
>  {
>  	int key;
>  	unsigned long offset;
> -	const char help[] =
> +	static const char help[] =
>  	"h/?/F1        Show this window\n"
>  	"UP/DOWN/PGUP\n"
>  	"PGDN/SPACE\n"
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index a96f62ca984a..eab9dc025b3a 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2737,7 +2737,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
>  	"S             Zoom into current Processor Socket\n"		\
>  
>  	/* help messages are sorted by lexical order of the hotkey */
> -	const char report_help[] = HIST_BROWSER_HELP_COMMON
> +	static const char report_help[] = HIST_BROWSER_HELP_COMMON
>  	"i             Show header information\n"
>  	"P             Print histograms to perf.hist.N\n"
>  	"r             Run available scripts\n"
> @@ -2745,7 +2745,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
>  	"t             Zoom into current Thread\n"
>  	"V             Verbose (DSO names in callchains, etc)\n"
>  	"/             Filter symbol by name";
> -	const char top_help[] = HIST_BROWSER_HELP_COMMON
> +	static const char top_help[] = HIST_BROWSER_HELP_COMMON
>  	"P             Print histograms to perf.hist.N\n"
>  	"t             Zoom into current Thread\n"
>  	"V             Verbose (DSO names in callchains, etc)\n"
> -- 
> 2.19.1.6.gbde171bbf5
> 
