Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F4C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1832146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1832146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeLAEaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbeLAEaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:30:39 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E80C206B7;
        Fri, 30 Nov 2018 17:20:38 +0000 (UTC)
Date:   Fri, 30 Nov 2018 12:20:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mathieu.desnoyers@efficios.com
Subject: Re: [RFC PATCH v3] ftrace: support very early function tracing
Message-ID: <20181130122036.2b993c1a@gandalf.local.home>
In-Reply-To: <20181024192230.Horde.jyOd6XtJHX9UpT8_PPWxjfa@www.imp.polymtl.ca>
References: <20181024192230.Horde.jyOd6XtJHX9UpT8_PPWxjfa@www.imp.polymtl.ca>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 19:22:30 +0000
Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca> wrote:


> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -239,6 +239,16 @@ static inline void ftrace_free_init_mem(void) { }
>   static inline void ftrace_free_mem(struct module *mod, void *start,  
> void *end) { }
>   #endif /* CONFIG_FUNCTION_TRACER */
> 
> +#ifdef CONFIG_VERY_EARLY_FUNCTION_TRACER
> +extern void ftrace_early_init(char *command_line);
> +extern void ftrace_early_shutdown(void);
> +extern void ftrace_early_fill_ringbuffer(void *data);
> +#else
> +static inline void ftrace_early_init(char *command_line) { }
> +static inline void ftrace_early_shutdown(void) { }
> +static inline void ftrace_early_fill_ringbuffer(void *data) { }
> +#endif
> +
>   #ifdef CONFIG_STACK_TRACER
> 
>   #define STACK_TRACE_ENTRIES 500
> @@ -443,6 +453,10 @@ unsigned long ftrace_get_addr_curr(struct  
> dyn_ftrace *rec);
> 
>   extern ftrace_func_t ftrace_trace_function;
> 
> +#if defined(CONFIG_VERY_EARLY_FUNCTION_TRACER) &&  
> defined(CONFIG_DYNAMIC_FTRACE)

Seems the patch has some formatting issue. Can you resend with better
email client options.

