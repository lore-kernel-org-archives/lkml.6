Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6C92082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeoyJhvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6C92082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLDNuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbeLDNuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:50:03 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EA8206B7;
        Tue,  4 Dec 2018 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543931402;
        bh=XWEJJsvDFbgkuCsALG6+PEpbc7VY/pnz5bn5e/wn0No=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GeoyJhvONJoyTwtQxRWZj82SgjGCXTupTqrkXKs1mTPqfcBGNTxLe/b4IM3dOP6K6
         iQ2BDTdvSdRYZMR61+NF2WSfpO2HMNHa6kRHX90hXzDdtbbgxtXKQt6VTwpRPDWu2y
         RujDqTR27/PrIX8CZ3wO6qpj6JDZYNoPMmXaX94g=
Date:   Tue, 4 Dec 2018 22:49:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michael Rodin <michael@rodin.online>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH -tip] kprobes/x86: Fix to copy RIP relative
 instruction correctly
Message-Id: <20181204224958.30d1080d4c4e795953e1588f@kernel.org>
In-Reply-To: <20181204081335.GB67285@gmail.com>
References: <153504457253.22602.1314289671019919596.stgit@devbox>
        <20181204081335.GB67285@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 09:13:35 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since copy_optimized_instructions() misses to update real RIP
> > address while copying several instructions to working buffer,
> > it adjusts RIP-relative instruction with wrong RIP address for
> > the 2nd and subsequent instructions.
> > 
> > This may break the kernel (like kernel freeze) because
> > probed instruction can refer a wrong data. For example,
> > putting kprobes on cpumask_next hit this bug.
> > 
> > cpumask_next is normally like below if CONFIG_CPUMASK_OFFSTACK=y
> > (in this case nr_cpumask_bits is an alias of nr_cpu_ids)
> > 
> >  <cpumask_next>:
> >        48 89 f0                mov    %rsi,%rax
> >        8b 35 7b fb e2 00       mov    0xe2fb7b(%rip),%esi
> >         # ffffffff82db9e64 <nr_cpu_ids>
> >        55                      push   %rbp
> > ...
> > 
> > If we put a kprobe on it and optimized with jump, it becomes
> > like this.
> > 
> > 	e9 95 7d 07 1e	jmpq   0xffffffffa000207a
> > 	7b fb	jnp    0xffffffff81f8a2e2 <cpumask_next+2>
> > 	e2 00	loop   0xffffffff81f8a2e9 <cpumask_next+9>
> > 	55	push   %rbp
> > 
> > This shows first 2 "mov" instructions are copied to trampoline
> > buffer at 0xffffffffa000207a. Here is the disassembled result.
> > (skipped optprobe template instructions)
> > 
> > Dump of assembler code from 0xffffffffa000207a to 0xffffffffa00020ea:
> > 	54	push   %rsp
> > ...
> > 	48 83 c4 08	add    $0x8,%rsp
> > 	9d	popfq
> > 	48 89 f0	mov    %rsi,%rax
> > 	8b 35 82 7d db e2	mov    -0x1d24827e(%rip),%esi
> >         # 0xffffffff82db9e67 <nr_cpu_ids+3>
> > 
> > As it shows, the 2nd mov accesses *(nr_cpu_ids+3) instead of
> > *nr_cpu_ids. This leads a kernel freeze because cpumask_next()
> > always returns 0 and for_each_cpu() never ended.
> > 
> > Fixing this by adding len correctly to real RIP address while
> > copying.
> > 
> > Fixes: 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()")
> > Reported-by: Michael Rodin <michael@rodin.online>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/x86/kernel/kprobes/opt.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> > index eaf02f2e7300..e92672b8b490 100644
> > --- a/arch/x86/kernel/kprobes/opt.c
> > +++ b/arch/x86/kernel/kprobes/opt.c
> > @@ -189,7 +189,8 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
> >  	int len = 0, ret;
> >  
> >  	while (len < RELATIVEJUMP_SIZE) {
> > -		ret = __copy_instruction(dest + len, src + len, real, &insn);
> > +		ret = __copy_instruction(dest + len, src + len, real + len,
> > +			&insn);
> 
> I applied this, except that I unbroke the line: please ignore checkpatch 
> in such cases where the cure is worse than the disease ...

Thanks Ingo!

> 
> I.e. even if slightly over 80 cols, this is more readable:
> 
> 		ret = __copy_instruction(dest + len, src + len, real + len, &insn);

Got it.

BTW, this ugry "+ len" repeat would be avoided. I would better make a new inline
function to wrap it.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
