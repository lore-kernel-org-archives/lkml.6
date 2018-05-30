Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030446AbeE3IUT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:20:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46051 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030414AbeE3IUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:20:12 -0400
X-Google-Smtp-Source: ADUXVKI1LbCgJ9ayNC9PVt51NxIbkMR+Fo71qDPApPlWfOy/zsKexY7Zhdhue00Xq/himzTOCFrsjuXqOhk1EIXSDVM=
MIME-Version: 1.0
In-Reply-To: <20180529221625.33541-12-thgarnie@google.com>
References: <20180529221625.33541-1-thgarnie@google.com> <20180529221625.33541-12-thgarnie@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 May 2018 10:20:11 +0200
X-Google-Sender-Auth: gZOPKlrmlO_nDQNrcl3Vvy8m8wk
Message-ID: <CAJZ5v0h9pagSOmLWcpu9Ewwy7gDGDofweN6fSaL5yVWUhntj4w@mail.gmail.com>
Subject: Re: [PATCH v4 11/27] x86/power/64: Adapt assembly for PIE support
To: Thomas Garnier <thgarnie@google.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:15 AM, Thomas Garnier <thgarnie@google.com> wrote:
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
>
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range 0xffffffff80000000.
>
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/power/hibernate_asm_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
> index ce8da3a0412c..6fdd7bbc3c33 100644
> --- a/arch/x86/power/hibernate_asm_64.S
> +++ b/arch/x86/power/hibernate_asm_64.S
> @@ -24,7 +24,7 @@
>  #include <asm/frame.h>
>
>  ENTRY(swsusp_arch_suspend)
> -       movq    $saved_context, %rax
> +       leaq    saved_context(%rip), %rax
>         movq    %rsp, pt_regs_sp(%rax)
>         movq    %rbp, pt_regs_bp(%rax)
>         movq    %rsi, pt_regs_si(%rax)
> @@ -115,7 +115,7 @@ ENTRY(restore_registers)
>         movq    %rax, %cr4;  # turn PGE back on
>
>         /* We don't restore %rax, it must be 0 anyway */
> -       movq    $saved_context, %rax
> +       leaq    saved_context(%rip), %rax
>         movq    pt_regs_sp(%rax), %rsp
>         movq    pt_regs_bp(%rax), %rbp
>         movq    pt_regs_si(%rax), %rsi
> --
> 2.17.0.921.gf22659ad46-goog
>
