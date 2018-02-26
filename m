Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeBZJ7t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:59:49 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:33874 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeBZJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:59:35 -0500
X-Google-Smtp-Source: AH8x2255ua1yq/dlLrppARM9zGyruYOqp3wgQiKN7UiBVcPb9D/woRLEouVAX0VNuuKFNGY2NbvqH1zXziHC0z/JUng=
MIME-Version: 1.0
In-Reply-To: <CAHp75VfFKDkQQ9-vdjzDfE2Cdk2Cb93+kdceYQgEqt3hti=Wkg@mail.gmail.com>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
 <20180222191647.4727-3-ard.biesheuvel@linaro.org> <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
 <CAKv+Gu9XkmSPHZf+jVKOm-SX1GCWJUc7y3zTCuaHBwk8O3OC3Q@mail.gmail.com> <CAHp75VfFKDkQQ9-vdjzDfE2Cdk2Cb93+kdceYQgEqt3hti=Wkg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 26 Feb 2018 09:59:33 +0000
Message-ID: <CAKv+Gu__HiajW5fWvRnDft3+ef+gOowijxEd8wrF4U5Vu=3o0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

On 23 February 2018 at 13:12, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 23, 2018 at 2:40 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 23 February 2018 at 12:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Feb 22, 2018 at 9:16 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
...
>>>> +       ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>>>> +                                      &speed_khz);
>>>> +       if (ret) {
>>>> +               dev_err(&pdev->dev,
>>>> +                       "Missing clock-frequency property\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +       speed_khz /= 1000;
>
>>>> +       if (dev_of_node(&pdev->dev)) {
>>>> +               i2c->clk = devm_clk_get(&pdev->dev, "pclk");
>>>> +               if (IS_ERR(i2c->clk)) {
>>>> +                       dev_err(&pdev->dev, "cannot get clock\n");
>>>> +                       return PTR_ERR(i2c->clk);
>>>> +               }
>>>> +               dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
>>>> +
>>>> +               i2c->clkrate = clk_get_rate(i2c->clk);
>>>> +               dev_dbg(&pdev->dev, "clock rate %d\n", i2c->clkrate);
>>>> +               clk_prepare_enable(i2c->clk);
>>>> +       } else {
>>>> +               ret = device_property_read_u32(&pdev->dev,
>>>> +                                              "socionext,pclk-rate",
>>>> +                                              &i2c->clkrate);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +       }
>>>
>>> Okay, I got this case. It's more likely the one in 8250_dw.c.
>>>
>>> Can you do the similar way?
>
>> Could you elaborate?
>
> --- 8< --- 8< --- 8< ---
>         device_property_read_u32(dev, "clock-frequency", &p->uartclk);
>
>        /* If there is separate baudclk, get the rate from it. */
>        data->clk = devm_clk_get(dev, "baudclk");
> ...
>        if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
>                return -EPROBE_DEFER;
>        if (!IS_ERR_OR_NULL(data->clk)) {
>                err = clk_prepare_enable(data->clk);
>                if (err)
>                        dev_warn(dev, "could not enable optional baudclk: %d\n",
>                                 err);
>                else
>                        p->uartclk = clk_get_rate(data->clk);
>        }
>
>        /* If no clock rate is defined, fail. */
>        if (!p->uartclk) {
>                dev_err(dev, "clock rate not defined\n");
>                err = -EINVAL;
>                goto err_clk;
> --- 8< --- 8< --- 8< ---
>
> Replace 'baudclk' with 'pclk' and p->uartclk with i2c->clkrate in
> above and you are almost done.
>

I don't think this is better. The generic DT I2C 'clock-frequency'
property denotes the bus clock rate not the rate of the clock that
feeds the IP block. This is rather different from the UART bindings.

Also, I don't want to support 'socionext,pclk-rate' for DT platforms,
only for ACPI platforms.

>>>> +       i2c->irq = platform_get_irq(pdev, 0);
>>>> +       if (i2c->irq <= 0) {
>>>
>>> < 0 ?
>>>
>>> On some platforms IRQ == 0 might be valid.
>
>> Are you sure about that?
>
> Yes. I fixed some cases on one of a such.
>
>> http://yarchive.net/comp/linux/no_irq.html
>
> I agree with Linus from software IRQ (and nowadays luckily we are
> using IRQ descriptors), but I disagree with him from hardware
> prospective.
> 0 is totally valid HW IRQ line. In hardware there is no descriptor
> (except, yes, MSI and alike cases), it's just a wire with an index.
>
> So, while drivers are getting better in code prospective (though I
> don't see many of them comparing this to 0), the IRQ framework is
> changing itself as well.
>
> At which circumstances we might get 0 in the first place?
>
> Second question, doesn't request_irq() fail on irq==0 if it's not
> supported as valid by platform?
>

Yes, I suppose it does.

I'll change it to '< 0'
