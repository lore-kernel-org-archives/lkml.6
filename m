Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeFAHcF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:32:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34027 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeFAHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:32:01 -0400
X-Google-Smtp-Source: ADUXVKI/ZANiCzwC/Kkm84GIMMQL50srXvHczKBfHOmcWwr3aE+nKQRgwUDuiqKVWYOWtG4kCMbKhA==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Fri, 1 Jun 2018 10:31:56 +0300
To: Stephen Boyd <sboyd@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, mazziesaccount@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 5/6] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180601073156.GC5150@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3d9d7239331c30826a237ae55db28d918155d504.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <152777943977.144038.10971658990200651749@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152777943977.144038.10971658990200651749@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all - Thanks for looking at this!

On Thu, May 31, 2018 at 08:10:39AM -0700, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-05-30 01:43:19)
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 41492e980ef4..4b045699bb5e 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -279,6 +279,15 @@ config COMMON_CLK_STM32H7
> >         ---help---
> >           Support for stm32h7 SoC family clocks
> >  
> > +config COMMON_CLK_BD71837
> > +       tristate "Clock driver for ROHM BD71837 PMIC MFD"
> > +       depends on MFD_BD71837
> > +       depends on I2C=y
> 
> Why depend on I2C=y?

I added this because the PMIC is connected via i2c. But as you ask this
- and as you probably knew my answer - I guess this is not correct. So
I guess depends on MFD_BD71837 should be sufficient and the MFD portion
should hide the fact we sit on I2C? If this is the case - I will remove
this.

> 
> > +       depends on OF
> 
> Why depend on OF?

You're right. This is not needed. I'll remove this.

> 
> > +       help
> > +         This driver supports ROHM BD71837 PMIC clock.
> > +
> > +
> >  source "drivers/clk/bcm/Kconfig"
> >  source "drivers/clk/hisilicon/Kconfig"
> >  source "drivers/clk/imgtec/Kconfig"
> > diff --git a/drivers/clk/clk-bd71837.c b/drivers/clk/clk-bd71837.c
> > new file mode 100644
> > index 000000000000..91456d1077ac
> > --- /dev/null
> > +++ b/drivers/clk/clk-bd71837.c
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// bd71837.c  -- ROHM BD71837MWV clock driver
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/bd71837.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +
> > +static int bd71837_clk_enable(struct clk_hw *hw);
> > +static void bd71837_clk_disable(struct clk_hw *hw);
> > +static int bd71837_clk_is_enabled(struct clk_hw *hw);
> > +
> > +struct bd71837_clk {
> > +       struct clk_hw hw;
> > +       uint8_t reg;
> > +       uint8_t mask;
> > +       unsigned long rate;
> > +       struct platform_device *pdev;
> > +       struct bd71837 *mfd;
> > +};
> > +
> > +static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
> > +                                            unsigned long parent_rate);
> > +
> > +static const struct clk_ops bd71837_clk_ops = {
> > +       .recalc_rate = &bd71837_clk_recalc_rate,
> > +       .prepare = &bd71837_clk_enable,
> > +       .unprepare = &bd71837_clk_disable,
> > +       .is_prepared = &bd71837_clk_is_enabled,
> > +};
> 
> Move this structure after the function definitions. And drop the forward
> declared functions.

Allright.

> 
> > +
> > +static int bd71837_clk_set(struct clk_hw *hw, int status)
> > +{
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       return bd71837_update_bits(c->mfd, c->reg, c->mask, status);
> > +}
> > +
> > +static void bd71837_clk_disable(struct clk_hw *hw)
> > +{
> > +       int rv;
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       rv = bd71837_clk_set(hw, 0);
> > +       if (rv)
> > +               dev_err(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
> 
> Why is a disable error message more important than an enable error
> message?  Please drop this message and rely on callers to indicate if
> enabling their clk didn't work for some reason.

Reason is that the disable function is not returning error. So if I drop
the print there will be no indication of error, right?

> 
> > +}
> > +
> > +static int bd71837_clk_enable(struct clk_hw *hw)
> > +{
> > +       return bd71837_clk_set(hw, 1);
> > +}
> > +
> > +static int bd71837_clk_is_enabled(struct clk_hw *hw)
> > +{
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       return c->mask & bd71837_reg_read(c->mfd, c->reg);
> 
> Please put this on two or more lines so we know what the type of
> bd71837_reg_read() returns:
> 
> 	u32 reg = bd71837_reg_read(....)
> 
> 	return c->mask & reg;
> 

Right. I'll do this.

> 
> > +}
> > +
> > +static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
> > +                                            unsigned long parent_rate)
> > +{
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       return c->rate;
> 
> Recalc rate should read the hardware instead of returning a cached rate
> unless it can't actually read hardware.

We can't read the rate from HW. And actually, as this is fixed rate
clock generator - is the recalc_rate needed at all?

> 
> > +}
> > +
> > +static int bd71837_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct bd71837_clk *c;
> > +       int rval = -ENOMEM;
> > +       struct bd71837 *mfd = dev_get_drvdata(pdev->dev.parent);
> > +       const char *errstr = "memory allocation for bd71837 data failed";
> 
> We don't need allocation error messages.

