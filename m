Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02595C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B71214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550114045;
	bh=k04O4vjaGA/r0SyvOwuQgVIhXJeH4zpezzed8hJNqFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=frn3ib8zkjdmIIvWxei7FpuwVzmJNG1PlLax787J/LXr6Jb/weAPmbezGu76P1GiU
	 KSkL2BUi3BKXh3HDq+NPZMBM4ek6jViLkrCYMCf2AWqF8jbG0N+lIKVOzWK4jru+9n
	 nVLlHH4b0ePL+4w5gMR2Qt6bDRmyNLATUyAb5O84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405351AbfBNDOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395314AbfBNDOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:14:02 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF714207E0;
        Thu, 14 Feb 2019 03:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550114042;
        bh=k04O4vjaGA/r0SyvOwuQgVIhXJeH4zpezzed8hJNqFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lhl7NisAwuE6ZZQO0vhEAerPFPuB/in1tPu41vJexvNfDeA5xoKL8AvFykmywCnXf
         aURarPkUp5qzEt7M+4JbOHkgq+PvRLlqy5R1lPOGsO3iaqYBAbZglNxvGYCDloANYs
         S6ImHUxpLBlcE3LBCTZik2NrPXVKJu7Mwu8MH2G8=
Date:   Thu, 14 Feb 2019 12:13:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] tracing: Use tracing error_log with kprobe
 events (incomplete)
Message-Id: <20190214121359.fff5e00e036fec5bfe39351e@kernel.org>
In-Reply-To: <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
        <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 13 Feb 2019 12:17:55 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Here are a few examples of replacing kprobe_events error handling with
> tracing_log_err() from the new tracing error_log mechanism.  Only a
> few example errors are converted, and even these are incomplete, since
> I didn't know where to get the current command and used a dummy string
> for those.  Also, these are completely untested, just provided for
> RFC purposes.

OK, can I take this over? I would like to try to use this framework.

> 
> With this change, users will find some kprobe_events errors in
> tracing/error_log instead of dmesg.

Yes, that is much better, especially for ftracetest.


Thank you,


> 
> TODO: If acceptable, convert all the rest of the kprobe errors and
> figure out how to get the actual cmd logged along with the error.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_probe.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9962cb5da8ac..3d7b195c943b 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -13,6 +13,22 @@
>  
>  #include "trace_probe.h"
>  
> +#define ERRORS								\
> +	C(NONE,			"No error"),				\
> +	C(INVALID_STRING_SPEC,	"string only accepts memory or address."), \
> +	C(ARG_TOO_LONG,		"Argument is too long."),		\
> +	C(INVALID_ARG_NAME,	"Invalid argument name"),
> +
> +#undef C
> +#define C(a, b)		KPROBE_ERR_##a
> +
> +enum { ERRORS };
> +
> +#undef C
> +#define C(a, b)		b
> +
> +static const char *err_text[] = { ERRORS };
> +
>  const char *reserved_field_names[] = {
>  	"common_type",
>  	"common_flags",
> @@ -384,7 +400,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  	int ret, len;
>  
>  	if (strlen(arg) > MAX_ARGSTR_LEN) {
> -		pr_info("Argument is too long.: %s\n",  arg);
> +		tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_ARG_TOO_LONG, err_pos("command", arg));
>  		return -ENOSPC;
>  	}
>  	parg->comm = kstrdup(arg, GFP_KERNEL);
> @@ -443,7 +459,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  	if (!strcmp(parg->type->name, "string")) {
>  		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
>  		    code->op != FETCH_OP_COMM) {
> -			pr_info("string only accepts memory or address.\n");
> +			tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_INVALID_STRING_SPEC, 0);
> +
>  			ret = -EINVAL;
>  			goto fail;
>  		}
> @@ -558,8 +575,7 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
>  		return -ENOMEM;
>  
>  	if (!is_good_name(parg->name)) {
> -		pr_info("Invalid argument[%d] name: %s\n",
> -			i, parg->name);
> +		tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_INVALID_ARG_NAME, err_pos("cmd", parg->name));
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
