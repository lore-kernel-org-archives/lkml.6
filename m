Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933696AbeCMQfg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:35:36 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46604 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933069AbeCMQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:35:34 -0400
X-Google-Smtp-Source: AG47ELt22rKOEF9foU/myetHez0Io1vpmWej94BztZ4y+OlGskW5nZeF02Ct755tCNi52O1jiZLuJ7TSK4s53g655iA=
MIME-Version: 1.0
In-Reply-To: <1520879456-14777-1-git-send-email-phil.edworthy@renesas.com>
References: <1520879456-14777-1-git-send-email-phil.edworthy@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 18:35:32 +0200
Message-ID: <CAHp75Vfj-=fity+ibx8GDVf+vN7oPAUAzSGVBW=AVeSXhb3_Rw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: dwapb: Add support for a bus clock
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 8:30 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> Enable an optional bus clock provided by DT.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(Assuming it has been tested on clock-less cases)

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Fix include order.
>  - Use a clock name.
>  - Check errors from clk_prepare_enable()
>  - Add calls to enable/disable the clock in PM
> ---
>  drivers/gpio/gpio-dwapb.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index b0704a8..226977f 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -8,8 +8,9 @@
>   * All enquiries to support@picochip.com
>   */
>  #include <linux/acpi.h>
> -#include <linux/gpio/driver.h>
> +#include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -98,6 +99,7 @@ struct dwapb_gpio {
>         struct irq_domain       *domain;
>         unsigned int            flags;
>         struct reset_control    *rst;
> +       struct clk              *clk;
>  };
>
>  static inline u32 gpio_reg_v2_convert(unsigned int offset)
> @@ -670,6 +672,16 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
>         if (IS_ERR(gpio->regs))
>                 return PTR_ERR(gpio->regs);
>
> +       /* Optional bus clock */
> +       gpio->clk = devm_clk_get(&pdev->dev, "bus");
> +       if (!IS_ERR(gpio->clk)) {
> +               err = clk_prepare_enable(gpio->clk);
> +               if (err) {
> +                       dev_info(&pdev->dev, "Cannot enable clock\n");
> +                       return err;
> +               }
> +       }
> +
>         gpio->flags = 0;
>         if (dev->of_node) {
>                 const struct of_device_id *of_devid;
> @@ -712,6 +724,7 @@ static int dwapb_gpio_remove(struct platform_device *pdev)
>         dwapb_gpio_unregister(gpio);
>         dwapb_irq_teardown(gpio);
>         reset_control_assert(gpio->rst);
> +       clk_disable_unprepare(gpio->clk);
>
>         return 0;
>  }
> @@ -757,6 +770,8 @@ static int dwapb_gpio_suspend(struct device *dev)
>         }
>         spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>
> +       clk_disable_unprepare(gpio->clk);
> +
>         return 0;
>  }
>
> @@ -768,6 +783,9 @@ static int dwapb_gpio_resume(struct device *dev)
>         unsigned long flags;
>         int i;
>
> +       if (!IS_ERR(gpio->clk))
> +               clk_prepare_enable(gpio->clk);
> +
>         spin_lock_irqsave(&gc->bgpio_lock, flags);
>         for (i = 0; i < gpio->nr_ports; i++) {
>                 unsigned int offset;
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
