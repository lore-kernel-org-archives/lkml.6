Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9E9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D89620851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AcOLyZ0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D89620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeK1KXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:23:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33284 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeK1KXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:23:45 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so3126360itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ktWiST3J0PhkcLNl8DSIkRY00GReKyTxaVr1/SUY75g=;
        b=AcOLyZ0iAm8vhmPJ0XO5e3qik9vjUAJ6C9VpXC/X8JZIr9FDNl9WrkPZ7GV+SIOz9x
         NWKsC0AEbX4cbX7tKi8eQ4e5y7JL1o1BcxcgMQ9DjdTZOAksAvalWknsZ915f/4Tv6T9
         lLVJ/lP8ff1ucZfIlkSieW0WcELHmnR3ObsQSPYqKMdlZeZPnTBrdGezKeDzO3vTgarC
         4pKsR+Hy3aYy6eJa+aXNwqc7DjRj85tvw/ykpSBzUXjstGPfQbVZPQ+z3iGfSPJV3+PV
         v8yCS8lq6JdbooLf1BHTO2ZiSl7gizj1yHgoysJ90jpcEu4P7xTGQBBx8M8rOZZncopv
         rWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ktWiST3J0PhkcLNl8DSIkRY00GReKyTxaVr1/SUY75g=;
        b=h5rQIV4Yv1rMI1pMaXCFys8OyP6bk/dhz0+nBXSLH81BCGma6btoetCxe3XbPlO8yf
         OqNZpfKx0zDdk1rVD5yV+WOZEyg4QvrJe0DF6sEy7EZpAkkqi8dt4fgw0LbN1SJTtxEw
         KeBfJO8v0vh5tSuZkTyeuNS/ocDIBJVDidFV596hzfWeDN9Fg2+ge4rdaKVdA2yQshCy
         f949zYYHR5rGMjdva7FpsPK0mQdbDrkIAmZSyKWkFw5Ii1UlXi3syEmHsyHuyDBDHa1o
         f5w4pSvKifPo7EhGXuxIIXAvZ/aXHGtleIO56dm+Z6wpaz/+lwP1E2VEe5WFJ49eEeBb
         Eq6w==
X-Gm-Message-State: AA+aEWbUWAPciirkDKjaOi9YIhOIsFxpVZs2Q2UTqePz8FyBULfM8cPw
        ossgLMLR0ZAsSgo8xn2UA8/BIA==
X-Google-Smtp-Source: AFSGD/XKx9HgNDUEgx4Btw0dCOs/ob0C9YnVzPPr0qC4kuElvxozA0udjl1csfsx0Zz4CzZHsCwjzQ==
X-Received: by 2002:a24:b305:: with SMTP id e5-v6mr953407itf.128.1543361053249;
        Tue, 27 Nov 2018 15:24:13 -0800 (PST)
Received: from localhost (230.sub-174-209-19.myvzw.com. [174.209.19.230])
        by smtp.gmail.com with ESMTPSA id 195sm346748itm.2.2018.11.27.15.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:24:12 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Tue, 27 Nov 2018 15:24:11 -0800 (PST)
To:     Stephen Boyd <sboyd@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/3] clk: sifive: add a driver for the SiFive FU540
 PRCI IP block
In-Reply-To: <154281815686.88331.17857751098132553261@swboyd.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.9999.1811261919130.16271@viisi.sifive.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com> <20181020135024.28573-4-paul.walmsley@sifive.com> <154281815686.88331.17857751098132553261@swboyd.mtv.corp.google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Stephen Boyd wrote:

> Quoting Paul Walmsley (2018-10-20 06:50:24)
> > diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
> > new file mode 100644
> > index 000000000000..870cb8333648
> > --- /dev/null
> > +++ b/drivers/clk/sifive/fu540-prci.c
> > @@ -0,0 +1,634 @@
> > +// SPDX-License-Identifier: GPL-2.0
> [...]
> > +
> > +#include <linux/clkdev.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clk.h>
> 
> Is this for of_clk_get_parent_count()? Use of_clk.h include for that,
> and drop this clk.h include if possible.

