Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeBAIPS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:15:18 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46042 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeBAIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:15:13 -0500
X-Google-Smtp-Source: AH8x226d8B4zHJbarmy83mr8v6KmVGZEunKi7q4qI8zlFfHHGPq7taKmmGgk1oh8x6iswojTkTm4xv2jow1flGqFWHM=
MIME-Version: 1.0
In-Reply-To: <tip-55595980acc3232b018ba30df8ee6e0ac40ad184@git.kernel.org>
References: <alpine.DEB.2.20.1801301935410.1797@nanos> <tip-55595980acc3232b018ba30df8ee6e0ac40ad184@git.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2018 09:15:12 +0100
X-Google-Sender-Auth: TH-XH8oIcPt-o7WDQXtTz2-8DJc
Message-ID: <CAMuHMdUfGUXmjFdyjLdBiyOayy22p-91Oonp-hK4x0hqcOnPUA@mail.gmail.com>
Subject: Re: [tip:irq/urgent] genirq: Make legacy autoprobing work again
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Meelis Roos <mroos@linux.ee>, Ingo Molnar <mingo@kernel.org>
Cc: linux-tip-commits@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:54 AM, tip-bot for Thomas Gleixner
<tipbot@zytor.com> wrote:
> Commit-ID:  55595980acc3232b018ba30df8ee6e0ac40ad184
> Gitweb:     https://git.kernel.org/tip/55595980acc3232b018ba30df8ee6e0ac40ad184
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Tue, 30 Jan 2018 19:36:32 +0100
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 31 Jan 2018 10:52:06 +0100
>
> genirq: Make legacy autoprobing work again
>
> Meelis reported the following warning on a quad P3 HP NetServer museum piece:
>
> WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244 __irq_startup+0x80/0x100
> EIP: __irq_startup+0x80/0x100
> irq_startup+0x7e/0x170
> probe_irq_on+0x128/0x2b0
> parport_irq_probe.constprop.18+0x8d/0x1af [parport_pc]
> parport_pc_probe_port+0xf11/0x1260 [parport_pc]
> parport_pc_init+0x78a/0xf10 [parport_pc]
> parport_parse_param.constprop.16+0xf0/0xf0 [parport_pc]
> do_one_initcall+0x45/0x1e0
>
> This is caused by the rewrite of the irq activation/startup sequence which
> missed to convert a callsite in the irq legacy auto probing code.
>
> To fix this irq_activate_and_startup() needs to gain a return value so the
> pending logic can work proper.
>
> Fixes: c942cee46bba ("genirq: Separate activation and startup")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801301935410.1797@nanos

> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -294,11 +294,11 @@ int irq_activate(struct irq_desc *desc)
>         return 0;
>  }
>
> -void irq_activate_and_startup(struct irq_desc *desc, bool resend)
> +int irq_activate_and_startup(struct irq_desc *desc, bool resend)
>  {
>         if (WARN_ON(irq_activate(desc)))
>                 return;

As reported by 0day, this should return something.

if CONFIG_IRQ_DOMAIN=n or CONFIG_IRQ_DOMAIN_HIERARCHY=n,
irq_activate() will never return 1, and the code path can be eliminated.

BTW, is gcc becoming too smart, and already eliminating code before it
generates warnings for it? Recently I've seen some other cases where buggy
code was not warned about, as it was considered not having any impact.

> -       irq_startup(desc, resend, IRQ_START_FORCE);
> +       return irq_startup(desc, resend, IRQ_START_FORCE);
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
