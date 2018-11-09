Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A020883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdeGigpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1A020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeKIQzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbeKIQzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:55:14 -0500
Received: from devnote (p19194-mobac01.tokyo.ocn.ne.jp [153.233.10.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CCC20840;
        Fri,  9 Nov 2018 07:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541747758;
        bh=k9CN/myP8tqt5ie05VDUfMpukNiYLcE17P1u+o7xKbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hdeGigpo37LMHYhqHbaM+OnCCIdEAdLSzxADQj0dv/+XvbadFbpCn9T0W5u4hD7Gf
         4xMj9HwP3Lfj7BbDmhOJXN1HkPRMaXLeHzO4EXHtYJUIRdJI5szHDSJUpeAmfrzIqj
         H3xBR2ckOQepEjRKwboJlplmAAv9Qc0VLIRb9/VM=
Date:   Fri, 9 Nov 2018 16:15:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
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
Message-Id: <20181109161551.6b96bd7d932c71432ac65e83@kernel.org>
In-Reply-To: <20181108080448.rggfn4zawi3por23@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
        <20181101204720.6ed3fe37@vmware.local.home>
        <20181102050509.tw3dhvj5urudvtjl@yavin>
        <20181102065932.bdt4pubbrkvql4mp@yavin>
        <20181102091658.1bc979a4@gandalf.local.home>
        <20181103070253.ajrqzs5xu2vf5stu@yavin>
        <20181104115913.74l4yzecisvtt2j5@yavin>
        <20181106171501.59ccabbc@gandalf.local.home>
        <20181108074612.ldy6rozdpsdps6bf@yavin>
        <20181108080448.rggfn4zawi3por23@yavin>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 19:04:48 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> On 2018-11-08, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > I will attach what I have at the moment to hopefully explain what the
> > issue I've found is (re-using the kretprobe architecture but with the
> > shadow-stack idea).
> 
> Here is the patch I have at the moment (it works, except for the
> question I have about how to handle the top-level pt_regs -- I've marked
> that code with XXX).
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
> 
> --8<---------------------------------------------------------------------
> 
> Since the return address is modified by kretprobe, the various unwinders
> can produce invalid and confusing stack traces. ftrace mostly solved
> this problem by teaching each unwinder how to find the original return
> address for stack trace purposes. This same technique can be applied to
> kretprobes by simply adding a pointer to where the return address was
> replaced in the stack, and then looking up the relevant
> kretprobe_instance when a stack trace is requested.
> 
> [WIP: This is currently broken because the *first entry* will not be
>       overwritten since it looks like the stack pointer is different
>       when we are provided pt_regs. All other addresses are correctly
>       handled.]
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  arch/x86/events/core.c         |  6 +++-
>  arch/x86/include/asm/ptrace.h  |  1 +
>  arch/x86/kernel/kprobes/core.c |  5 ++--
>  arch/x86/kernel/stacktrace.c   | 10 +++++--
>  arch/x86/kernel/unwind_frame.c |  2 ++
>  arch/x86/kernel/unwind_guess.c |  5 +++-
>  arch/x86/kernel/unwind_orc.c   |  2 ++
>  include/linux/kprobes.h        | 15 +++++++++-
>  kernel/kprobes.c               | 55 ++++++++++++++++++++++++++++++++++
>  9 files changed, 93 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index de32741d041a..d71062702179 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2371,7 +2371,11 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>  
> -	if (perf_callchain_store(entry, regs->ip))
> +	/* XXX: Currently broken -- stack_addr(regs) doesn't match entry. */
> +	addr = regs->ip;
> +	//addr = ftrace_graph_ret_addr(current, &state.graph_idx, addr, stack_addr(regs));
> +	addr = kretprobe_ret_addr(current, addr, stack_addr(regs));
> +	if (perf_callchain_store(entry, addr))
>  		return;
>  
>  	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index ee696efec99f..c4dfafd43e11 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -172,6 +172,7 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>  	return regs->sp;
>  }
>  #endif
> +#define stack_addr(regs) ((unsigned long *) kernel_stack_pointer(regs))

No, you should use kernel_stack_pointer(regs) itself instead of stack_addr().

> 
>  #define GET_IP(regs) ((regs)->ip)
>  #define GET_FP(regs) ((regs)->bp)
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index b0d1e81c96bb..eb4da885020c 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -69,8 +69,6 @@
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> -#define stack_addr(regs) ((unsigned long *)kernel_stack_pointer(regs))

I don't like keeping this meaningless macro... this should be replaced with generic
kernel_stack_pointer() macro.

