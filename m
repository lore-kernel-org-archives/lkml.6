Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A007CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF722419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjDOz37h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DF722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeKOSsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbeKOSsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:48:37 -0500
Received: from devnote (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0583F2089D;
        Thu, 15 Nov 2018 08:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542271304;
        bh=ZlOBP4BK6/cN8ha7RZjNJSt2lIsxxfvauSGWcB5i06M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjDOz37hZUIV5agAveCx28C2q7JFQ2u9xDccAdjWgbUY88I6D8n5a5ibWchr8zEAo
         j119n/5JcHEMjERwaTnsbgJF5asEs1D5mgY40iwG7X6c0K+e3wm+vOYjMeIdj0GoJH
         w/4K3Nhx34Je37FhOYew/5/3TccZIS7opbQtjd60=
Date:   Thu, 15 Nov 2018 00:41:41 -0800
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Patrick Staehlin <me@packi.ch>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>, Zong Li <zong@andestech.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jim Wilson <jimw@sifive.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC/RFT 2/2] RISC-V: kprobes/kretprobe support
Message-Id: <20181115004141.5ed772834fc6bdf3467f244e@kernel.org>
In-Reply-To: <a6abc4ce-4398-5ca6-992b-efb31e01c5ca@packi.ch>
References: <20181113195804.22825-1-me@packi.ch>
        <20181113195804.22825-3-me@packi.ch>
        <20181114003730.06f810517a270070734df4ce@kernel.org>
        <a6abc4ce-4398-5ca6-992b-efb31e01c5ca@packi.ch>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 21:52:57 +0100
Patrick Staehlin <me@packi.ch> wrote:

> Hi Masami,
> 
> thank you for your remarks.
> 
> On 14.11.18 09:37, Masami Hiramatsu wrote>
> > Thank you very much for implementing kprobes on RISC-V :)
> > 
> > On Tue, 13 Nov 2018 20:58:04 +0100
> > Patrick Stählin <me@packi.ch> wrote:
> > 
> >> First implementation, adapted from arm64. The C.ADDISP16 instruction
> >> gets simulated and the kprobes-handler called by inserting a C.EBREAK
> >> instruction.
> >>
> >> C.ADDISP16 was chosen as it sets-up the stack frame for functions.
> >> Some work has been done to support probes on non-compressed
> >> instructions but there is no support yet for decoding those.
> > 
> > Does this only support C.ADDISP16? No other insns are supported?
> > Supporting 1 insn is too few I think.
> 
> At the moment, yes. I'm waiting for some input from somebody with deeper
> insights into the RISC-V architecture than me before implementing more
> instructions, should solution I've chosen be woefully inadequate.

I think starting with a few emulatable set of instruction support is good
to me. But maybe we need more... 1 instruction is too limited.


> > Can RISC-V do single stepping? If not, we need to prepare emulator
> > as match as possible, or for ALU instructions, we can run it on
> > buffer and hook it.
> 
> The debug-specification is still a draft but there are some softcores
> that implement it. But even if it was finalized I don't think this will
> be made a mandatory extension so we need to simulate/emulate a good part
> of the instruction set anyway.

OK.

[...]
> >> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> >> new file mode 100644
> >> index 000000000000..2d8f46f4c2e7
> >> --- /dev/null
> >> +++ b/arch/riscv/kernel/probes/decode-insn.c
> >> @@ -0,0 +1,38 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/kprobes.h>
> >> +#include <linux/module.h>
> >> +#include <linux/kallsyms.h>
> >> +#include <asm/sections.h>
> >> +
> >> +#include "decode-insn.h"
> >> +#include "simulate-insn.h"
> >> +
> >> +#define C_ADDISP16_MASK 0x6F83
> >> +#define C_ADDISP16_VAL  0x6101
> >> +
> >> +/* Return:
> >> + *   INSN_REJECTED     If instruction is one not allowed to kprobe,
> >> + *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
> >> + */
> >> +enum probe_insn __kprobes
> >> +riscv_probe_decode_insn(kprobe_opcode_t *addr, struct arch_probe_insn *api)
> > 
> > Please don't use __kprobes anymore. That is old stlye, instead, please
> > use NOKPROBE_SYMBOL() or nokprobe_inline for static-inline function.
> > (NOKPROBE_SYMBOL() will make the symbol non-inline always)
> 
> OK, should I make a note to change that in the arm64 port as well in a
> separate patch?

