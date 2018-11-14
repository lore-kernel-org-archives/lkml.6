Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74B72243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6am2etp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74B72243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeKOBxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732950AbeKOBxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:53:39 -0500
Received: from devnote (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D5A214F1;
        Wed, 14 Nov 2018 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542210592;
        bh=D18OzsVre62OCCAyxjcygNQHmbI7ApSJ9PDtChqSB9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6am2etpp90qUteJ6dJ6NBAHnp+G5DSaXGjx0dzIYNfT0FIgeuMTAML4a/SFB0cv3
         yTP4GteG1Nj0lNi9Aza3P/qQx5oYKx89pOV924JEOf3nI8jnu6wj2l1NNzgY0ibS/M
         aBOhA/Gxme7UqJkM5b0CsjJgZTwIhTvdZ43j4otI=
Date:   Wed, 14 Nov 2018 07:49:51 -0800
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Patrick =?UTF-8?B?U3TDpGhsaW4=?= <me@packi.ch>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Message-Id: <20181114074951.0902699286fdf8652f2878a4@kernel.org>
In-Reply-To: <20181114003730.06f810517a270070734df4ce@kernel.org>
References: <20181113195804.22825-1-me@packi.ch>
        <20181113195804.22825-3-me@packi.ch>
        <20181114003730.06f810517a270070734df4ce@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 00:37:30 -0800
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +
> > +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> > +{
> > +	if (is_compressed_insn(opcode))
> > +		*(u16 *)addr = cpu_to_le16(opcode);
> > +	else
> > +		*addr = cpu_to_le32(opcode);
> > +

BTW, don't RISC-V need any i-cache flush and per-core serialization
for patching the text area? (and no text_mutex protection?)

> > diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
> > new file mode 100644
> > index 000000000000..c7ceda9556a3
> > --- /dev/null
> > +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
> > @@ -0,0 +1,91 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#include <linux/linkage.h>
> > +
> > +#include <asm/asm.h>
> > +#include <asm/asm-offsets.h>
> > +
> > +	.text
> > +	.altmacro
> > +
> > +	.macro save_all_base_regs
> > +	REG_S x1,  PT_RA(sp)
> > +	REG_S x3,  PT_GP(sp)
> > +	REG_S x4,  PT_TP(sp)
> > +	REG_S x5,  PT_T0(sp)
> > +	REG_S x6,  PT_T1(sp)
> > +	REG_S x7,  PT_T2(sp)
> > +	REG_S x8,  PT_S0(sp)
> > +	REG_S x9,  PT_S1(sp)
> > +	REG_S x10, PT_A0(sp)
> > +	REG_S x11, PT_A1(sp)
> > +	REG_S x12, PT_A2(sp)
> > +	REG_S x13, PT_A3(sp)
> > +	REG_S x14, PT_A4(sp)
> > +	REG_S x15, PT_A5(sp)
> > +	REG_S x16, PT_A6(sp)
> > +	REG_S x17, PT_A7(sp)
> > +	REG_S x18, PT_S2(sp)
> > +	REG_S x19, PT_S3(sp)
> > +	REG_S x20, PT_S4(sp)
> > +	REG_S x21, PT_S5(sp)
> > +	REG_S x22, PT_S6(sp)
> > +	REG_S x23, PT_S7(sp)
> > +	REG_S x24, PT_S8(sp)
> > +	REG_S x25, PT_S9(sp)
> > +	REG_S x26, PT_S10(sp)
> > +	REG_S x27, PT_S11(sp)
> > +	REG_S x28, PT_T3(sp)
> > +	REG_S x29, PT_T4(sp)
> > +	REG_S x30, PT_T5(sp)
> > +	REG_S x31, PT_T6(sp)
> > +	.endm
> > +
> > +	.macro restore_all_base_regs
> > +	REG_L x3,  PT_GP(sp)
> > +	REG_L x4,  PT_TP(sp)
> > +	REG_L x5,  PT_T0(sp)
> > +	REG_L x6,  PT_T1(sp)
> > +	REG_L x7,  PT_T2(sp)
> > +	REG_L x8,  PT_S0(sp)
> > +	REG_L x9,  PT_S1(sp)
> > +	REG_L x10, PT_A0(sp)
> > +	REG_L x11, PT_A1(sp)
> > +	REG_L x12, PT_A2(sp)
> > +	REG_L x13, PT_A3(sp)
> > +	REG_L x14, PT_A4(sp)
> > +	REG_L x15, PT_A5(sp)
> > +	REG_L x16, PT_A6(sp)
> > +	REG_L x17, PT_A7(sp)
> > +	REG_L x18, PT_S2(sp)
> > +	REG_L x19, PT_S3(sp)
> > +	REG_L x20, PT_S4(sp)
> > +	REG_L x21, PT_S5(sp)
> > +	REG_L x22, PT_S6(sp)
> > +	REG_L x23, PT_S7(sp)
> > +	REG_L x24, PT_S8(sp)
> > +	REG_L x25, PT_S9(sp)
> > +	REG_L x26, PT_S10(sp)
> > +	REG_L x27, PT_S11(sp)
> > +	REG_L x28, PT_T3(sp)
> > +	REG_L x29, PT_T4(sp)
> > +	REG_L x30, PT_T5(sp)
> > +	REG_L x31, PT_T6(sp)
> > +	.endm


It seems thses macros can be (partially?) shared with entry.S

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
