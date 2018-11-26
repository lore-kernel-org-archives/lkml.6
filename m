Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE18C2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMSKhgD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeKZWYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeKZWYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:24:44 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5AD820672;
        Mon, 26 Nov 2018 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543231853;
        bh=iImUr/SIn/W8WDvBsMSJjCMq01vLTCXHkHSdmymneFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FMSKhgD8aCkN9LsWCOqqvRMTOyMuVGp5Ps4gWNvRLHoPus/lEEGE49UHGMx4DUZFF
         jyLE69s0KeqpmeOk+LRsGlNkU4rxqHj/pF2smjWhzHJrtR2j1/YsB8xpJ2g5pQ1ewr
         YQici+Zw8ognsWs+chmDWPxlf97EgQGYdeDtpFa4=
Date:   Mon, 26 Nov 2018 20:30:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 07/14] fgraph: Add new fgraph_ops structure to
 enable function graph hooks
Message-Id: <20181126203049.88df7c2cafed2b30a9d02bb9@kernel.org>
In-Reply-To: <20181122012803.576692300@goodmis.org>
References: <20181122012708.491151844@goodmis.org>
        <20181122012803.576692300@goodmis.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 20:27:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Currently the registering of function graph is to pass in a entry and return
> function. We need to have a way to associate those functions together where
> the entry can determine to run the return hook. Having a structure that
> contains both functions will facilitate the process of converting the code
> to be able to do such.
> 
> This is similar to the way function hooks are enabled (it passes in
> ftrace_ops). Instead of passing in the functions to use, a single structure
> is passed in to the registering function.
> 
> The unregister function is now passed in the fgraph_ops handle. When we
> allow more than one callback to the function graph hooks, this will let the
> system know which one to remove.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/ftrace.h               | 24 +++++++++++++++++-------
>  kernel/trace/fgraph.c                |  9 ++++-----
>  kernel/trace/ftrace.c                | 10 +++++++---
>  kernel/trace/trace_functions_graph.c | 21 ++++++++++++++++-----
>  kernel/trace/trace_irqsoff.c         | 10 +++++++---
>  kernel/trace/trace_sched_wakeup.c    | 10 +++++++---
>  kernel/trace/trace_selftest.c        |  8 ++++++--
>  7 files changed, 64 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index f98063e273e5..477ff9412d26 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -749,6 +749,18 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  
> +struct fgraph_ops {
> +	trace_func_graph_ent_t		entryfunc;
> +	trace_func_graph_ret_t		retfunc;

> +	struct fgraph_ops __rcu		*next;
> +	unsigned long			flags;
> +	void				*private;
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	struct ftrace_ops_hash		local_hash;
> +	struct ftrace_ops_hash		*func_hash;
> +#endif

Hmm, can we introduce these fields when we actually use it?

BTW, would you have any idea for using private field?

Thank you,




-- 
Masami Hiramatsu <mhiramat@kernel.org>
