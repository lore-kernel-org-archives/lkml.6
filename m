Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeEKJai (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:30:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39522 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbeEKJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:30:35 -0400
X-Google-Smtp-Source: AB8JxZrQjnc7geHbbvKzfhMJ/Zt+6vEb0Yz6zhDd8+WoGPSGt5oCVctuFLmHVhsz/jUCAob0qj0DZQ==
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
 <alpine.LNX.2.21.1805031801310.8@nippy.intranet>
 <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <alpine.LNX.2.21.1805091805130.72@nippy.intranet>
 <CAOmrzkKNPemq5RySvza+Y8_jgwg2fkUZodR794cgOxpQpfh+SA@mail.gmail.com>
 <alpine.LNX.2.21.1805110921020.8@nippy.intranet>
 <CAOmrzkLL0ZNzAh7rwiDy=BkNqqXgbqfv3vkN6K8CTF8VGbT8zA@mail.gmail.com>
 <alpine.LNX.2.21.1805111221180.8@nippy.intranet>
 <0b13a08d-ba2d-b9dc-4fd9-1f6bad5cd1ee@gmail.com>
 <alpine.LNX.2.21.1805111451220.8@nippy.intranet>
Cc: "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <8c2c3ad5-eeb5-cf61-b9fb-c6096619e310@gmail.com>
Date: Fri, 11 May 2018 21:30:26 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805111451220.8@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 11.05.2018 um 17:28 schrieb Finn Thain:
> On Fri, 11 May 2018, Michael Schmitz wrote:
> 
>>
>> I'm afraid using platform_device_register() (which you already use for 
>> the SCC devices) is the only option handling this on a per-device basis 
>> without touching platform core code, while at the same time keeping the 
>> DMA mask setup out of device drivers
> 
> I don't think that will fly. If you call platform_device_register() and 
> follow that with a dma mask assignment, you could race with the bus 
> matching and driver probe, and we are back to the same WARNING message.

I wasn't proposing to follow platform_device_register() with the mask
assignment, but rather to use the same strategy from the Coldfire FEC
patch (f61e64310b75): set pdev.dev.coherent_dma_mask and
pdev.dev.dma_mask _before_ calling platform_device_register().

> If you want to use platform_device_register(), you'd have to implement 
> arch_setup_pdev_archdata() and use that to set up the dma mask.

If you want to avoid the overhead of defining the macmace platform
device and using platform_device_register() ... seeing as you would not
be defining just the DMA mask and nothing else, that's probably the
least effort for the MACE and SONIC drivers.

>> (I can see Geert's point there - device driver code might be shared 
>> across implementations of the device on platforms with different DMA 
>> mask requirements,, something the driver can't be expected to know 
>> about).
> 
> As I said, these drivers might be expected to be portable between Macs and 
> early PowerMacs, but the same dma mask would apply AFAIK.
> 
> If a platform driver isn't expected to be portable, I think either method 
> is reasonable: arch_setup_pdev_archdata() or the method in the patch.
> 
> Anyway, there is this in arch/powerpc/kernel/setup-common.c:
> 
> void arch_setup_pdev_archdata(struct platform_device *pdev)
> {
>         pdev->archdata.dma_mask = DMA_BIT_MASK(32);
>         pdev->dev.dma_mask = &pdev->archdata.dma_mask;
> 	...

You would have to be careful not to overwrite a pdev->dev.dma_mask and
pdev->dev.dma_coherent_mask that might have been set in a platform
device passed via platform_device_register here. Coldfire is the only
m68k platform currently using that, but there might be others in future.

> I'm inclined to propose something similar for m68k. That should fix the 
> problem, since arch_setup_pdev_archdata() is already in the call chain:
> 
> 	platform_device_register_simple()
> 		platform_device_register_resndata()
> 			platform_device_register_full()
> 				platform_device_alloc()
> 					arch_setup_pdev_archdata()
> 
> Thoughts? Will this have nasty side effects for m68k platforms that use 
> smaller dma masks?

These can still set a smaller mask in pdev->dev directly and use
platform_device_register() instead. But I don't think there are smaller
DMA masks used by m68k drivers that use the platform device mechanism at
present. I've only looked at arch/m68k though.

Cheers,

	Michael