I think you don't need such note for this annotation. It should be fixed on arm64
too. (Sorry, that is my lazyness..)

[...]
> >> +
> >> +static void __kprobes kprobe_handler(struct pt_regs *regs)
> >> +{
> > 
> > Does this handler run under local IRQ disabled? (for making sure)
> 
> Exceptions are being handled with locals IRQs _enabled_.

Oops that's crazy and cool :D
So I guess it just implemented as an indirect jump referring the exception vector.
Just out of curiosity, is that enough safe for interruption?

> As we've not
> implemented any simulated instructions to modify the instruction
> pointer, I think this is safe? Then again, I'm new to this, so please
> bear with me.

kprobes itself should be safe, since I introduced a jump optimization,
which doing similar thing.

However, if it is not IRQ disabled, you must preempt_disable() right
before using get_kprobe_ctlblk() because it is per-cpu.

> >> +	struct kprobe *p, *cur_kprobe;
> >> +	struct kprobe_ctlblk *kcb;
> >> +	unsigned long addr = instruction_pointer(regs);
> >> +
> >> +	kcb = get_kprobe_ctlblk();
> >> +	cur_kprobe = kprobe_running();
> >> +
> >> +	p = get_kprobe((kprobe_opcode_t *) addr);
> >> +
> >> +	if (p) {
> >> +		if (cur_kprobe) {
> >> +			if (reenter_kprobe(p, regs, kcb))
> >> +				return;
> >> +		} else {
> >> +			/* Probe hit */
> >> +			set_current_kprobe(p);
> >> +			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >> +
> >> +			/*
> >> +			 * If we have no pre-handler or it returned 0, we
> >> +			 * continue with normal processing.  If we have a
> >> +			 * pre-handler and it returned non-zero, it will
> >> +			 * modify the execution path and no need to single
> >> +			 * stepping. Let's just reset current kprobe and exit.
> >> +			 *
> >> +			 * pre_handler can hit a breakpoint and can step thru
> >> +			 * before return, keep PSTATE D-flag enabled until
> >> +			 * pre_handler return back.
> > 
> > Is this true on RISC-V too?
> 
> It's not as we don't have a debug-unit at the moment. I'll remove the
> second part of the comment block.

OK.

> >> +			 */
> >> +			if (!p->pre_handler || !p->pre_handler(p, regs))
> >> +				simulate(p, regs, kcb, 0);
> >> +			else
> >> +				reset_current_kprobe();
> >> +		}
> >> +	}
> >> +	/*
> >> +	 * The breakpoint instruction was removed right
> >> +	 * after we hit it.  Another cpu has removed
> >> +	 * either a probepoint or a debugger breakpoint
> >> +	 * at this address.  In either case, no further
> >> +	 * handling of this interrupt is appropriate.
> >> +	 * Return back to original instruction, and continue.
> >> +	 */
> > 
> > This should return 0 if it doesn't handle anything, but if it handles c.break
> > should return 1.
> 
> I thought so too, but didn't insert one because of the comment (again,
> copied from arm64). If get_kprobe doesn't return a result, it could have
> been removed between the time the exception got raised or is the comment
> just wrong? On the other hand, solving it this way effectively means
> that we'll silently drop any other exceptions.

Hmm, in x86, original code, I checked the *addr whether there is a Breakpoint
instruction. If not, this means someone already removed it. If there is,
we just return to kernel's break handler and see what happens, since the breakpoint
instruction can be used from another subsystem. If no one handles it, kernel may
warn it finds stray breakpoint. (warning such case is kernel's work, not kprobes') 

I think I have to recheck the arm64's implementation again...


