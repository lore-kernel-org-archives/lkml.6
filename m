Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeCZQ7R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeCZQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:59:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E662217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 12:59:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
Message-ID: <20180326125913.521ac69b@gandalf.local.home>
In-Reply-To: <41987dff-d05f-168f-2662-ddd69eed11dc@universe-factory.net>
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
        <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>
        <41987dff-d05f-168f-2662-ddd69eed11dc@universe-factory.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2018 19:09:39 +0200
Matthias Schiffer <mschiffer@universe-factory.net> wrote:

> 
> I have two more questions/issues regarding the generic code:
> 
> 1) There is a small window when enabling the profiler where rec->counter
> gets incremented, but profile_graph_return() does not record times yet. For
> functions that are called a lot, the effect is negligible, but for very
> infrequent calls, the shown average time and variance are way off. Moving
> the rec->counter increment to profile_graph_return() when
> CONFIG_FUNCTION_GRAPH_TRACER is enabled would fix this. Does this sound
> reasonable?

Because the counter is done with function_profile_call() which is used
by function tracer (when graph tracer is not enabled), I wouldn't move
it.

But instead, we could make a function_profile_call() helper that does
all that function_profile_call does, and return a value if it does
something. For example:

static int
calculate_profile_call(unsigned long ip, unsigned long parent_ip,
		       struct ftrace_ops *ops, struct pt_regs *regs)
{
	struct ftrace_profile_stat *stat;
	struct ftrace_profile *rec;
	unsigned long flags;
	int ret = 0;

	if (!ftrace_profile_enabled)
		return 0;

	local_irq_save(flags);

	stat = this_cpu_ptr(&ftrace_profile_stats);
	if (!stat->hash || !ftrace_profile_enabled)
		goto out;

	rec = ftrace_find_profiled_func(stat, ip);
	if (!rec) {
		rec = ftrace_profile_alloc(stat, ip);
		if (!rec)
			goto out;
	}

	rec->counter++;
	ret = 1;
 out:
	local_irq_restore(flags);
	return ret;
}

static void
function_profile_call(unsigned long ip, unsigned long parent_ip,
		      struct ftrace_ops *ops, struct pt_regs *regs)
{
	calculate_profile_call(ip, parent_ip, ops, regs);
}

#ifdef CONFIG_FUNCTION_GRAPH_TRACER
static int profile_graph_entry(struct ftrace_graph_ent *trace)
{
	int index = trace->depth;

	if (!calculate_profile_call(trace->func, 0, NULL, NULL))
		return 0;

	/* If function graph is shutting down, ret_stack can be NULL */
	if (!current->ret_stack)
		return 0;

	if (index >= 0 && index < FTRACE_RETFUNC_DEPTH)
		current->ret_stack[index].subtime = 0;

	return 1;
}

If we don't calculate the profile call, then we return 0, this will
tell the function graph tracer not to perform the return part of the
tracing.

> 
> 2) I noticed that my patch does not handle rec->counter overflows correctly
> and will cause a zero division. I can think of two solutions for handling
> overflows that keep the avg / stddev fields meaningful:
> - Reset time/avg/stddev to 0 on overflows
> - Stop updating the record at 0xffffffff, avoiding the overflow

Or add an option that lets the user decide. But I still would like to
find a way not to add a that division on every function call. That's
really heavy weight.

-- Steve

> 
> Matthias
> 
> 
> > 
> > 
> >   
> >> ---
> >>  kernel/trace/ftrace.c | 33 +++++++++++++++++++--------------
> >>  1 file changed, 19 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index eac9ce2c57a2..16dce67b855a 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -460,7 +460,8 @@ struct ftrace_profile {
> >>  	unsigned long			counter;
> >>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >>  	unsigned long long		time;
> >> -	unsigned long long		time_squared;
> >> +	unsigned long long		avg;
> >> +	unsigned long long		stddev;
> >>  #endif
> >>  };
> >>  
> >> @@ -580,7 +581,6 @@ static int function_stat_show(struct seq_file *m, void *v)
> >>  	int ret = 0;
> >>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >>  	static struct trace_seq s;
> >> -	unsigned long long avg;
> >>  	unsigned long long stddev;
> >>  #endif
> >>  	mutex_lock(&ftrace_profile_lock);
> >> @@ -592,9 +592,7 @@ static int function_stat_show(struct seq_file *m, void *v)
> >>  	}
> >>  
> >>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >> -	avg = rec->time;
> >> -	do_div(avg, rec->counter);
> >> -	if (tracing_thresh && (avg < tracing_thresh))
> >> +	if (tracing_thresh && (rec->avg < tracing_thresh))
> >>  		goto out;
> >>  #endif
> >>  
> >> @@ -608,24 +606,19 @@ static int function_stat_show(struct seq_file *m, void *v)
> >>  	if (rec->counter <= 1)
> >>  		stddev = 0;
> >>  	else {
> >> -		/*
> >> -		 * Apply Welford's method:
> >> -		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
> >> -		 */
> >> -		stddev = rec->counter * rec->time_squared -
> >> -			 rec->time * rec->time;
> >> +		stddev = rec->stddev;
> >>  
> >>  		/*
> >>  		 * Divide only 1000 for ns^2 -> us^2 conversion.
> >>  		 * trace_print_graph_duration will divide 1000 again.
> >>  		 */
> >> -		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
> >> +		do_div(stddev, 1000 * (rec->counter - 1));
> >>  	}
> >>  
> >>  	trace_seq_init(&s);
> >>  	trace_print_graph_duration(rec->time, &s);
> >>  	trace_seq_puts(&s, "    ");
> >> -	trace_print_graph_duration(avg, &s);
> >> +	trace_print_graph_duration(rec->avg, &s);
> >>  	trace_seq_puts(&s, "    ");
> >>  	trace_print_graph_duration(stddev, &s);
> >>  	trace_print_seq(m, &s);
> >> @@ -905,8 +898,20 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
> >>  
> >>  	rec = ftrace_find_profiled_func(stat, trace->func);
> >>  	if (rec) {
> >> +		unsigned long long avg, delta1, delta2;
> >> +
> >>  		rec->time += calltime;
> >> -		rec->time_squared += calltime * calltime;
> >> +
> >> +		/* Apply Welford's method */
> >> +		delta1 = calltime - rec->avg;
> >> +
> >> +		avg = rec->time;
> >> +		do_div(avg, rec->counter);
> >> +		rec->avg = avg;
> >> +
> >> +		delta2 = calltime - rec->avg;
> >> +
> >> +		rec->stddev += delta1 * delta2;
> >>  	}
> >>  
> >>   out:
> >>  
> > 
> >   
> 
> 
