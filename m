Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7474C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D44D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D44D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeK0HKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:10:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeK0HKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:10:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1A693086258;
        Mon, 26 Nov 2018 20:14:53 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B50319C65;
        Mon, 26 Nov 2018 20:14:51 +0000 (UTC)
Date:   Mon, 26 Nov 2018 14:14:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181126201449.xepvj3owldkrsvgr@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <CALCETrX+FP4V+SoMEwX2-WeSmr2g2xZvGbS5qthuO6N6dXE+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrX+FP4V+SoMEwX2-WeSmr2g2xZvGbS5qthuO6N6dXE+bQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 26 Nov 2018 20:14:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:28:08AM -0800, Andy Lutomirski wrote:
> On Mon, Nov 26, 2018 at 9:10 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Nov 26, 2018 at 05:02:17PM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> > > > diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> > > > index 8026d176f25c..d3869295b88d 100644
> > > > --- a/arch/x86/kernel/static_call.c
> > > > +++ b/arch/x86/kernel/static_call.c
> > > > @@ -9,13 +9,21 @@
> > > >
> > > >  void static_call_bp_handler(void);
> > > >  void *bp_handler_dest;
> > > > +void *bp_handler_continue;
> > > >
> > > >  asm(".pushsection .text, \"ax\"                                            \n"
> > > >      ".globl static_call_bp_handler                                 \n"
> > > >      ".type static_call_bp_handler, @function                               \n"
> > > >      "static_call_bp_handler:                                               \n"
> > > > -    "ANNOTATE_RETPOLINE_SAFE                                               \n"
> > > > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > > > +    ANNOTATE_RETPOLINE_SAFE
> > > > +    "call *bp_handler_dest                                         \n"
> > > > +    ANNOTATE_RETPOLINE_SAFE
> > > > +    "jmp *bp_handler_continue                                              \n"
> > > > +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> > > > +    ANNOTATE_RETPOLINE_SAFE
> > > >      "jmp *bp_handler_dest                                          \n"
> > > > +#endif
> > > >      ".popsection                                                   \n");
> > > >
> > > >  void arch_static_call_transform(void *site, void *tramp, void *func)
> > > > @@ -25,7 +33,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
> > > >     unsigned char insn_opcode;
> > > >     unsigned char opcodes[CALL_INSN_SIZE];
> > > >
> > > > -   insn = (unsigned long)tramp;
> > > > +   if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> > > > +           insn = (unsigned long)site;
> > > > +   else
> > > > +           insn = (unsigned long)tramp;
> > > >
> > > >     mutex_lock(&text_mutex);
> > > >
> > > > @@ -41,8 +52,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
> > > >     opcodes[0] = insn_opcode;
> > > >     memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
> > > >
> > > > -   /* Set up the variable for the breakpoint handler: */
> > > > +   /* Set up the variables for the breakpoint handler: */
> > > >     bp_handler_dest = func;
> > > > +   if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> > > > +           bp_handler_continue = (void *)(insn + CALL_INSN_SIZE);
> > > >
> > > >     /* Patch the call site: */
> > > >     text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
> > >
> > > OK, so this is where that static_call_bp_handler comes from; you need
> > > that CALL to frob the stack.
> > >
> > > But I still think it is broken; consider:
> > >
> > >       CPU0                            CPU1
> > >
> > >       bp_handler = ponies;
> > >
> > >       text_poke_bp(, &static_call_bp_handler)
> > >         text_poke(&int3);
> > >         on_each_cpu(sync)
> > >                                       <IPI>
> > >                                         ...
> > >                                       </IPI>
> > >
> > >         text_poke(/* all but first bytes */)
> > >         on_each_cpu(sync)
> > >                                       <IPI>
> > >                                         ...
> > >                                       </IPI>
> > >
> > >                                       <int3>
> > >                                         pt_regs->ip = &static_call_bp_handler
> > >                                       </int3>
> > >
> > >                                       // VCPU takes a nap...
> > >         text_poke(/* first byte */)
> > >         on_each_cpu(sync)
> > >                                       <IPI>
> > >                                         ...
> > >                                       </IPI>
> > >
> > >                                       // VCPU sleeps more
> > >       bp_handler = unicorn;
> > >
> > >                                       CALL unicorn
> > >
> > > *whoops*
> > >
> > > Now, granted, that is all rather 'unlikely', but that never stopped
> > > Murphy.
> >
> > Good find, thanks Peter.
> >
> > As we discussed on IRC, we'll need to fix this from within the int3
> > exception handler by faking the call: putting a fake return address on
> > the stack (pointing to right after the call) and setting regs->ip to the
> > called function.
> 
> Can you add a comment that it will need updating when kernel CET is added?

Will do, though I get the feeling there's a lot of other (existing) code
that will also need to change for kernel CET.

-- 
Josh
