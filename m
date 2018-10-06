Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B23C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A802147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5oLSstH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A802147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJFX0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbeJFX0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:26:54 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEEE208E7;
        Sat,  6 Oct 2018 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538842976;
        bh=4FSebQivrxUyb1ODfFsDVX01m/FvsN73KmEjDuBaI1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5oLSstHfyH7r9ObCHzWtLcvsYrD2uRLZyIqLIUgbrI7DsuIb7Q1yI92B5mskNU3a
         wApplm9+Bpbqmzo5mwynSlJIMN8jzdH4N4g+v1B5Xa2WLb6LSwZ8fueqAXyc+5yBV4
         EaVkK0R360QLXAs41H0BYrVvL9O6R1/bQbixb+CY=
Date:   Sat, 6 Oct 2018 21:52:46 +0530
From:   Vinod <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
 driver
Message-ID: <20181006162246.GO2372@vkoul-mobl>
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
 <1536799869-10643-3-git-send-email-yamada.masahiro@socionext.com>
 <20181005145706.GM2372@vkoul-mobl>
 <CAK7LNASF5Ct+ONWnRqZwstg+htAo0buG19HOGM-EV2EPe1NSbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASF5Ct+ONWnRqZwstg+htAo0buG19HOGM-EV2EPe1NSbQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-10-18, 04:11, Masahiro Yamada wrote:
> On Fri, Oct 5, 2018 at 11:57 PM Vinod <vkoul@kernel.org> wrote:
> >
> > On 13-09-18, 09:51, Masahiro Yamada wrote:
> >
> > > +#define UNIPHIER_MDMAC_CH_IRQ_STAT   0x010   // current hw status (RO)
> > > +#define UNIPHIER_MDMAC_CH_IRQ_REQ    0x014   // latched STAT (WOC)
> > > +#define UNIPHIER_MDMAC_CH_IRQ_EN     0x018   // IRQ enable mask
> > > +#define UNIPHIER_MDMAC_CH_IRQ_DET    0x01c   // REQ & EN (RO)
> > > +#define   UNIPHIER_MDMAC_CH_IRQ__ABORT               BIT(13)
> > > +#define   UNIPHIER_MDMAC_CH_IRQ__DONE                BIT(1)
> >
> > why notation if UNIPHIER_MDMAC_CH_IRQ__FOO ?
> 
> 
> Macros without double-underscore are just register offsets.
> 
> Macros with double-underscore are bit flags in
> the corresponding register.
> 
> 
> I often use this notation,
> and I also see somebody else did so.
> 
> For example, see
> drivers/mtd/nand/raw/denali.h
> 
> Please let me know if you do not like it.
> I can adjust myself to your preference.

Hmm I dont have a strong preference either way, though might be
worthwhile to document this style so that future updates can be
consistent

> 
> 
> 
> > > +#define UNIPHIER_MDMAC_CH_SRC_MODE   0x020   // mode of source
> > > +#define UNIPHIER_MDMAC_CH_DEST_MODE  0x024   // mode of destination
> > > +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_INC   (0 << 4)
> > > +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_DEC   (1 << 4)
> > > +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED (2 << 4)
> > > +#define UNIPHIER_MDMAC_CH_SRC_ADDR   0x028   // source address
> > > +#define UNIPHIER_MDMAC_CH_DEST_ADDR  0x02c   // destination address
> > > +#define UNIPHIER_MDMAC_CH_SIZE               0x030   // transfer bytes
> >
> > Please use /* comment */ style for these
> 
> I just thought people are getting tolerant of C++ comments.
> 
> Linus is so:
> https://lkml.org/lkml/2017/11/25/133
> 
> However, C++ is not officially allowed in the
> Linux coding style.
> 
> Will fix (without odd closing */ alignment)

Lets be conistent with the subsystem and use one style unless we decide
to move..

> > > +/* mc->vc.lock must be held by caller */
> > > +static struct uniphier_mdmac_desc *__uniphier_mdmac_next_desc(
> > > +                                             struct uniphier_mdmac_chan *mc)
> >
> > this can be made to look better by:
> >
> > static struct uniphier_mdmac_desc *
> > __uniphier_mdmac_next_desc(struct uniphier_mdmac_chan *mc)
> 
> OK.
> This is not mentioned in the coding style doc at least,
> but common enough.
> Will fix.