> +extern ftrace_func_t ftrace_vearly_trace_function;
> +#endif
> +
>   int ftrace_regex_open(struct ftrace_ops *ops, int flag,
>   		  struct inode *inode, struct file *file);
>   ssize_t ftrace_filter_write(struct file *file, const char __user *ubuf,
> @@ -716,7 +730,7 @@ static inline unsigned long get_lock_parent_ip(void)
>   #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>   extern void ftrace_init(void);
>   #else
> -static inline void ftrace_init(void) { }
> +static inline void ftrace_init(void) { ftrace_early_shutdown(); }
>   #endif
> 
>   /*
> diff --git a/init/main.c b/init/main.c
> index 18f8f0140fa0..1b289325223f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -533,6 +533,7 @@ asmlinkage __visible void __init start_kernel(void)
>   	char *command_line;
>   	char *after_dashes;
> 
> +	ftrace_early_init(boot_command_line);
>   	set_task_stack_end_magic(&init_task);
>   	smp_setup_processor_id();
>   	debug_objects_early_init();
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 5e3de28c7677..4b358bf6abb0 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -19,6 +19,11 @@ config HAVE_FUNCTION_TRACER
>   	help
>   	  See Documentation/trace/ftrace-design.rst
> 
> +config HAVE_VERY_EARLY_FTRACE
> +	bool
> +	help
> +	  See Documentation/trace/ftrace-design.txt
> +
>   config HAVE_FUNCTION_GRAPH_TRACER
>   	bool
>   	help
> @@ -155,6 +160,52 @@ config FUNCTION_TRACER
>   	  (the bootup default), then the overhead of the instructions is very
>   	  small and not measurable even in micro-benchmarks.
> 
> +config VERY_EARLY_FUNCTION_TRACER
> +	bool "Very Early Kernel Function Tracer"
> +	depends on FUNCTION_TRACER
> +	depends on HAVE_VERY_EARLY_FTRACE
> +	help
> +	  Normally, function tracing can only start after memory has been
> +	  initialized early in boot. If "ftrace=function" is added to the
> +	  command line, then function tracing will start after memory setup.
> +	  In order to trace functions before that, this option will
> +	  have function tracing starts before memory setup is complete, by

 s/starts/start/

> +	  placing the trace in a temporary buffer, which will be copied to
> +	  the trace buffer after memory setup. The size of this temporary
> +	  buffer is defined by VERY_EARLY_FTRACE_BUF_SHIFT.

I'm also thinking that we should allocate a sub buffer for this. That
is, hold off on writing to ring buffer until after file systems are
initialized. Create a sub buffer "early_boot" (will be in
tracefs/instances/early_boot)" and copy the data there.

The reason I say this is that having ftrace=function will continue to
fill the buffer and you will most likely lose your data from
overwriting.

> +
> +config VERY_EARLY_FTRACE_BUF_SHIFT
> +	int "Temporary buffer size (17 => 128 KB, 24 => 16 MB)"
> +	depends on VERY_EARLY_FUNCTION_TRACER
> +	range 8 24
> +	default 19
> +	help
> +	  Select the size of the buffer to be used for storing function calls at
> +	  very early stage.
> +	  The value defines the size as a power of 2.
> +	  Examples:
> +	    20 =>   1 MB
> +	    19 => 512 KB
> +	    17 => 128 KB

Should state the allowable range in the help text as well.

> +
> +config VERY_EARLY_FTRACE_FILTER_SHIFT
> +	int "Temporary filter size (filter/notrace) (17 => 128 KB, 19 => 512 KB)"
> +	depends on VERY_EARLY_FUNCTION_TRACER
> +	depends on FTRACE_MCOUNT_RECORD
> +	range 0 19
> +	default 17
> +	help
> +	  Select the size of the filter buffer to be used for filtering (trace/
> +	  no trace) functions at very early stage.
> +	  Two buffers (trace/no_trace) will be created using by this option.
> +	  These following kernel parameters control filtering during bootup :
> +	  "ftrace_filter", "ftrace_notrace".
> +	  The value defines the size as a power of 2.
> +	  Examples:
> +	    19 => 512 KB for each buffer
> +	    18 => 256 KB for each buffer
> +	    17 => 128 KB for each buffer

Also state the allowable range here too.

> +
>   config FUNCTION_GRAPH_TRACER
>   	bool "Kernel Function Graph Tracer"
>   	depends on HAVE_FUNCTION_GRAPH_TRACER
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f536f601bd46..45d575ae2056 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -65,6 +65,11 @@
>   #define FTRACE_HASH_DEFAULT_BITS 10
>   #define FTRACE_HASH_MAX_BITS 12
> 
> +#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +extern unsigned long __start_mcount_loc[];
> +extern unsigned long __stop_mcount_loc[];
> +#endif
> +
>   #ifdef CONFIG_DYNAMIC_FTRACE
>   #define INIT_OPS_HASH(opsname)	\
>   	.func_hash		= &opsname.local_hash,			\
> @@ -6126,11 +6131,11 @@ void __init ftrace_free_init_mem(void)
> 
>   void __init ftrace_init(void)
>   {
> -	extern unsigned long __start_mcount_loc[];
> -	extern unsigned long __stop_mcount_loc[];
>   	unsigned long count, flags;
>   	int ret;
> 
> +	ftrace_early_shutdown();
> +
>   	local_irq_save(flags);
>   	ret = ftrace_dyn_arch_init();
>   	local_irq_restore(flags);
> @@ -7092,3 +7097,283 @@ void ftrace_graph_exit_task(struct task_struct *t)
>   	kfree(ret_stack);
>   }
>   #endif
> +
> +
> +#ifdef CONFIG_VERY_EARLY_FUNCTION_TRACER
> +
> +#define VEARLY_BUFF_LEN ((1 << CONFIG_VERY_EARLY_FTRACE_BUF_SHIFT) / \
> +					sizeof(struct ftrace_vearly_entry))
> +
> +struct ftrace_vearly_entry {
> +	unsigned long ip;
> +	unsigned long parent_ip;
> +	unsigned long long clock;
> +};
> +/*
> + * Only CPU0 is running in early stage, no need to have per-cpu buffer
> + */
> +static struct ftrace_vearly_entry  
> ftrace_vearly_entries[VEARLY_BUFF_LEN] __initdata;
> +static const unsigned long VEARLY_BUFF_MAX __initconst = VEARLY_BUFF_LEN;
> +static unsigned long vearly_entries_count __initdata;
> +static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> +
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +ftrace_func_t ftrace_vearly_trace_function __read_mostly = ftrace_stub;
> +#else
> +# define ftrace_vearly_trace_function ftrace_trace_function
> +#endif
> +
> +static inline __init void ftrace_vearly_disable(void)
> +{
> +	ftrace_vearly_trace_function = ftrace_stub;
> +}
> +
> +#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +#define VEARLY_FILTER_LEN ((1 << CONFIG_VERY_EARLY_FTRACE_FILTER_SHIFT) / \
> +					sizeof(unsigned long))
> +struct ftrace_vearly_filtering {
> +	unsigned long list[VEARLY_FILTER_LEN];
> +	char buf[COMMAND_LINE_SIZE];
> +	int size;
> +};
> +static const unsigned long VEARLY_FILTER_MAX __initconst = VEARLY_FILTER_LEN;
> +static struct ftrace_vearly_filtering ftrace_data_notrace __initdata;
> +static struct ftrace_vearly_filtering ftrace_data_filter __initdata;
> +
> +static __init int ftrace_vearly_filter_has_addr(unsigned long addr,
> +	unsigned long *filter, int *size)
> +{
> +	int i;
> +
> +	for (i = 0; i < *size; i++) {
> +		if (filter[i] == addr)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static __init int
> +ftrace_vearly_match_record(unsigned long ip, struct ftrace_glob *func_g)
> +{
> +	char str[KSYM_SYMBOL_LEN];
> +	char *modname;
> +
> +	kallsyms_lookup(ip, NULL, NULL, &modname, str);
> +	return ftrace_match(str, func_g);
> +}
> +
> +static __init void
> +ftrace_vearly_regex(char *func, unsigned long *filter, int *size)
> +{
> +	struct ftrace_glob func_g = { .type = MATCH_FULL };
> +	unsigned long *start = __start_mcount_loc;
> +	unsigned long *end = __stop_mcount_loc;
> +	unsigned long count;
> +	unsigned long addr;
> +	unsigned long *p;
> +	int clear_filter = 0;
> +
> +	count = end - start;
> +
> +	if (!count)
> +		return;
> +
> +	if (func) {
> +		func_g.type = filter_parse_regex(func, strlen(func), &func_g.search,
> +						 &clear_filter);
> +		func_g.len = strlen(func_g.search);
> +	}
> +
> +	p = start;
> +	while (p < end) {
> +		addr = ftrace_call_adjust(*p++);
> +		if (!addr)
> +			continue;
> +
> +		if ((*size) > VEARLY_FILTER_MAX)
> +			return;
> +
> +		if (ftrace_vearly_match_record(addr, &func_g)) {
> +			if (!ftrace_vearly_filter_has_addr(addr, filter, size))
> +				filter[(*size)++] = addr;
> +		}
> +	}
> +}
> +
> +static int __init ftrace_addr_compare(const void *a, const void *b)
> +{
> +	if (*(unsigned long *)a > *(unsigned long *)b)
> +		return 1;
> +	if (*(unsigned long *)a < *(unsigned long *)b)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void __init ftrace_addr_swap(void *a, void *b, int size)
> +{
> +	unsigned long t = *(unsigned long *)a;
> +	*(unsigned long *)a = *(unsigned long *)b;
> +	*(unsigned long *)b = t;
> +}
> +
> +static __init int set_ftrace_vearly_filtering(void *data, char *str)
> +{
> +	struct ftrace_vearly_filtering *ftrace_data = data;
> +	char *func;
> +	char *buf;
> +
> +	if (!ftrace_data)
> +		return 0;
> +	buf = ftrace_data->buf;
> +	strlcpy(buf, str, COMMAND_LINE_SIZE);
> +
> +	while (buf) {
> +		func = strsep(&buf, ",");
> +		ftrace_vearly_regex(func, ftrace_data->list, &ftrace_data->size);
> +	}
> +	/* sort filter to use binary search on it */
> +	sort(ftrace_data->list, ftrace_data->size,
> +		sizeof(unsigned long), ftrace_addr_compare, ftrace_addr_swap);
> +
> +	return 1;
> +}
> +
> +#define ftrace_vearly_bsearch_addr(addr, data) bsearch(&addr, data.list,\
> +	data.size, sizeof(unsigned long), ftrace_addr_compare)
> +
> +#endif /* CONFIG_FTRACE_MCOUNT_RECORD */
> +
> +
> +static __init void
> +ftrace_function_vearly_trace_call(unsigned long ip, unsigned long parent_ip,
> +			struct ftrace_ops *op, struct pt_regs *regs)
> +{
> +	struct ftrace_vearly_entry *entry;
> +
> +#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +	if (ftrace_data_notrace.size &&
> +			ftrace_vearly_bsearch_addr(ip, ftrace_data_notrace))
> +		return;
> +
> +	if (ftrace_data_filter.size &&
> +			!ftrace_vearly_bsearch_addr(ip, ftrace_data_filter))
> +		return;
> +#endif
> +
> +	if (vearly_entries_count >= VEARLY_BUFF_MAX) {
> +		/* stop tracing when buffer is full */
> +		ftrace_vearly_disable();
> +		return;
> +	}
> +
> +	entry = &ftrace_vearly_entries[vearly_entries_count++];
> +	entry->ip = ip;
> +	entry->parent_ip = parent_ip;
> +	entry->clock = trace_clock_local();
> +}
> +
> +/*
> + * Will be passed to ringbuffer by early_trace_clock
> + */
> +static u64 early_timestamp __initdata;
> +
> +static __init u64 early_trace_clock(void)
> +{
> +	return early_timestamp;
> +}
> +
> +void __init ftrace_early_fill_ringbuffer(void *data)
> +{
> +	struct ftrace_vearly_entry *entry;
> +	struct trace_array *tr = data;
> +	int i;
> +
> +	if (ftrace_vearly_entries <= 0)
> +		return;
> +
> +	ring_buffer_set_clock(tr->trace_buffer.buffer, early_trace_clock);
> +	preempt_disable_notrace();

I'm not sure we need the "notrace" here.

> +	for (i = 0; i < vearly_entries_count; i++) {
> +		entry = &ftrace_vearly_entries[i];
> +		early_timestamp = entry->clock;

Cute.

-- Steve


> +		trace_function(tr, entry->ip, entry->parent_ip, 0, 0);
> +	}
> +	preempt_enable_notrace();
> +	ring_buffer_set_clock(tr->trace_buffer.buffer, trace_clock_local);
> +}
> +
> +/*
> + * this will be used as __setup_param
> + */
> +struct ftrace_vearly_obs_param {
> +	int (*setup_func)(void *, char*);
> +	const char *str;
> +	void *data;
> +};
> +static struct ftrace_vearly_obs_param ftrace_vearly_params[] __initdata = {
> +#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +	{
> +		.str = "ftrace_notrace",
> +		.data = &ftrace_data_notrace,
> +		.setup_func = set_ftrace_vearly_filtering,
> +	},
> +	{
> +		.str = "ftrace_filter",
> +		.data = &ftrace_data_filter,
> +		.setup_func = set_ftrace_vearly_filtering,
> +	},
> +#endif
> +};
> +
> +static int __init ftrace_do_very_early_param(char *param, char *val,
> +				 const char *unused, void *arg)
> +{
> +	int size = ARRAY_SIZE(ftrace_vearly_params);
> +	struct ftrace_vearly_obs_param *p;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		p = &ftrace_vearly_params[i];
> +		if (strcmp(param, p->str) == 0) {
> +			p->setup_func(p->data, val);
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}
> +
> +void __init ftrace_early_init(char *command_line)
> +{
> +	/* proceed only if function tracing was enabled */
> +	if (!strstr(command_line, "ftrace=function "))
> +		return;
> +
> +	strlcpy(tmp_cmdline, command_line, COMMAND_LINE_SIZE);
> +	parse_args("ftrace vearly options", tmp_cmdline, NULL, 0, 0, 0, NULL,
> +		ftrace_do_very_early_param);
> +
> +	// After this point, we enable early function tracing
> +	ftrace_vearly_trace_function = ftrace_function_vearly_trace_call;
> +}
> +
> +void __init ftrace_early_shutdown(void)
> +{
> +	if (ftrace_vearly_trace_function == ftrace_stub)
> +		return;
> +
> +	// Disable early tracing
> +	ftrace_vearly_disable();
> +
> +#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +	pr_info("ftrace: vearly %lu entries, notrace=%d, filter=%d",
> +		vearly_entries_count,
> +		ftrace_data_notrace.size,
> +		ftrace_data_filter.size);
> +#else
> +	pr_info("ftrace: vearly %lu recorded entries", vearly_entries_count);
> +#endif
> +}
> +
> +#endif /* CONFIG_VERY_EARLY_FUNCTION_TRACER */
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bf6f1d70484d..08763c380a3e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8551,6 +8551,9 @@ __init static int tracer_alloc_buffers(void)
>   	/* Function tracing may start here (via kernel command line) */
>   	init_function_trace();
> 
> +	/* Pre-fill the ring buffer with very early events */
> +	ftrace_early_fill_ringbuffer(&global_trace);
> +
>   	/* All seems OK, enable tracing */
>   	tracing_disabled = 0;
> 

