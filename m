Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeEPMvX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:51:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38632 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbeEPMvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:51:18 -0400
X-Google-Smtp-Source: AB8JxZpONqhsmo+sA+JJat+iWOB8tE/XFCG4CTOR/6/AiMCShSZbvz60phd0KlSfE6wpzTWRysUFYEc1NR2koFt7wwA=
MIME-Version: 1.0
In-Reply-To: <no_message-id@ru>
References: <no_message-id@ru>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 14:51:16 +0200
Message-ID: <CACRpkdbn_8WUQ8oqn2+M6KpEEogLTMMqbJrp-d2=HEkjJ-XtDQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Clear irq trigger type on irq shutdown
To: Grigoryev Denis <grigoryev@fastwel.ru>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 6:53 PM, Grigoryev Denis <grigoryev@fastwel.ru> wrote:

> The driver stores the result of irq_set_type() in the internal variables
> irq_trig_raise and irq_trig_fall, which later are used to determine
> the GPIOs that must be re-configured as input. These variables retain their
> value between gpiolib's  export / unexport, resulting in an incorrect
> state in some cases. The corresponding bits in the variables
> irq_trig_raise and irq_trig_fall should be cleared in irq_shutdown().
>
> Signed-off-by: Denis Grigoryev <grigoryev@fastwel.ru>
> ---
>  drivers/gpio/gpio-pca953x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index d2ead4b..b41be8c 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -522,6 +522,15 @@ static int pca953x_irq_set_type(struct irq_data *d, unsigned int type)
>         return 0;
>  }
>
> +static void pca953x_irq_shutdown(struct irq_data *d)
> +{
> +       struct pca953x_chip *chip = irq_data_get_irq_chip_data(d);
> +       u8 mask = 1 << (d->hwirq % BANK_SZ);
> +
> +       chip->irq_trig_raise[d->hwirq / BANK_SZ] &= ~mask;
> +       chip->irq_trig_fall[d->hwirq / BANK_SZ] &= ~mask;
> +}
> +
>  static struct irq_chip pca953x_irq_chip = {
>         .name                   = "pca953x",
>         .irq_mask               = pca953x_irq_mask,
> @@ -529,6 +538,7 @@ static struct irq_chip pca953x_irq_chip = {
>         .irq_bus_lock           = pca953x_irq_bus_lock,
>         .irq_bus_sync_unlock    = pca953x_irq_bus_sync_unlock,
>         .irq_set_type           = pca953x_irq_set_type,
> +       .irq_shutdown           = pca953x_irq_shutdown,
>  };

This driver has a big set of users, so putting some maintainers
in the loop so we can get some patch review.

Yours,
Linus Walleij
