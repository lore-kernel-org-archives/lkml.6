Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1E2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394678AbfBNIeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:34:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394645AbfBNIeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:34:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9022A0B42;
        Thu, 14 Feb 2019 08:34:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id E92B154500;
        Thu, 14 Feb 2019 08:34:12 +0000 (UTC)
Date:   Thu, 14 Feb 2019 09:34:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix potential USE_AFTER_FREE  problem
Message-ID: <20190214083411.GA25842@krava>
References: <20190214052356.26884-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214052356.26884-1-tsu.yubo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 14 Feb 2019 08:34:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:23:56AM -0500, Bo YU wrote:
> From: Bo Yu <tsu.yubo@gmail.com>
> 
> There is a freed pointer "evsel", so fix it.
> 
> Detected by CoverityScan, CID#1442595("Memory-illegalaccesses
> (USE_AFTER_FREE)")
> Fixes: 6ab3bc240ade4("perf trace: Support multiple "vfs_getname" probes")
> 
> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index b36061cd1ab8..4036b20a1067 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2515,7 +2515,7 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
>  static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
>  {
>  	bool found = false;
> -	struct perf_evsel *evsel, *tmp;
> +	struct perf_evsel *evsel = NULL, *tmp;

hum, I can't see how this change could matter,
could you pelase explain?

jirka

>  	struct parse_events_error err = { .idx = 0, };
>  	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
>  
> -- 
> 2.11.0
> 
