Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E1820684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iByubt0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfAVNzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:55:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44250 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfAVNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:55:25 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so19103368iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va/webB65xAQkHXqaHqTjHSAjNDLESnhLUArsDNowQQ=;
        b=iByubt0YbEMmC4ppjgC9ANZeBGsR4BavV8L/2iNC6MyZe+L66+TPQalc2P2SPSGash
         XJj5pf/CJ+xLVEdDlARRU9RTmZX+w8xKPJGEQwMVZ+Tr1DJhmUhaD43xOvi9+AaWTdS2
         iXxGmkF68bx3/5py9Z+hCoiCJ6Zlv24sChnZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va/webB65xAQkHXqaHqTjHSAjNDLESnhLUArsDNowQQ=;
        b=PVDi5BVDcD0g1sU8OiprL7L+B2LO+6nN8oI2hdso3W93CIqzZywAu5AeEN+4YBUPrg
         ZZbp2kH1kth36syrmU617BmZ7ozv206nAw1NjfRTxogvcF87CrvYz5m5IfJ3Lx3/F98Y
         m4bmCkJ8Epnxe2x/KSygjSQLDzibnaPZhMwEQr8FDV9pZnj7rqP13KdEqjSWbBViu+sd
         Mg1DSDg+tlWgbl1WVVoCMQFD0PlSDE1gAnXquSNKQDsrBGsUZrIwmGtNhKvt+BxaYsvK
         e9KrpUj4uslB5WLEdtNWZWFmb7loEkLX2dYsaEAbrrzEWGRWyKI0qXU/bdcaprmnRSWF
         cWRw==
X-Gm-Message-State: AJcUukdu5DXj1Tsxc5SeST8QB2oQVJIMlkRUTkRW/aKdFpKpbG9KlPuI
        sMy1LqgoaG/TVd5SJzD5ST1S32HIQJzsqoFE4BtwhQ==
X-Google-Smtp-Source: ALg8bN4CUfmaQUvoD7ZDD41LIBAEW2D3uGNjzrxf/RVj5hl6IUC2vYme9V0ycJE2uU/6U9Q9Q/WBwVCQpIGfJsSbYXs=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr19964688iop.60.1548165323852;
 Tue, 22 Jan 2019 05:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20190118163736.6A99268CEB@newverein.lst.de> <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com> <20190122132832.GB16778@lst.de>
In-Reply-To: <20190122132832.GB16778@lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Jan 2019 14:55:12 +0100
Message-ID: <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 14:28, Torsten Duwe <duwe@lst.de> wrote:
>
> On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
> > Hi Torsten,
> >
> > A few suggestions below.
> >
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > > +/* All we need is some magic value. Simply use "_mCount:" */
> >
> > Nit: Should the casing be "_mcount" ?
>
> No! The string makes it clear what it's supposed to be and the peculiar
> casing makes it unique and leaves no doubt were it came from. So whenever
> you see this register value in a crash dump you don't have to wonder about
> weird linkage errors, as it surely did not originate from a symtab.
>

In that case, do you need to deal with endianness here?

> > > +#define MCOUNT_ADDR                (0x5f6d436f756e743a)
> > > +#else
> > > +#define REC_IP_BRANCH_OFFSET 0
> > > +#define MCOUNT_ADDR                ((unsigned long)_mcount)
> > > +#endif
> > > +
> > >  #ifndef __ASSEMBLY__
> > >  #include <linux/compat.h>
> > >
> > > --- a/arch/arm64/kernel/entry-ftrace.S
> > > +++ b/arch/arm64/kernel/entry-ftrace.S
> > > @@ -10,6 +10,7 @@
> > >   */
> > >
> > >  #include <linux/linkage.h>
> > > +#include <asm/asm-offsets.h>
> > >  #include <asm/assembler.h>
> > >  #include <asm/ftrace.h>
> > >  #include <asm/insn.h>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +ENTRY(ftrace_common)
> > > +
> > > +   mov     x3, sp          /* pt_regs are @sp */
> > > +   ldr_l   x2, function_trace_op, x0
> > > +   mov     x1, x9          /* parent IP */
> > > +   sub     x0, lr, #8      /* function entry == IP */
> >
> > The #8 is because we go back two instructions right? Can we use
> > #(AARCH64_INSN_SIZE * 2) instead?
>
> Hmm, <asm/insn.h> was already included, so why not. (same below)
>
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> > > +                   unsigned long addr)
> > > +{
> > > +   unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> > > +   u32 old, new;
> > > +
> > > +   old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> > > +   new = aarch64_insn_gen_branch_imm(pc, addr, true);
> >
> > The last argument of aarch64_insn_gen_branch_imm() is an enum, not a
> > boolean.
> >
> > You should use AARCH64_INSN_BRANCH_LINK here which happens to be equal to 1.
>
> That's what you get when you keep copying code...
> Good catch, thanks!
>
> > > +    *  initially; the NOPs are already there. So instead,
> > > +    *  put the LR saver there ahead of time, in order to avoid
> > > +    *  any race condition over patching 2 instructions.
> > > +    */
> > > +   if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> > > +           addr == MCOUNT_ADDR) {
> >
> > This works, however it feels a bit weird since core code asked to
> > generate a NOP but not only we don't generate it but we put another
> > instruction instead.
>
> It's not the first time weird x86 sets the standards and all others
> need workarounds. But here it just came handy to abuse this call :-)
>
> > I think it would be useful to state that the replacement of mcount calls
> > by nops is only ever done once at system initialization.
> >
> > Or maybe have a intermediate function:
> >
> > static int ftrace_setup_patchable_entry(unsigned long addr)
> > {
> >       u32 old, new;
> >
> >       old = aarch64_insn_gen_nop();
> >       new = MOV_X9_X30;
> >       pc -= REC_IP_BRANCH_OFFSET;
> >       return ftrace_modify_code(pc, old, new, validate);
> > }
> >
> >       [...]
> >
> >       if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> >               addr == MCOUNT_ADDR)
> >               return ftrace_setup_patchable_entry(pc);
> >
> >
> > This way it clearly show that this is a setup/init corner case.
>
> I'll definitely consider this.
>
> Thanks for the input,
>
>         Torsten
>
>
