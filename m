Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDRHCf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:02:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40163 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeDRHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:02:33 -0400
X-Google-Smtp-Source: AB8JxZoDUuXMbIxn8OhFAI7j+dO0G+Rqq2GZUiVqWXGcQoC0m8pPHBqt8+sPj0reb5B4+LE0DxYOrNMeNOXUqpCmimc=
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1769DB39F986BEADEF61F8C9F5B30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1523609472-4481-1-git-send-email-phil.edworthy@renesas.com>
 <CAFHUOYziPaZC-Zcb7rXqC9p24H+CU4wK4NQShQkYLgH7c5mVwA@mail.gmail.com> <TY1PR01MB1769DB39F986BEADEF61F8C9F5B30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From: Hoan Tran <hotran@apm.com>
Date: Wed, 18 Apr 2018 00:02:31 -0700
Message-ID: <CAFHUOYzPO+99HMLV7i1=ZoQG3vKRp2v5GzJdpW9yoWovx8D91Q@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: dwapb: Add support for 1 interrupt per port A GPIO
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3I72fKg010370

Hi Phil,

On Fri, Apr 13, 2018 at 9:47 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> Hi Hoan,
>
> On 13 April 2018 17:37 Hoan Tran wrote:
>> On Fri, Apr 13, 2018 at 1:51 AM, Phil Edworthy wrote:
>> > The DesignWare GPIO IP can be configured for either 1 interrupt or 1
>> > per GPIO in port A, but the driver currently only supports 1 interrupt.
>> > See the DesignWare DW_apb_gpio Databook description of the
>> > 'GPIO_INTR_IO' parameter.
>> >
>> > This change allows the driver to work with up to 32 interrupts, it
>> > will get as many interrupts as specified in the DT 'interrupts' property.
>> > It doesn't do anything clever with the different interrupts, it just
>> > calls the same handler used for single interrupt hardware.
>> >
>> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> > ---
>> > One point to mention is that I have made it possible for users to have
>> > unconncted interrupts by specifying holes in the list of interrupts.
>> > This is done by supporting the interrupts-extended DT prop.
>> > However, I have no use for this and had to hack some test case for this.
>> > Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
>> >
>> > v3:
>> >  - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid
>> > bisect problems
>> > v2:
>> >  - Replaced interrupt-mask DT prop with support for the interrupts-
>> extended
>> >    prop. This means replacing the call to irq_of_parse_and_map() with calls
>> >    to of_irq_parse_one() and irq_create_of_mapping().
>> >
>> > Note: There are a few *code* lines over 80 chars, but this is just guidance,
>> >    right? Especially as there are already some lines over 80 chars.
>> > ---
> [snip]
>
>> > -               if (has_acpi_companion(dev) && pp->idx == 0)
>> > -                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
>> > +               if (has_acpi_companion(dev) && pp->idx == 0) {
>> > +                       pp->irq[0] = platform_get_irq(to_platform_device(dev), 0);
>> > +                       if (pp->irq[0])
>> > +                               pp->has_irq = true;
>> > +               }
>>
>> It doesn't work for ACPI. Could you do the same logic for ACPI?
> I don’t have access to any device that was baked (i.e. fabbed) with multiple
> output interrupts from the Synopsys GPIO blocks and use ACPI. I don't
> know if any such device exists.

Below code is tested on X-Gene system which supports 1 interrupt per
GPIO on Port A. You can update it into your patch.

-               if (has_acpi_companion(dev) && pp->idx == 0)
-                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
+               if (has_acpi_companion(dev) && pp->idx == 0) {
+                       unsigned int j;
+                       for (j = 0; j < pp->ngpio; j++) {
+                               pp->irq[j] =
platform_get_irq(to_platform_device(dev), j);
+                               if (pp->irq[j])
+                                       pp->has_irq = true;
+                       }
+               }

Thanks
Hoan

>
> I would prefer not writing code that can be tested easily. I cannot even
> test the current, albeit small, changes to the Intel Quark MFD.
>
> Regards
> Phil
>
>> Thanks
>> Hoan
>>
>> >
>> >                 pp->irq_shared  = false;
>> >                 pp->gpio_base   = -1;
>> > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c
>> > b/drivers/mfd/intel_quark_i2c_gpio.c
>> > index 90e35de..5bddb84 100644
>> > --- a/drivers/mfd/intel_quark_i2c_gpio.c
>> > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
>> > @@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev
>> *pdev, struct mfd_cell *cell)
>> >         pdata->properties->idx          = 0;
>> >         pdata->properties->ngpio        = INTEL_QUARK_MFD_NGPIO;
>> >         pdata->properties->gpio_base    = INTEL_QUARK_MFD_GPIO_BASE;
>> > -       pdata->properties->irq          = pdev->irq;
>> > +       pdata->properties->irq[0]       = pdev->irq;
>> > +       pdata->properties->has_irq      = true;
>> >         pdata->properties->irq_shared   = true;
>> >
>> >         cell->platform_data = pdata;
>> > diff --git a/include/linux/platform_data/gpio-dwapb.h
>> > b/include/linux/platform_data/gpio-dwapb.h
>> > index 2dc7f4a..5a52d69 100644
>> > --- a/include/linux/platform_data/gpio-dwapb.h
>> > +++ b/include/linux/platform_data/gpio-dwapb.h
>> > @@ -19,7 +19,8 @@ struct dwapb_port_property {
>> >         unsigned int    idx;
>> >         unsigned int    ngpio;
>> >         unsigned int    gpio_base;
>> > -       unsigned int    irq;
>> > +       unsigned int    irq[32];
>> > +       bool            has_irq;
>> >         bool            irq_shared;
>> >  };
>> >
>> > --
>> > 2.7.4
>> >
