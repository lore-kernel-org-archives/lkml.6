Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162170AbeBNSgI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:36:08 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41560 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162106AbeBNSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:36:07 -0500
X-Google-Smtp-Source: AH8x226m6aJJT6TMJUCxOq2sywrQcyiMKl4jAswm9PIYVuqEZojeTVm5xgGUhOOZKOCTSkF5LE07qVmjJz1pJWsAduI=
MIME-Version: 1.0
In-Reply-To: <20180214182113.27247-3-linux@dominikbrodowski.net>
References: <20180214182113.27247-1-linux@dominikbrodowski.net> <20180214182113.27247-3-linux@dominikbrodowski.net>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 14 Feb 2018 13:36:06 -0500
Message-ID: <CAMzpN2j4a166dt5M7QHmJE-m4XVBER42nUF-h8Wq-Tssq8Fgog@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/entry/64: move ENTER_IRQ_STACK from interrupt
 macro to helper function
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 1:21 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Moving the switch to IRQ stack from the interrupt macro to the helper
> function requires some trickery: All ENTER_IRQ_STACK really cares about
> is where the "original" stack -- meaning the GP registers etc. -- is
> stored. Therefore, we need to offset the stored RSP value by 8 whenever
> ENTER_IRQ_STACK is called from within a function. In such cases, and
> after switching to the IRQ stack, we need to push the "original" return
> address (i.e. the return address from the call to the interrupt entry
> function) to the IRQ stack.
>
> This trickery allows us to carve another 1k from the text size:
>
>    text    data     bss     dec     hex filename
>   17905       0       0   17905    45f1 entry_64.o-orig
>   16897       0       0   16897    4201 entry_64.o
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  arch/x86/entry/entry_64.S | 53 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index de8a0da0d347..3046b12a1acb 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -449,10 +449,18 @@ END(irq_entries_start)
>   *
>   * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
>   */
> -.macro ENTER_IRQ_STACK regs=1 old_rsp
> +.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
>         DEBUG_ENTRY_ASSERT_IRQS_OFF
>         movq    %rsp, \old_rsp
>
> +       .if \save_ret
> +       /*
> +        * If save_ret is set, the original stack contains one additional
> +        * entry -- the return address.
> +        */
> +       addq    $8, \old_rsp
> +       .endif

Combine the mov and add into leaq 8(%rsp), \old_rsp.

--
Brian Gerst
