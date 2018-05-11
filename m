Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeEKWCO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 18:02:14 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:38485 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeEKWCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 18:02:12 -0400
X-Google-Smtp-Source: AB8JxZrfVg4AILpTk6KRzWTZb+apPy3LRELyyEs7bQALfvUTQ3Fol+4Mii8caMH9TINRkLeC5vGsCw==
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Finn Thain <fthain@telegraphics.com.au>
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
 <8c2c3ad5-eeb5-cf61-b9fb-c6096619e310@gmail.com>
 <alpine.LNX.2.21.1805112003250.8@nippy.intranet>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <23ed7ff8-c1d7-a069-3058-3944c7586116@gmail.com>
Date: Sat, 12 May 2018 10:02:03 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805112003250.8@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 11.05.2018 um 22:06 schrieb Finn Thain:
>> You would have to be careful not to overwrite a pdev->dev.dma_mask and 
>> pdev->dev.dma_coherent_mask that might have been set in a platform 
>> device passed via platform_device_register here. Coldfire is the only 
>> m68k platform currently using that, but there might be others in future.
>>
> 
> That Coldfire patch could be reverted if this is a better solution.

True, but there might be other uses for deviating from a platform
default (I'm thinking of Atari SCSI and floppy drivers here). But we
could chose the correct mask to set in arch_setup_pdev_archdata()
instead, as it's a platform property not a driver property in that case.

>> ... But I don't think there are smaller DMA masks used by m68k drivers 
>> that use the platform device mechanism at present. I've only looked at 
>> arch/m68k though.
> 
> So we're back at the same problem that Geert's suggestion also raised: how 
> to identify potentially affected platform devices and drivers?
> 
> Maybe we can take a leaf out of Christoph's book, and leave a noisy 
> WARNING splat in the log.
> 
> void arch_setup_pdev_archdata(struct platform_device *pdev)
> {
>         WARN_ON_ONCE(pdev->dev.coherent_dma_mask != DMA_MASK_NONE ||
>                      pdev->dev.dma_mask != NULL);

I'd suggest using WARN_ON() so we catch all uses on a particular platform.

I initially thought it necessary to warn on unset mask here, but I see
that would throw up a lot of redundant false positives.

Cheers,

	Michael
