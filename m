Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694C621521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd0Yuv4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694C621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbeISXv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbeISXv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:51:57 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9D12151B;
        Wed, 19 Sep 2018 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537380771;
        bh=sP8JLOHciAYjd4zaULkZHID61jtYmAM6NTcQn8rKFzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pd0Yuv4Z4bmYJNxcfjDDi5IJNmR42MAel2nE/nFWstL0y7ftLjQt6AvR5izSkvbsh
         3jDH86Qn/1/9fGMWbxcfn6o+fZHpoSpjcklj/8SwmQvwArJLFrMiEXsgKbQk8Uzo4L
         XtgqqTCcGk7EH5GSG9G6wkQvzYau17oQgcN8mqUo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 75105140260; Wed, 19 Sep 2018 15:12:47 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:12:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 03/10] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20180919181247.GC31812@kernel.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-4-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829171834.6590-4-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 29, 2018 at 10:18:27AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a --insn-trace short hand option for decoding and disassembling
> instruction streams for intel_pt. This automatically pipes the
> output into the xed disassembler to generate disassembled instructions.
> This just makes this use model much nicer to use

Would be nice to provide at least an URL to where to find xed, I tried
this:

[root@seventh ~]# dnf search xed
Last metadata expiration check: 0:25:39 ago on Wed 19 Sep 2018 02:42:36 PM -03.
=================================================================================== Name Exactly Matched: xed ====================================================================================
xed.i686 : X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)
xed.x86_64 : X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)

https://github.com/intelxed

So I have to install a build system and then install it to then build
intelxed?

- Arnaldo
 
> Before
> 
> % perf record -e intel_pt// ...
> % perf script --itrace=i0ns --ns -F +insn,-event,-period | xed -F insn: -A -64
>    swapper     0 [000] 117276.429606186:  ffffffff81010486 pt_config ([kernel.kallsyms])          nopl  %eax, (%rax,%rax,1)
>    swapper     0 [000] 117276.429606186:  ffffffff8101048b pt_config ([kernel.kallsyms])          add $0x10, %rsp
>    swapper     0 [000] 117276.429606186:  ffffffff8101048f pt_config ([kernel.kallsyms])          popq  %rbx
>    swapper     0 [000] 117276.429606186:  ffffffff81010490 pt_config ([kernel.kallsyms])          popq  %rbp
>    swapper     0 [000] 117276.429606186:  ffffffff81010491 pt_config ([kernel.kallsyms])          popq  %r12
>    swapper     0 [000] 117276.429606186:  ffffffff81010493 pt_config ([kernel.kallsyms])          popq  %r13
>    swapper     0 [000] 117276.429606186:  ffffffff81010495 pt_config ([kernel.kallsyms])          popq  %r14
>    swapper     0 [000] 117276.429606186:  ffffffff81010497 pt_config ([kernel.kallsyms])          popq  %r15
>    swapper     0 [000] 117276.429606186:  ffffffff81010499 pt_config ([kernel.kallsyms])          retq
>    swapper     0 [000] 117276.429606186:  ffffffff8101063e pt_event_add ([kernel.kallsyms])               cmpl  $0x1, 0x1b0(%rbx)
>    swapper     0 [000] 117276.429606186:  ffffffff81010645 pt_event_add ([kernel.kallsyms])               mov $0xffffffea, %eax
>    swapper     0 [000] 117276.429606186:  ffffffff8101064a pt_event_add ([kernel.kallsyms])               mov $0x0, %edx
>    swapper     0 [000] 117276.429606186:  ffffffff8101064f pt_event_add ([kernel.kallsyms])               popq  %rbx
>    swapper     0 [000] 117276.429606186:  ffffffff81010650 pt_event_add ([kernel.kallsyms])               cmovnz %edx, %eax
>    swapper     0 [000] 117276.429606186:  ffffffff81010653 pt_event_add ([kernel.kallsyms])               jmp 0xffffffff81010635
>    swapper     0 [000] 117276.429606186:  ffffffff81010635 pt_event_add ([kernel.kallsyms])               retq
>    swapper     0 [000] 117276.429606186:  ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])            test %eax, %eax
> 
> Now
> 
> % perf record -e intel_pt// ...
> % perf script --insn-trace
> ... same output ...
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-script.txt |  4 ++++
>  tools/perf/builtin-script.c              | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index afdafe2110a1..04a57e0fb3a6 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -383,6 +383,10 @@ include::itrace.txt[]
>  	will be printed. Each entry has function name and file/line. Enabled by
>  	default, disable with --no-inline.
>  
> +--insn-trace::
> +	Show instruction stream for intel_pt traces. Requires installing the
> +	xed disassembler.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-script-perl[1],
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 910e0f1f2876..66daa7df68c5 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -44,6 +44,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> +#include <subcmd/pager.h>
>  
>  #include "sane_ctype.h"
>  
> @@ -3072,6 +3073,17 @@ static int perf_script__process_auxtrace_info(struct perf_tool *tool,
>  #define perf_script__process_auxtrace_info 0
>  #endif
>  
> +static int parse_insn_trace(const struct option *opt __maybe_unused,
> +			    const char *str __maybe_unused,
> +			    int unset __maybe_unused)
> +{
> +	parse_output_fields(NULL, "+insn,-event,-period", 0);
> +	itrace_parse_synth_opts(opt, "i0ns", 0);
> +	nanosecs = true;
> +	force_pager("xed -F insn: -A -64 | less");
> +	return 0;
> +}
> +
>  int cmd_script(int argc, const char **argv)
>  {
>  	bool show_full_info = false;
> @@ -3156,6 +3168,8 @@ int cmd_script(int argc, const char **argv)
>  		    "system-wide collection from all CPUs"),
>  	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
>  		   "only consider these symbols"),
> +	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
> +			"Decode instructions from itrace", parse_insn_trace),
>  	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
>  		   "Stop display of callgraph at these symbols"),
>  	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
> -- 
> 2.17.1
