Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeFEHOM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:14:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44822 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeFEHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:14:10 -0400
X-Google-Smtp-Source: ADUXVKKX63XeJHR0YvO/5AtY0WTsPyIegDpHnzL55Fld2PDJLmefD+9yk5cPGHUQnA1HrNzpHBQjg8bn5nQu5/p999g=
MIME-Version: 1.0
In-Reply-To: <20180604162224.819273597@linutronix.de>
References: <20180604162224.819273597@linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 5 Jun 2018 00:14:09 -0700
Message-ID: <CAPhsuW577-zethODoH2a_Z6PVZkhRPu+a7bgL2ZGpYiBNcEwpQ@mail.gmail.com>
Subject: Re: [patch 7/8] genirq/affinity: Defer affinity setting if irq chip
 is busy
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
> The case that interrupt affinity setting fails with -EBUSY can be handled
> in the kernel completely by using the already available generic pending
> infrastructure.
>
> If a irq_chip::set_affinity() fails with -EBUSY, handle it like the
> interrupts for which irq_chip::set_affinity() can only be invoked from
> interrupt context. Copy the new affinity mask to irq_desc::pending_mask and
> set the affinity pending bit. The next raised interrupt for the affected
> irq will check the pending bit and try to set the new affinity from the
> handler. This avoids that -EBUSY is returned when an affinity change is
> requested from user space and the previous change has not been cleaned
> up. The new affinity will take effect when the next interrupt is raised
> from the device.
>
> Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

Tested-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/irq/manage.c |   37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -204,6 +204,39 @@ int irq_do_set_affinity(struct irq_data
>         return ret;
>  }
>
> +#ifdef CONFIG_GENERIC_PENDING_IRQ
> +static inline int irq_set_affinity_pending(struct irq_data *data,
> +                                          const struct cpumask *dest)
> +{
> +       struct irq_desc *desc = irq_data_to_desc(data);
> +
> +       irqd_set_move_pending(data);
> +       irq_copy_pending(desc, dest);
> +       return 0;
> +}
> +#else
> +static inline int irq_set_affinity_pending(struct irq_data *data,
> +                                          const struct cpumask *dest)
> +{
> +       return -EBUSY;
> +}
> +#endif
> +
> +static int irq_try_set_affinity(struct irq_data *data,
> +                               const struct cpumask *dest, bool force)
> +{
> +       int ret = irq_do_set_affinity(data, dest, force);
> +
> +       /*
> +        * In case that the underlying vector management is busy and the
> +        * architecture supports the generic pending mechanism then utilize
> +        * this to avoid returning an error to user space.
> +        */
> +       if (ret == -EBUSY && !force)
> +               ret = irq_set_affinity_pending(data, dest);
> +       return ret;
> +}
> +
>  int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
>                             bool force)
>  {
> @@ -214,8 +247,8 @@ int irq_set_affinity_locked(struct irq_d
>         if (!chip || !chip->irq_set_affinity)
>                 return -EINVAL;
>
> -       if (irq_can_move_pcntxt(data)) {
> -               ret = irq_do_set_affinity(data, mask, force);
> +       if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
> +               ret = irq_try_set_affinity(data, mask, force);
>         } else {
>                 irqd_set_move_pending(data);
>                 irq_copy_pending(desc, mask);
>
>
