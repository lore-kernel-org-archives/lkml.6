Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC36C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9D22173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuTbnNaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9D22173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeI1Qqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:46:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37266 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbeI1Qqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:46:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so5788561wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mj+HvahiXJ9vCDLJMK6OBVul4wxYmFsZu/bEWoCs1AA=;
        b=TuTbnNaIb74XYSyhj62ZCt6NeQodcFtC1OOBPzYLpyM9zcIjAX1aXByt3ZS3yvCi99
         o4XYV+fj1Wd8TOyIDTJN1AYIx6MeV9Py9/9U2H7/eKYictYEQK6VORY4erpgoPOeFkTS
         zxacwDSrEptlsV9xGAYfWkCvVXF6Q6E1Ibn50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mj+HvahiXJ9vCDLJMK6OBVul4wxYmFsZu/bEWoCs1AA=;
        b=cxxKYKTxemEb7+lOa96/bW52i5IQmtn4GDRx8WOeoQ97IHYvr/i0/2R1zmWYo4i7Cy
         AGhvGtPaAy+GTWT6LOLJd6bX+9+ZPVfQmAqJNrjZlaCaCjmabeLFGgapbhygIyNU9dm6
         bLuLMODY0Rb/VQ2R1TU6RWcTYo3mJ38MKS6vQ9/0bdb6fQAQBdScJMdINlYCdIyYLeio
         1slPJR8EZvX2JbxSioVYRdwrHqvemNhjyAqJYX8IJOmSnGljc+l90THynKl16GJz8uzc
         tjgwQxXh1M/JGn0czFsEoK+ZlFpQHL49JiXNSxKaABGWSlts7Ea5WCH8bh1MBKeS0Gjd
         LelA==
X-Gm-Message-State: ABuFfoj+FuSNBjUshfBpnRldrhuiCtAJtNPOUT0SgWsER2QUZWvUmwpZ
        4qP7STDMe657Qp+OlBFb3VST0w==
X-Google-Smtp-Source: ACcGV63AAyqgGXgz6eYCkwYPyWkxwjkFzjCJvpuNYA4in6nrBf1P+WxRt2LVWeQwmbHO3U5mKj1k7Q==
X-Received: by 2002:adf:e882:: with SMTP id d2-v6mr11407289wrm.43.1538130218716;
        Fri, 28 Sep 2018 03:23:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id d18-v6sm1239674wmb.33.2018.09.28.03.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:23:37 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:23:31 +0800
From:   leo.yan@linaro.org
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 3/5] tools, perf, script: Add --call-trace and
 --call-ret-trace
Message-ID: <20180928102331.GA15533@leoy-ThinkPad-X240s>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-4-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920180540.14039-4-andi@firstfloor.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Thu, Sep 20, 2018 at 11:05:38AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add short cut options to print PT call trace and call-ret-trace,
> for calls and call and returns. Roughly corresponds to ftrace
> function tracer and function graph tracer.
> 
> Just makes these common use cases nicer to use.
> 
> % perf record -a -e intel_pt// sleep 1
> % perf script --call-trace
> 	    perf   900 [000] 194167.205652203: ([kernel.kallsyms])          perf_pmu_enable
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])          __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])          event_filter_match
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
> 
> % perf script --call-ret-trace
> 	    perf   900 [000] 194167.205652203:   tr strt     ([unknown])        pt_config
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_config
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_event_add
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            perf_pmu_enable
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_void
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_sched_in.isra.107
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_int
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            group_sched_in
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            event_filter_match
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_filter_match
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            group_sched_in
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])                perf_pmu_nop_txn
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                event_sched_in.isra.107
>             perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                    perf_event_set_state.part.71
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
> v2: Print errors, power, ptwrite too
> ---
>  tools/perf/Documentation/perf-script.txt |  7 +++++++
>  tools/perf/builtin-script.c              | 24 ++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 00c655ab4968..805baabd238e 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -390,6 +390,13 @@ include::itrace.txt[]
>  --xed::
>  	Run xed disassembler on output. Requires installing the xed disassembler.
>  
> +--call-trace::
> +	Show call stream for intel_pt traces. The CPUs are interleaved, but
> +	can be filtered with -C.
> +
> +--call-ret-trace::
> +	Show call and return stream for intel_pt traces.

Seems to me, these two features are _NOT_ only benefit for intel_pt,
other hardware tracing (e.g. Arm CoreSight) can enable these features
as well.  This patch is to document only for intel_pt, later if we
enable this feature on Arm platform we need to change the doc;
alternatively we can use more general description for these two options
at the first place.  How about you think for this?

Except this question, this patch looks good for me.

Thanks,
Leo Yan

>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-script-perl[1],
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 519ebb5a1f96..6c4562973983 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3119,6 +3119,26 @@ static int parse_xed(const struct option *opt __maybe_unused,
>  	return 0;
>  }
>  
> +static int parse_call_trace(const struct option *opt __maybe_unused,
> +			    const char *str __maybe_unused,
> +			    int unset __maybe_unused)
> +{
> +	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
> +	itrace_parse_synth_opts(opt, "cewp", 0);
> +	nanosecs = true;
> +	return 0;
> +}
> +
> +static int parse_callret_trace(const struct option *opt __maybe_unused,
> +			    const char *str __maybe_unused,
> +			    int unset __maybe_unused)
> +{
> +	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
> +	itrace_parse_synth_opts(opt, "crewp", 0);
> +	nanosecs = true;
> +	return 0;
> +}
> +
>  int cmd_script(int argc, const char **argv)
>  {
>  	bool show_full_info = false;
> @@ -3210,6 +3230,10 @@ int cmd_script(int argc, const char **argv)
>  			"Decode instructions from itrace", parse_insn_trace),
>  	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
>  			"Run xed disassembler on output", parse_xed),
> +	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
> +			"Decode calls from from itrace", parse_call_trace),
> +	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
> +			"Decode calls and returns from itrace", parse_callret_trace),
>  	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
>  		   "Stop display of callgraph at these symbols"),
>  	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
