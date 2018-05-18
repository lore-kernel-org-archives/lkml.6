Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeERHYS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:24:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34393 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeERHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:24:16 -0400
X-Google-Smtp-Source: AB8JxZoy3Y2ZaSnCS1571zRCBYzKFYfFSuHSVyrRxoJCwrZ4zi//3xOjSfr/nRJMF4qssmrFRk8KwA==
Date: Fri, 18 May 2018 09:24:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [PATCH] objtool: Detect assembly code falling through to INT3
 padding
Message-ID: <20180518072412.GC26358@gmail.com>
References: <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
 <20180516033044.odb74pdgcn5nacwb@treble>
 <20180517134934.eog2fgoby5azq5a7@treble>
 <20180517140118.GT12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517140118.GT12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, May 17, 2018 at 08:49:34AM -0500, Josh Poimboeuf wrote:
> > With the following commit:
> > 
> >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > 
> > ... asm function alignments are padded with INT3, so it's no longer safe
> > to fall through to an aligned function.  Make sure we catch any such
> > cases with objtool.
> > 
> > Note this only adds checking for 64-bit, since objtool doesn't support
> > x86-32.
> > 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/kernel/head_64.S       |  2 --
> >  tools/objtool/arch.h            |  3 ++-
> >  tools/objtool/arch/x86/decode.c |  2 +-
> >  tools/objtool/check.c           | 11 ++++++++++-
> >  4 files changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index 8344dd2f310a..3ed8cec6e765 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -285,11 +285,9 @@ ENTRY(early_idt_handler_array)
> >  	.endif
> >  	pushq $i		# 72(%rsp) Vector number
> >  	jmp early_idt_handler_common
> > -	UNWIND_HINT_IRET_REGS
> >  	i = i + 1
> >  	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
> >  	.endr
> > -	UNWIND_HINT_IRET_REGS offset=16
> >  END(early_idt_handler_array)
> >  
> >  early_idt_handler_common:
> 
> As noted on IRC; I got slightly confused what this was about.
> 
> Other than that:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And after talking to you on IRC I added this paragraph to the changelog:

  Also remove incorrect and unnecessary unwinder hints from head_64.S
  which caused false positives in the new detection code.

Thanks,

	Ingo
