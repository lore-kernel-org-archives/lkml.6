Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCEBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6E22409B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6E22409B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFVKtO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:49:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41132 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeFVKtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:49:12 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWJcj-0003ia-5S; Fri, 22 Jun 2018 12:49:01 +0200
Date:   Fri, 22 Jun 2018 12:49:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
In-Reply-To: <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2018, Fenghua Yu wrote:
> +static void wait_for_reexecution(void)
> +{
> +	while (time_before(jiffies, disable_split_lock_jiffies +
> +			   reenable_split_lock_delay))
> +		cpu_relax();
> +}
> +
> +/*
> + * TEST_CTL MSR is shared among threads on the same core. To simplify
> + * situation, disable_split_lock_jiffies is global instead of per core.

Simplify?

> + * Multiple threads may generate #AC for split lock at the same time.
> + * disable_split_lock_jiffies is updated by those threads. This may
> + * postpone re-enabling split lock on this thread. But that's OK
> + * because we need to make sure all threads on the same core re-execute
> + * their faulting instructions before re-enabling split lock on the core.

This does not ensure anything. It's a bandaid. If the task gets scheduled
out _before_ reexecuting then the timer will reenable AC and then when
scheduled back in it will trip it again.

> + * We want to avoid the situation when split lock is disabled on one
> + * thread (thus on the whole core), then split lock is re-enabled on
> + * another thread (thus on the whole core), and the faulting instruction
> + * generates another #AC on the first thread.
> + *
> + * Before re-enabling split lock, wait until there is no re-executed
> + * split lock instruction which may only exist before
> + * disable_split_lock_jiffies + reenable_split_lock_delay.
> + */
> +static void delayed_reenable_split_lock(struct work_struct *w)
> +{
> +	mutex_lock(&reexecute_split_lock_mutex);
> +	wait_for_reexecution();

And because the delayed work got scheduled after a tick and the other
thread just managed to make the timeout another tick longer, this thing
busy loops for a full tick with the mutex held. Groan.

> +	_setup_split_lock(ENABLE_SPLIT_LOCK_AC);
> +	mutex_unlock(&reexecute_split_lock_mutex);
> +}
> +
> +/* Will the faulting instruction be re-executed? */
> +static bool re_execute(struct pt_regs *regs)
> +{
> +	/*
> +	 * The only reason for generating #AC from kernel is because of
> +	 * split lock. The kernel faulting instruction will be re-executed.

Will be reexecuted? By what?

> +	 */
> +	if (!user_mode(regs))
> +		return true;
> +
> +	return false;
> +}

The extra value of this wrapper around !user_mode(regs) is that it is more
obfuscated than just having a sensible comment and a simple 'if
(user_mode(regs))' at the call site. Or is there anything I'm missing here?

> +static void disable_split_lock(void *unused)
> +{
> +	_setup_split_lock(DISABLE_SPLIT_LOCK_AC);
> +}
> +
> +/*
> + * #AC handler for split lock is called by generic #AC handler.
> + *
> + * Disable #AC for split lock on the CPU that the current task runs on
> + * in order for the faulting instruction to get executed. The #AC for split
> + * lock is re-enabled later.
> + */
> +bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
> +{
> +	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 5);
> +	char str[] = "alignment check for split lock";
> +	struct task_struct *tsk = current;
> +	int cpu = task_cpu(tsk);

What the heck is wrong with smp_processor_id()?

task_cpu(current) is the CPU on which current is running and that's nothing
else than smp_processor_id(). But sure, it would be too obvious and not
make a reviewer scratch his head while trying to figure out what the magic
cpu selection means.

> +
> +	if (!re_execute(regs))
> +		return false;

So user space just returns here. The explanatory comment for that is where?
It's not even in this hideous wrapper which inverts the condition.

> +
> +	/* Pace logging with jiffies. */
> +	if (__ratelimit(&ratelimit)) {
> +		pr_info("%s[%d] %s ip:%lx sp:%lx error:%lx",
> +			tsk->comm, tsk->pid, str,
> +			regs->ip, regs->sp, error_code);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);

Why the heck would print_vma_addr() of a kernel IP provide any useful
information? Kernel IP is in the kernel not in some random VMA.

What's wrong with a simple WARN() which is prominent and immediately
pointing to the right place?

> +
> +	mutex_lock(&reexecute_split_lock_mutex);

How is that supposed to work when the exception happens in a preempt or
interrupt disabled region? And what guarantees that there is no #AC inside
a reexecute_split_lock_mutex held region? It's just forbidden to have one
there, right? If there is one, then you still have the reset button.

> +	smp_call_function_single(cpu, disable_split_lock, NULL, 1);

When #AC happens in a interrupt disabled region then this will trigger the
irq disabled warning in smp_call_function_single(). Cannot happen because
it's forbidden to trip #AC in an interrupt disabled region, right?

Aside of that the value of using smp_call_function_single() instead of
invoking the function directly is? It makes sure that it's executed on:

	 task_cpu(current)

which is obviously the same as smp_processor_id(), i.e. the current
CPU. Makes a lot of sense especially as it has the added value that it
makes sure by setting 'wait = 1' that the function actually was
called.

> +	/*
> +	 * Mark the time when split lock is disabled for re-executing the
> +	 * faulting instruction.
> +	 */
> +	disable_split_lock_jiffies = jiffies;
> +	mutex_unlock(&reexecute_split_lock_mutex);
> +
> +	/* The faulting instruction will be re-executed when
> +	 * split lock is re-enabled 1 HZ later.

Ah, the reenablement of that stuff will re-execute the instruction. Now it
becomes more clear - NOT! These re-execution comments are just misleading
and wrong.

Aside of that Linus will love this comment style:

   https://lkml.kernel.org/r/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com

Why don't you use it everywhere?

> +	 */
> +	schedule_delayed_work_on(cpu, &per_cpu(reenable_delayed_work, cpu),
> +				 reenable_split_lock_delay);

That does work really well during early boot because #AC can only happen
after scheduler and workqueues are initialized and after late init calls
have been done which initialized the per cpu delayed work. Heck no. #AC
wants to be on right from the beginning.

This patch surely earns extra points in the trainwreck engineering contest,
but that's not taking place on LKML.

The whole thing is simply:

handle_ac()
{
	if (user_mode(regs)) {
		 do_trap(AC, SIGBUS, ...);
	} else {
		disable_ac_on_local_cpu();
		WARN_ONCE(1);
	}
}

That wants #AC enabled as early as possible so the kernel gets as much
coverage as it can. If it trips in the kernel it's a bug and needs to be
fixed and we can them fix ONE by ONE.

There is absolutely no requirement for all this so called "re-execution"
hackery. If there would be a true benefit of keeping #AC on after it
tripped in the kernel then you'd need to do 

	disable_ac()
	emulate_faulting_insn()
	enable_ac()

Obviously including refcounted synchronization of the disable/enable pair
with the CPUs which share the AC mechanics. Total overkill.

Thanks,

	tglx
