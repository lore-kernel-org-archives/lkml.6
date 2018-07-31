Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E5208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghb43A+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E5208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeGaCmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeGaCmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:42:17 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFCD208A3;
        Tue, 31 Jul 2018 01:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532999077;
        bh=OKWfWmoPIayyKU274y4KG2NRcBpLKJkkuqZ5dpaPH7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ghb43A+zq5iF6rs0VD536+bRJzt+vREe8pHU+9ADvaJoaiHwo4odCJHLa4tE/moBN
         HMgfIx7/XX5CJgcOUQyl5B8qIdeg/svPwr6fY57s1xOCZZEZdY3SI7DwpXZkg+nYji
         GFzLj50JLLxjVnPfKn9VtonYdBLE6JtI/nyINN7Y=
Date:   Tue, 31 Jul 2018 10:04:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] tracing: kprobes: Prohibit probing on notrace
 function
Message-Id: <20180731100434.3a867bde77575c993c19c7fe@kernel.org>
In-Reply-To: <20180730184010.0d5597a1@gandalf.local.home>
References: <153294598465.32740.17737878083872427008.stgit@devbox>
        <153294601436.32740.10557881188933661239.stgit@devbox>
        <20180730184010.0d5597a1@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 18:40:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Jul 2018 19:20:14 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Prohibit kprobe-events probing on notrace function.
> > Since probing on the notrace function can cause recursive
> > event call. In most case those are just skipped, but
> > in some case it falls into infinit recursive call.
> > 
> > This protection can be disabled by the kconfig
> > CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly
> > recommended to keep it "n" for normal kernel.
> > Note that this is only available if "kprobes on ftrace"
> > has been implemented on target arch and
> > CONFIG_KPROBES_ON_FTRACE=y.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> 
> Hi Masami,
> 
> Note, I made the following changes for grammar. For the Change log I
> have this:
> 
>     tracing: kprobes: Prohibit probing on notrace function
>     
>     Prohibit kprobe-events probing on notrace functions.  Since probing on a
>     notrace function can cause a recursive event call. In most cases those are just
>     skipped, but in some cases it falls into an infinite recursive call.
>     
>     This protection can be disabled by the kconfig
>     CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly recommended to keep it
>     "n" for normal kernel builds.  Note that this is only available if "kprobes on
>     ftrace" has been implemented on the target arch and CONFIG_KPROBES_ON_FTRACE=y.
>     
>     Link: http://lkml.kernel.org/r/153294601436.32740.10557881188933661239.stgit@devbox
>     
>     Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>     Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
>     [ Slight grammar and spelling fixes ]
>     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks good to me.
Thanks for fixing it! :)

> 
> 
> And this change to the patch:
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 4d4eb15cc7fd..23fc7c9abedb 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -457,7 +457,7 @@ config KPROBE_EVENTS
>  	  If you want to use perf tools, this option is strongly recommended.
>  
>  config KPROBE_EVENTS_ON_NOTRACE
> -	bool "Do NOT protect notrace function from kprobe events"
> +	bool "Do NOT protect notrace functions from kprobe events"
>  	depends on KPROBE_EVENTS
>  	depends on KPROBES_ON_FTRACE
>  	default n
> @@ -465,13 +465,13 @@ config KPROBE_EVENTS_ON_NOTRACE
>  	  This is only for the developers who want to debug ftrace itself
>  	  using kprobe events.
>  
> -	  If kprobes can use ftrace instead of breakpoint, ftrace related
> -	  functions are protected from kprobe-events to prevent an infinit
> -	  recursion or any unexpected execution path which leads to a kernel
> -	  crash.
> +	  If kprobes is using ftrace to hook to a function instead of a
> +	  breakpoint, ftrace related functions are protected from
> +	  kprobe-events to prevent an infinite recursion or any unexpected
> +	  execution path which would lead to a kernel crash.
>  
>  	  This option disables such protection and allows you to put kprobe
> -	  events on ftrace functions for debugging ftrace by itself.
> +	  events on ftrace functions for debugging ftrace itself.
>  	  Note that this might let you shoot yourself in the foot.
>  
>  	  If unsure, say N.
> 
> 
> Are you OK with this?
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
