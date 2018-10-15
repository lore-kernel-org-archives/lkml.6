Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71353C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8062089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xhxgr3u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8062089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeJOUNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeJOUNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:13:02 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93F220652;
        Mon, 15 Oct 2018 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539606476;
        bh=auSy4bTOMYKNjeWeZavoZ3LgMModS2RYuwYJm6Gvkp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xhxgr3u8eHAnFW63NzL5V2k0m+8rza4YSMSOFgniG9TNAuoipD+IbFImttYSMxUds
         ziwM04yvKLiDxtG/Vc1/fxd5glwoCp7qRb/vg9w5XqqyWvjXwG3GiIHedT7LPTFGuZ
         tFq/PzQyUIM9N8BrLOl6TpWTrpt+bfsI1nMoxuRk=
Date:   Mon, 15 Oct 2018 21:27:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] arm64: kprobe: make page to RO mode when allocate it
Message-Id: <20181015212753.39e30fe38460fba455703309@kernel.org>
In-Reply-To: <CAKv+Gu8gHxeb-XUBUhnni4YEEKEO+Fy-AKr+DHgbL96VvR8RoQ@mail.gmail.com>
References: <20181015111600.5479-1-anders.roxell@linaro.org>
        <CAKv+Gu8gHxeb-XUBUhnni4YEEKEO+Fy-AKr+DHgbL96VvR8RoQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 13:22:12 +0200
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> (+ Masami)
> 
> On 15 October 2018 at 13:16, Anders Roxell <anders.roxell@linaro.org> wrote:
> > Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
> > has successfully identified code that leaves a page with W+X
> > permissions.
> >
> > [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
> > [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
> > [    3.246141] Modules linked in:
> > [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
> > [    3.247008] Hardware name: linux,dummy-virt (DT)
> > [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
> > [    3.247623] pc : note_page+0x410/0x420
> > [    3.247898] lr : note_page+0x410/0x420
> > [    3.248071] sp : ffff00000804bcd0
> > [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
> > [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
> > [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
> > [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
> > [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
> > [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
> > [    3.249924] x17: 0000000000000000 x16: 0000000000000000
> > [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
> > [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
> > [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
> > [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
> > [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
> > [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
> > [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
> > [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
> > [    3.252664] Call trace:
> > [    3.252953]  note_page+0x410/0x420
> > [    3.253186]  walk_pgd+0x12c/0x238
> > [    3.253417]  ptdump_check_wx+0x68/0xf8
> > [    3.253637]  mark_rodata_ro+0x68/0x98
> > [    3.253847]  kernel_init+0x38/0x160
> > [    3.254103]  ret_from_fork+0x10/0x18
> >
> > Reworked to that when allocate a page it sets mode RO. Inspired by
> > commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").

Yeah, that looks similar issue on x86, and looks good to me.
Thank you for fixing it!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 9b65132e789a..b842e908b423 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -23,7 +23,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/stop_machine.h>
> >  #include <linux/sched/debug.h>
> > +#include <linux/set_memory.h>
> >  #include <linux/stringify.h>
> > +#include <linux/vmalloc.h>
> >  #include <asm/traps.h>
> >  #include <asm/ptrace.h>
> >  #include <asm/cacheflush.h>
> > @@ -42,10 +44,21 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> >  static void __kprobes
> >  post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
> >
> > +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> > +{
> > +       void *addrs[1];
> > +       u32 insns[1];
> > +
> > +       addrs[0] = (void *)addr;
> > +       insns[0] = (u32)opcode;
> > +
> > +       return aarch64_insn_patch_text(addrs, insns, 1);
> > +}
> > +
> >  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >  {
> >         /* prepare insn slot */
> > -       p->ainsn.api.insn[0] = cpu_to_le32(p->opcode);
> > +       patch_text(p->ainsn.api.insn, p->opcode);
> >
> >         flush_icache_range((uintptr_t) (p->ainsn.api.insn),
> >                            (uintptr_t) (p->ainsn.api.insn) +
> > @@ -118,15 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >         return 0;
> >  }
> >
> > -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> > +void *alloc_insn_page(void)
> >  {
> > -       void *addrs[1];
> > -       u32 insns[1];
> > +       void *page;
> >
> > -       addrs[0] = (void *)addr;
> > -       insns[0] = (u32)opcode;
> > +       page = vmalloc_exec(PAGE_SIZE);
> > +       if (page)
> > +               set_memory_ro((unsigned long)page & PAGE_MASK, 1);
> >
> > -       return aarch64_insn_patch_text(addrs, insns, 1);
> > +       return page;
> >  }
> >
> >  /* arm kprobe: install breakpoint in text */
> > --
> > 2.19.1
> >


-- 
Masami Hiramatsu <mhiramat@kernel.org>
