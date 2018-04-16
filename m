Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDPISJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:18:09 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40238 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeDPISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:18:08 -0400
X-Google-Smtp-Source: AIpwx49PN7wSjpNRYfS7VoiH2VbS8PU2Z41Dmgq3hNbhgSxEDiR/ZxKlqRmm4Ogo1qngWML581aBg82Qyl1nDOlDRAg=
MIME-Version: 1.0
In-Reply-To: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
References: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 16 Apr 2018 16:18:06 +0800
Message-ID: <CAMz4kuKdLEN6MNeyoBjR7NMhG-YJ9qBMZ5U1iYi623Z_1JXbpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: eic: Add edge trigger emulation for EIC
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30 March 2018 at 15:02, Baolin Wang <baolin.wang@linaro.org> wrote:
> The Spreadtrum debounce EIC and latch EIC can not support edge trigger,
> but most GPIO users (like gpio-key driver) only use the edge trigger,
> thus the EIC driver need add some support to emulate the edge trigger
> to satisfy this requirement.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Any comments for this patch set? Thanks.

> ---
>  drivers/gpio/gpio-eic-sprd.c |   73 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index de7dd93..e0d6a0a 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -300,6 +300,7 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>         struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
>         struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
>         u32 offset = irqd_to_hwirq(data);
> +       int state;
>
>         switch (sprd_eic->type) {
>         case SPRD_EIC_DEBOUNCE:
> @@ -310,6 +311,17 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>                 case IRQ_TYPE_LEVEL_LOW:
>                         sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
>                         break;
> +               case IRQ_TYPE_EDGE_RISING:
> +               case IRQ_TYPE_EDGE_FALLING:
> +               case IRQ_TYPE_EDGE_BOTH:
> +                       state = sprd_eic_get(chip, offset);
> +                       if (state)
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_DBNC_IEV, 0);
> +                       else
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_DBNC_IEV, 1);
> +                       break;
>                 default:
>                         return -ENOTSUPP;
>                 }
> @@ -324,6 +336,17 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>                 case IRQ_TYPE_LEVEL_LOW:
>                         sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
>                         break;
> +               case IRQ_TYPE_EDGE_RISING:
> +               case IRQ_TYPE_EDGE_FALLING:
> +               case IRQ_TYPE_EDGE_BOTH:
> +                       state = sprd_eic_get(chip, offset);
> +                       if (state)
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_LATCH_INTPOL, 0);
> +                       else
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_LATCH_INTPOL, 1);
> +                       break;
>                 default:
>                         return -ENOTSUPP;
>                 }
> @@ -405,6 +428,55 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>         return 0;
>  }
>
> +static void sprd_eic_toggle_trigger(struct gpio_chip *chip, unsigned int irq,
> +                                   unsigned int offset)
> +{
> +       struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
> +       struct irq_data *data = irq_get_irq_data(irq);
> +       u32 trigger = irqd_get_trigger_type(data);
> +       int state, post_state;
> +
> +       /*
> +        * The debounce EIC and latch EIC can only support level trigger, so we
> +        * can toggle the level trigger to emulate the edge trigger.
> +        */
> +       if ((sprd_eic->type != SPRD_EIC_DEBOUNCE &&
> +            sprd_eic->type != SPRD_EIC_LATCH) ||
> +           !(trigger & IRQ_TYPE_EDGE_BOTH))
> +               return;
> +
> +       sprd_eic_irq_mask(data);
> +       state = sprd_eic_get(chip, offset);
> +
> +retry:
> +       switch (sprd_eic->type) {
> +       case SPRD_EIC_DEBOUNCE:
> +               if (state)
> +                       sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
> +               else
> +                       sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
> +               break;
> +       case SPRD_EIC_LATCH:
> +               if (state)
> +                       sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
> +               else
> +                       sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
> +               break;
> +       default:
> +               sprd_eic_irq_unmask(data);
> +               return;
> +       }
> +
> +       post_state = sprd_eic_get(chip, offset);
> +       if (state != post_state) {
> +               dev_warn(chip->parent, "EIC level was changed.\n");
> +               state = post_state;
> +               goto retry;
> +       }
> +
> +       sprd_eic_irq_unmask(data);
> +}
> +
>  static int sprd_eic_match_chip_by_type(struct gpio_chip *chip, void *data)
>  {
>         enum sprd_eic_type type = *(enum sprd_eic_type *)data;
> @@ -448,6 +520,7 @@ static void sprd_eic_handle_one_type(struct gpio_chip *chip)
>                                         bank * SPRD_EIC_PER_BANK_NR + n);
>
>                         generic_handle_irq(girq);
> +                       sprd_eic_toggle_trigger(chip, girq, n);
>                 }
>         }
>  }
> --
> 1.7.9.5
>



-- 
Baolin.wang
Best Regards
