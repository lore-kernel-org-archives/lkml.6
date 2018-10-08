Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJNrdR48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJIBQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIBQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:16:13 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DFF72064E;
        Mon,  8 Oct 2018 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539021798;
        bh=pJZJbx4ZP3sHSgszWqdMuOKOCk8y48TBX9oimX1yCxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJNrdR482OCHF2CE2T/Hwy6GHohbmLU3rDsEptkpryjrChR5ivEceriqHomI0DztD
         iWYvrwKP83tcilcvzV3o3H/5XYMnZ3iF+QNCXyOuvl+0Xl5WBItKw3DX4/5ekaVvbE
         +ZwLBEJAxqz4cDohEITRaMORnjAVK0Dr6RjssUfQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A8FE6141DDC; Mon,  8 Oct 2018 15:03:14 -0300 (-03)
Date:   Mon, 8 Oct 2018 15:03:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 1/5] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20181008180314.GT3541@kernel.org>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920180540.14039-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 20, 2018 at 11:05:36AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a --insn-trace short hand option for decoding and disassembling
> instruction streams for intel_pt. This automatically pipes the
> output into the xed disassembler to generate disassembled instructions.
> This just makes this use model much nicer to use
> 
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
> % perf script --insn-trace --xed
> ... same output ...
> 
> XED needs to be installed with:
> 
> > git clone https://github.com/intelxed/mbuild.git mbuild
> > git clone https://github.com/intelxed/xed
> > cd xed
> > mkdir obj
> > cd obj
> > ../mfile.py
> > sudo ../mfile.py --prefix=/usr/local install

I tried following these instructions, but in the end these are the only
files installed in /usr/local:

[acme@jouet obj]$ find /usr/local -name "*xed*"
/usr/local/include/xed
/usr/local/include/xed/xed-reg-class.h
/usr/local/include/xed/xed-reg-role-enum.h
/usr/local/include/xed/xed-format-options.h
/usr/local/include/xed/xed-encoder-hl.h
/usr/local/include/xed/xed-ild.h
/usr/local/include/xed/xed-encode.h
/usr/local/include/xed/xed-immed.h
/usr/local/include/xed/xed-init-pointer-names.h
/usr/local/include/xed/xed-operand-accessors.h
/usr/local/include/xed/xed-operand-enum.h
/usr/local/include/xed/xed-flags.h
/usr/local/include/xed/xed-operand-action.h
/usr/local/include/xed/xed-print-info.h
/usr/local/include/xed/xed-chip-features.h
/usr/local/include/xed/xed-types.h
/usr/local/include/xed/xed-common-hdrs.h
/usr/local/include/xed/xed-decoded-inst-api.h
/usr/local/include/xed/xed-inst.h
/usr/local/include/xed/xed-address-width-enum.h
/usr/local/include/xed/xed-state.h
/usr/local/include/xed/xed-decoded-inst.h
/usr/local/include/xed/xed-isa-set.h
/usr/local/include/xed/xed-reg-enum.h
/usr/local/include/xed/xed-attribute-enum.h
/usr/local/include/xed/xed-operand-ctype-enum.h
/usr/local/include/xed/xed-extension-enum.h
/usr/local/include/xed/xed-iformfl-enum.h
/usr/local/include/xed/xed-convert-table-init.h
/usr/local/include/xed/xed-immdis.h
/usr/local/include/xed/xed-iclass-enum.h
/usr/local/include/xed/xed-flag-enum.h
/usr/local/include/xed/xed-get-time.h
/usr/local/include/xed/xed-attributes.h
/usr/local/include/xed/xed-init.h
/usr/local/include/xed/xed-operand-storage.h
/usr/local/include/xed/xed-operand-width-enum.h
/usr/local/include/xed/xed-operand-ctype-map.h
/usr/local/include/xed/xed-error-enum.h
/usr/local/include/xed/xed-operand-values-interface.h
/usr/local/include/xed/xed-operand-convert-enum.h
/usr/local/include/xed/xed-chip-enum.h
/usr/local/include/xed/xed-cpuid-bit-enum.h
/usr/local/include/xed/xed-iform-enum.h
/usr/local/include/xed/xed-decode.h
/usr/local/include/xed/xed-flag-action-enum.h
/usr/local/include/xed/xed-rep-prefix.h
/usr/local/include/xed/xed-patch.h
/usr/local/include/xed/xed-util.h
/usr/local/include/xed/xed-cpuid-rec.h
/usr/local/include/xed/xed-iform-map.h
/usr/local/include/xed/xed-category-enum.h
/usr/local/include/xed/xed-machine-mode-enum.h
/usr/local/include/xed/xed-syntax-enum.h
/usr/local/include/xed/xed-isa-set-enum.h
/usr/local/include/xed/xed-disas.h
/usr/local/include/xed/xed-operand-type-enum.h
/usr/local/include/xed/xed-portability.h
/usr/local/include/xed/xed-exception-enum.h
/usr/local/include/xed/xed-version.h
/usr/local/include/xed/xed-operand-element-xtype-enum.h
/usr/local/include/xed/xed-build-defines.h
/usr/local/include/xed/xed-common-defs.h
/usr/local/include/xed/xed-gen-table-defs.h
/usr/local/include/xed/xed-operand-element-type-enum.h
/usr/local/include/xed/xed-nonterminal-enum.h
/usr/local/include/xed/xed-encoder-gen-defs.h
/usr/local/include/xed/xed-agen.h
/usr/local/include/xed/xed-interface.h
/usr/local/include/xed/xed-encoder-iforms.h
/usr/local/include/xed/xed-operand-visibility-enum.h
/usr/local/include/xed/xed-operand-action-enum.h
/usr/local/include/xed/xed-reg-class-enum.h
/usr/local/include/llvm/MC/MCFixedLenDisassembler.h
/usr/local/include/llvm/ADT/IndexedMap.h
/usr/local/include/clang/Basic/FixedPoint.h
/usr/local/lib/libxed.a
/usr/local/lib/libxed-ild.a
[acme@jouet obj]$

