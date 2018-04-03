Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeDCRAc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:00:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34776 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeDCRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:00:27 -0400
X-Google-Smtp-Source: AIpwx4+FbtCXkP8c9/UN30csSGCb1N7aywoHSM1qNwWYNFjS8JgqL1MP6ci/xBziWyvXbfM9qjSbHg==
Date: Tue, 3 Apr 2018 22:30:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Subject: Re: [PATCH v6 3/9] pinctrl: actions: Add Actions S900 pinctrl driver
Message-ID: <20180403170016.w3scjt57ssvk6zyi@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
 <20180328174703.19778-4-manivannan.sadhasivam@linaro.org>
 <CAHp75VeRh9hORs=4nPqc=rUOCRzAfp0z2_1_xpJUScAeE07yqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeRh9hORs=4nPqc=rUOCRzAfp0z2_1_xpJUScAeE07yqw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Mar 31, 2018 at 12:16:49AM +0300, Andy Shevchenko wrote:
> On Wed, Mar 28, 2018 at 8:46 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> > pinctrl, pinmux and pinconf functionalities through a range of registers
> > common to both gpio driver and pinctrl driver.
> >
> > Pinmux functionality is available only for the pin groups while the
> > pinconf functionality is available for both pin groups and individual
> > pins.
> 
> > +static void owl_update_bits(void __iomem *base, u32 mask, u32 val)
> > +{
> > +       u32 reg_val;
> > +
> > +       reg_val = readl_relaxed(base);
> > +
> > +       reg_val &= ~mask;
> > +       reg_val |= val;
> 
> Usual pattern here is
> 
> reg_val = (reg_val & ~mask) | (val & mask);
> 
> This will allow to avoid possible overflow.
> 

Ack.

> > +
> > +       writel_relaxed(reg_val, base);
> > +}
> 
> > +       tmp = readl_relaxed(pctrl->base + reg);
> > +       mask = (1 << width) - 1;
> > +       arg = (tmp >> bit) & mask;
> 
> This looks like a candidate for a helper function. You have at least
> one more same code.
> 
> Something like
> 
> ..._read_field(reg, mask, shift)
> 
>

Okay. Will add owl_read_field helper function.
 
> > +               mask = (1 << width) - 1;
> > +               mask = mask << bit;
> > +
> > +               owl_update_bits(pctrl->base + reg, mask, (arg << bit));
> 
> Similar here,
> 
> ..._write_field(regm mask, shift, arg)
> 

Will add owl_write_field helper function.

> > +       tmp = readl_relaxed(pctrl->base + reg);
> > +       mask = (1 << width) - 1;
> > +       arg = (tmp >> bit) & mask;
> 
> > +               mask = (1 << width) - 1;
> > +               mask = mask << bit;
> > +
> > +               owl_update_bits(pctrl->base + reg, mask, (arg << bit));
> 
> > +static const struct pinconf_ops owl_pinconf_ops = {
> > +       .is_generic = true,
> > +       .pin_config_get = owl_pin_config_get,
> > +       .pin_config_set = owl_pin_config_set,
> > +       .pin_config_group_get = owl_group_config_get,
> > +       .pin_config_group_set = owl_group_config_set
> 
> It's still good idea to leave comma here...
>

I'm confused. What is the criteria for removing/keeping comma for last member
of struct? I followed your gpio driver suggestion.

Thanks,
Mani

> > +};
> > +
> > +static struct pinctrl_desc owl_pinctrl_desc = {
> > +       .pctlops = &owl_pinctrl_ops,
> > +       .pmxops = &owl_pinmux_ops,
> > +       .confops = &owl_pinconf_ops,
> > +       .owner = THIS_MODULE
> 
> ...and here, and in all similar places.
> 
> > +};
> > +
> 
> -- 
> With Best Regards,
> Andy Shevchenko
