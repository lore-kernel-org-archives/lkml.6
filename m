Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B920672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ocMuEycv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69B920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501927AbeKWNmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:42:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36994 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393000AbeKWNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:42:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so2437804pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 18:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wl3342N9sJb6az68nzZEct4OmKXInJjpFEHqKdC8Kck=;
        b=ocMuEycv1O4Y8TTvxuBoutksamJieAh1q7FeWhhfz5qXftxTJ9iqU3gHF0fDN7qCX8
         OnDGWHmzFQJeb/HSOlpeKopgKy+J3jFrebgTEfJ8riB5BW6H24tEuLYA+db3uyiNJevS
         kHWaecaK9gGiN2TZapnuALeWhWF6v14FdjEyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wl3342N9sJb6az68nzZEct4OmKXInJjpFEHqKdC8Kck=;
        b=tk1Gr0qhLXPMKn4/xc+V/k+VJlzHJjKU9j/8aZGE92Kl5nIYT86qdd9JEDUyNLxkdy
         0LdLE3rDRCiEtJ1oad+5WB/bi00fOJtQbEY37941H1tpegnWDmJ8tmMnCslZR3Fioo8K
         eUtccbKUHPHSiTa4o96bPXvRXMaiu1liBEtlMgrkydlEDaL4mACgf57nBT6WBb5WGP+W
         I0Paokjo8DDTFhsaNr7msQIPfJXNf8Cwd8y4s9rHdWFzVMRT28nSYAyaVNHVT2mMylV7
         ua4jsPdH93deefgDn/y+eRhmmnb+PSsPtnfzLYrYCs52FciozXxEPw2qq7NDdfOvoRIZ
         yq4Q==
X-Gm-Message-State: AGRZ1gKMJJ0nOIslSp3Vn74P4XXZZGbGNpGPsXBGMRUTNUS9HFA4vQ9v
        nIGpXrjimwh9IHjIQjEnIVrx+Q==
X-Google-Smtp-Source: AJdET5f8JZqA44I0lTY7+Qx2CmstVFOV+VvfnASIGHhpCp7PviFv4I4J/F0deqya696/fRvHTc/LIQ==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr14074666pfd.246.1542941988545;
        Thu, 22 Nov 2018 18:59:48 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id y1sm16212134pfe.9.2018.11.22.18.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 18:59:47 -0800 (PST)
Date:   Thu, 22 Nov 2018 18:59:46 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 07/14] fgraph: Add new fgraph_ops structure to
 enable function graph hooks
Message-ID: <20181123025946.GB17060@google.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012803.576692300@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122012803.576692300@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:27:15PM -0500, Steven Rostedt wrote:
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
> +};
> +
>  /*
>   * Stack of return addresses for functions
>   * of a thread.
> @@ -792,8 +804,9 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  
>  #define FTRACE_RETFUNC_DEPTH 50
>  #define FTRACE_RETSTACK_ALLOC_SIZE 32
> -extern int register_ftrace_graph(trace_func_graph_ret_t retfunc,
> -				trace_func_graph_ent_t entryfunc);
> +
> +extern int register_ftrace_graph(struct fgraph_ops *ops);
> +extern void unregister_ftrace_graph(struct fgraph_ops *ops);
>  
>  extern bool ftrace_graph_is_dead(void);
>  extern void ftrace_graph_stop(void);
> @@ -802,8 +815,6 @@ extern void ftrace_graph_stop(void);
>  extern trace_func_graph_ret_t ftrace_graph_return;
>  extern trace_func_graph_ent_t ftrace_graph_entry;
>  
> -extern void unregister_ftrace_graph(void);
> -
>  extern void ftrace_graph_init_task(struct task_struct *t);
>  extern void ftrace_graph_exit_task(struct task_struct *t);
>  extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
> @@ -830,12 +841,11 @@ static inline void ftrace_graph_init_task(struct task_struct *t) { }
>  static inline void ftrace_graph_exit_task(struct task_struct *t) { }
>  static inline void ftrace_graph_init_idle_task(struct task_struct *t, int cpu) { }
>  
> -static inline int register_ftrace_graph(trace_func_graph_ret_t retfunc,
> -			  trace_func_graph_ent_t entryfunc)
> +static inline int register_ftrace_graph(struct fgraph_ops *ops);
>  {
>  	return -1;
>  }
> -static inline void unregister_ftrace_graph(void) { }
> +static inline void unregister_ftrace_graph(struct fgraph_ops *ops) { }
>  
>  static inline int task_curr_ret_stack(struct task_struct *tsk)
>  {
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index b9c7dbbbdd96..f3a89ecac671 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -491,8 +491,7 @@ static int start_graph_tracing(void)
>  	return ret;
>  }
>  
> -int register_ftrace_graph(trace_func_graph_ret_t retfunc,
> -			trace_func_graph_ent_t entryfunc)
> +int register_ftrace_graph(struct fgraph_ops *gops)
>  {
>  	int ret = 0;
>  
> @@ -513,7 +512,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
>  		goto out;
>  	}
>  
> -	ftrace_graph_return = retfunc;
> +	ftrace_graph_return = gops->retfunc;
>  
>  	/*
>  	 * Update the indirect function to the entryfunc, and the
> @@ -521,7 +520,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
>  	 * call the update fgraph entry function to determine if
>  	 * the entryfunc should be called directly or not.
>  	 */
> -	__ftrace_graph_entry = entryfunc;
> +	__ftrace_graph_entry = gops->entryfunc;
>  	ftrace_graph_entry = ftrace_graph_entry_test;
>  	update_function_graph_func();
>  
> @@ -531,7 +530,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
>  	return ret;
>  }
>  
> -void unregister_ftrace_graph(void)
> +void unregister_ftrace_graph(struct fgraph_ops *gops)
>  {
>  	mutex_lock(&ftrace_lock);
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 64e635994648..d057dde081e7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -849,15 +849,19 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
>  	local_irq_restore(flags);
>  }
>  
> +static struct fgraph_ops fprofiler_ops = {
> +	.entryfunc = &profile_graph_entry,
> +	.retfunc = &profile_graph_return,
> +};
> +
>  static int register_ftrace_profiler(void)
>  {
> -	return register_ftrace_graph(&profile_graph_return,
> -				     &profile_graph_entry);
> +	return register_ftrace_graph(&fprofiler_ops);
>  }
>  
>  static void unregister_ftrace_profiler(void)
>  {
> -	unregister_ftrace_graph();
> +	unregister_ftrace_graph(&fprofiler_ops);
>  }
>  #else
>  static struct ftrace_ops ftrace_profile_ops __read_mostly = {
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 0e0ff08357cf..7c7fd13d2373 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -336,17 +336,25 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
>  		trace_graph_return(trace);
>  }
>  
> +static struct fgraph_ops funcgraph_threash_ops = {

minor nit: should be funcgraph_thresh_ops ?

thanks,

 - Joel

