Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBHKSX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:18:23 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:38177 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeBHKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:18:20 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 8 Feb 2018 19:18:18 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 03/18] tracing: Add simple arguments to function based
 events
Message-ID: <20180208101818.GA26290@sejong>
References: <20180202230458.840252014@goodmis.org>
 <20180202231017.459764446@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180202231017.459764446@goodmis.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:05:01PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The function based events can now have arguments passed in. A weak function
> arch_get_func_args() is created so that archs can fill in the arguments
> based on pt_regs. Currently no arch implements this function, so no
> arguments are returned. Passing NULL for pt_regs into this function returns
> the number of supported args that can be processed, and the format will
> only allow the user to add valid args. Which currently are all arguments
> until an arch implements the arg_get_func_args() function.
> 
> [ missing 'static' found by Fengguang Wu's kbuild test robot ]
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

[SNIP]
> @@ -129,9 +284,14 @@ static void func_event_trace(struct trace_event_file *trace_file,
>  	struct trace_event_call *call = &func_event->call;
>  	struct ring_buffer_event *event;
>  	struct ring_buffer *buffer;
> +	struct func_arg *arg;
> +	long args[func_event->arg_cnt];
> +	long long val = 1;
>  	unsigned long irq_flags;
> +	int nr_args;
>  	int size;
>  	int pc;
> +	int i = 0;
>  
>  	if (trace_trigger_soft_disabled(trace_file))
>  		return;
> @@ -139,7 +299,7 @@ static void func_event_trace(struct trace_event_file *trace_file,
>  	local_save_flags(irq_flags);
>  	pc = preempt_count();
>  
> -	size = sizeof(*entry);
> +	size = func_event->arg_offset + sizeof(*entry);
>  
>  	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
>  						call->event.type,
> @@ -150,6 +310,15 @@ static void func_event_trace(struct trace_event_file *trace_file,
>  	entry = ring_buffer_event_data(event);
>  	entry->ip = ip;
>  	entry->parent_ip = parent_ip;
> +	nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
> +
> +	list_for_each_entry(arg, &func_event->args, list) {
> +		if (i < nr_args)
> +			val = args[i];
> +		else
> +			val = 0;
> +		memcpy(&entry->data[arg->offset], &val, arg->size);
> +	}

Where is the 'i' increased?

Thanks,
Namhyung
