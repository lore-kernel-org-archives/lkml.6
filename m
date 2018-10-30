Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A6C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF31D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDAejby4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF31D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJ3KD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeJ3KD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:03:28 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBA52054F;
        Tue, 30 Oct 2018 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540861931;
        bh=oVCEf/4tceP7cbcJUzvi0ZxQ7lLWdJkBFXr/1zYN08k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lDAejby4an6BJv+LlsB2Mhyt2W8Nq58MwG18UaOABxsR9vVgzgLKNj3DTRgdUMpnG
         JN+QJUKs202cVp60lnyiytvJkHsBUByPkHjHnQvINaCoM7Dlc8DtxdXKqqCclc43B4
         xhPA2qnsTHAiTgFiKmLOmnNOOpqTZb8htrA+rDPc=
Date:   Tue, 30 Oct 2018 10:12:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-Id: <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
In-Reply-To: <20181026132210.12569-1-cyphar@cyphar.com>
References: <20181026132210.12569-1-cyphar@cyphar.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

On Sat, 27 Oct 2018 00:22:10 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> Historically, kretprobe has always produced unusable stack traces
> (kretprobe_trampoline is the only entry in most cases, because of the
> funky stack pointer overwriting). This has caused quite a few annoyances
> when using tracing to debug problems[1] -- since return values are only
> available with kretprobes but stack traces were only usable for kprobes,
> users had to probe both and then manually associate them.

Yes, this unfortunately still happens. I once tried to fix it by
replacing current "kretprobe instance" with graph-tracer's per-thread
return stack. (https://lkml.org/lkml/2017/8/21/553)

I still believe that direction is the best solution to solve this kind
of issues, otherwise, we have to have 2 different stack fixups for
kretprobe and ftrace graph tracer. (I will have a talk with Steve at
plumbers next month)

Anyway, until that merge happens, this patch looks good to avoid
this issue for generic solution (e.g. for the arch which doesn't
supports retstack).


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
> In theory, patches like commit 76094a2cf46e ("ftrace: distinguish
> kretprobe'd functions in trace logs") are no longer necessary *for
> tracing* because now all kretprobe traces should produce sane stack
> traces. However it's not clear whether removing them completely is
> reasonable.

Then, let's try to revert it :)

BTW, could you also add a test case for ftrace too?
also, I have some comments below.

> 
> [1]: https://github.com/iovisor/bpftrace/issues/101
> 
> Cc: Brendan Gregg <bgregg@netflix.com>
> Cc: Christian Brauner <christian@brauner.io>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  include/linux/kprobes.h   |  15 ++++++
>  kernel/events/callchain.c |   8 ++-
>  kernel/kprobes.c          | 108 +++++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace.c      |  11 +++-
>  4 files changed, 138 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e909413e4e38..8a4f78a0c990 100644
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
> +#define KRETPROBE_TRACE_SIZE 1024
> +struct kretprobe_trace {
> +	int nr_entries;
> +	unsigned long entries[KRETPROBE_TRACE_SIZE];
> +};

Hmm, do we really need all entries? It takes 8KB for each instances.
Note that the number of instances can be big if the system core number
is larger.

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
> index 90e98e233647..a0776a7d1244 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -48,6 +48,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/sched/debug.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -1206,6 +1207,16 @@ __releases(hlist_lock)
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
> @@ -1800,6 +1811,13 @@ unsigned long __weak arch_deref_entry_point(void *entry)
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
> @@ -1826,6 +1844,8 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);
>  	raw_spin_lock_irqsave(&rp->lock, flags);
>  	if (!hlist_empty(&rp->free_instances)) {
> +		struct stack_trace trace = {};
> +
>  		ri = hlist_entry(rp->free_instances.first,
>  				struct kretprobe_instance, hlist);
>  		hlist_del(&ri->hlist);
> @@ -1834,6 +1854,11 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  		ri->rp = rp;
>  		ri->task = current;
>  
> +		trace.entries = &ri->entry.entries[0];
> +		trace.max_entries = KRETPROBE_TRACE_SIZE;
> +		save_stack_trace_regs(regs, &trace);
> +		ri->entry.nr_entries = trace.nr_entries;
> +
>  		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
>  			raw_spin_lock_irqsave(&rp->lock, flags);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
> @@ -1856,6 +1881,70 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
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
> +	struct kretprobe_instance *iter, *ri = NULL;
> +	struct hlist_head *head;
> +	struct hlist_node *next;
> +	unsigned long hash = hash_ptr(current, KPROBE_HASH_BITS);
> +
> +	kp = kprobe_running();
> +	if (!kp || !kprobe_is_retprobe(kp))
> +		return NULL;
> +	if (WARN_ON(!kretprobe_hash_is_locked(current)))

Yes, good catch :)

> +		return NULL;
> +
> +	rp = container_of(kp, struct kretprobe, kp);
> +	head = &kretprobe_inst_table[hash];
> +
> +	hlist_for_each_entry_safe(iter, next, head, hlist) {

Why would you use "_safe" variant here? if you don't modify the hlist,
you don't need to use it.

> +		if (iter->task == current && iter->rp == rp) {
> +			ri = iter;
> +			break;
> +		}
> +	}
> +	return ri;
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
> +EXPORT_SYMBOL_GPL(kretprobe_save_stack_trace);
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
> +EXPORT_SYMBOL_GPL(kretprobe_perf_callchain_kernel);


Why do we need to export these functions?

Thank you,

> +
>  bool __weak arch_kprobe_on_func_entry(unsigned long offset)
>  {
>  	return !offset;
> @@ -2005,6 +2094,23 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> +struct kretprobe_instance *current_kretprobe_instance(void)
> +{
> +	return NULL;
> +}
> +NOKPROBE_SYMBOL(current_kretprobe_instance);
> +
> +void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> +				struct stack_trace *trace)
> +{
> +}
> +EXPORT_SYMBOL_GPL(kretprobe_save_stack_trace);
> +
> +void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> +				     struct perf_callchain_entry_ctx *ctx)
> +{
> +}
> +EXPORT_SYMBOL_GPL(kretprobe_perf_callchain_kernel);
>  #endif /* CONFIG_KRETPROBES */
>  
>  /* Set the kprobe gone and remove its instruction buffer. */
> @@ -2241,7 +2347,7 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
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
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
