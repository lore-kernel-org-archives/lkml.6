Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B3F21848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548248229;
	bh=4UHeL/PRsy5ZkqwjY/2Kvh0/ucw9ulcgdgyag/qx65M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ag8e3zpuXh2NZ4bcENiO/oQt7EHBJwiTC/lxXzvXSb7ZIRKZKCblhz0/7SxoRee8V
	 74locqIr+5dw0pv0Uhgfpb3zoAeWuUgIrTK7zTWCX/cYxDXqV4wTNWTXA5hOUSxMBm
	 n+f9MM9wDEVHlsH1fDRoI5MvJlOYyqN8kfoBfc6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfAWM5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWM5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:57:07 -0500
Received: from localhost (unknown [106.200.229.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4C32183F;
        Wed, 23 Jan 2019 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548248225;
        bh=4UHeL/PRsy5ZkqwjY/2Kvh0/ucw9ulcgdgyag/qx65M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0aFG3JcIVRE+xK8lqRt6YzT8MICeP6Og7mSzJ+k7kVUJyoESVczFxoO77og2DQ4r
         iN3hE2GSKH1Qjc5sPM0bxG3jNOz10am+IEq25vfAFdLszxMIk0WWtXQ5bmbPCQ29TK
         KeVWw1OE6iKdNtwymxteXyYz2Z+ys/nJ5qW76Clo=
Date:   Wed, 23 Jan 2019 18:25:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Tanglei Han <hantanglei@huawei.com>
Subject: Re: [PATCH 3/8 v4] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
Message-ID: <20190123125533.GP4635@vkoul-mobl>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-4-git-send-email-john.stultz@linaro.org>
 <20190120111115.GU4635@vkoul-mobl>
 <CALAqxLXauR4guYMtCYK-wnAqcZCkLY7-vWQ5U-knvHQt1twG4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXauR4guYMtCYK-wnAqcZCkLY7-vWQ5U-knvHQt1twG4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-19, 15:48, John Stultz wrote:
> On Sun, Jan 20, 2019 at 3:12 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 16-01-19, 09:10, John Stultz wrote:
> > > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> > >
> > > On the hi3660 hardware there are two (at least) DMA controllers,
> > > the DMA-P (Peripherial DMA) and the DMA-A (Audio DMA). The
> >                     ^^^
> > typo
> 
> Thanks so much for the review!
> 
> Fixed!
> 
> > > +
> > > +#define K3_FLAG_NOCLK  (1<<0)
> >
> > why not use BIT()
> >
> > space between two please
> 
> Fixed.
> 
> > > +static const struct k3dma_soc_data k3_v1_dma_data = {
> > > +     .flags = 0,
> > > +};
> >
> > So basically this is default right, do we need to set dma_data and not
> > assume default..
> 
> I'm not sure I fully understand you here. Basically I'm just creating
> a per-variant data structure. The k3_v1_dma_data isn't really the
> default, but is the first variant supported. There may be future
> variants that cause some new flag that the k3_v3_dma_data may need to
> set. But for now that variant doesn't have any flags set.

So my point was we can skip this and treat driver data NULL as default
i.e. no flags, no big deal though, saves you dummy k3_v1_dma_data.

> 
> 
> > > +
> > > +static const struct k3dma_soc_data asp_v1_dma_data = {
> > > +     .flags = K3_FLAG_NOCLK,
> > > +};
> > > +
> > >  static const struct of_device_id k3_pdma_dt_ids[] = {
> > > -     { .compatible = "hisilicon,k3-dma-1.0", },
> > > +     { .compatible = "hisilicon,k3-dma-1.0",
> > > +       .data = &k3_v1_dma_data
> > > +     },
> > > +     { .compatible = "hisilicon,hisi-pcm-asp-dma-1.0",
> > > +       .data = &asp_v1_dma_data
> > > +     },
> > >       {}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> > > @@ -810,6 +830,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
> > >
> > >  static int k3_dma_probe(struct platform_device *op)
> > >  {
> > > +     const struct k3dma_soc_data *soc_data;
> > >       struct k3_dma_dev *d;
> > >       const struct of_device_id *of_id;
> > >       struct resource *iores;
> > > @@ -823,6 +844,10 @@ static int k3_dma_probe(struct platform_device *op)
> > >       if (!d)
> > >               return -ENOMEM;
> > >
> > > +     soc_data = device_get_match_data(&op->dev);
> > > +     if (!soc_data)
> > > +             return -EINVAL;
> >
> > So this is not optional, either ways fine by me :)
> 
> I think this way makes sense, but maybe I'm missing a better alternative?
> 
> Do let me know if there's an example you'd rather I follow.

To elaborate I was thinking of alternate scheme with:

        compatible = "hisilicon,k3-dma-1.0", NULL
        compatible = "hisilicon,hisi-pcm-asp-dma-1.0", .data = &asp_v1_dma_data

and

        soc_data = device_get_match_data(&op->dev);
        if (!soc_data) {
                /* no data so flags are null */
                dev_warn(... "no driver data specified, assuming  no flags\n"
                k3_dma->flags = 0;
        }

-- 
~Vinod