I have /usr/local/bin in my PATH and:

[acme@jouet perf]$ perf script --xed -i /home/acme/perf.data.intel_pt
sh: xed: command not found
[acme@jouet perf]$

What am I missing?

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> --
> 
> v2: Add separate --xed option
> v3: Add xed build documentation and update commit
> ---
>  tools/perf/Documentation/build-xed.txt   | 11 +++++++++++
>  tools/perf/Documentation/perf-script.txt |  7 +++++++
>  tools/perf/builtin-script.c              | 23 +++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 tools/perf/Documentation/build-xed.txt
> 
> diff --git a/tools/perf/Documentation/build-xed.txt b/tools/perf/Documentation/build-xed.txt
> new file mode 100644
> index 000000000000..8da3028e6dca
> --- /dev/null
> +++ b/tools/perf/Documentation/build-xed.txt
> @@ -0,0 +1,11 @@
> +
> +For --xed the xed tool is needed. Here is how to install it:
> +
> +> git clone https://github.com/intelxed/mbuild.git mbuild                                                                                        
> +> git clone https://github.com/intelxed/xed                                                                                                      
> +> cd xed                                                                                                                                         
> +> mkdir obj                                                                                                                                      
> +> cd obj                                                                                                                                         
> +> ../mfile.py                                                                                                                                    
> +> sudo ../mfile.py --prefix=/usr/local install    
> +
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index afdafe2110a1..00c655ab4968 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -383,6 +383,13 @@ include::itrace.txt[]
>  	will be printed. Each entry has function name and file/line. Enabled by
>  	default, disable with --no-inline.
>  
> +--insn-trace::
> +	Show instruction stream for intel_pt traces. Combine with --xed to
> +	show disassembly.
> +
> +--xed::
> +	Run xed disassembler on output. Requires installing the xed disassembler.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-script-perl[1],
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4da5e32b9e03..311f5b53dd83 100644
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
> @@ -3100,6 +3101,24 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
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
> +	return 0;
> +}
> +
> +static int parse_xed(const struct option *opt __maybe_unused,
> +		     const char *str __maybe_unused,
> +		     int unset __maybe_unused)
> +{
> +	force_pager("xed -F insn: -A -64 | less");
> +	return 0;
> +}
> +
>  int cmd_script(int argc, const char **argv)
>  {
>  	bool show_full_info = false;
> @@ -3184,6 +3203,10 @@ int cmd_script(int argc, const char **argv)
>  		    "system-wide collection from all CPUs"),
>  	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
>  		   "only consider these symbols"),
> +	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
> +			"Decode instructions from itrace", parse_insn_trace),
> +	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
> +			"Run xed disassembler on output", parse_xed),
>  	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
>  		   "Stop display of callgraph at these symbols"),
>  	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
> -- 
> 2.17.1
