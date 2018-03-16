Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932663AbeCPRWd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:22:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36731 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeCPRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:22:30 -0400
X-Google-Smtp-Source: AG47ELvaJh/1WHnf79G3N03BpPmgrAJIg8X+8Z616lw2UFoS+Vn5hJ1hfx1a6KqK4QuIADuj9GRMiQlqdnw449r2mJ8=
MIME-Version: 1.0
In-Reply-To: <20180316114849.GD5852@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de> <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble> <20180316114849.GD5852@pd.tnic>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 10:22:29 -0700
X-Google-Sender-Auth: xLUCY4AmwIg2oQuXTVP3HUL4QyE
Message-ID: <CA+55aFwmi38uJyir_e_TTDObBGg55WsTB_0AqcVHzgU=+Fy=ag@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive summary
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 4:48 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Mar 15, 2018 at 02:01:32PM -0500, Josh Poimboeuf wrote:
>> no_context() has the following line, right before it calls oops_end():
>>
>>       /* Executive summary in case the body of the oops scrolled away */
>>       printk(KERN_DEFAULT "CR2: %016lx\n", address);
>>
>> I think that line can now be removed, since the executive summary
>> __show_regs() will include CR2.
>
> Good idea. Done.

NOOOO!

Guys, %cr2 CAN AND DOES CHANGE!

The reason we do that

        printk(KERN_DEFAULT "CR2: %016lx\n", address);

is because WE ARE NOT PRINTING OUT THE CURRENT CR2 REGISTER!

This is really damn important.

The "address" register contains the CR2 value as it was read *very*
early in the page fault case, before we enabled interrupts, and before
we did various random things that can cause further page faults and
change CR2!

So the executive summary that does __show_regs() may end up showing
something completely different than the actual faulting address,
because we might have taken a vmalloc-space exception in the meantime,
for example.

Do *NOT* get rid of that thing.

You're better off getting rid of the CR2 line from __show_regs(),
because it can be dangerously confusing. It's not actually part of the
saved register state at all, it's something entirely different. It's
like showing the current eflags rather than the eflags saved on the
faulting stack.

                     Linus
