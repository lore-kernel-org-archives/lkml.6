Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeCUQjT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:39:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32857 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeCUQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:39:12 -0400
X-Google-Smtp-Source: AG47ELs7t39ac7Oe6F1vQZIQJXCKE/dmr8CaLLru+OrJJbVDF/nQUMtEriMCj8kb7ikF2JqhfpWBsw==
Subject: Re: [PATCH 2/2] bpftool: Adjust to new print_bpf_insn interface
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180321150212.5586-1-jolsa@kernel.org>
 <20180321150212.5586-2-jolsa@kernel.org>
From: Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <c27c5c1c-79ee-3ed2-d1c3-a011ead4edea@netronome.com>
Date: Wed, 21 Mar 2018 16:39:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321150212.5586-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-21 16:02 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
> Change bpftool to skip the removed struct bpf_verifier_env
> argument in print_bpf_insn. It was passed as NULL anyway.
> 
> No functional change intended.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/prog.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index e549e329be82..108001d974ee 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -489,7 +489,7 @@ static struct kernel_sym *kernel_syms_search(struct dump_data *dd,
>  		       sizeof(*dd->sym_mapping), kernel_syms_cmp) : NULL;
>  }
>  
> -static void print_insn(struct bpf_verifier_env *env, const char *fmt, ...)
> +static void print_insn(void *private_data, const char *fmt, ...)
>  {
>  	va_list args;
>  
> @@ -576,7 +576,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
>  		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
>  
>  		printf("% 4d: ", i);
> -		print_bpf_insn(&cbs, NULL, insn + i, true);
> +		print_bpf_insn(&cbs, insn + i, true);
>  
>  		if (opcodes) {
>  			printf("       ");
> @@ -590,7 +590,7 @@ static void dump_xlated_plain(struct dump_data *dd, void *buf,
>  	}
>  }
>  
> -static void print_insn_json(struct bpf_verifier_env *env, const char *fmt, ...)
> +static void print_insn_json(void *private_data, const char *fmt, ...)
>  {
>  	unsigned int l = strlen(fmt);
>  	char chomped_fmt[l];
> @@ -628,7 +628,7 @@ static void dump_xlated_json(struct dump_data *dd, void *buf,
>  
>  		jsonw_start_object(json_wtr);
>  		jsonw_name(json_wtr, "disasm");
> -		print_bpf_insn(&cbs, NULL, insn + i, true);
> +		print_bpf_insn(&cbs, insn + i, true);
>  
>  		if (opcodes) {
>  			jsonw_name(json_wtr, "opcodes");
> 

Hi Jiri, this code has changed in the tree. It was moved to
tools/bpf/bpftool/xlated_dumper.c, and there is now a third function to
update: print_insn_for_graph(). Could you please rebase the patch?

Quentin