Done.

> > +#include <linux/clk/analogbits-wrpll-cln28hpc.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/log2.h>
> 
> Is this used?

It isn't.  Dropped.

> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/clk/sifive-fu540-prci.h>
> 
> Can you sort these at least by path includes so that linux/clk/ is
> somewhere together?

Done.

> > +/**
> > + * struct __prci_data - per-device-instance data
> > + * @va: base virtual address of the PRCI IP block
> > + * @hw_clks: encapsulates struct clk_hw records
> > + *
> > + * PRCI per-device instance data
> > + */
> > +struct __prci_data {
> > +       void __iomem *va;
> 
> Usually this is called 'base', but 'va' is fine too. 

OK

> What happens with NOMMU? Then it's not a VA anymore?

It's similar to other Linux code that refers to virtual addresses:

$ fgrep -r va linux/ | fgrep __iomem | egrep -iv '(val|riva)' | wc -l
270
$

(as a first-order approximation)

> > +/**
> > + * struct __prci_wrpll_data - WRPLL configuration and integration data
> > + * @c: WRPLL current configuration record
> > + * @bypass: fn ptr to code to bypass the WRPLL (if applicable; else NULL)
> > + * @no_bypass: fn ptr to code to not bypass the WRPLL (if applicable; else NULL)
> > + * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base address
> > + *
> > + * @bypass and @no_bypass are used for WRPLL instances that contain a separate
> > + * external glitchless clock mux downstream from the PLL.  The WRPLL internal
> > + * bypass mux is not glitchless.
> > + */
> > +struct __prci_wrpll_data {
> > +       struct analogbits_wrpll_cfg c;
> > +       void (*bypass)(struct __prci_data *pd);
> > +       void (*no_bypass)(struct __prci_data *pd);
> > +       u8 cfg0_offs;
> > +};
> 
> Why do we have this struct? Why not fold it into the prci_clock
> structure?

The code was written to be extensible to non-PLL clock tree elements.

> As far as I can tell it's a one to one correlation right now.

Certainly true at the moment.  Do you want them combined?

> > +/**
> > + * __prci_readl() - read from a PRCI register
> > + * @pd: PRCI context
> > + * @offs: register offset to read from (in bytes, from PRCI base address)
> > + *
> > + * Read the register located at offset @offs from the base virtual
> > + * address of the PRCI register target described by @pd, and return
> > + * the value to the caller.
> > + *
> > + * Context: Any context.
> > + *
> > + * Return: the contents of the register described by @pd and @offs.
> > + */
> > +static u32 __prci_readl(struct __prci_data *pd, u32 offs)
> > +{
> > +       return readl_relaxed(pd->va + offs);
> > +}
> > +
> > +static void __prci_writel(u32 v, u32 offs, struct __prci_data *pd)
> > +{
> > +       return writel_relaxed(v, pd->va + offs);
> > +}
> 
> Please remove these wrappers. The lines are only barely shorter with
> them, they mostly obfuscate the code,

Isn't the use of wrappers fairly common CCF and Linux device driver 
practice?

$ pcregrep -r \\wwritel drivers/clk | fgrep -v __raw | fgrep -v clk_writel | wc -l
148
$ pcregrep --buffer-size 65536 -r \\wwritel drivers/ | fgrep -v __raw | wc -l
8526
$

The usual motivation is not so much to shorten lines, but to have a 
centralized place for adding IP block-specific I/O barriers, register 
logging, and other debug.

> and writel swaps 'offs' and 'pd' vs readl (why?).

Yeah.  The include/asm-generic/io.h write*() functions invert the argument 
order from the read*() argument order.  There doesn't appear to be a 
strong idiom for device driver write*() argument order in the kernel, so I 
just picked one when I wrote them.

>       __prci_wrpll_unpack(&pwd->c, __prci_readl(pd, pwd->cfg0_offs));
> 
> vs.
> 
>       __prci_wrpll_unpack(&pwd->c, readl_relaxed(pd->va + pwd->cfg0_offs));

In any case, I am fine with removing them if that is the standard practice 
going forward for drivers/clk.

> > +/**
> > + * __prci_wrpll_pack() - pack PLL configuration parameters into a register value
> > + * @c: pointer to a struct analogbits_wrpll_cfg record containing the PLL's cfg
> > + *
> > + * Using a set of WRPLL configuration values pointed to by @c,
> > + * assemble a PRCI PLL configuration register value, and return it to
> > + * the caller.
> > + *
> > + * Context: Any context.  Caller must ensure that the contents of the
> > + *          record pointed to by @c do not change during the execution
> > + *          of this function.
> > + *
> > + * Returns: a value suitable for writing into a PRCI PLL configuration
> > + *          register
> > + */
> > +static u32 __prci_wrpll_pack(struct analogbits_wrpll_cfg *c)
> 
> const c?

Changed.

> > +/**
> > + * __prci_wrpll_write_cfg() - write WRPLL configuration into the PRCI
> > + * @pd: PRCI context
> > + * @pwd: PRCI WRPLL metadata
> > + * @c: WRPLL configuration record to write
> > + *
> > + * Write the WRPLL configuration described by @c into the WRPLL
> > + * configuration register identified by @pwd in the PRCI instance
> > + * described by @c.  Make a cached copy of the WRPLL's current
> > + * configuration so it can be used by other code.
> > + *
> > + * Context: Any context.  Caller must prevent the records pointed to by
> > + *          @pd and @pwd from changing during execution.
> > + */
> > +static void __prci_wrpll_write_cfg(struct __prci_data *pd,
> > +                                  struct __prci_wrpll_data *pwd,
> > +                                  struct analogbits_wrpll_cfg *c)
> > +{
> > +       __prci_writel(__prci_wrpll_pack(c), pwd->cfg0_offs, pd);
> > +
> > +       memcpy(&pwd->c, c, sizeof(struct analogbits_wrpll_cfg));
> 
> I'm trying to understand what all the memcpy() calls in this driver are
> doing. What is being optimized by storing the values in software? Is I/O
> access really that bad that we need to use memcpy()? Can you remove it
> all and just read and write registers when we need them? It would make
> things clearer and shorter. If you need caching, I would suggest you use
> regmap and all the caching features therein.

The primary goal is to minimize the number of CPU instructions executed by 
this driver when the CPU is running at a low clock rate.  This is 
important on the FU540 since the PLL bypass clock is slow.  Switching to 
regmap wouldn't help here, since the driver would still need to do the 
computation.

As a secondary goal, the shadow copy of the PLL configuration also 
allows the driver to avoid unnecessary PRCI register reads.

> > +/**
> > + * __prci_coreclksel_use_hfclk() - switch the CORECLK mux to output HFCLK
> > + * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
> > + *
> > + * Switch the CORECLK mux to the HFCLK input source; return once complete.
> > + *
> > + * Context: Any context.  Caller must prevent concurrent changes to the
> > + *          PRCI_CORECLKSEL_OFFSET register.
> > + */
> > +static void __prci_coreclksel_use_hfclk(struct __prci_data *pd)
> > +{
> > +       u32 r;
> > +
> > +       r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
> > +       r |= PRCI_CORECLKSEL_CORECLKSEL_MASK;
> > +       __prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
> > +
> > +       r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */
> 
> Barrier with what? 

That's an I/O barrier.  

> What are we synchronizing with?

The completion of the preceding write to the PRCI.

> > +/*
> > + * Linux clock framework integration
> > + *
> > + * See the Linux clock framework documentation for more information on
> > + * these functions.
> > + */
> > +
> > +static unsigned long sifive_fu540_prci_wrpll_recalc_rate(struct clk_hw *hw,
> > +                                                        unsigned long parent_rate)
> > +{
> > +       struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
> > +       struct __prci_wrpll_data *pwd = pc->pwd;
> > +
> > +       return analogbits_wrpll_calc_output_rate(&pwd->c, parent_rate);
> 
> I suppose this is one place where the caching must have gone wrong, so 
> then we needed to add __prci_wrpll_read_cfg() to make sure we've kept 
> things in sync with our memcpy? Please don't do that. Just read the 
> hardware in recalc_rate() so that we don't have to worry about syncing 
> framework state with this driver state.

The code is written to the usual Linux principle that the driver has 
exclusive access to the PRCI IP block.  Thus the shadow copy should be in 
sync with the hardware at all times. The only time that the PLL 
configuration needs to be read from the hardware is when the driver 
initializes.

Of course, the code could be changed to read the hardware directly. I'd be 
curious to know what advantage you see in making that change.  MMIO reads 
from a leaf IP block are slow, and the CPU cores on this chip are 
in-order.  The PRCI driver already maintains an up-to-date shadow copy of 
the PLL data to avoid unnecessary computation (as mentioned above).  Thus 
since the shadow copy is already there, it makes sense to use it.  But 
perhaps I am misunderstanding your comment?

> > +static int sifive_fu540_prci_wrpll_set_rate(struct clk_hw *hw,
> > +                                           unsigned long rate,
> > +                                           unsigned long parent_rate)
> > +{
> > +       struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
> > +       struct __prci_wrpll_data *pwd = pc->pwd;
> > +       struct __prci_data *pd = pc->pd;
> > +       int r;
> > +
> > +       r = analogbits_wrpll_configure_for_rate(&pwd->c, rate, parent_rate);
> > +       if (r)
> > +               return -ERANGE;
> 
> Why not return the value of 'r'?

Changed.

> > +
> > +       if (pwd->bypass)
> > +               pwd->bypass(pd);
> > +
> > +       __prci_wrpll_write_cfg(pd, pwd, &pwd->c);
> > +
> > +       udelay(analogbits_wrpll_calc_max_lock_us(&pwd->c));
> > +
> > +       if (pwd->no_bypass)
> > +               pwd->no_bypass(pd);
> 
> Maybe call it enable/disable_bypass() instead? no_bypass sounds like
> it's doing something if there isn't a bypass.

Changed.

> > +
> > +       return 0;
> > +}
> [...]
> > +
> > +/**
> > + * __prci_register_clocks() - register clock controls in the PRCI with Linux
> > + * @dev: Linux struct device *
> > + *
> > + * Register the list of clock controls described in __prci_init_plls[] with
> > + * the Linux clock framework.
> > + *
> > + * Return: 0 upon success or a negative Linux error code upon failure.
> 
> This is all Linux, so drop the "Linux" part?

Done.

> > + */
> > +static int __prci_register_clocks(struct device *dev)
> > +{
> > +       struct __prci_data *pd = dev_get_drvdata(dev);
> > +       struct clk_init_data init;
> > +       struct __prci_clock *pic;
> > +       int parent_count, i, clk_hw_count, r;
> > +
> > +       parent_count = of_clk_get_parent_count(dev->of_node);
> > +       if (parent_count != EXPECTED_CLK_PARENT_COUNT) {
> > +               dev_err(dev, "expected two parent clocks, only found %d\n",
> > +                       parent_count);
> 
> Heh, this would read funny if it says "expected two parent clocks, only
> found 50". 

Thanks, I've moved the "only" to appear earlier in the message.

> Can this be enforced with DT schema instead of checking at runtime in 
> the driver? We don't typically validate DT in the kernel because the 
> kernel is not a DT validator.

Doesn't most code that calls of_*() functions in the kernel check the 
result?  Looks like it based on a brief glance through the output of:

$ fgrep -rA 3 =\ of_ linux/

> > +               return -EINVAL;
> > +       }
> > +
> > +       memset(&init, 0, sizeof(struct clk_init_data));
> > +
> > +       /* Register PLLs */
> > +       clk_hw_count = sizeof(__prci_init_clocks) / sizeof(struct __prci_clock);
> > +
> > +       for (i = 0; i < clk_hw_count; ++i) {
> > +               pic = &__prci_init_clocks[i];
> > +
> > +               init.name = pic->name;
> > +               init.parent_names = (const char *[]) { pic->parent_name };
> 
> Just use &pic->parent_name instead?

Done.

> > +               init.num_parents = 1;
> > +               init.ops = pic->ops;
> > +               init.flags = CLK_IGNORE_UNUSED;
> 
> Why? Can you remove it? Or add a comment indicating why you need to have
> it here?

It's mostly prophylactic until the device driver code for this SoC 
matures.  It should be possible to remove it.

> > +               pic->hw.init = &init;
> > +
> > +               pic->pd = pd;
> > +
> > +               if (pic->pwd)
> > +                       __prci_wrpll_read_cfg(pd, pic->pwd);
> > +
> > +               r = devm_clk_hw_register(dev, &pic->hw);
> > +               if (r) {
> > +                       dev_warn(dev, "Failed to register clock %s: %d\n",
> > +                                init.name, r);
> > +                       return r;
> > +               }
> > +
> > +               r = clk_hw_register_clkdev(&pic->hw, pic->name, dev_name(dev));
> 
> Do you need clkdev? I would avoid clkdev if possible and just use DT
> based lookups until you need clkdev.

For debugging and sysfs code external to this patch, it's pleasant to be 
able to use clk_get_sys() et al.  Does the use of clkdev cause problems?

> > +       r = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                       &pd->hw_clks);
> > +       if (r) {
> > +               dev_err(dev, "could not add hw_provider: %d\n", r);
> > +               return -EINVAL;
> 
> Why override error code?

Changed.

> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Linux device model integration
> > + *
> > + * See the Linux device model documentation for more information about
> > + * these functions.
> > + */
> > +static int sifive_fu540_prci_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct resource *res;
> > +       struct __prci_data *pd;
> > +       int r;
> > +
> > +       pd = devm_kzalloc(dev, sizeof(struct __prci_data), GFP_KERNEL);
> 
> sizeof(*pd) please, makes shorter lines and avoids types changing.

Changed.

> > +       if (!pd)
> > +               return -ENOMEM;
> > +
> > +       dev_set_drvdata(dev, pd);
> 
> Why not just pass the pd to __prci_register_clocks() and not have any
> driver data?

Changed.

> > +
> > +       r = __prci_register_clocks(dev);
> > +       if (r) {
> > +               dev_err(dev, "could not register clocks: %d\n", r);
> > +               return -EINVAL;
> 
> But we override return value and always return -EINVAL? Why not return
> r?

Changed.

> > +       }
> > +
> > +       dev_info(dev, "SiFive FU540 PRCI probed\n");
> 
> Please no "I'm alive!" messages.

Converted this to a dev_dbg(), since I still find it useful during debug.  
Let me know if that's not enough.

> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id sifive_fu540_prci_of_match[] = {
> > +       { .compatible = "sifive,fu540-c000-prci0", },
> > +       {}
> > +};
> 
> Can it be a module? If so, add an MODULE_DEVICE_TABLE(of, ...) here.

Added.

> > +
> > +static struct platform_driver sifive_fu540_prci_driver = {
> > +       .driver = {
> > +               .name = "sifive-fu540-prci",
> > +               .of_match_table = sifive_fu540_prci_of_match,
> 
> And consider suppressing unbind from sysfs here if you don't want that
> feature.

I'm OK with someone trying to unbind it.

> > +       },
> > +       .probe = sifive_fu540_prci_probe,
> 
> Especially because there isn't a remove function.

Added one, based on other remove functions in drivers/clk.

> > diff --git a/include/linux/clk/sifive-fu540-prci.h b/include/linux/clk/sifive-fu540-prci.h
> > new file mode 100644
> > index 000000000000..5d03eae7d4ef
> > --- /dev/null
> > +++ b/include/linux/clk/sifive-fu540-prci.h
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 SiFive, Inc.
> > + * Wesley Terpstra
> > + * Paul Walmsley
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> Same SPDX comments apply here.

Done.


- Paul
