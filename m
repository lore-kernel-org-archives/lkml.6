Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeCURZl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:25:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34972 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeCURZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:25:36 -0400
X-Google-Smtp-Source: AG47ELtLz+BmTBtaSker4HuM9itQ7+xSjqqT25ehAXavPQywDXCepXYrowAPBMcX2JfbiCAytM6xEw==
Subject: Re: [PATCH 1/2] bpf: Remove struct bpf_verifier_env argument from
 print_bpf_insn
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180321150212.5586-1-jolsa@kernel.org>
From: Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <d28f0a7f-3721-88f3-f4e9-97a73a8833e5@netronome.com>
Date: Wed, 21 Mar 2018 17:25:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321150212.5586-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-21 16:02 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
> We use print_bpf_insn in user space (bpftool and soon perf),
> so it'd be nice to keep it generic and strip it off the kernel
> struct bpf_verifier_env argument.
> 
> This argument can be safely removed, because its users can
> use the struct bpf_insn_cbs::private_data to pass it.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/disasm.c   | 52 +++++++++++++++++++++++++--------------------------
>  kernel/bpf/disasm.h   |  5 +----
>  kernel/bpf/verifier.c |  6 +++---
>  3 files changed, 30 insertions(+), 33 deletions(-)
> 

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c6eff108aa99..9f27d3fa7259 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -202,8 +202,7 @@ EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
>   * generic for symbol export. The function was renamed, but not the calls in
>   * the verifier to avoid complicating backports. Hence the alias below.
>   */
> -static __printf(2, 3) void verbose(struct bpf_verifier_env *env,
> -				   const char *fmt, ...)
> +static __printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
>  	__attribute__((alias("bpf_verifier_log_write")));

Just as a note, verbose() will be aliased to a function whose prototype
differs (bpf_verifier_log_write() still expects a struct
bpf_verifier_env as its first argument). I am not so familiar with
function aliases, could this change be a concern?

Other than this the patch seems good to me.
Quentin

>  
>  static bool type_is_pkt_pointer(enum bpf_reg_type type)
> @@ -4601,10 +4600,11 @@ static int do_check(struct bpf_verifier_env *env)
>  		if (env->log.level) {
>  			const struct bpf_insn_cbs cbs = {
>  				.cb_print	= verbose,
> +				.private_data	= env,
>  			};
>  
>  			verbose(env, "%d: ", insn_idx);
> -			print_bpf_insn(&cbs, env, insn, env->allow_ptr_leaks);
> +			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
>  		}
>  
>  		if (bpf_prog_is_dev_bound(env->prog->aux)) {
> 
