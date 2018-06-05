Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeFEHHv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:07:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46029 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeFEHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:07:49 -0400
X-Google-Smtp-Source: ADUXVKK/2gVfBym337yYSm6K+ysiCy5LKKNo1p7FMdoR50Ep2zxWQ3wt+56ROHXe31c1lgcn3ZmLE5JDfcAnKh0rt5A=
MIME-Version: 1.0
In-Reply-To: <20180604162224.471925894@linutronix.de>
References: <20180604162224.471925894@linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 5 Jun 2018 00:07:48 -0700
Message-ID: <CAPhsuW6BnCSLcSUnG75KkAJeYBaS4bTvyj-brk2OUUfOfQszcQ@mail.gmail.com>
Subject: Re: [patch 3/8] x86/apic: Provide apic_ack_irq()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 8:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> apic_ack_edge() is explicitely for handling interrupt affinity cleanup when
> interrupt remapping is not available or disable.
>
> Remapped interrupts and also some of the platform specific special
> interrupts, e.g. UV, invoke ack_APIC_irq() directly.
>
> To address the issue of failing an affinity update with -EBUSY the delayed
> affinity mechanism can be reused, but ack_APIC_irq() does not handle
> that. Adding this to ack_APIC_irq() is not possible, because that function
> is also used for exceptions and directly handled interrupts like IPIs.
>
> Create a new function, which just contains the conditional invocation of
> irq_move_irq() and the final ack_APIC_irq(). Making the invocation of
> irq_move_irq() conditional avoids the out of line call if the pending bit
> is not set.
>
> Reuse the new function in apic_ack_edge().
>
> Preparatory change for the real fix
>
> Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

Tested-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/x86/include/asm/apic.h   |    2 ++
>  arch/x86/kernel/apic/vector.c |   10 ++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -436,6 +436,8 @@ static inline void apic_set_eoi_write(vo
>
>  #endif /* CONFIG_X86_LOCAL_APIC */
>
> +extern void apic_ack_irq(struct irq_data *data);
> +
>  static inline void ack_APIC_irq(void)
>  {
>         /*
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -809,11 +809,17 @@ static int apic_retrigger_irq(struct irq
>         return 1;
>  }
>
> +void apic_ack_irq(struct irq_data *irqd)
> +{
> +       if (unlikely(irqd_is_setaffinity_pending(irqd)))
> +               irq_move_irq(irqd);
> +       ack_APIC_irq();
> +}
> +
>  void apic_ack_edge(struct irq_data *irqd)
>  {
>         irq_complete_move(irqd_cfg(irqd));
> -       irq_move_irq(irqd);
> -       ack_APIC_irq();
> +       apic_ack_irq(irqd);
>  }
>
>  static struct irq_chip lapic_controller = {
>
>
