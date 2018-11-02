Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D885ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DDD20666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DDD20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeKBJwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeKBJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:52:40 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F5720657;
        Fri,  2 Nov 2018 00:47:22 +0000 (UTC)
Date:   Thu, 1 Nov 2018 20:47:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181101204720.6ed3fe37@vmware.local.home>
In-Reply-To: <20181101083551.3805-2-cyphar@cyphar.com>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Nov 2018 19:35:50 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> Historically, kretprobe has always produced unusable stack traces
> (kretprobe_trampoline is the only entry in most cases, because of the
> funky stack pointer overwriting). This has caused quite a few annoyances
> when using tracing to debug problems[1] -- since return values are only
> available with kretprobes but stack traces were only usable for kprobes,
> users had to probe both and then manually associate them.
> 
> With the advent of bpf_trace, users would have been able to do this
> association in bpf, but this was less than ideal (because
> bpf_get_stackid would still produce rubbish and programs that didn't
> know better would get silly results). The main usecase for stack traces
> (at least with bpf_trace) is for DTrace-style aggregation on stack
> traces (both entry and exit). Therefore we cannot simply correct the
> stack trace on exit -- we must stash away the stack trace and return the
> entry stack trace when it is requested.
> 
> [1]: https://github.com/iovisor/bpftrace/issues/101
> 
> Cc: Brendan Gregg <bgregg@netflix.com>
> Cc: Christian Brauner <christian@brauner.io>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  Documentation/kprobes.txt                     |   6 +-
>  include/linux/kprobes.h                       |  27 +++++
>  kernel/events/callchain.c                     |   8 +-
>  kernel/kprobes.c                              | 101 +++++++++++++++++-
>  kernel/trace/trace.c                          |  11 +-
>  .../test.d/kprobe/kretprobe_stacktrace.tc     |  25 +++++
>  6 files changed, 173 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 10f4499e677c..1965585848f4 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -597,7 +597,11 @@ address with the trampoline's address, stack backtraces and calls
>  to __builtin_return_address() will typically yield the trampoline's
>  address instead of the real return address for kretprobed functions.
>  (As far as we can tell, __builtin_return_address() is used only
> -for instrumentation and error reporting.)
> +for instrumentation and error reporting.) However, since return probes
> +are used extensively in tracing (where stack backtraces are useful),
> +return probes will stash away the stack backtrace during function entry
> +so that return probe handlers can use the entry backtrace instead of
> +having a trace with just kretprobe_trampoline.
>  
>  If the number of times a function is called does not match the number
>  of times it returns, registering a return probe on that function may
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e909413e4e38..1a1629544e56 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -40,6 +40,8 @@
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
>  #include <linux/ftrace.h>
> +#include <linux/stacktrace.h>
> +#include <linux/perf_event.h>
>  #include <asm/kprobes.h>
>  
>  #ifdef CONFIG_KPROBES
> @@ -168,11 +170,18 @@ struct kretprobe {
>  	raw_spinlock_t lock;
>  };
>  
> +#define KRETPROBE_TRACE_SIZE 127
> +struct kretprobe_trace {
> +	int nr_entries;
> +	unsigned long entries[KRETPROBE_TRACE_SIZE];
> +};
> +
>  struct kretprobe_instance {
>  	struct hlist_node hlist;
>  	struct kretprobe *rp;
>  	kprobe_opcode_t *ret_addr;
>  	struct task_struct *task;
> +	struct kretprobe_trace entry;
>  	char data[0];
>  };
>  
> @@ -371,6 +380,12 @@ void unregister_kretprobe(struct kretprobe *rp);
>  int register_kretprobes(struct kretprobe **rps, int num);
>  void unregister_kretprobes(struct kretprobe **rps, int num);
>  
> +struct kretprobe_instance *current_kretprobe_instance(void);
> +void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> +				struct stack_trace *trace);
> +void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> +				     struct perf_callchain_entry_ctx *ctx);
> +
>  void kprobe_flush_task(struct task_struct *tk);
>  void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
>  
> @@ -397,6 +412,18 @@ static inline struct kprobe *kprobe_running(void)
>  {
>  	return NULL;
>  }
> +static inline struct kretprobe_instance *current_kretprobe_instance(void)
> +{
> +	return NULL;
> +}
> +static inline void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> +					      struct stack_trace *trace)
> +{
> +}
> +static inline void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> +						   struct perf_callchain_entry_ctx *ctx)
> +{
> +}
>  static inline int register_kprobe(struct kprobe *p)
>  {
>  	return -ENOSYS;
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 24a77c34e9ad..98edcd8a6987 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -12,6 +12,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/slab.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/kprobes.h>
>  
>  #include "internal.h"
>  
> @@ -197,9 +198,14 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  	ctx.contexts_maxed = false;
>  
>  	if (kernel && !user_mode(regs)) {
> +		struct kretprobe_instance *ri = current_kretprobe_instance();
> +
>  		if (add_mark)
>  			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
> -		perf_callchain_kernel(&ctx, regs);
> +		if (ri)
> +			kretprobe_perf_callchain_kernel(ri, &ctx);
> +		else
> +			perf_callchain_kernel(&ctx, regs);
>  	}
>  
>  	if (user) {
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 90e98e233647..fca3964d18cd 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1206,6 +1206,16 @@ __releases(hlist_lock)
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_unlock);
>  
> +static bool kretprobe_hash_is_locked(struct task_struct *tsk)
> +{
> +	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> +	raw_spinlock_t *hlist_lock;
> +
> +	hlist_lock = kretprobe_table_lock_ptr(hash);
> +	return raw_spin_is_locked(hlist_lock);
> +}
> +NOKPROBE_SYMBOL(kretprobe_hash_is_locked);
> +
>  /*
>   * This function is called from finish_task_switch when task tk becomes dead,
>   * so that we can recycle any function-return probe instances associated
> @@ -1800,6 +1810,13 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  	return (unsigned long)entry;
>  }
>  
> +static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs);
> +
> +static inline bool kprobe_is_retprobe(struct kprobe *kp)
> +{
> +	return kp->pre_handler == pre_handler_kretprobe;
> +}
> +
>  #ifdef CONFIG_KRETPROBES
>  /*
>   * This kprobe pre_handler is registered with every kretprobe. When probe
> @@ -1826,6 +1843,8 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);
>  	raw_spin_lock_irqsave(&rp->lock, flags);
>  	if (!hlist_empty(&rp->free_instances)) {
> +		struct stack_trace trace = {};
> +
>  		ri = hlist_entry(rp->free_instances.first,
>  				struct kretprobe_instance, hlist);
>  		hlist_del(&ri->hlist);
> @@ -1834,6 +1853,11 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  		ri->rp = rp;
>  		ri->task = current;
>  
> +		trace.entries = &ri->entry.entries[0];
> +		trace.max_entries = KRETPROBE_TRACE_SIZE;
> +		save_stack_trace_regs(regs, &trace);
> +		ri->entry.nr_entries = trace.nr_entries;
> +


So basically your saving a copy of the stack trace for each probe, for
something that may not ever be used?

This adds quite a lot of overhead for something not used often.

I think the real answer is to fix kretprobes (and I just checked, the
return call of function graph tracer stack trace doesn't go past the
return_to_handler function either. It's just that a stack trace was
never done on the return side).

The more I look at this patch, the less I like it.

-- Steve




>  		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
>  			raw_spin_lock_irqsave(&rp->lock, flags);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
> @@ -1856,6 +1880,65 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> +/*
> + * Return the kretprobe_instance associated with the current_kprobe. Calling
> + * this is only reasonable from within a kretprobe handler context (otherwise
> + * return NULL).
> + *
> + * Must be called within a kretprobe_hash_lock(current, ...) context.
> + */
> +struct kretprobe_instance *current_kretprobe_instance(void)
> +{
> +	struct kprobe *kp;
> +	struct kretprobe *rp;
> +	struct kretprobe_instance *ri;
> +	struct hlist_head *head;
> +	unsigned long hash = hash_ptr(current, KPROBE_HASH_BITS);
> +
> +	kp = kprobe_running();
> +	if (!kp || !kprobe_is_retprobe(kp))
> +		return NULL;
> +	if (WARN_ON(!kretprobe_hash_is_locked(current)))
> +		return NULL;
> +
> +	rp = container_of(kp, struct kretprobe, kp);
> +	head = &kretprobe_inst_table[hash];
> +
> +	hlist_for_each_entry(ri, head, hlist) {
> +		if (ri->task == current && ri->rp == rp)
> +			return ri;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(current_kretprobe_instance);
> +NOKPROBE_SYMBOL(current_kretprobe_instance);
> +
> +void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> +				struct stack_trace *trace)
> +{
> +	int i;
> +	struct kretprobe_trace *krt = &ri->entry;
> +
> +	for (i = trace->skip; i < krt->nr_entries; i++) {
> +		if (trace->nr_entries >= trace->max_entries)
> +			break;
> +		trace->entries[trace->nr_entries++] = krt->entries[i];
> +	}
> +}
> +
> +void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> +				     struct perf_callchain_entry_ctx *ctx)
> +{
> +	int i;
> +	struct kretprobe_trace *krt = &ri->entry;
> +
> +	for (i = 0; i < krt->nr_entries; i++) {
> +		if (krt->entries[i] == ULONG_MAX)
> +			break;
> +		perf_callchain_store(ctx, (u64) krt->entries[i]);
> +	}
> +}
> +
>  bool __weak arch_kprobe_on_func_entry(unsigned long offset)
>  {
>  	return !offset;
> @@ -2005,6 +2088,22 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> +struct kretprobe_instance *current_kretprobe_instance(void)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(current_kretprobe_instance);
> +NOKPROBE_SYMBOL(current_kretprobe_instance);
> +
> +void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> +				struct stack_trace *trace)
> +{
> +}
> +
> +void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> +				     struct perf_callchain_entry_ctx *ctx)
> +{
> +}
>  #endif /* CONFIG_KRETPROBES */
>  
>  /* Set the kprobe gone and remove its instruction buffer. */
> @@ -2241,7 +2340,7 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
>  	char *kprobe_type;
>  	void *addr = p->addr;
>  
> -	if (p->pre_handler == pre_handler_kretprobe)
> +	if (kprobe_is_retprobe(p))
>  		kprobe_type = "r";
>  	else
>  		kprobe_type = "k";
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bf6f1d70484d..2210d38a4dbf 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -42,6 +42,7 @@
>  #include <linux/nmi.h>
>  #include <linux/fs.h>
>  #include <linux/trace.h>
> +#include <linux/kprobes.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
>  
> @@ -2590,6 +2591,7 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
>  	struct ring_buffer_event *event;
>  	struct stack_entry *entry;
>  	struct stack_trace trace;
> +	struct kretprobe_instance *ri = current_kretprobe_instance();
>  	int use_stack;
>  	int size = FTRACE_STACK_ENTRIES;
>  
> @@ -2626,7 +2628,9 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
>  		trace.entries		= this_cpu_ptr(ftrace_stack.calls);
>  		trace.max_entries	= FTRACE_STACK_MAX_ENTRIES;
>  
> -		if (regs)
> +		if (ri)
> +			kretprobe_save_stack_trace(ri, &trace);
> +		else if (regs)
>  			save_stack_trace_regs(regs, &trace);
>  		else
>  			save_stack_trace(&trace);
> @@ -2653,7 +2657,10 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
>  	else {
>  		trace.max_entries	= FTRACE_STACK_ENTRIES;
>  		trace.entries		= entry->caller;
> -		if (regs)
> +
> +		if (ri)
> +			kretprobe_save_stack_trace(ri, &trace);
> +		else if (regs)
>  			save_stack_trace_regs(regs, &trace);
>  		else
>  			save_stack_trace(&trace);
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc
> new file mode 100644
> index 000000000000..03146c6a1a3c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +# description: Kretprobe dynamic event with a stacktrace
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +echo 0 > events/enable
> +echo 1 > options/stacktrace
> +
> +echo 'r:teststackprobe sched_fork $retval' > kprobe_events
> +grep teststackprobe kprobe_events
> +test -d events/kprobes/teststackprobe
> +
> +clear_trace
> +echo 1 > events/kprobes/teststackprobe/enable
> +( echo "forked")
> +echo 0 > events/kprobes/teststackprobe/enable
> +
> +# Make sure we don't see kretprobe_trampoline and we see _do_fork.
> +! grep 'kretprobe' trace
> +grep '_do_fork' trace
> +
> +echo '-:teststackprobe' >> kprobe_events
> +clear_trace
> +test -d events/kprobes/teststackprobe && exit_fail || exit_pass