> -
>  #define W(row, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, ba, bb, bc, bd, be, bf)\
>  	(((b0##UL << 0x0)|(b1##UL << 0x1)|(b2##UL << 0x2)|(b3##UL << 0x3) |   \
>  	  (b4##UL << 0x4)|(b5##UL << 0x5)|(b6##UL << 0x6)|(b7##UL << 0x7) |   \
> @@ -568,7 +566,8 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
>  	unsigned long *sara = stack_addr(regs);
>  
> -	ri->ret_addr = (kprobe_opcode_t *) *sara;
> +	ri->ret_addrp = (kprobe_opcode_t **) sara;
> +	ri->ret_addr = *ri->ret_addrp;
>  
>  	/* Replace the return addr with trampoline addr */
>  	*sara = (unsigned long) &kretprobe_trampoline;
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 7627455047c2..8a4fb3109d6b 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -8,6 +8,7 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/stacktrace.h>
>  #include <linux/export.h>
> +#include <linux/kprobes.h>
>  #include <linux/uaccess.h>
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
> @@ -37,8 +38,13 @@ static void noinline __save_stack_trace(struct stack_trace *trace,
>  	struct unwind_state state;
>  	unsigned long addr;
>  
> -	if (regs)
> -		save_stack_address(trace, regs->ip, nosched);
> +	if (regs) {
> +		/* XXX: Currently broken -- stack_addr(regs) doesn't match entry. */
> +		addr = regs->ip;

Since this part is for storing regs->ip as a top of call-stack, this
seems correct code. Stack unwind will be done next block.

> +		//addr = ftrace_graph_ret_addr(current, &state.graph_idx, addr, stack_addr(regs));

so func graph return trampoline address will be shown only when unwinding stack entries.
I mean func-graph tracer is not used as an event, so it never kicks stackdump.

> +		addr = kretprobe_ret_addr(current, addr, stack_addr(regs));

But since kretprobe will be an event, which can kick the stackdump.
BTW, from kretprobe, regs->ip should always be the trampoline handler, 
see arch/x86/kernel/kprobes/core.c:772 :-)
So it must be fixed always.

> +		save_stack_address(trace, addr, nosched);
> +	}
>  
>  	for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
>  	     unwind_next_frame(&state)) {
> diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
> index 3dc26f95d46e..47062427e9a3 100644
> --- a/arch/x86/kernel/unwind_frame.c
> +++ b/arch/x86/kernel/unwind_frame.c
> @@ -1,4 +1,5 @@
>  #include <linux/sched.h>
> +#include <linux/kprobes.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/interrupt.h>
> @@ -270,6 +271,7 @@ static bool update_stack_state(struct unwind_state *state,
>  		addr = READ_ONCE_TASK_STACK(state->task, *addr_p);
>  		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
>  						  addr, addr_p);
> +		state->ip = kretprobe_ret_addr(state->task, state->ip, addr_p);
>  	}
>  
>  	/* Save the original stack pointer for unwind_dump(): */
> diff --git a/arch/x86/kernel/unwind_guess.c b/arch/x86/kernel/unwind_guess.c
> index 4f0e17b90463..554fd7c5c331 100644
> --- a/arch/x86/kernel/unwind_guess.c
> +++ b/arch/x86/kernel/unwind_guess.c
> @@ -1,5 +1,6 @@
>  #include <linux/sched.h>
>  #include <linux/ftrace.h>
> +#include <linux/kprobes.h>
>  #include <asm/ptrace.h>
>  #include <asm/bitops.h>
>  #include <asm/stacktrace.h>
> @@ -14,8 +15,10 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
>  
>  	addr = READ_ONCE_NOCHECK(*state->sp);
>  
> -	return ftrace_graph_ret_addr(state->task, &state->graph_idx,
> +	addr = ftrace_graph_ret_addr(state->task, &state->graph_idx,
>  				     addr, state->sp);
> +	addr = kretprobe_ret_addr(state->task, addr, state->sp);
> +	return addr;
>  }
>  EXPORT_SYMBOL_GPL(unwind_get_return_address);
>  
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 26038eacf74a..b6393500d505 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -1,5 +1,6 @@
>  #include <linux/module.h>
>  #include <linux/sort.h>
> +#include <linux/kprobes.h>
>  #include <asm/ptrace.h>
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
> @@ -462,6 +463,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  
>  		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
>  						  state->ip, (void *)ip_p);
> +		state->ip = kretprobe_ret_addr(state->task, state->ip, (void *)ip_p);
>  
>  		state->sp = sp;
>  		state->regs = NULL;
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e909413e4e38..3a01f9998064 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -172,6 +172,7 @@ struct kretprobe_instance {
>  	struct hlist_node hlist;
>  	struct kretprobe *rp;
>  	kprobe_opcode_t *ret_addr;
> +	kprobe_opcode_t **ret_addrp;
>  	struct task_struct *task;
>  	char data[0];
>  };
> @@ -203,6 +204,7 @@ static inline int kprobes_built_in(void)
>  extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				   struct pt_regs *regs);
>  extern int arch_trampoline_kprobe(struct kprobe *p);
> +extern void kretprobe_trampoline(void);
>  #else /* CONFIG_KRETPROBES */
>  static inline void arch_prepare_kretprobe(struct kretprobe *rp,
>  					struct pt_regs *regs)
> @@ -212,6 +214,9 @@ static inline int arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	return 0;
>  }
> +static inline void kretprobe_trampoline(void)
> +{
> +}
>  #endif /* CONFIG_KRETPROBES */
>  
>  extern struct kretprobe_blackpoint kretprobe_blacklist[];
> @@ -341,7 +346,7 @@ struct kprobe *get_kprobe(void *addr);
>  void kretprobe_hash_lock(struct task_struct *tsk,
>  			 struct hlist_head **head, unsigned long *flags);
>  void kretprobe_hash_unlock(struct task_struct *tsk, unsigned long *flags);
> -struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
> +struct hlist_head *kretprobe_inst_table_head(struct task_struct *tsk);
>  
>  /* kprobe_running() will just return the current_kprobe on this CPU */
>  static inline struct kprobe *kprobe_running(void)
> @@ -371,6 +376,9 @@ void unregister_kretprobe(struct kretprobe *rp);
>  int register_kretprobes(struct kretprobe **rps, int num);
>  void unregister_kretprobes(struct kretprobe **rps, int num);
>  
> +unsigned long kretprobe_ret_addr(struct task_struct *tsk, unsigned long ret,
> +				 unsigned long *retp);
> +
>  void kprobe_flush_task(struct task_struct *tk);
>  void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
>  
> @@ -425,6 +433,11 @@ static inline void unregister_kretprobe(struct kretprobe *rp)
>  static inline void unregister_kretprobes(struct kretprobe **rps, int num)
>  {
>  }
> +unsigned long kretprobe_ret_addr(struct task_struct *task, unsigned long ret,
> +				 unsigned long *retp)
> +{
> +	return ret;
> +}
>  static inline void kprobe_flush_task(struct task_struct *tk)
>  {
>  }
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 90e98e233647..ed78141664ec 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -83,6 +83,11 @@ static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
>  	return &(kretprobe_table_locks[hash].lock);
>  }
>  
> +struct hlist_head *kretprobe_inst_table_head(struct task_struct *tsk)
> +{
> +	return &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
> +}
> +
>  /* Blacklist -- list of struct kprobe_blacklist_entry */
>  static LIST_HEAD(kprobe_blacklist);
>  
> @@ -1206,6 +1211,15 @@ __releases(hlist_lock)
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_unlock);
>  
> +static bool kretprobe_hash_is_locked(struct task_struct *tsk)
> +{
> +	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> +	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> +
> +	return raw_spin_is_locked(hlist_lock);
> +}
> +NOKPROBE_SYMBOL(kretprobe_hash_is_locked);
> +
>  /*
>   * This function is called from finish_task_switch when task tk becomes dead,
>   * so that we can recycle any function-return probe instances associated
> @@ -1856,6 +1870,41 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> +unsigned long kretprobe_ret_addr(struct task_struct *tsk, unsigned long ret,
> +				 unsigned long *retp)
> +{
> +	struct kretprobe_instance *ri;
> +	unsigned long flags = 0;
> +	struct hlist_head *head;
> +	bool need_lock;
> +
> +	if (likely(ret != (unsigned long) &kretprobe_trampoline))
> +		return ret;
> +
> +	need_lock = !kretprobe_hash_is_locked(tsk);
> +	if (WARN_ON(need_lock))
> +		kretprobe_hash_lock(tsk, &head, &flags);
> +	else
> +		head = kretprobe_inst_table_head(tsk);

This may not work unless this is called from the kretprobe handler context,
since if we are out of kretprobe handler context, another CPU can lock the
hash table and it can be detected by kretprobe_hash_is_locked();.

So, we should check we are in the kretprobe handler context if tsk == current,
if not, we definately can lock the hash lock without any warning. This can
be something like;

if (is_kretprobe_handler_context()) {
  // kretprobe_hash_lock(current == tsk) has been locked by caller  
  if (tsk != current && kretprobe_hash(tsk) != kretprobe_hash(current))
    // the hash of tsk and current can be same.
    need_lock = true;
} else
  // we should take a lock for tsk.
  need_lock = true;


Thank you,

> +
> +	hlist_for_each_entry(ri, head, hlist) {
> +		if (ri->task != current)
> +			continue;
> +		if (ri->ret_addr == (kprobe_opcode_t *) &kretprobe_trampoline)
> +			continue;
> +		if (ri->ret_addrp == (kprobe_opcode_t **) retp) {
> +			ret = (unsigned long) ri->ret_addr;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	if (need_lock)
> +		kretprobe_hash_unlock(tsk, &flags);
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(kretprobe_ret_addr);
> +
>  bool __weak arch_kprobe_on_func_entry(unsigned long offset)
>  {
>  	return !offset;
> @@ -2005,6 +2054,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> +unsigned long kretprobe_ret_addr(struct task_struct *tsk, unsigned long ret,
> +				 unsigned long *retp)
> +{
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(kretprobe_ret_addr);
>  #endif /* CONFIG_KRETPROBES */
>  
>  /* Set the kprobe gone and remove its instruction buffer. */
> -- 
> 2.19.1


-- 
Masami Hiramatsu <mhiramat@kernel.org>
