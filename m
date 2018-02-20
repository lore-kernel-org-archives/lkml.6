Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeBTWZG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:25:06 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:42541 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBTWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:25:04 -0500
X-Google-Smtp-Source: AG47ELvUJ3TQmtYCqb2aURhDeitsAo/dSarUYdcNsVB0nlPoVIEw/sRbJQJSwmajm74HC4Ulmk9FeQWWSzmkLdIz9ME=
MIME-Version: 1.0
In-Reply-To: <20180220210113.6725-2-linux@dominikbrodowski.net>
References: <20180220210113.6725-1-linux@dominikbrodowski.net> <20180220210113.6725-2-linux@dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2018 14:25:03 -0800
X-Google-Sender-Auth: 6XAxsFItZBsaLoeEndNE7Mg0PmQ
Message-ID: <CA+55aFx=moDaKj3Ogc_Fvm0vKQ1DP=yA9UE3axmpECyv3Khi1Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/6] x86/entry/64: move PUSH_AND_CLEAR_REGS from
 interrupt macro to helper function
To: Dominik Brodowski <linux@dominikbrodowski.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>, Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 1:01 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> +ENTRY(interrupt_entry)
> +       UNWIND_HINT_FUNC
> +
> +       PUSH_AND_CLEAR_REGS save_ret=1
> +       ENCODE_FRAME_POINTER 8
> +
> +       ret
> +END(interrupt_entry)

There's nothing wrong with this patch, but it does expose what a nasty
hack our "ENCODE_FRAME_POINTER" thing is.

It generates (when there is an offset, like this):

        leaq \ptregs_offset(%rsp), %rbp
        orq     $0x1, %rbp

and I would _really_ hope that the stack pointer is always aligned on
interrupt entry, so I don't see why it's not just

        leaq 1+\ptregs_offset(%rsp), %rbp

instead.

I dunno. Let's ask Josh what the reason for the separate "or" was.

But this is an independent issue of this patch, really.

              Linus
