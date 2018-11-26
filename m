Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F3B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqbAlI9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F3B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeK0FXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725199AbeK0FXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:23:19 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5382086E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543256902;
        bh=1FbfjxumzL31JcgS38noQ3Mg7ckl6RT6axMBxEObQV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WqbAlI9slgEI354KkMfMS25Q/Wg28Xd6HgNjSf51wZd50Oivd9WI7ydcC94VDvGNA
         fB9RggYFsyru+nTrEP7Q5Z2luidB0sKM3Vi7TE80ftAvmEBPJZFBBhKppCUmJEysp1
         C843E1gaRgv84wv9NW9/x+ESPjZxSd02as1+GcSM=
Received: by mail-wm1-f44.google.com with SMTP id y185so13147243wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:28:22 -0800 (PST)
X-Gm-Message-State: AA+aEWb/r1lL5EYILczENIMwu0DaePLfuQmcL31B1+f2uQQKU7gyL209
        mLJLxHRZVxEBHAHNkIMrVQguFO/Gtp4irunAvi3pbw==
X-Google-Smtp-Source: AJdET5cb1NiFbrOTCuP/SGdE533oSXc70NGkYrzyKQg19MlISEqYkugkcoKoX4gy+62clns5qhaPvqszF5+heLkwYa4=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr25095001wmf.32.1543256900794;
 Mon, 26 Nov 2018 10:28:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543200841.git.jpoimboe@redhat.com> <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net> <20181126171036.chcbmb35ygpxziub@treble>
In-Reply-To: <20181126171036.chcbmb35ygpxziub@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 26 Nov 2018 10:28:08 -0800
X-Gmail-Original-Message-ID: <CALCETrX+FP4V+SoMEwX2-WeSmr2g2xZvGbS5qthuO6N6dXE+bQ@mail.gmail.com>
Message-ID: <CALCETrX+FP4V+SoMEwX2-WeSmr2g2xZvGbS5qthuO6N6dXE+bQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:10 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Nov 26, 2018 at 05:02:17PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> > > diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> > > index 8026d176f25c..d3869295b88d 100644
> > > --- a/arch/x86/kernel/static_call.c
> > > +++ b/arch/x86/kernel/static_call.c
> > > @@ -9,13 +9,21 @@
> > >
> > >  void static_call_bp_handler(void);
> > >  void *bp_handler_dest;
> > > +void *bp_handler_continue;
> > >
> > >  asm(".pushsection .text, \"ax\"                                            \n"
> > >      ".globl static_call_bp_handler                                 \n"
> > >      ".type static_call_bp_handler, @function                               \n"
> > >      "static_call_bp_handler:                                               \n"
> > > -    "ANNOTATE_RETPOLINE_SAFE                                               \n"
> > > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > > +    ANNOTATE_RETPOLINE_SAFE
> > > +    "call *bp_handler_dest                                         \n"
> > > +    ANNOTATE_RETPOLINE_SAFE
> > > +    "jmp *bp_handler_continue                                              \n"
> > > +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> > > +    ANNOTATE_RETPOLINE_SAFE
> > >      "jmp *bp_handler_dest                                          \n"
> > > +#endif
> > >      ".popsection                                                   \n");
> > >
> > >  void arch_static_call_transform(void *site, void *tramp, void *func)
> > > @@ -25,7 +33,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
> > >     unsigned char insn_opcode;
> > >     unsigned char opcodes[CALL_INSN_SIZE];
> > >
> > > -   insn = (unsigned long)tramp;
> > > +   if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> > > +           insn = (unsigned long)site;
> > > +   else
> > > +           insn = (unsigned long)tramp;
> > >
> > >     mutex_lock(&text_mutex);
> > >
> > > @@ -41,8 +52,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
> > >     opcodes[0] = insn_opcode;
> > >     memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
> > >
> > > -   /* Set up the variable for the breakpoint handler: */
> > > +   /* Set up the variables for the breakpoint handler: */
> > >     bp_handler_dest = func;
> > > +   if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> > > +           bp_handler_continue = (void *)(insn + CALL_INSN_SIZE);
> > >
> > >     /* Patch the call site: */
> > >     text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
> >
> > OK, so this is where that static_call_bp_handler comes from; you need
> > that CALL to frob the stack.
> >
> > But I still think it is broken; consider:
> >
> >       CPU0                            CPU1
> >
> >       bp_handler = ponies;
> >
> >       text_poke_bp(, &static_call_bp_handler)
> >         text_poke(&int3);
> >         on_each_cpu(sync)
> >                                       <IPI>
> >                                         ...
> >                                       </IPI>
> >
> >         text_poke(/* all but first bytes */)
> >         on_each_cpu(sync)
> >                                       <IPI>
> >                                         ...
> >                                       </IPI>
> >
> >                                       <int3>
> >                                         pt_regs->ip = &static_call_bp_handler
> >                                       </int3>
> >
> >                                       // VCPU takes a nap...
> >         text_poke(/* first byte */)
> >         on_each_cpu(sync)
> >                                       <IPI>
> >                                         ...
> >                                       </IPI>
> >
> >                                       // VCPU sleeps more
> >       bp_handler = unicorn;
> >
> >                                       CALL unicorn
> >
> > *whoops*
> >
> > Now, granted, that is all rather 'unlikely', but that never stopped
> > Murphy.
>
> Good find, thanks Peter.
>
> As we discussed on IRC, we'll need to fix this from within the int3
> exception handler by faking the call: putting a fake return address on
> the stack (pointing to right after the call) and setting regs->ip to the
> called function.

Can you add a comment that it will need updating when kernel CET is added?
