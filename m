Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D993C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC5C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3h09tUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC5C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJPAtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeJPAtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:49:47 -0400
Received: from localhost (unknown [106.201.39.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B889B204FD;
        Mon, 15 Oct 2018 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539623022;
        bh=/oxljZrE2efmRLtQLfPOVDipvkApCELsfRpcCJ/K8D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3h09tUvJsYsje3YZ+nYsNwcJ8Z28lJ/nrIwj3ZBrraJ5ngzu8W+59GbUSCuW95wn
         MzCP+alXoc9IHuaybwtS3/VuRvt1TGzeE3jKfzKwMTBICC8GroeIBzD/Btc+w0NaOS
         q528ToQRZHFcCLs5u0mIeyn/82aivEcv2fO4/oBY=
Date:   Mon, 15 Oct 2018 22:33:33 +0530
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
Message-ID: <20181015170333.GJ2400@vkoul-mobl>
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
 <1536799869-10643-3-git-send-email-yamada.masahiro@socionext.com>
 <20181005145706.GM2372@vkoul-mobl>
 <CAK7LNASF5Ct+ONWnRqZwstg+htAo0buG19HOGM-EV2EPe1NSbQ@mail.gmail.com>
 <20181006162246.GO2372@vkoul-mobl>
 <CAK7LNASmbRF1zvs_zbS1Ux3SKmAS5Ew9kVYPMagoO1Uf-WPUPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASmbRF1zvs_zbS1Ux3SKmAS5Ew9kVYPMagoO1Uf-WPUPg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-18, 01:27, Masahiro Yamada wrote:
> On Sun, Oct 7, 2018 at 1:23 AM Vinod <vkoul@kernel.org> wrote:
> > > > > +static int uniphier_mdmac_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct device *dev = &pdev->dev;
> > > > > +     struct uniphier_mdmac_device *mdev;
> > > > > +     struct dma_device *ddev;
> > > > > +     struct resource *res;
> > > > > +     int nr_chans, ret, i;
> > > > > +
> > > > > +     nr_chans = platform_irq_count(pdev);
> > > > > +     if (nr_chans < 0)
> > > > > +             return nr_chans;
> > > > > +
> > > > > +     ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> > > > > +                         GFP_KERNEL);
> > > > > +     if (!mdev)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > +     mdev->reg_base = devm_ioremap_resource(dev, res);
> > > > > +     if (IS_ERR(mdev->reg_base))
> > > > > +             return PTR_ERR(mdev->reg_base);
> > > > > +
> > > > > +     mdev->clk = devm_clk_get(dev, NULL);
> > > > > +     if (IS_ERR(mdev->clk)) {
> > > > > +             dev_err(dev, "failed to get clock\n");
> > > > > +             return PTR_ERR(mdev->clk);
> > > > > +     }
> > > > > +
> > > > > +     ret = clk_prepare_enable(mdev->clk);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     ddev = &mdev->ddev;
> > > > > +     ddev->dev = dev;
> > > > > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > > > > +     ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> > > > > +     ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> > > >
> > > > undefined?
> > >
> > > Precisely, I do not know the *_addr_widths.
> >
> > This is "your" controller, you know the capability!
> 
> No, I do not.
> 
> I wrote this driver, but the hardware-internal is not fully documented
> in the datasheet.
> I can see the functionality only from the software point of view.

Ah that is sad!

> > > As far as I read dmaengine/provider.rst
> > > this represents the data bytes that are read/written at a time.
> > >
> > > Really I do not know (care about) the transfer width.
> > >
> > > As I commented in v2, the connection of the device side is hard-wired.
> > > The transfer width cannot be observed from SW view.
> > >
> > > What should I do?
> >
> > Add the widths that are supported by the controller
> 
> To my best knowledge, this DMA engine is connected to a 32-bit bus.
> So, 4 bytes are read/written at a time.
> 
> This HW allows to set the transfer size by byte granularity.
> So, it would be possible to access the data bus
> by 1-byte, 2-bytes, 3-bytes as well.
> 
> I will set the OR of 1, 2, 3, 4 bytes.

that would be better. Also if you can test and verify these and add the
ones you have verified would be even better

> > > > > +static int uniphier_mdmac_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct uniphier_mdmac_device *mdev = platform_get_drvdata(pdev);
> > > > > +
> > > > > +     of_dma_controller_free(pdev->dev.of_node);
> > > > > +     dma_async_device_unregister(&mdev->ddev);
> > > > > +     clk_disable_unprepare(mdev->clk);
> > > >
> > > > at this point your irq is registered and can be fired, the tasklets are
> > > > not killed :(
> > >
> > >
> > > Please let me clarify the concerns here.
> > >
> > > Before the .remove hook is called, all the consumers should
> > > have already put the dma channels.
> > > So, no new descriptor is coming in.
> > >
> > > However,
> > >
> > > Some already-issued descriptors might be remaining, and being processed.
> > >
> > > [1] This DMA engine might be still running
> > >     when clk_disable_unprepare() is being called.
> > >     The register access with its clock disabled
> > >     would cause the system crash.
> >
> > Yes and dmaengine may fire a spurious irq..
> > >
> > > [2] vchan_cookie_complete() might being called at this point
> > >     and schedule the tasklet.
> > >     It might call uniphier_mdmac_desc_free() after
> > >     the reference disapperrs.
> > >
> > > Is this correct?
> >
> > Correct :)
> >
> > > Do you have recommendation
> > > for module removal guideline?
> >
> > Yes please free up or disable irq explictly, ensure pending irqs have
> > completed and then ensure all the tasklets are killed and in this order
> > for obvious reasons
> 
> Also, need to free up the left-over descriptor(s) right?
> Just killing the tasklets may result in memory leak.

Yes I am assuming you would have done so in terminate calls

> Please let know if the implementation in v4 is wrong.

Sure will do

-- 
~Vinod
