Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeECIrB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:47:01 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37647 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeECIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:46:57 -0400
X-Google-Smtp-Source: AB8JxZogBebeUikNxY3/jJBWkOTpSmTEfqite5kH7OXp6aVR+nXoHVFKfMbghuDAdQdMHMRqfrkVcsJEM9AJEHVq2NE=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805031801310.8@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 May 2018 10:46:56 +0200
X-Google-Sender-Auth: 27YmNKhHOf7vtTu7MIyof1hIDiA
Message-ID: <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

CC Christoph

On Thu, May 3, 2018 at 10:38 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Thu, 3 May 2018, Geert Uytterhoeven wrote:
>> > --- a/drivers/net/ethernet/apple/macmace.c
>> > +++ b/drivers/net/ethernet/apple/macmace.c
>> > @@ -203,6 +203,10 @@ static int mace_probe(struct platform_device *pdev)
>> >         unsigned char checksum = 0;
>> >         int err;
>> >
>> > +       err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> > +       if (err)
>> > +               return err;
>> > +
>> >         dev = alloc_etherdev(PRIV_BYTES);
>> >         if (!dev)
>> >                 return -ENOMEM;
>>
>> Shouldn't this be handled in the platform code that instantiates the
>> device, i.e. in arch/m68k/mac/config.c:mac_platform_init()?
>
> I wondered about that too. The downside is that I'd have to convert
> platform_device_register_simple() into platform_device_register() and add
> all of the boilerplate that goes with that, for little gain.
>
>> Cfr. commit f61e64310b75733d ("m68k: set dma and coherent masks for
>> platform FEC ethernets").
>
> Yes, I looked at that patch before I sent this one. It makes sense to set
> the mask when defining the device since some devices tend to have inherent
> limitations (but that's not really applicable here).
>
> Moreover, it turns out that a number of platform drivers already call
> dma_set_mask_and_coherent() or dma_coerce_mask_and_coherent() or similar.
>
> I figured that platform drivers aren't expected to be particularly
> portable. Well, I'd expect macmace and macsonic to be portable to NuBus
> PowerMacs, but AFAIK the correct mask would remain DMA_BIT_MASK(32).
>
> So that's how I ended up with this patch. But if you are not pursuaded by
> my reasoning then just say the word and I'll take another approach.

Perhaps you can add a new helper (platform_device_register_simple_dma()?)
that takes the DMA mask, too?
With people setting the mask to kill the WARNING splat, this may become
more common.

struct platform_device_info already has a dma_mask field, but
platform_device_register_resndata() explicitly sets it to zero.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
