Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeBIDPv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:15:51 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:41693 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:15:49 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 9 Feb 2018 12:15:47 +0900
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
Subject: Re: [PATCH 15/18] tracing: Add string type for dynamic strings in
 function based events
Message-ID: <20180209031547.GD28206@sejong>
References: <20180202230458.840252014@goodmis.org>
 <20180202231019.285051395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180202231019.285051395@goodmis.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:05:13PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a "string" type that will create a dynamic length string for the
> event, this is the same as the __string() field in normal TRACE_EVENTS.
> 
> [ missing 'static' found by Fengguang Wu's kbuild test robot ]
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Documentation/trace/function-based-events.rst |  19 ++-
>  kernel/trace/trace_event_ftrace.c             | 183 +++++++++++++++++++++++---
>  2 files changed, 181 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
> index 99ae77cd59e6..6c643ea749e7 100644
> --- a/Documentation/trace/function-based-events.rst
> +++ b/Documentation/trace/function-based-events.rst
> @@ -99,7 +99,7 @@ as follows:
>           's8' | 's16' | 's32' | 's64' |
>           'x8' | 'x16' | 'x32' | 'x64' |
>           'char' | 'short' | 'int' | 'long' | 'size_t' |
> -	 'symbol'
> +	 'symbol' | 'string'
>  
>   FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX
>  
> @@ -342,3 +342,20 @@ the format "%s". If a nul is found, the output will stop. Use another type
>        bash-1470  [003] ...2   980.678715: path_openat->link_path_walk(name=/lib64/ld-linux-x86-64.so.2)
>        bash-1470  [003] ...2   980.678721: path_openat->link_path_walk(name=ld-2.24.so)
>        bash-1470  [003] ...2   980.678978: path_lookupat->link_path_walk(name=/etc/ld.so.preload)
> +
> +
> +Dynamic strings
> +===============
> +
> +Static strings are fine, but they can waste a lot of memory in the ring buffer.
> +The above allocated 64 bytes for a character array, but most of the output was
> +less than 20 characters. Not wanting to truncate strings or waste space on
> +the ring buffer, the dynamic string can help.
> +
> +Use the "string" type for strings that have a large range in size. The max
> +size that will be recorded is 512 bytes. If a string is larger than that, then
> +it will be truncated.
> +
> + # echo 'link_path_walk(string name)' > function_events
> +
> +Gives the same result as above, but does not waste buffer space.
> diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
> index dd24b840329d..273c5838a8e2 100644
> --- a/kernel/trace/trace_event_ftrace.c
> +++ b/kernel/trace/trace_event_ftrace.c
> @@ -39,6 +39,7 @@ struct func_event {
>  	struct func_arg			*last_arg;
>  	int				arg_cnt;
>  	int				arg_offset;
> +	int				has_strings;
>  };
>  
>  struct func_file {
> @@ -83,6 +84,8 @@ typedef u32 x32;
>  typedef u16 x16;
>  typedef u8 x8;
>  typedef void * symbol;
> +/* 2 byte offset, 2 byte length */
> +typedef u32 string;
>  
>  #define TYPE_TUPLE(type)			\
>  	{ #type, sizeof(type), is_signed_type(type) }
> @@ -105,7 +108,8 @@ typedef void * symbol;
>  	TYPE_TUPLE(u8),				\
>  	TYPE_TUPLE(s8),				\
>  	TYPE_TUPLE(x8),				\
> -	TYPE_TUPLE(symbol)
> +	TYPE_TUPLE(symbol),			\
> +	TYPE_TUPLE(string)
>  
>  static struct func_type {
>  	char		*name;
> @@ -124,6 +128,16 @@ enum {
>  	FUNC_TYPE_MAX
>  };
>  
> +#define MAX_STR		512
> +
> +/* Two contexts, normal and NMI, hence the " * 2" */
> +struct func_string {
> +	char		buf[MAX_STR * 2];
> +};
> +
> +static struct func_string __percpu *str_buffer;
> +static int nr_strings;

What protects it?

Thanks,
Namhyung


> +
>  /**
>   * arch_get_func_args - retrieve function arguments via pt_regs
>   * @regs: The registers at the moment the function is called
> @@ -163,6 +177,23 @@ int __weak arch_get_func_args(struct pt_regs *regs,
>  	return 0;
>  }
>  
> +static void free_arg(struct func_arg *arg)
> +{
> +	list_del(&arg->list);
> +	if (arg->func_type == FUNC_TYPE_string) {
> +		nr_strings--;
> +		if (WARN_ON(nr_strings < 0))
> +			nr_strings = 0;
> +		if (!nr_strings) {
> +			free_percpu(str_buffer);
> +			str_buffer = NULL;
> +		}
> +	}
> +	kfree(arg->name);
> +	kfree(arg->type);
> +	kfree(arg);
> +}
> +
>  static void free_func_event(struct func_event *func_event)
>  {
>  	struct func_arg *arg, *n;
> @@ -171,10 +202,7 @@ static void free_func_event(struct func_event *func_event)
>  		return;
>  
>  	list_for_each_entry_safe(arg, n, &func_event->args, list) {
> -		list_del(&arg->list);
> -		kfree(arg->name);
> -		kfree(arg->type);
> -		kfree(arg);
> +		free_arg(arg);
>  	}
>  	ftrace_free_filter(&func_event->ops);
>  	kfree(func_event->call.print_fmt);
> @@ -255,6 +283,17 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
>  	list_add_tail(&arg->list, &fevent->args);
>  	fevent->last_arg = arg;
>  
> +	if (ftype == FUNC_TYPE_string) {
> +		fevent->has_strings++;
> +		nr_strings++;
> +		if (nr_strings == 1) {
> +			str_buffer = alloc_percpu(struct func_string);
> +			if (!str_buffer) {
> +				free_arg(arg);
> +				return -ENOMEM;
> +			}
> +		}
> +	}
>  	return 0;
>  }
