Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeFEHHK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:07:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38409 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeFEHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:07:08 -0400
X-Google-Smtp-Source: ADUXVKLboUweTuYCoSR3pXzT+bOxkgJTLycUb7CdGa0hjwcSy72MW3YOzX8ku1XlSqbAeqNjwvF2wIV+n+yHgeGeeeY=
MIME-Version: 1.0
In-Reply-To: <20180604162224.386544292@linutronix.de>
References: <20180604162224.386544292@linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 5 Jun 2018 00:07:08 -0700
Message-ID: <CAPhsuW4M=i1bGTEeL=SvfPKPQxgv79NbQHSRWLerbFtCnOZ2FQ@mail.gmail.com>
Subject: Re: [patch 2/8] genirq/generic_pending: Do not lose pending affinity update
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
> The generic pending interrupt mechanism moves interrupts from the interrupt
> handler on the original target CPU to the new destination CPU. This is
> required for x86 and ia64 due to the way the interrupt delivery and
> acknowledge works if the interrupts are not remapped.
>
> However that update can fail for various reasons. Some of them are valid
> reasons to discard the pending update, but the case, when the previous move
> has not been fully cleaned up is not a legit reason to fail.
>
> Check the return value of irq_do_set_affinity() for -EBUSY, which indicates
> a pending cleanup, and rearm the pending move in the irq dexcriptor so it's
> tried again when the next interrupt arrives.
>
> Fixes: 996c591227d9 ("x86/irq: Plug vector cleanup race")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

Tested-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/irq/migration.c |   24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> --- a/kernel/irq/migration.c
> +++ b/kernel/irq/migration.c
> @@ -38,17 +38,18 @@ bool irq_fixup_move_pending(struct irq_d
>  void irq_move_masked_irq(struct irq_data *idata)
>  {
>         struct irq_desc *desc = irq_data_to_desc(idata);
> -       struct irq_chip *chip = desc->irq_data.chip;
> +       struct irq_data *data = &desc->irq_data;
> +       struct irq_chip *chip = data->chip;
>
> -       if (likely(!irqd_is_setaffinity_pending(&desc->irq_data)))
> +       if (likely(!irqd_is_setaffinity_pending(data)))
>                 return;
>
> -       irqd_clr_move_pending(&desc->irq_data);
> +       irqd_clr_move_pending(data);
>
>         /*
>          * Paranoia: cpu-local interrupts shouldn't be calling in here anyway.
>          */
> -       if (irqd_is_per_cpu(&desc->irq_data)) {
> +       if (irqd_is_per_cpu(data)) {
>                 WARN_ON(1);
>                 return;
>         }
> @@ -73,9 +74,20 @@ void irq_move_masked_irq(struct irq_data
>          * For correct operation this depends on the caller
>          * masking the irqs.
>          */
> -       if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids)
> -               irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
> +       if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
> +               int ret;
>
> +               ret = irq_do_set_affinity(data, desc->pending_mask, false);
> +               /*
> +                * If the there is a cleanup pending in the underlying
> +                * vector management, reschedule the move for the next
> +                * interrupt. Leave desc->pending_mask intact.
> +                */
> +               if (ret == -EBUSY) {
> +                       irqd_set_move_pending(data);
> +                       return;
> +               }
> +       }
>         cpumask_clear(desc->pending_mask);
>  }
>
>
>
