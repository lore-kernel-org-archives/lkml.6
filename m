Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DAF2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390825AbfBNOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:06:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfBNOGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:06:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FAB21927;
        Thu, 14 Feb 2019 14:06:21 +0000 (UTC)
Date:   Thu, 14 Feb 2019 09:06:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 7/9] x86/alternative: Batch of patch operations
Message-ID: <20190214090620.1ee73a36@gandalf.local.home>
In-Reply-To: <20190214125330.GB12467@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
        <84e6b00634085f0fca721e4e7e5aaf43cd062564.1549308412.git.bristot@redhat.com>
        <20190214125330.GB12467@zn.tnic>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 13:53:30 +0100
Borislav Petkov <bp@alien8.de> wrote:

> >  arch/x86/include/asm/text-patching.h |  15 ++++
> >  arch/x86/kernel/alternative.c        | 124 ++++++++++++++++++++++-----
> >  2 files changed, 118 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> > index e85ff65c43c3..42ea7846df33 100644
> > --- a/arch/x86/include/asm/text-patching.h
> > +++ b/arch/x86/include/asm/text-patching.h
> > @@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
> >  #define __parainstructions_end	NULL
> >  #endif
> >  
> > +/*
> > + * Currently, the max observed size in the kernel code is
> > + * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
> > + * Raise it if needed.
> > + */
> > +#define POKE_MAX_OPCODE_SIZE	5
> > +
> > +struct text_to_poke {  
> 
> That name needs bikeshedding. Maybe struct patch_loc is more fitting as
> it is a patch location descriptor, AFAICT.

Although you did say above that "patch" is an overloaded term. Also, I
do find the current name rather descriptive.

> 
> > +	void *handler;  
> 
> Oh my, took me a while to realize that this is not really a function
> which is supposed to handle something but the place we go to when the
> temporary breakpoint hits. Please change that name and all the code
> which calls it handler. It is very misleading.

	void *trampoline;

?

> 
> > +	void *addr;
> > +	size_t len;
> > +	const char opcode[POKE_MAX_OPCODE_SIZE];
> > +};
> > +
> >  extern void *text_poke_early(void *addr, const void *opcode, size_t len);
> >  
> >  /*
> > @@ -37,6 +51,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
> >  extern void *text_poke(void *addr, const void *opcode, size_t len);
> >  extern int poke_int3_handler(struct pt_regs *regs);
> >  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
> > +extern void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries);
> >  extern int after_bootmem;
> >  
> >  #endif /* _ASM_X86_TEXT_PATCHING_H */
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 202af29c43c0..318b6867dc5a 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/stop_machine.h>
> >  #include <linux/slab.h>
> >  #include <linux/kdebug.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/bsearch.h>
> >  #include <asm/text-patching.h>
> >  #include <asm/alternative.h>
> >  #include <asm/sections.h>
> > @@ -738,10 +740,26 @@ static void do_sync_core(void *info)
> >  }
> >  
> >  static bool bp_patching_in_progress;
> > -static void *bp_int3_handler, *bp_int3_addr;
> > +static struct text_to_poke *bp_int3_tpv;
> > +static unsigned int bp_int3_tpv_nr;  
> 
> Those names need bikeshedding. See below.

But they are named after you! "bp_" :-)

-- Steve

> 
> > +
> > +static int text_bp_batch_bsearch(const void *key, const void *elt)  
> 
