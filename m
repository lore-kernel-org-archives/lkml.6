Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A282EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028D223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS60Gwj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6028D223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeKOR4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeKOR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:56:48 -0500
Received: from devnote (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65B921582;
        Thu, 15 Nov 2018 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542268205;
        bh=7XF1fezt0O4sBhR1B3rFJZPqT8zuYrpGPjBU7AFtfVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jS60Gwj9r2E30VJAwmTJLaRMKpOngFEOs3p1uRfYwwZIyd2Z47qkL2fDbQ7rR9Vpm
         Hqnhc7GtrDkcAi7uKIP/aMXogmy09sKrUXuf/cjgZv/tRSkUJ3xnkFXYIjo2zWnahO
         UfKliDkgZDf7emclSTPg8fclyO+fzKXrDlVpyO74=
Date:   Wed, 14 Nov 2018 23:50:04 -0800
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
Message-Id: <20181114235004.1d57d911e15efaa8f18fa75e@kernel.org>
In-Reply-To: <05082ba4-33d6-a95c-e049-78791dafc009@packi.ch>
References: <20181113195804.22825-1-me@packi.ch>
        <20181113195804.22825-3-me@packi.ch>
        <20181114003730.06f810517a270070734df4ce@kernel.org>
        <20181114074951.0902699286fdf8652f2878a4@kernel.org>
        <05082ba4-33d6-a95c-e049-78791dafc009@packi.ch>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 22:10:52 +0100
Patrick Staehlin <me@packi.ch> wrote:

> On 14.11.18 16:49, Masami Hiramatsu wrote:
> > On Wed, 14 Nov 2018 00:37:30 -0800
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >>> +
> >>> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> >>> +{
> >>> +	if (is_compressed_insn(opcode))
> >>> +		*(u16 *)addr = cpu_to_le16(opcode);
> >>> +	else
> >>> +		*addr = cpu_to_le32(opcode);
> >>> +
> > 
> > BTW, don't RISC-V need any i-cache flush and per-core serialization
> > for patching the text area? (and no text_mutex protection?)
> 
> Yes, we should probably call flush_icache_all. This code works on
> QEMU/virt but I guess on real hardware you may run into problems,
> especially when disarming the kprobe. I'll have a look at the arm64 code
> again to see what's missing.

Note that self code-modifying is a special case for any processors, especially
if that is multi-processor. In general, this may depend on the circuit desgin,
not ISA.
Some processor implementation will do in-order and no i-cache, no SMP, that will
be simple, but if it is out-of-order, deep pipeline, huge i-cache, and many-core,
you might have to care many things. We have to talk with someone who is designing
real hardware, and maybe better to make the patch_text pluggable for variants.
(or choose the safest way)

> >>> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
> >>> new file mode 100644
> >>> index 000000000000..c7ceda9556a3
> >>> --- /dev/null
> >>> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
> >>> @@ -0,0 +1,91 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0+ */
> >>> +
> >>> +#include <linux/linkage.h>
> >>> +
> >>> +#include <asm/asm.h>
> >>> +#include <asm/asm-offsets.h>
> >>> +
> >>> +	.text
> >>> +	.altmacro
> >>> +
> >>> +	.macro save_all_base_regs
> >>> +	REG_S x1,  PT_RA(sp)
> >>> +	REG_S x3,  PT_GP(sp)
> >>> +	REG_S x4,  PT_TP(sp)
> >>> +	REG_S x5,  PT_T0(sp)
> >>> +	REG_S x6,  PT_T1(sp)
> >>> +	REG_S x7,  PT_T2(sp)
> >>> +	REG_S x8,  PT_S0(sp)
> >>> +	REG_S x9,  PT_S1(sp)
> >>> +	REG_S x10, PT_A0(sp)
> >>> +	REG_S x11, PT_A1(sp)
> >>> +	REG_S x12, PT_A2(sp)
> >>> +	REG_S x13, PT_A3(sp)
> >>> +	REG_S x14, PT_A4(sp)
> >>> +	REG_S x15, PT_A5(sp)
> >>> +	REG_S x16, PT_A6(sp)
> >>> +	REG_S x17, PT_A7(sp)
> >>> +	REG_S x18, PT_S2(sp)
> >>> +	REG_S x19, PT_S3(sp)
> >>> +	REG_S x20, PT_S4(sp)
> >>> +	REG_S x21, PT_S5(sp)
> >>> +	REG_S x22, PT_S6(sp)
> >>> +	REG_S x23, PT_S7(sp)
> >>> +	REG_S x24, PT_S8(sp)
> >>> +	REG_S x25, PT_S9(sp)
> >>> +	REG_S x26, PT_S10(sp)
> >>> +	REG_S x27, PT_S11(sp)
> >>> +	REG_S x28, PT_T3(sp)
> >>> +	REG_S x29, PT_T4(sp)
> >>> +	REG_S x30, PT_T5(sp)
> >>> +	REG_S x31, PT_T6(sp)
> >>> +	.endm
> >>> +
> >>> +	.macro restore_all_base_regs
> >>> +	REG_L x3,  PT_GP(sp)
> >>> +	REG_L x4,  PT_TP(sp)
> >>> +	REG_L x5,  PT_T0(sp)
> >>> +	REG_L x6,  PT_T1(sp)
> >>> +	REG_L x7,  PT_T2(sp)
> >>> +	REG_L x8,  PT_S0(sp)
> >>> +	REG_L x9,  PT_S1(sp)
> >>> +	REG_L x10, PT_A0(sp)
> >>> +	REG_L x11, PT_A1(sp)
> >>> +	REG_L x12, PT_A2(sp)
> >>> +	REG_L x13, PT_A3(sp)
> >>> +	REG_L x14, PT_A4(sp)
> >>> +	REG_L x15, PT_A5(sp)
> >>> +	REG_L x16, PT_A6(sp)
> >>> +	REG_L x17, PT_A7(sp)
> >>> +	REG_L x18, PT_S2(sp)
> >>> +	REG_L x19, PT_S3(sp)
> >>> +	REG_L x20, PT_S4(sp)
> >>> +	REG_L x21, PT_S5(sp)
> >>> +	REG_L x22, PT_S6(sp)
> >>> +	REG_L x23, PT_S7(sp)
> >>> +	REG_L x24, PT_S8(sp)
> >>> +	REG_L x25, PT_S9(sp)
> >>> +	REG_L x26, PT_S10(sp)
> >>> +	REG_L x27, PT_S11(sp)
> >>> +	REG_L x28, PT_T3(sp)
> >>> +	REG_L x29, PT_T4(sp)
> >>> +	REG_L x30, PT_T5(sp)
> >>> +	REG_L x31, PT_T6(sp)
> >>> +	.endm
> > 
> > 
> > It seems thses macros can be (partially?) shared with entry.S
> 
> Yes, I wanted to avoid somebody changing the shared code and breaking
> random things. But that's what reviews are for. I'll think of something
> for v2.

Ah, OK. So for the first version, we introduce this separated code until
someone complains it.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