Coding style tells you guideline, it is upto you to make code look and
read better :)

> > Btw why leading __ for function name here and other places?
> 
> Just a reminder of "mc->vc.lock must be held by caller".

A comment is just fine..

> It is common to use double-underscore prefixing
> for functions that should be used with care.
> 
> However, I am happy to adjust myself to the maintainer.
> Please let me know if you do not like it, then I will remove them out.

I would like these to be removed

> > > +{
> > > +     struct virt_dma_desc *vd;
> > > +
> > > +     vd = vchan_next_desc(&mc->vc);
> > > +     if (!vd) {
> > > +             mc->md = NULL;
> > > +             return NULL;
> > > +     }
> > > +
> > > +     list_del(&vd->node);
> > > +
> > > +     mc->md = to_uniphier_mdmac_desc(vd);
> > > +
> > > +     return mc->md;
> > > +}
> > > +
> > > +/* mc->vc.lock must be held by caller */
> > > +static void __uniphier_mdmac_handle(struct uniphier_mdmac_chan *mc,
> > > +                                 struct uniphier_mdmac_desc *md)
> >
> > please align this to previous line opening brace (hint checkpatch with
> > --strict option will give you the warning)
> 
> This is already aligned.
> Perhaps, due to your mailer.

As I said please check checkpatch --strict

> > > +static int uniphier_mdmac_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct uniphier_mdmac_device *mdev;
> > > +     struct dma_device *ddev;
> > > +     struct resource *res;
> > > +     int nr_chans, ret, i;
> > > +
> > > +     nr_chans = platform_irq_count(pdev);
> > > +     if (nr_chans < 0)
> > > +             return nr_chans;
> > > +
> > > +     ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> > > +                         GFP_KERNEL);
> > > +     if (!mdev)
> > > +             return -ENOMEM;
> > > +
> > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +     mdev->reg_base = devm_ioremap_resource(dev, res);
> > > +     if (IS_ERR(mdev->reg_base))
> > > +             return PTR_ERR(mdev->reg_base);
> > > +
> > > +     mdev->clk = devm_clk_get(dev, NULL);
> > > +     if (IS_ERR(mdev->clk)) {
> > > +             dev_err(dev, "failed to get clock\n");
> > > +             return PTR_ERR(mdev->clk);
> > > +     }
> > > +
> > > +     ret = clk_prepare_enable(mdev->clk);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ddev = &mdev->ddev;
> > > +     ddev->dev = dev;
> > > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > > +     ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> > > +     ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> >
> > undefined?
> 
> Precisely, I do not know the *_addr_widths.

This is "your" controller, you know the capability!
> 
> As far as I read dmaengine/provider.rst
> this represents the data bytes that are read/written at a time.
> 
> Really I do not know (care about) the transfer width.
> 
> As I commented in v2, the connection of the device side is hard-wired.
> The transfer width cannot be observed from SW view.
> 
> What should I do?

Add the widths that are supported by the controller

> > > +static int uniphier_mdmac_remove(struct platform_device *pdev)
> > > +{
> > > +     struct uniphier_mdmac_device *mdev = platform_get_drvdata(pdev);
> > > +
> > > +     of_dma_controller_free(pdev->dev.of_node);
> > > +     dma_async_device_unregister(&mdev->ddev);
> > > +     clk_disable_unprepare(mdev->clk);
> >
> > at this point your irq is registered and can be fired, the tasklets are
> > not killed :(
> 
> 
> Please let me clarify the concerns here.
> 
> Before the .remove hook is called, all the consumers should
> have already put the dma channels.
> So, no new descriptor is coming in.
> 
> However,
> 
> Some already-issued descriptors might be remaining, and being processed.
> 
> [1] This DMA engine might be still running
>     when clk_disable_unprepare() is being called.
>     The register access with its clock disabled
>     would cause the system crash.

Yes and dmaengine may fire a spurious irq..
> 
> [2] vchan_cookie_complete() might being called at this point
>     and schedule the tasklet.
>     It might call uniphier_mdmac_desc_free() after
>     the reference disapperrs.
> 
> Is this correct?

Correct :)

> Do you have recommendation
> for module removal guideline?

Yes please free up or disable irq explictly, ensure pending irqs have
completed and then ensure all the tasklets are killed and in this order
for obvious reasons

-- 
~Vinod
