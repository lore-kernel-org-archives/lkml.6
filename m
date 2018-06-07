Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kNF4C7SBGVvrCgAAmS7hNA
	; Thu, 07 Jun 2018 19:05:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DA0766074D; Thu,  7 Jun 2018 19:05:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="voH+a76Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4AAC3601D2;
	Thu,  7 Jun 2018 19:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AAC3601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbeFGTFA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753100AbeFGTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:04:58 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05AAF20896;
        Thu,  7 Jun 2018 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528398298;
        bh=mWJMwtYhNOLBBQEB4rx76yGKeEDuQwYyk1gXpVWhURE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=voH+a76QNHMqDeHUjPtVfK3+9UzNGzLI18XG1F2PDSdN0CCdmlKbmZAd/NRa5R6+E
         mRDnVXzh4xzlcq+zsNPrLUp/PGedQxsLraQabVwf7WDx2idJ7ZL1XKqWsyOd12/Wt0
         5a1IWS8Xur6DQswrW6nPrX+m1eo2slOc2LWKE57Y=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 99ED11468B9; Thu,  7 Jun 2018 16:04:55 -0300 (-03)
Date: Thu, 7 Jun 2018 16:04:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 07/10] perf stat: Add event parsing error handling to
 add_default_attributes
Message-ID: <20180607190455.GE17292@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-8-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 12:15:10AM +0200, Jiri Olsa escreveu:
> Adding missing error handling for parse_events calls
> in add_default_attributes functions. The error handler
> displays error details, like for transactions (-T):

Applied up to here, that are trivial, waiting a bit more discussion
about the really new stuff,

Thanks,

- Arnaldo
 
> Before:
>   $ perf stat -T
>   Cannot set up transaction events
> 
> After:
>   $ perf stat -T
>   Cannot set up transaction events
>   event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
>                                     \___ unknown term
> 
> Link: http://lkml.kernel.org/n/tip-hmctifkfiaij47xb9en1hlcf@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a8f93885763a..cc3dd85d5a60 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2451,14 +2451,13 @@ static int add_default_attributes(void)
>  	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
>  	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
>  };
> +	struct parse_events_error errinfo;
>  
>  	/* Set attrs if no event is selected and !null_run: */
>  	if (null_run)
>  		return 0;
>  
>  	if (transaction_run) {
> -		struct parse_events_error errinfo;
> -
>  		if (pmu_have_event("cpu", "cycles-ct") &&
>  		    pmu_have_event("cpu", "el-start"))
>  			err = parse_events(evsel_list, transaction_attrs,
> @@ -2469,6 +2468,7 @@ static int add_default_attributes(void)
>  					   &errinfo);
>  		if (err) {
>  			fprintf(stderr, "Cannot set up transaction events\n");
> +			parse_events_print_error(&errinfo, transaction_attrs);
>  			return -1;
>  		}
>  		return 0;
> @@ -2494,10 +2494,11 @@ static int add_default_attributes(void)
>  		    pmu_have_event("msr", "smi")) {
>  			if (!force_metric_only)
>  				metric_only = true;
> -			err = parse_events(evsel_list, smi_cost_attrs, NULL);
> +			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
>  		} else {
>  			fprintf(stderr, "To measure SMI cost, it needs "
>  				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
> +			parse_events_print_error(&errinfo, smi_cost_attrs);
>  			return -1;
>  		}
>  		if (err) {
> @@ -2532,12 +2533,13 @@ static int add_default_attributes(void)
>  		if (topdown_attrs[0] && str) {
>  			if (warn)
>  				arch_topdown_group_warn();
> -			err = parse_events(evsel_list, str, NULL);
> +			err = parse_events(evsel_list, str, &errinfo);
>  			if (err) {
>  				fprintf(stderr,
>  					"Cannot set up top down events %s: %d\n",
>  					str, err);
>  				free(str);
> +				parse_events_print_error(&errinfo, str);
>  				return -1;
>  			}
>  		} else {
> -- 
> 2.13.6
