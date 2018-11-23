Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC857C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53EE20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53EE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407895AbeKWKnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:43:12 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:41289 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbeKWKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:43:12 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 23 Nov 2018 09:01:19 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 23 Nov 2018 09:01:19 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 23 Nov 2018 09:01:18 +0900
From:   Namhyung Kim <namhyung@kernel.org>
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
        Mark Rutland <mark.rutland@arm.com>, kernel-team@lge.com
Subject: Re: [RFC][PATCH 02/14] fgraph: Have set_graph_notrace only affect
 function_graph tracer
Message-ID: <20181123000118.GB25952@sejong>
References: <20181122012708.491151844@goodmis.org>
 <20181122012802.894046175@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122012802.894046175@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Nov 21, 2018 at 08:27:10PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In order to make the function graph infrastructure more generic, there can
> not be code specific for the function_graph tracer in the generic code. This
> includes the set_graph_notrace logic, that stops all graph calls when a
> function in the set_graph_notrace is hit.
> 
> By using the trace_recursion mask, we can use a bit in the current
> task_struct to implement the notrace code, and move the logic out of
> fgraph.c and into trace_functions_graph.c and keeps it affecting only the
> tracer and not all call graph callbacks.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  kernel/trace/fgraph.c                | 21 ---------------------
>  kernel/trace/trace.h                 |  6 ++++++
>  kernel/trace/trace_functions_graph.c | 21 +++++++++++++++++++++
>  3 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index e8fcf1b2b38c..c684968b87e7 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -64,30 +64,9 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * The curr_ret_stack is an index to ftrace return stack of
> -	 * current task.  Its value should be in [0, FTRACE_RETFUNC_
> -	 * DEPTH) when the function graph tracer is used.  To support
> -	 * filtering out specific functions, it makes the index
> -	 * negative by subtracting huge value (FTRACE_NOTRACE_DEPTH)
> -	 * so when it sees a negative index the ftrace will ignore
> -	 * the record.  And the index gets recovered when returning
> -	 * from the filtered function by adding the FTRACE_NOTRACE_
> -	 * DEPTH and then it'll continue to record functions normally.
> -	 *
> -	 * The curr_ret_stack is initialized to -1 and get increased
> -	 * in this function.  So it can be less than -1 only if it was
> -	 * filtered out via ftrace_graph_notrace_addr() which can be
> -	 * set from set_graph_notrace file in tracefs by user.
> -	 */
> -	if (current->curr_ret_stack < -1)
> -		return -EBUSY;
> -
>  	calltime = trace_clock_local();
>  
>  	index = ++current->curr_ret_stack;
> -	if (ftrace_graph_notrace_addr(func))
> -		current->curr_ret_stack -= FTRACE_NOTRACE_DEPTH;
>  	barrier();
>  	current->ret_stack[index].ret = ret;
>  	current->ret_stack[index].func = func;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 3b8c0e24ab30..f3ad85830961 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -512,6 +512,12 @@ enum {
>   * can only be modified by current, we can reuse trace_recursion.
>   */
>  	TRACE_IRQ_BIT,
> +/*
> + * To implement set_graph_notrace, if this bit is set, we ignore
> + * function graph tracing of called functions, until the return
> + * function is called to clear it.
> + */
> +	TRACE_GRAPH_NOTRACE_BIT,
>  };
>  
>  #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index af1759cd6eab..4748dc1bf5e1 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -188,6 +188,18 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
>  	int cpu;
>  	int pc;
>  
> +	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
> +		return 0;
> +
> +	if (ftrace_graph_notrace_addr(trace->func)) {
> +		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
> +		/*
> +		 * Need to return 1 to have the return called
> +		 * that will clear the NOTRACE bit.
> +		 */
> +		return 1;
> +	}
> +
>  	if (!ftrace_trace_task(tr))
>  		return 0;
>  
> @@ -288,6 +300,11 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
>  	int cpu;
>  	int pc;
>  
> +	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
> +		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  	cpu = raw_smp_processor_id();
>  	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
> @@ -311,6 +328,10 @@ void set_graph_array(struct trace_array *tr)
>  
>  static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
>  {
> +	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
> +		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
> +		return;
> +	}
>  	if (tracing_thresh &&
>  	    (trace->rettime - trace->calltime < tracing_thresh))
>  		return;
> -- 
> 2.19.1
> 
> 
