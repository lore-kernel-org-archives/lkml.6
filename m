Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBTOCX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:02:23 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45876 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBTOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:02:20 -0500
X-Google-Smtp-Source: AH8x225fipL7WqEGPllAVi6A4a+xksfejhDSeKP6Dq9zzcMvzsTe93OPhMIMEYa4zuUuWx0GDhFbVnV10akWLV+ulpo=
MIME-Version: 1.0
In-Reply-To: <20180220090827.913-3-ard.biesheuvel@linaro.org>
References: <20180220090827.913-1-ard.biesheuvel@linaro.org> <20180220090827.913-3-ard.biesheuvel@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 16:02:18 +0200
Message-ID: <CAHp75VeUJpXLpL55erp+uoMH4jqppoG5zTt1DcffqNYPsJMdUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 11:08 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This is a cleaned up version of the I2C controller driver for
> the Fujitsu F_I2C IP, which was never supported upstream, and
> has now been incorporated into the Socionext SynQuacer SoC.
>

Typical issues below.

> +/* SPDX-License-Identifier: GPL-2.0 */

Shouldn't be // ?

> +#include <linux/init.h>

> +#include <linux/module.h>

Supposed to be one of them, not both.

> +#define WAIT_PCLK(n, rate)     ndelay((((1000000000 +  (rate) - 1) / \
> +                                        (rate) + n - 1) / n) + 10)

This split makes it harder to catch the calculus.
Also, you can use DIV_ROUND_UP(), though it longer, but adds a bit of
clarity to the calculus.

> +#define SYNQUACER_I2C_TIMEOUT(x) (msecs_to_jiffies(x))

Isn't shorter to use original function in place?

> +static inline unsigned long calc_timeout_ms(struct synquacer_i2c *i2c,
> +                                           struct i2c_msg *msgs,
> +                                           int num)
> +{
> +       unsigned long bit_count = 0;
> +       int i;
> +
> +       for (i = 0; i < num; i++, msgs++)
> +               bit_count += msgs->len;
> +
> +       return DIV_ROUND_UP(((bit_count * 9) + (10 * num)) * 3, 200) + 10;

Redundant parens surrounding multiplications.

bit_count * 9 + num * 10 ?

> +}

> +static void synquacer_i2c_stop(struct synquacer_i2c *i2c, int ret)
> +{
> +       dev_dbg(i2c->dev, "STOP\n");

Hmm... Can't use FTRACE ?

> +
> +       /*
> +        * clear IRQ (INT=0, BER=0)
> +        * set Stop Condition (MSS=0)
> +        * Interrupt Disable
> +        */
> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_BCR);
> +
> +       i2c->state = STATE_IDLE;
> +
> +       i2c->msg_ptr = 0;
> +       i2c->msg = NULL;
> +       i2c->msg_idx++;
> +       i2c->msg_num = 0;
> +       if (ret)
> +               i2c->msg_idx = ret;
> +
> +       complete(&i2c->completion);
> +}

> +       default:
> +               BUG();

Oh, oh. What is the strong argument to have this kind of crash here?

> +static int synquacer_i2c_master_start(struct synquacer_i2c *i2c,
> +                                     struct i2c_msg *pmsg)
> +{
> +       unsigned char bsr, bcr;

> +       dev_dbg(i2c->dev, "%s slave:0x%02x\n", __func__, pmsg->addr);

__func__ is redundant (See dynamic debug manual how to enable run-time).

> +       /* Force to make one clock pulse */

> +       count = 0;
> +       for (;;) {

> +               if (++count > 9) {
> +                       dev_err(i2c->dev, "%s: count: %i, bc2r: 0x%x\n",
> +                               __func__, count, bc2r);
> +                       return -EIO;
> +               }
> +       }

Personally I think for iterations do {} while approach looks cleaner
and more understandable:

unsigned int count = 10;

do {
...
} while (--count);

> +static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
> +                               struct i2c_msg *msgs, int num)
> +{
> +       unsigned char bsr;
> +       unsigned long timeout, bb_timeout;

> +       int ret = 0;

Redundant assignment.

> +       ret = synquacer_i2c_master_start(i2c, i2c->msg);
> +       if (ret < 0) {
> +               dev_dbg(i2c->dev, "Address failed: (0x%08x)\n", ret);

ret as a hex?!?!
So confusing.

A side note, %#08x will print 0x.

> +out:
> +       return ret;

Useless label since there is nothing except returning an error code.

> +static int synquacer_i2c_probe(struct platform_device *pdev)
> +{
> +       struct synquacer_i2c *i2c;
> +       struct resource *r;
> +       int speed_khz;
> +       int ret;

> +       if (dev_of_node(&pdev->dev)) {
> +               i2c->clk = devm_clk_get(&pdev->dev, "pclk");
> +               if (IS_ERR(i2c->clk)) {
> +                       dev_err(&pdev->dev, "cannot get clock\n");
> +                       return PTR_ERR(i2c->clk);
> +               }
> +               dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
> +
> +               i2c->clkrate = clk_get_rate(i2c->clk);
> +               dev_dbg(&pdev->dev, "clock rate %d\n", i2c->clkrate);
> +               clk_prepare_enable(i2c->clk);
> +       } else {

> +               ret = device_property_read_u32(&pdev->dev,
> +                                              "socionext,pclk-rate",
> +                                              &i2c->clkrate);

I suppose for ACPI we just register a fixed rate clock and use it in
the driver in the same way as in OF case.
I guess at some point we even can provide a generic clock provider for
ACPI based on rate property.

> +               if (ret)
> +                       return ret;
> +       }

> +       i2c->state = STATE_IDLE;
> +       i2c->dev = &pdev->dev;

> +       i2c->msg = NULL;

Isn't it done by z letter in allocation?


> +#ifdef CONFIG_PM_SLEEP

__maybe_unused instead of ugly #ifdef:s.

> +static int synquacer_i2c_suspend(struct device *dev)

> +static int synquacer_i2c_resume(struct device *dev)

> +#else
> +#define SYNQUACER_I2C_PM       NULL
> +#endif

> +#ifdef CONFIG_OF

OK, this is fine since we have an ACPI ID for it.

> +static const struct of_device_id synquacer_i2c_dt_ids[] = {
> +       { .compatible = "socionext,synquacer-i2c" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, synquacer_i2c_dt_ids);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id synquacer_i2c_acpi_ids[] = {
> +       { "SCX0003" },
> +       { /* sentinel */ }
> +};
> +#endif

> +static struct platform_driver synquacer_i2c_driver = {
> +       .probe  = synquacer_i2c_probe,
> +       .remove = synquacer_i2c_remove,
> +       .driver = {

> +               .owner = THIS_MODULE,

Macro below will fill this for you.

> +               .name = "synquacer_i2c",
> +               .of_match_table = of_match_ptr(synquacer_i2c_dt_ids),
> +               .acpi_match_table = ACPI_PTR(synquacer_i2c_acpi_ids),
> +               .pm = SYNQUACER_I2C_PM,
> +       },
> +};
> +module_platform_driver(synquacer_i2c_driver);

-- 
With Best Regards,
Andy Shevchenko
