Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078552086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfBHNMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:12:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:12:44 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gs5xJ-0001QT-Qz; Fri, 08 Feb 2019 14:12:34 +0100
Date:   Fri, 8 Feb 2019 14:12:33 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
Message-ID: <20190208131233.5g5guefglq6ik2ow@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190130113555.GC18383@zn.tnic>
 <20190130120647.abbf2cbbpguaz356@linutronix.de>
 <20190130122713.GG18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130122713.GG18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 13:27:13 [+0100], Borislav Petkov wrote:
> On Wed, Jan 30, 2019 at 01:06:47PM +0100, Sebastian Andrzej Siewior wrote:
> > I don't know if hackbench would show anything besides noise.
> 
> Yeah, if a sensible benchmark (dunno if hackbench is among them :))
> shows no difference, is also saying something.

"hackbench -g80 -l 1000 -s 255" shows just noise. I don't see any
reasonable difference with or without the series.

Tracing. The following patch

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c5a6edd92de4f..aa1914e5bf5c0 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -292,6 +292,7 @@ struct fpu {
 	 * FPU state should be reloaded next time the task is run.
 	 */
 	unsigned int			last_cpu;
+	unsigned int avoided_loads;
 
 	/*
 	 * @state:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c98c54e796186..7560942a550ed 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -358,9 +358,11 @@ void fpu__clear(struct fpu *fpu)
  */
 void switch_fpu_return(void)
 {
+	struct fpu *fpu = &current->thread.fpu;
+
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
-
+	fpu->avoided_loads = 0;
 	__fpregs_load_activate();
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 37b2ecef041e6..875f74b1e8779 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -522,6 +522,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);
+	else if (current->mm) {
+		prev_fpu->avoided_loads++;
+		trace_printk("skipped save %d\n", prev_fpu->avoided_loads);
+	}
 
 	/* We must save %fs and %gs before load_TLS() because
 	 * %fs and %gs may be cleared by load_TLS().

should help to spot the optimization. So if TIF_NEED_FPU_LOAD is set at
this point then between this and the last invocation of schedule() we
haven't been in userland and so we avoided loading + storing of FPU
registers. I saw things like:

|  http-1935  [001] d..2   223.460434: sched_switch: prev_comm=http prev_pid=1935 prev_prio=120 prev_state=R+ ==> next_comm=apt next_pid=1931 next_prio=120
|   apt-1931  [001] d..2   223.460680: sched_switch: prev_comm=apt prev_pid=1931 prev_prio=120 prev_state=D ==> next_comm=http next_pid=1935 next_prio=120
|  http-1935  [001] d..2   223.460729: sched_switch: prev_comm=http prev_pid=1935 prev_prio=120 prev_state=R+ ==> next_comm=apt next_pid=1931 next_prio=120
|  http-1935  [001] d..2   223.460732: __switch_to: skipped save 1
|   apt-1931  [001] d..2   223.461076: sched_switch: prev_comm=apt prev_pid=1931 prev_prio=120 prev_state=D ==> next_comm=http next_pid=1935 next_prio=120
|  http-1935  [001] d..2   223.461111: sched_switch: prev_comm=http prev_pid=1935 prev_prio=120 prev_state=R+ ==> next_comm=apt next_pid=1931 next_prio=120
|  http-1935  [001] d..2   223.461112: __switch_to: skipped save 2

which means we avoided loading FPU registers for `http' because for some
reason it was not required. Here we switched between two user tasks so
without the patches we would have to save and restore them.

I captured a few instances of something like:

|  rcu_preempt-10    [000] d..2  1032.867293: sched_switch: prev_comm=rcu_preempt prev_pid=10 prev_prio=98 prev_state=I ==> next_comm=kswapd0 next_pid=536 next_prio=120
|          apt-1954  [001] d..2  1032.867435: sched_switch: prev_comm=apt prev_pid=1954 prev_prio=120 prev_state=R+ ==> next_comm=kworker/1:0 next_pid=1943 next_prio=120
|          apt-1954  [001] d..2  1032.867436: __switch_to: skipped save 30
|  kworker/1:0-1943  [001] d..2  1032.867455: sched_switch: prev_comm=kworker/1:0 prev_pid=1943 prev_prio=120 prev_state=I ==> next_comm=apt next_pid=1954 next_prio=120
|          apt-1954  [001] d..2  1032.867459: sched_switch: prev_comm=apt prev_pid=1954 prev_prio=120 prev_state=D ==> next_comm=swapper/1 next_pid=0 next_prio=120
|          apt-1954  [001] d..2  1032.867460: __switch_to: skipped save 31

It has been avoided to restore and save the FPU register of `apt' 31
times (in a row). This isn't 100% true. We switched to and from a kernel
thread to `apt' so switch_fpu_finish() wouldn't load the registers
because the switch to the kernel thread (switch_fpu_prepare()) would not
destroy them. *However* the switch away from `apt' would save the FPU
registers so we avoid this (current code always saves FPU registers on
context switch, see switch_fpu_prepare()).
My understanding is that if the CPU supports `xsaves' then it wouldn't
save anything in this scenario because the CPU would notice that its FPU
state didn't change since last time so no need to save anything.

Then we have lat_sig [0]. Without the series 64bit:
|Signal handler overhead: 2.6839 microseconds
|Signal handler overhead: 2.6996 microseconds
|Signal handler overhead: 2.6821 microseconds

with the series:
|Signal handler overhead: 3.2976 microseconds
|Signal handler overhead: 3.3033 microseconds
|Signal handler overhead: 3.2980 microseconds

that is approximately 22% worse. Without the series 64bit kernel with
32bit binary:
| Signal handler overhead: 3.8139 microseconds
| Signal handler overhead: 3.8035 microseconds
| Signal handler overhead: 3.8127 microseconds

with the series:
| Signal handler overhead: 4.0434 microseconds
| Signal handler overhead: 4.0438 microseconds
| Signal handler overhead: 4.0408 microseconds

approximately 6% worse. I'm a little surprised in the 32bit case because
it did save+copy earlier (while the 64bit saved it directly to signal
stack).

If we restore directly from signal stack (instead the copy_from_user())
we get to (64bit only):
| Signal handler overhead: 3.0376 microseconds
| Signal handler overhead: 3.0687 microseconds
| Signal handler overhead: 3.0510 microseconds

and if additionally save the registers to the signal stack:
| Signal handler overhead: 2.7835 microseconds
| Signal handler overhead: 2.7850 microseconds
| Signal handler overhead: 2.7766 microseconds

then we get almost to where we started. I will fire a commit per commit
bench to see if I notice something.
Ach and this was PREEMPT on a 
|x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.

machine. So those with AVX-512 might be worse but I don't have any of
those.

[0] Part of lmbench, test
    taskset 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/lat_sig -P 1 -W 64 -N 5000 catch

Sebastian
