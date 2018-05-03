Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeECIii (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:38:38 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56614 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeECIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:38:35 -0400
Date: Thu, 3 May 2018 18:38:21 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "David S. Miller" <davem@davemloft.net>, linux-m68k@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
In-Reply-To: <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1805031801310.8@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018, Geert Uytterhoeven wrote:

> > --- a/drivers/net/ethernet/apple/macmace.c
> > +++ b/drivers/net/ethernet/apple/macmace.c
> > @@ -203,6 +203,10 @@ static int mace_probe(struct platform_device *pdev)
> >         unsigned char checksum = 0;
> >         int err;
> >
> > +       err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +       if (err)
> > +               return err;
> > +
> >         dev = alloc_etherdev(PRIV_BYTES);
> >         if (!dev)
> >                 return -ENOMEM;
> 
> Shouldn't this be handled in the platform code that instantiates the 
> device, i.e. in arch/m68k/mac/config.c:mac_platform_init()?
> 

I wondered about that too. The downside is that I'd have to convert 
platform_device_register_simple() into platform_device_register() and add 
all of the boilerplate that goes with that, for little gain.

> Cfr. commit f61e64310b75733d ("m68k: set dma and coherent masks for 
> platform FEC ethernets").
> 

Yes, I looked at that patch before I sent this one. It makes sense to set 
the mask when defining the device since some devices tend to have inherent 
limitations (but that's not really applicable here).

Moreover, it turns out that a number of platform drivers already call 
dma_set_mask_and_coherent() or dma_coerce_mask_and_coherent() or similar.

I figured that platform drivers aren't expected to be particularly 
portable. Well, I'd expect macmace and macsonic to be portable to NuBus 
PowerMacs, but AFAIK the correct mask would remain DMA_BIT_MASK(32).

So that's how I ended up with this patch. But if you are not pursuaded by 
my reasoning then just say the word and I'll take another approach.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