> >> +}
> >> +
> >> +int __kprobes
> >> +kprobe_breakpoint_handler(struct pt_regs *regs)
> >> +{
> >> +	kprobe_handler(regs);
> >> +	return 1;
> > 
> > Why don't you call kprobe_handler directly?
> 
> I should.
> 
> > 
> >> +}
> >> +
> >> +bool arch_within_kprobe_blacklist(unsigned long addr)
> >> +{
> >> +	if ((addr >= (unsigned long)__kprobes_text_start &&
> >> +	    addr < (unsigned long)__kprobes_text_end) ||
> >> +	    (addr >= (unsigned long)__entry_text_start &&
> >> +	    addr < (unsigned long)__entry_text_end) ||
> >> +	    !!search_exception_tables(addr))
> >> +		return true;
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> >> +{
> >> +	struct kretprobe_instance *ri = NULL;
> >> +	struct hlist_head *head, empty_rp;
> >> +	struct hlist_node *tmp;
> >> +	unsigned long flags, orig_ret_address = 0;
> >> +	unsigned long trampoline_address =
> >> +		(unsigned long)&kretprobe_trampoline;
> >> +	kprobe_opcode_t *correct_ret_addr = NULL;
> >> +
> > 
> > 	It seems you don't setup instruction_pointer.
> 
> I don't think I get what you mean by that. The instruction pointer (or
> rather the return address register) gets set by kretprobe_trampoline.S
> to the address returned from this function.

I meant regs->sepc should be set as the address of the trampoline function.
There is a histrical reason, but that is expected behavior...

[...]
> >> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> >> new file mode 100644
> >> index 000000000000..5734d9bae22f
> >> --- /dev/null
> >> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> >> @@ -0,0 +1,33 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +#include <linux/bitops.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/kprobes.h>
> >> +
> >> +#include "simulate-insn.h"
> >> +
> >> +#define bit_at(value, bit)		((value) & (1 << (bit)))
> >> +#define move_bit_at(value, bit, to)	((bit_at(value, bit) >> bit) << to)
> >> +
> >> +void __kprobes
> >> +simulate_caddisp16(u32 opcode, long addr, struct pt_regs *regs)
> >> +{
> >> +	s16 imm;
> >> +
> >> +	/*
> >> +	 * Immediate value layout in c.addisp16:
> >> +	 * xxx9 xxxx x468 75xx
> >> +	 * 1  1    8    4    0
> >> +	 * 5  2
> >> +	 */
> >> +	imm = sign_extend32(
> >> +		move_bit_at(opcode, 12, 9) |
> >> +		move_bit_at(opcode, 6, 4) |
> >> +		move_bit_at(opcode, 5, 6) |
> >> +		move_bit_at(opcode, 4, 8) |
> >> +		move_bit_at(opcode, 3, 7) |
> >> +		move_bit_at(opcode, 2, 5),
> >> +		9);
> >> +
> >> +	regs->sp += imm;
> > 
> > What about updating regs->sepc?
> 
> sepc gets updated by instruction_pointer_set in kprobe_handler

post_kprobe_handler()? Anyway, I think it should be updated in
this function or simulate() since it is a part of instruction execution.

> >> +}
> >> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
> >> new file mode 100644
> >> index 000000000000..dc2c06c30167
> >> --- /dev/null
> >> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> >> @@ -0,0 +1,8 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +
> >> +#ifndef _RISCV_KERNEL_KPROBES_SIMULATE_INSN_H
> >> +#define _RISCV_KERNEL_KPROBES_SIMULATE_INSN_H
> >> +
> >> +void simulate_caddisp16(u32 opcode, long addr, struct pt_regs *regs);
> >> +
> >> +#endif /* _RISCV_KERNEL_KPROBES_SIMULATE_INSN_H */
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index 24a9333dda2c..d7113178d401 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -18,6 +18,7 @@
> >>  #include <linux/sched/signal.h>
> >>  #include <linux/signal.h>
> >>  #include <linux/kdebug.h>
> >> +#include <linux/kprobes.h>
> >>  #include <linux/uaccess.h>
> >>  #include <linux/mm.h>
> >>  #include <linux/module.h>
> >> @@ -120,8 +121,14 @@ DO_ERROR_INFO(do_trap_ecall_m,
> >>  
> >>  asmlinkage void do_trap_break(struct pt_regs *regs)
> >>  {
> >> +	bool handler_found = false;
> >> +
> >> +#ifdef CONFIG_KPROBES
> >> +	if (kprobe_breakpoint_handler(regs))
> >> +		handler_found = 1;
> > 
> > Why don't you just return from here?
> 
> Following the pattern I've seen in other places, I can change that.

Yeah, I think it's simpler.

And I found that the kprobe_breakpoint_handler() was called without
checking !user_mode(regs). In that case, you should add the check in
front of kprobe_breakpoint_handler() call.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
