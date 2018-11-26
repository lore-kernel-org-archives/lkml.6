Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D615220855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh2iNHkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeKZSSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeKZSSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:18:23 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1615C2082F;
        Mon, 26 Nov 2018 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543217110;
        bh=GWEBpZjVeXmJBonohJuqsClJV8am9rTVd0fhz7F4FQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bh2iNHkPOoVhGdAeI8Pclx8S3uYC4+TlLZSxGQfYk6v92EGVoanZwlxg0ctd3idHa
         5iwHm1l7NABv5WI5QZ9fVFQon3IepR/v+OX1dVt+z7Ok7bPubeVZ1wte4xxeGapnEx
         9hecqCJjZA5Bg4p39Ccz4TowdkrsWvFu35zmJhfU=
Date:   Mon, 26 Nov 2018 16:25:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
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
Message-Id: <20181126162506.0b82ab1e8fb7a3dd573eb221@kernel.org>
In-Reply-To: <20181123061133.GA195223@google.com>
References: <20181122012708.491151844@goodmis.org>
        <20181122012803.442190047@goodmis.org>
        <20181123061133.GA195223@google.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

Good catch, I also confirmed it.

I think we'd better to define an empty stub of ftrace_graph_graph_time_control(enable)
in trace.h instead, since fgraph_graph_time is not used if CONFIG_FUNCTION_PROFILER=n.

Thank you,

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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
