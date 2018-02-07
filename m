Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeBGV6W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:58:22 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:39206 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeBGV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:58:21 -0500
X-Google-Smtp-Source: AH8x227A9nJAvOHCpru77EGiE+5kvh4be+kKjLPOZ+wG+D28tjxcf4V/QI2mgYcP6uZVWXXvKM+phDk52xLfUWXmUFk=
MIME-Version: 1.0
In-Reply-To: <20180207212915.GA4633@isilmar-4.linta.de>
References: <20180207201517.6518-1-linux@dominikbrodowski.net>
 <20180207201517.6518-7-linux@dominikbrodowski.net> <CA+55aFxZ-pyx88rwykT0Dzh-_bwGQcmc00GhrMQ4OEwXqMO+pA@mail.gmail.com>
 <20180207212915.GA4633@isilmar-4.linta.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 13:58:20 -0800
X-Google-Sender-Auth: bKUWTyVTvmsbq1Px-en6K61HgA8
Message-ID: <CA+55aFxyBrF+2uZYN7dfVJ4MFgfxEQPFWGqBAueRne4LWJP0QA@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 6/7] x86/entry: get rid of ALLOC_PT_GPREGS_ON_STACK
 and SAVE_AND_CLEAR_REGS
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 1:29 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>>
>> So this removes lines of asm code, but it adds a lot of instructions
>> to the end result thanks to the macro, I think.
>
> Indeed, that is the case (see below). However, if we want to switch to
> PUSH instructions and do this in a routine which is call'ed and which
> ret'urns, %rsp needs to be moved around even more often than the old
> ALLOC_PT_GPREGS_ON_STACK macro did (which you wanted to get rid of,
> IIUYC). Or do I miss something?

So I agree that your approach makes for a lot simpler stack setup.

I was just hoping that we could play some tricks.

For example, right now your PUSH_AND_CLEAR_REGS starts off with

        pushq   %rdi            /* pt_regs->di */
        pushq   %rsi            /* pt_regs->si */
        pushq   %rdx            /* pt_regs->dx */
        pushq   %rcx            /* pt_regs->cx */
        ....

and maybe we could still use this in paranoid_entry and error_entry if
we made it something like

/* if 'save_ret' is set, we pop the return point into %rsi */
.macro PUSH_AND_CLEAR_REGS save_ret=0
        .if \save_ret
        pushq %%rsi
        movq 8(%%rsp),%rsi
        movq %%rdi,8(%%rsp)
        .else
        pushq   %rdi            /* pt_regs->di */
        pushq   %rsi            /* pt_regs->si */
        .endif
        pushq   %rdx            /* pt_regs->dx */
        pushq   %rcx            /* pt_regs->cx */
        ....

which would allow error_entry and paranoid_entry to do something like this:

        PUSH_AND_CLEAR_REGS save_ret=1
        pushq %rsi
        ... do the other common code ..
        ret

(totally untested, I'm just doing a "stream-of-consciousness" thing in
the email.

See what I'm saying?

That said, maybe the pushq sequence is now so small that it doesn't
even matter, and duplicating it isn't a big problem.

Because your version sure is simpler.

         Linus
