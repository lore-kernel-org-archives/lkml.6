Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeERQY2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:24:28 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36787 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:24:26 -0400
X-Google-Smtp-Source: AB8JxZqC6LKr9PzeEntLinKcZ9Kc4BvMi+z7k0gX3GXnAylols60KGBgYhfXJeGMBtKWT6hJOCCNkjtD5pFm4b4NWwg=
MIME-Version: 1.0
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180518075853.GD12217@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 09:24:14 -0700
Message-ID: <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: Peter Zijlstra <peterz@infradead.org>
Cc: namit@vmware.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Anvin <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:59 AM Peter Zijlstra <peterz@infradead.org>
wrote:

> This is an awesome hack, but is there really nothing we can do to make
> it more readable? Esp, that global asm doing the macro definition is a
> pain to read.

I actually find that macro to be *more* legible than what we do now,
although I'm not enamored with the pseudo-operation name ("__BUG_FLAGS").

That said, the C header code itself I don't love.

I wonder if we should just introduce a new assembler header file, and get
it included when processing compiler-generated asm. We already do that for
our _real_ *.S files, with a number of our header files having constants
and code for the asm case too, not just C.

But we could have an <asm/asm-macro.h> header file that has these kinds of
macros (or "pseudo-instructions") for assembly language cases, and then we
could just rely on them in inline asm.

Because if you want to see illegible, look at what we currently generate:

     # kernel/exit.c:1761:       BUG();
     #APP
     # 1761 "kernel/exit.c" 1
         1:      .byte 0x0f, 0x0b
     .pushsection __bug_table,"aw"
     2:  .long 1b - 2b   # bug_entry::bug_addr
         .long .LC0 - 2b # bug_entry::file       #
         .word 1761      # bug_entry::line       #
         .word 0 # bug_entry::flags      #
         .org 2b+12      #
     .popsection
     # 0 "" 2
     # 1761 "kernel/exit.c" 1
         180:    #
         .pushsection .discard.unreachable
         .long 180b - .  #
         .popsection

     # 0 "" 2
     #NO_APP

and tell me that's legible.. Of course, I'm probably one of the few people
who actually look at the generated asm fairly regularly.

So a few macros that we can use in inline asm definitely wouldn't hurt
legibility. And if we actually can put them in a header file as legible
code - instead of having to wrap them in a global "asm()" macro in C code,
they'd probably be legible at a source level too.

It's not just the bug_flags cases. It's things like jump labels too:

     # ./arch/x86/include/asm/jump_label.h:36:   asm_volatile_goto("1:"
     #APP
     # 36 "./arch/x86/include/asm/jump_label.h" 1
         1:.byte 0x0f,0x1f,0x44,0x00,0
         .pushsection __jump_table,  "aw"
          .balign 8
          .quad 1b, .L71, __tracepoint_sched_process_free+8 + 0  #,,
         .popsection

     # 0 "" 2
     #NO_APP

and atomics:

     # ./arch/x86/include/asm/atomic.h:122:      GEN_UNARY_RMWcc(LOCK_PREFIX
"decl", v->counter, "%0", e);
     #APP
     # 122 "./arch/x86/include/asm/atomic.h" 1
         .pushsection .smp_locks,"a"
     .balign 4
     .long 671f - .
     .popsection
     671:
         lock; decl -2336(%rbp)  # _7->counter
         /* output condition code e*/

     # 0 "" 2
     # ./include/linux/sched/task.h:95:  if (atomic_dec_and_test(&t->usage))
     #NO_APP

where I suspect we could hide the whole "lock" magic in a macro, and make
this much more legible.

Maybe? I think it might be worth trying. It's possible that the macro games
themselves would just cause enough pain to make any gains go away.

                    Linus
