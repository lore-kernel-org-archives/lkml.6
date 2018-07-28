Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6015AC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CB020873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv2AUupQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CB020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbeG1CY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388893AbeG1CY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:24:28 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE03820862;
        Sat, 28 Jul 2018 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532739603;
        bh=HhFDc99xV1suOHxfCBdVpw9Upq23GzaojyuCVJFiG0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rv2AUupQBNKIryZ6CJct2uphPOeHwz43ocTQ9E6SosjX4vAMn/Geh/BWZdoSk70jI
         7Hp1UN1CtBUHojss0qMpsrheuOxUtRPpOY9NoPU0HUj4KeiFmhb76iuYoIcokCED5n
         tEXhCwQu4Z5I+hiRz6zVPYbp7LSaIUqtjsUSi0BY=
Date:   Sat, 28 Jul 2018 10:00:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: kprobes: Prohibit probing on notrace
 function
Message-Id: <20180728100000.6861740643d5a293824d7de1@kernel.org>
In-Reply-To: <153258440707.11602.3706182300882155086.stgit@devbox>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258440707.11602.3706182300882155086.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 14:53:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Prohibit kprobe-events probing on notrace function.
> Since probing on the notrace function can cause recursive
> event call. In most case those are just skipped, but
> in some case it falls into infinit recursive call.
> 
> This protection can be disabled by the kconfig
> CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly
> recommended to keep it "n" for normal kernel.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> ---
>   Changes from v1
>    - Add CONFIG_KPROBE_EVENTS_ON_NOTRACE kconfig for knocking down
>      the protection.
> ---
>  kernel/trace/Kconfig        |   18 ++++++++++++++++++
>  kernel/trace/trace_kprobe.c |   23 +++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index dcc0166d1997..24d5a58467a3 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -456,6 +456,24 @@ config KPROBE_EVENTS
>  	  This option is also required by perf-probe subcommand of perf tools.
>  	  If you want to use perf tools, this option is strongly recommended.
>  
> +config KPROBE_EVENTS_ON_NOTRACE
> +	bool "Do NOT protect notrace function from kprobe events"
> +	depends on KPROBE_EVENTS
> +	default n
> +	help
> +	  This is only for the developers who want to debug ftrace itself
> +	  using kprobe events.
> +
> +	  Usually, ftrace related functions are protected from kprobe-events
> +	  to prevent an infinit recursion or any unexpected execution path
> +	  which leads to a kernel crash.
> +
> +	  This option disables such protection and allows you to put kprobe
> +	  events on ftrace functions for debugging ftrace by itself.
> +	  Note that this might let you shoot yourself in the foot.
> +
> +	  If unsure, say N.
> +
>  config UPROBE_EVENTS
>  	bool "Enable uprobes-based dynamic events"
>  	depends on ARCH_SUPPORTS_UPROBES
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 27ace4513c43..1f1b4d712a7e 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -496,6 +496,23 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_KPROBE_EVENTS_ON_NOTRACE
> +#define within_notrace_func(tk)	(false)
> +#else
> +static bool within_notrace_func(struct trace_kprobe *tk)
> +{
> +	unsigned long offset, size, addr;
> +
> +	addr = kallsyms_lookup_name(trace_kprobe_symbol(tk));

Oops, I found this is wrong. (Thanks for old myself :P)
As ftracetest probepoint.tc said, kprobe-events can be
defined without symbol (direct address) for debugging.
In that case trace_kprobe_symbol will not return the symbol string.
I'll fix this series again.

Thank you,

> +	addr += trace_kprobe_offset(tk);
> +
> +	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
> +		return true;	/* Out of range. */
> +
> +	return !ftrace_location_range(addr - offset, addr - offset + size);
> +}
> +#endif
> +
>  /* Internal register function - just handle k*probes and flags */
>  static int __register_trace_kprobe(struct trace_kprobe *tk)
>  {
> @@ -504,6 +521,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
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
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