Correct. I'll remove.

> 
> > +       struct clk_init_data init = {
> > +               .name = "bd71837-32k-out",
> > +               .ops = &bd71837_clk_ops,
> > +       };
> > +
> > +       c = kzalloc(sizeof(struct bd71837_clk), GFP_KERNEL);
> 
> Use sizeof(*c) instead so we don't have to worry about type mismatches.

Ok.

> 
> > +       if (!c)
> > +               goto err_out;
> > +
> > +       c->reg = BD71837_REG_OUT32K;
> > +       c->mask = BD71837_OUT32K_EN;
> > +       c->rate = BD71837_CLK_RATE;
> 
> Is the plan to have more clks supported by this driver in the future?
> Because right now it seems to make a structure up and then hardcode the
> members for a single clk so I'm not sure why those registers aren't just
> hardcoded in the clk_ops functions that use them.

(At least) one more chip from this series is coming and I am planning to
support it with this driver. I am not sure if the registers will stay
the same. Hence I rather not hardcode the register values.

> 
> > +       c->mfd = mfd;
> > +       c->pdev = pdev;
> > +
> > +       if (pdev->dev.of_node)
> 
> If there isn't an of_node it would be NULL, and then calling the
> function below would cause it to not update the init name? Seems like it
> could be called unconditionally.

Right.

> 
> > +               of_property_read_string_index(pdev->dev.of_node,
> > +                                             "clock-output-names", 0,
> > +                                             &init.name);
> > +
> > +       c->hw.init = &init;
> > +
> > +       errstr = "failed to register 32K clk";
> 
> The 'errstr' thing is not standard. Please just call dev_err() directly
> with the string you want to print. And consider not printing anything at
> all.

I think this technique is actually used in many places at net side. I
guess i have adobted this habit from some netlink message handling code.
I can change this to in-place prints if it fits environment better
though.

> 
> > +       rval = clk_hw_register(&pdev->dev, &c->hw);
> > +       if (rval)
> > +               goto err_free;
> > +
> > +       errstr = "failed to register clkdev for bd71837";
> > +       rval = clk_hw_register_clkdev(&c->hw, init.name, NULL);
> 
> Are you using the clkdev lookup? Or this is just added for backup
> purposes? If this is a mostly DT driver then please drop this part of
> the patch and rely on of_clk_hw_add_provider() to handle the lookup
> instead.

I did this because this is how I get the clk_get to work in my test
driver. Problem is that I don't know how this clock is going to be used
- and I lack of knowledge how these things are usually done. I don't
know the clock consumer code so this was best I could think of. But if
this is not how things are usually handled I can remove the clkdev and
rely on of_clk_add_hw_provider. Would this be correct then:

> 
> > +       if (rval)
> > +               goto err_unregister;
> > +
> > +       platform_set_drvdata(pdev, c);
> > +       dev_dbg(&pdev->dev, "bd71837_clk successfully probed\n");
> 
> There's a pr_debug() in really_probe() for this.

Oh, thanks. I'll remove this debug.

> 
> > +
> > +       return 0;
> > +
> > +err_unregister:
> > +       clk_hw_unregister(&c->hw);
> > +err_free:
> > +       kfree(c);
> > +err_out:
> > +       dev_err(&pdev->dev, "%s\n", errstr);
> > +       return rval;
> > +}
> > +
> > +static int bd71837_clk_remove(struct platform_device *pdev)
> > +{
> > +       struct bd71837_clk *c = platform_get_drvdata(pdev);
> > +
> > +       if (c) {
> > +               clk_hw_unregister(&c->hw);
> 
> Use devm to register clks.
> 
> > +               kfree(c);
> 
> and devm_kzalloc()

Right. Thanks - devm makes this simpler.

> 
> > +               platform_set_drvdata(pdev, NULL);
> 
> This doesn't need to be done. Drop it.

Allright. Will drop.

> 
> > +       }
> > +       return 0;
> > +}
> > +



Br,
	Matti Vaittinen
