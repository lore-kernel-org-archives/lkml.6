Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDRQxj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbeDRQxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:53:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B992178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4+W5Km5Cvk+SFA3CPDzkWY4OfGSb0o880IYUclryIyH6wXqUcREdsRTon9dx+2Dc0WV/o81W8FUIzyCIjNNzKU=
MIME-Version: 1.0
In-Reply-To: <cd1a4b8c-dd8e-d88d-c154-fcf02aca5d74@redhat.com>
References: <d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org>
 <cd1a4b8c-dd8e-d88d-c154-fcf02aca5d74@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 18 Apr 2018 09:53:16 -0700
X-Gmail-Original-Message-ID: <CALCETrU3KLXwToBTOTnHpKrUhENFUVFJbWxfiPMbs2iQHoDDZA@mail.gmail.com>
Message-ID: <CALCETrU3KLXwToBTOTnHpKrUhENFUVFJbWxfiPMbs2iQHoDDZA@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64/compat: Preserve r8-r11 in int $0x80
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 8:00 AM, Denys Vlasenko <dvlasenk@redhat.com> wrote:
> This means that the new behavior is there for some 8 years already.
> Whoever was impacted by it, probably already switched to the new ABI.
>
> Current ABI is "weaker", it allows kernel to save fewer registers.
>
> Which is generally a good thing, since saving/restoring things cost
> cycles, and sometimes painful on entry paths where you may desperately
> need a scratch register or two. (Recall this one? -
> ...
>         movq    %rsp, PER_CPU_VAR(rsp_scratch)
>         movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>         /* Construct struct pt_regs on stack */
>         pushq   $__USER_DS                      /* pt_regs->ss */
>         pushq   PER_CPU_VAR(rsp_scratch)        /* pt_regs->sp */
> ...
> wouldn't it be _great_ if one of GPRs would be available here
> to hold userspace %rsp?
> )

But this is the int $0x80 entry, which uses the stack sanely and
doesn't have this problem at all.

>
> If userspace needs some registers saved, it's trivial for it to have:
>
>         push reg1
>         push reg2
>         int  0x80
>         pop  reg2
>         pop  reg1
>
> OTOH if userspace _does not_ need some registers saved,
> but they are defined as saved by the entrypoint ABI, then save/restore work
> is done every time, even when not needed.
>
> Thus, I propose to retain the current behavior.

The problems are:

1. If you look up how to do int $0x80, every answer you get doesn't
mention any clobbers.  The code works on x86_32 and seems to work on
x86_64.  I think we should make it actually work.

2. It's very easy to make this mistake and get away with it for a long
time, and the failure modes are hard to debug.  gcc doesn't allocate
r8..r11 that often, and there are plenty of contexts (near end of a
leaf function) where r8..r11 are dead even if they were allocated.  So
there is probably a decent body of code out there that makes this
mistake and is okay for now.  But if anyone ever compiles it with LTO,
it's reasonably likely to go boom.

So I think we should fix it in the interest of avoiding weird bugs.
