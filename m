Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAECC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD4320866
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD4320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441044AbeKXEny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbeKXEny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:43:54 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C7120863;
        Fri, 23 Nov 2018 17:58:36 +0000 (UTC)
Date:   Fri, 23 Nov 2018 12:58:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 06/14] fgraph: Move function graph specific code
 into fgraph.c
Message-ID: <20181123125834.1ddc367e@vmware.local.home>
In-Reply-To: <20181123061133.GA195223@google.com>
References: <20181122012708.491151844@goodmis.org>
        <20181122012803.442190047@goodmis.org>
        <20181123061133.GA195223@google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 22:11:33 -0800
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Nov 21, 2018 at 08:27:14PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > To make the function graph infrastructure more managable, the code needs to
> > be in its own file (fgraph.c). Move the code that is specific for managing
> > the function graph infrastructure out of ftrace.c and into fgraph.c
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> I think this patch causes a build error if CONFIG_FUNCTION_PROFILER is
> disabled but function graph is enabled. The following diff fixes it for me.

Thanks for reporting this.

> 
> thanks,
> 
>  - Joel
> 
>  ----8<------
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 3b8c307c7ff0..ce38bb962f91 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -382,6 +382,15 @@ static void ftrace_update_pid_func(void)
>  	update_ftrace_function();
>  }
>  
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +static bool fgraph_graph_time = true;
> +
> +void ftrace_graph_graph_time_control(bool enable)
> +{
> +	fgraph_graph_time = enable;
> +}
> +#endif
> +

I think the better answer is to move it into trace_functions_graph.c.

I'll do that and give you the "reported-by".

-- Steve


>  #ifdef CONFIG_FUNCTION_PROFILER
>  struct ftrace_profile {
>  	struct hlist_node		node;
> @@ -783,12 +792,6 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
>  }
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -static bool fgraph_graph_time = true;
> -
> -void ftrace_graph_graph_time_control(bool enable)
> -{
> -	fgraph_graph_time = enable;
> -}
>  
>  static int profile_graph_entry(struct ftrace_graph_ent *trace)
>  {

