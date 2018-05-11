Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeEKCL6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:11:58 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41749 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEKCLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:11:55 -0400
X-Google-Smtp-Source: AB8JxZo+HIsdTaqaUoz0WZcvW+pC5HPvEi8DnGNvtXhg343jFUlLMikGR3c98KOhNpZT3AAuMRwAQgCTmcruYVQCtPE=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805110921020.8@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
 <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <alpine.LNX.2.21.1805091805130.72@nippy.intranet> <CAOmrzkKNPemq5RySvza+Y8_jgwg2fkUZodR794cgOxpQpfh+SA@mail.gmail.com>
 <alpine.LNX.2.21.1805110921020.8@nippy.intranet>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Fri, 11 May 2018 14:11:54 +1200
Message-ID: <CAOmrzkLL0ZNzAh7rwiDy=BkNqqXgbqfv3vkN6K8CTF8VGbT8zA@mail.gmail.com>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, May 11, 2018 at 11:55 AM, Finn Thain <fthain@telegraphics.com.au> wrote:

>> > What's worse, if you do pass a dma_mask in struct
>> > platform_device_info, you end up with this problem in
>> > platform_device_register_full():
>> >
>> >         if (pdevinfo->dma_mask) {
>> >                 /*
>> >                  * This memory isn't freed when the device is put,
>> >                  * I don't have a nice idea for that though.  Conceptually
>> >                  * dma_mask in struct device should not be a pointer.
>> >                  * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
>> >                  */
>> >                 pdev->dev.dma_mask =
>> >                         kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
>>
>> Maybe platform_device_register_full() should rather check whether
>> dev.coherent_dma_mask is set, and make dev.dma_mask point to that? This
>> is how we solved the warning issue for the Zorro bus devices...
>> (8614f1b58bd0e920a5859464a500b93152c5f8b1)
>>
>
> The claim in the comment above that a pointer is the wrong solution
> suggests that your proposal won't get far. Also, your proposal doesn't

I read the comment to be mostly concerned about not freeing memory,
and attempted to address that. I won't pretend it's the right thing to
do if the pointer will go away anyway, and I certainly won't submit a
patch. Sorry for muddling the issue.

> address the other issues I raised: a new
> platform_device_register_simple_dma() API would only have two callers, and
> the dma mask setup for device-tree probed platform devices is apparently a
> work-in-progress (which I don't want to churn up).

Yes, and that's why I would prefer your old patch handling this in the
device driver (which Geert didn't like), or in the alternative to set
the mask up when registering a device with its bus where appropriate.

I concede this won't help with pure platform devices but as we can't
test all these, we should leave the fix for platfoem devices up to
Christoph.

>
>> > > With people setting the mask to kill the WARNING splat, this may
>> > > become more common.
>> >
>> > Since the commit which introduced the WARNING, only commits f61e64310b75
>> > ("m68k: set dma and coherent masks for platform FEC ethernets") and
>> > 7bcfab202ca7 ("powerpc/macio: set a proper dma_coherent_mask") seem to be
>> > aimed at squelching that WARNING.
>> >
>> > (Am I missing any others?)
>>
>> Zorro devices :-)
>
> Right, I should add commit 55496d3fe2ac ("zorro: Set up z->dev.dma_mask
> for the DMA API") to that list.
>
>> Which begs the question: why can' you set up all Nubus bus devices' DMA
>> masks in nubus_device_register(), or nubus_add_board()?
>
> I am expecting to see the same WARNING from the nubus sonic driver but it
> hasn't happened yet, so I don't have a patch for it yet. In anycase, the
> nubus fix would be a lot like the zorro bus fix, so I don't see a problem.

That's odd. But what I meant to say is that by setting up
dma_coherent_mask in nubus_add_board(), and pointing dma_mask to that,
ypu won't need any patches to Nubus device drivers.

I must be missing something else...

Cheers,

  Michael


>
> --
