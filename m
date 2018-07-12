Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDFECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2283F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2283F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbeGLWBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeGLWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:01:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC6C2087C;
        Thu, 12 Jul 2018 21:49:54 +0000 (UTC)
Date:   Thu, 12 Jul 2018 17:49:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Francis Deslauriers <francis.deslauriers@efficios.com>
Cc:     mhiramat@kernel.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: kprobes: Prohibit probing on notrace
 functions
Message-ID: <20180712174952.0262b49d@gandalf.local.home>
In-Reply-To: <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 13:54:12 -0400
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Prohibit kprobe-events probing on notrace function.
> Since probing on the notrace function can cause recursive
> event call. In most case those are just skipped, but
> in some case it falls into infinite recursive call.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>

BTW, since you are sending the patch, you must also put in your
Signed-off-by too, after Masami's. You can keep the Tested-by.

-- Steve

> ---
>  kernel/trace/trace_kprobe.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index daa8157..952dc2a 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -487,6 +487,23 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +static bool within_notrace_func(struct trace_kprobe *tk)
> +{
> +	unsigned long offset, size, addr;
> +
> +	addr = kallsyms_lookup_name(trace_kprobe_symbol(tk));
> +	addr += trace_kprobe_offset(tk);
> +
> +	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
> +		return true;	/* Out of range. */
> +
> +	return !ftrace_location_range(addr - offset, addr - offset + size);
> +}
> +#else
> +#define within_notrace_func(tk)	(false)
> +#endif
> +
>  /* Internal register function - just handle k*probes and flags */
>  static int __register_trace_kprobe(struct trace_kprobe *tk)
>  {
> @@ -495,6 +512,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
>  	if (trace_probe_is_registered(&tk->tp))
>  		return -EINVAL;
>  
> +	if (within_notrace_func(tk)) {
> +		pr_warn("Could not probe notrace function %s\n",
> +			trace_kprobe_symbol(tk));
> +		return -EINVAL;
> +	}
> +
>  	for (i = 0; i < tk->tp.nr_args; i++)
>  		traceprobe_update_arg(&tk->tp.args[i]);
>  

