Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeEJU1E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:27:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33901 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEJU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:27:02 -0400
X-Google-Smtp-Source: AB8JxZo09nqmGZj2cY05Su7UIT+F0+n+6xiRg0jRTqWqCqxSwO5yniJ6xdeKH9LaHmergi95dd+gMOyrxffAcqXhcd4=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805091805130.72@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
 <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <alpine.LNX.2.21.1805091805130.72@nippy.intranet>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Fri, 11 May 2018 08:27:01 +1200
Message-ID: <CAOmrzkKNPemq5RySvza+Y8_jgwg2fkUZodR794cgOxpQpfh+SA@mail.gmail.com>
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

On Thu, May 10, 2018 at 1:25 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Thu, 3 May 2018, Geert Uytterhoeven wrote:
>
>>
>> Perhaps you can add a new helper
>> (platform_device_register_simple_dma()?) that takes the DMA mask, too?
[...]
> To actually hoist the dma mask setup out of existing platform drivers
> would have implications for every device that matches with those drivers.
>
> That's a bit risky since I can't test those devices -- that's assuming I
> could identify them all; sometimes platform device matching is not well
> defined at build time (see loongson_sysconf.ecname).
>
> So far, it looks like macmace and macsonic would be the only callers of
> this new API call.
>
> What's worse, if you do pass a dma_mask in struct platform_device_info,
> you end up with this problem in platform_device_register_full():
>
>         if (pdevinfo->dma_mask) {
>                 /*
>                  * This memory isn't freed when the device is put,
>                  * I don't have a nice idea for that though.  Conceptually
>                  * dma_mask in struct device should not be a pointer.
>                  * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
>                  */
>                 pdev->dev.dma_mask =
>                         kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);

Maybe platform_device_register_full() should rather check whether
dev.coherent_dma_mask is set, and make dev.dma_mask point to that?
This is how we solved the warning issue for the Zorro bus devices...
(8614f1b58bd0e920a5859464a500b93152c5f8b1)

Not sure what the ramifications of that change would be in the general
case (i.e. platforms where coherent and non-coherent DMA operations
must use different masks). I'd hope all those platforms explicitly set
up their DMA masks anyway.

Your other comment regarding the default used by dma_get_mask() is spot on.

> Most of the platform drivers that call dma_coerce_mask_and_coherent() are
> using pdev->of_match_table, not platform_device_register_simple(). Many of
> them have a comment like this:
>
>         /*
>          * Right now device-tree probed devices don't get dma_mask set.
>          * Since shared usb code relies on it, set it here for now.
>          * Once we have dma capability bindings this can go away.
>          */
>
>> With people setting the mask to kill the WARNING splat, this may become
>> more common.
>
> Since the commit which introduced the WARNING, only commits f61e64310b75
> ("m68k: set dma and coherent masks for platform FEC ethernets") and
> 7bcfab202ca7 ("powerpc/macio: set a proper dma_coherent_mask") seem to be
> aimed at squelching that WARNING.
>
> (Am I missing any others?)

Zorro devices :-) Which begs the question: why can' you set up all
Nubus bus devices' DMA masks in nubus_device_register(), or
nubus_add_board()?

> So far, this is not looking like a common problem, and I'm having trouble
> finding some way to improve on my original patches.

Putting this in the core platform device code might have too many
unintended side effects. Platform specific bus drivers or device
drivers might be a safer place to put this. Makes it harder for
Christoph to find all instances of such workarounds though.

Cheers,

  Michael
