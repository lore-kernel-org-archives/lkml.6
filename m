Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CF22151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwQL/uEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CF22151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbeISXwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbeISXwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:52:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36A82151B;
        Wed, 19 Sep 2018 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537380810;
        bh=anjIZSKx3QrlovLVZ/WGBFqZLZh9GghQvb68Tgw8hQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwQL/uECC/qgFUqNSAeihjBjNAIsefdmk25z/ZnB+CZjH2DpyC7H2E3t4prtewJDl
         VoB+Klh2oMaW0iPCneWNq3j6p/y6f9LjGvWxEjbPvLF9WVS1NV1Y6wygkGSyO4VlJT
         HEk8KfXLFycf+Nq1lbpCwujUx8eDujt0OM09ybMI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 10F3A140260; Wed, 19 Sep 2018 15:13:28 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:13:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 1/9] perf tools: Report itrace options in help
Message-ID: <20180919181328.GD31812@kernel.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918123214.26728-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 05:32:06AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> I often forget all the options that --itrace accepts. Instead of burying
> them in the man page only report them in the normal command line help
> too to make them easier accessible.

Looks reasonable, applied.

- Arnaldo
 
> v2: Align
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-inject.c |  3 ++-
>  tools/perf/builtin-report.c |  2 +-
>  tools/perf/builtin-script.c |  2 +-
>  tools/perf/util/auxtrace.h  | 19 +++++++++++++++++++
>  4 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a3b346359ba0..b649a0511ed8 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -803,7 +803,8 @@ int cmd_inject(int argc, const char **argv)
>  			   "kallsyms pathname"),
>  		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
>  		OPT_CALLBACK_OPTARG(0, "itrace", &inject.itrace_synth_opts,
> -				    NULL, "opts", "Instruction Tracing options",
> +				    NULL, "opts", "Instruction Tracing options\n"
> +				    ITRACE_HELP,
>  				    itrace_parse_synth_opts),
>  		OPT_BOOLEAN(0, "strip", &inject.strip,
>  			    "strip non-synthesized events (use with --itrace)"),
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 76e12bcd1765..191a389b45d1 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1105,7 +1105,7 @@ int cmd_report(int argc, const char **argv)
>  	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
>  		     "how to display percentage of filtered entries", parse_filter_percentage),
>  	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
> -			    "Instruction Tracing options",
> +			    "Instruction Tracing options\n" ITRACE_HELP,
>  			    itrace_parse_synth_opts),
>  	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
>  			"Show full source file name path for source lines"),
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6176bae177c2..49d84c85e846 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3195,7 +3195,7 @@ int cmd_script(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "ns", &nanosecs,
>  		    "Use 9 decimal places when displaying time"),
>  	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
> -			    "Instruction Tracing options",
> +			    "Instruction Tracing options\n" ITRACE_HELP,
>  			    itrace_parse_synth_opts),
>  	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
>  			"Show full source file name path for source lines"),
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 71fc3bd74299..a516a891d7ea 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -577,6 +577,23 @@ static inline void auxtrace__free(struct perf_session *session)
>  	return session->auxtrace->free(session);
>  }
>  
> +#define ITRACE_HELP \
> +"				i:	    		synthesize instructions events\n"		\
> +"				b:	    		synthesize branches events\n"		\
> +"				c:	    		synthesize branches events (calls only)\n"	\
> +"				r:	    		synthesize branches events (returns only)\n" \
> +"				x:	    		synthesize transactions events\n"		\
> +"				w:	    		synthesize ptwrite events\n"		\
> +"				p:	    		synthesize power events\n"			\
> +"				e:	    		synthesize error events\n"			\
> +"				d:	    		create a debug log\n"			\
> +"				g[len]:     		synthesize a call chain (use with i or x)\n" \
> +"				l[len]:     		synthesize last branch entries (use with i or x)\n" \
> +"				sNUMBER:    		skip initial number of events\n"		\
> +"				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
> +"				concatenate multiple options. Default is ibxwpe or cewp\n"
> +
> +
>  #else
>  
>  static inline struct auxtrace_record *
> @@ -717,6 +734,8 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>  				   struct perf_evlist *evlist, int idx,
>  				   bool per_cpu);
>  
> +#define ITRACE_HELP ""
> +
>  #endif
>  
>  #endif
> -- 
> 2.17.1
