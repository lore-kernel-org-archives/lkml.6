Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FF62241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FF62241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeKLVoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:44:09 -0500
Received: from verein.lst.de ([213.95.11.211]:50058 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbeKLVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:44:09 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 152A967358; Mon, 12 Nov 2018 12:51:13 +0100 (CET)
Date:   Mon, 12 Nov 2018 12:51:13 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 1/3] arm64: implement ftrace with regs
Message-ID: <20181112115112.GB30967@lst.de>
References: <20181026142008.D922868C94@newverein.lst.de> <20181026142148.6353A68C94@newverein.lst.de> <CAKv+Gu-rNeCj5jySq4H5mRONtWfoLy7ADsowWNW+LUBLMWnV+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-rNeCj5jySq4H5mRONtWfoLy7ADsowWNW+LUBLMWnV+A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:12:42PM +0100, Ard Biesheuvel wrote:
> 
> On 26 October 2018 at 16:21, Torsten Duwe <duwe@lst.de> wrote:
> > @@ -162,6 +165,114 @@ ftrace_graph_call:                        // ftrace_graph_cal
> >
> >         mcount_exit
> >  ENDPROC(ftrace_caller)
> > +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > +
> > +/*
> > + * Since no -pg or similar compiler flag is used, there should really be
> > + * no reference to _mcount; so do not define one. Only some value for
> > + * MCOUNT_ADDR is needed for comparison. Let it point here to have some
> > + * sort of magic value that can be recognised when debugging.
> > + */
> > +       .global _mcount
> > +_mcount:
> > +       ret     /* make it differ from regs caller */
> > +
> > +ENTRY(ftrace_regs_caller)
> > +       /* callee's preliminary stack frame: */
> > +       stp     fp, x9, [sp, #-16]!
> 
> Does the 'fp' alias for x29 work with older assemblers? I guess it
> does not matter gor GCC 8+ code, but be careful when you rewrite
> existing stuff.

I had gotten the impression the fp alias was there ever since, so I used
it for readability. Thanks for the notification, I'll double check.

> > +       mov     fp, sp
> > +
> > +       /* our stack frame: */
> > +       stp     fp, lr, [sp, #-S_FRAME_SIZE]!
> 
> If sizeof(struct pt_regs) == S_FRAME_SIZE), you should subtract 16
> additional bytes here

This is intentional :-]

At the end of pt_regs there's a "stackframe", which now aligns with the
"preliminary" frame I create for the callee. Please tell me what the struct
member is good for if not for an actual callee stack frame...
I thought it was a neat idea.

> > +
> > +ftrace_common:
> > +       /*
> > +        * At this point we have 2 new stack frames, and x9 pointing
> > +        * at a pt_regs which we can populate as needed.
> > +        */
> > +
> > +       /* save function arguments */
> > +       stp     x0, x1, [x9]
> > +       stp     x2, x3, [x9, #S_X2]
> > +       stp     x4, x5, [x9, #S_X4]
> > +       stp     x6, x7, [x9, #S_X6]
> > +       stp     x8, x9, [x9, #S_X8]
> > +
> 
> x9 is not a function argument, and if it were, you'd have clobbered it
> by now. Please use a single 'str' and store x8 only

This way the x9 slot in pt_regs will be undefined. Is that ok with everybody?

> > +ftrace_common_return:
> > +       add     x9, sp, #16     /* advance to pt_regs for restore */
> > +
> > +       ldp     x0, x1, [x9]
> > +       ldp     x2, x3, [x9, #S_X2]
> > +       ldp     x4, x5, [x9, #S_X4]
> > +       ldp     x6, x7, [x9, #S_X6]
> > +       ldp     x8, x9, [x9, #S_X8]
> > +
> 
> Same as above. It also deserves a mention that you are relying on the
> absence of IPA-RA, and so x9..x18 are guaranteed to be dead at
> function entry, and so they don't need to be restored here.

Sure, I can quote some ABI spec here :-/
I just wish all arm code was such well documented.

> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -65,18 +65,61 @@ int ftrace_update_ftrace_func(ftrace_fun
> >         return ftrace_modify_code(pc, 0, new, false);
> >  }
> >
> > +#ifdef CONFIG_ARM64_MODULE_PLTS
> > +static int install_ftrace_trampoline(struct module *mod, unsigned long *addr)
> > +{
> > +       struct plt_entry trampoline, *mod_trampoline;
> > +       trampoline = get_plt_entry(*addr);
> > +
> > +       if (*addr == FTRACE_ADDR)
> > +               mod_trampoline = mod->arch.ftrace_trampoline;
> > +       else if (*addr == FTRACE_REGS_ADDR)
> > +               mod_trampoline = mod->arch.ftrace_regs_trampoline;
> 
> Could we do something like
> 
> if (*addr == FTRACE_ADDR)
>     mod_trampoline = &mod->arch.ftrace_trampoline[0];
> else if (*addr == FTRACE_REGS_ADDR)
>     mod_trampoline = &mod->arch.ftrace_trampoline[1];
> 
> and get rid of the additional struct field and pointer?

"0" and "1" won't make it obvious which one has the regs tracing, but besides
that, I like the idea of making this a small array. Other opinions?

	Torsten

