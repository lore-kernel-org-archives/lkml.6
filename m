Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD84C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAB221521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v8V5guuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAB221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbeITAHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbeITAHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:07:50 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DC720877;
        Wed, 19 Sep 2018 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537381721;
        bh=Z/F5qgXw6Z9xN6P0DtkroyvdnbVOWSk0qYTtzpc0n9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8V5guufiB9axLtgVT+0zV3V1Yvpy6T+4iZMxiOb1hFluApOmybVFJng5kHM0I5Yo
         2131i3oiMz/hVCceJRQm/uxUMmyEB9QylxFtRWrz60JwjFi8EETm2xvrhfxTAzOoDy
         bXAS/Afkn6kCu1CJEn7wR/ns7MOLWCon2X3bSONU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5E00B140260; Wed, 19 Sep 2018 15:28:37 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:28:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 6/9] perf, tools, script: Make itrace script default
 to all calls
Message-ID: <20180919182837.GH31812@kernel.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-7-andi@firstfloor.org>
 <fa942e47-9654-dfa2-7a57-744b5fd3b790@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa942e47-9654-dfa2-7a57-744b5fd3b790@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 04:24:55PM +0300, Adrian Hunter escreveu:
> On 18/09/18 15:32, Andi Kleen wrote:
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -964,16 +964,23 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
> >  #define PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ	64
> >  #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
> >  
> > -void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
> > +void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
> > +				    bool no_sample)
> 
> Rather than pass no_sample, what about passing the whole of the tool's
> options i.e.

This can be done on top, right? Or will you need the other options on
work you're doing right now and that would be an advantage to do this
right now?

- Arnaldo
 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index db1511359c5e..d4db61626a5f 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -964,8 +964,14 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
>  #define PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ	64
>  #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
>  
> -void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
> +bool itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
> +				    const struct itrace_synth_opts *tool_synth_opts)
>  {
> +	if (tool_synth_opts && tool_synth_opts->set) {
> +		*synth_opts = *tool_synth_opts;
> +		return false;
> +	}
> +
>  	synth_opts->instructions = true;
>  	synth_opts->branches = true;
>  	synth_opts->transactions = true;
> @@ -977,6 +983,8 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
>  	synth_opts->callchain_sz = PERF_ITRACE_DEFAULT_CALLCHAIN_SZ;
>  	synth_opts->last_branch_sz = PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ;
>  	synth_opts->initial_skip = 0;
> +
> +	return true;
>  }
>  
>  /*
> @@ -1001,7 +1009,7 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
>  	}
>  
>  	if (!str) {
> -		itrace_synth_opts__set_default(synth_opts);
> +		itrace_synth_opts__set_default(synth_opts, NULL);
>  		return 0;
>  	}
>  
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index a516a891d7ea..172c92a8c596 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -528,7 +528,8 @@ int perf_event__process_auxtrace_error(struct perf_tool *tool,
>  				       struct perf_session *session);
>  int itrace_parse_synth_opts(const struct option *opt, const char *str,
>  			    int unset);
> -void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts);
> +bool itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
> +				    const struct itrace_synth_opts *tool_synth_opts);
>  
>  size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
>  void perf_session__auxtrace_error_inc(struct perf_session *session,
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2ae640257fdb..45b9a2b9f473 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1429,12 +1429,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  		return 0;
>  	}
>  
> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> -		etm->synth_opts = *session->itrace_synth_opts;
> -	} else {
> -		itrace_synth_opts__set_default(&etm->synth_opts);
> +	if (itrace_synth_opts__set_default(&etm->synth_opts,
> +					   session->itrace_synth_opts))
>  		etm->synth_opts.callchain = false;
> -	}
>  
>  	err = cs_etm__synth_events(etm, session);
>  	if (err)
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 7f0c83b6332b..2d96f4743789 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -907,12 +907,9 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
>  	if (dump_trace)
>  		return 0;
>  
> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> -		bts->synth_opts = *session->itrace_synth_opts;
> -	} else {
> -		itrace_synth_opts__set_default(&bts->synth_opts);
> -		if (session->itrace_synth_opts)
> -			bts->synth_opts.thread_stack =
> +	if (itrace_synth_opts__set_default(&bts->synth_opts,
> +					   session->itrace_synth_opts)) {
> +		bts->synth_opts.thread_stack =
>  				session->itrace_synth_opts->thread_stack;
>  	}
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index aec68908d604..b6ac8ac2f4c3 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2551,10 +2551,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  		goto err_delete_thread;
>  	}
>  
> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> -		pt->synth_opts = *session->itrace_synth_opts;
> -	} else {
> -		itrace_synth_opts__set_default(&pt->synth_opts);
> +	if (itrace_synth_opts__set_default(&pt->synth_opts,
> +					   session->itrace_synth_opts)) {
>  		if (use_browser != -1) {
>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;
