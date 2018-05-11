Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeEKESL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:18:11 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:41049 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKESJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:18:09 -0400
X-Google-Smtp-Source: AB8JxZrEm++PAN1DET1rVJ4mThCwU7EPY2Sxa41/GrKWSJXTTTrUfnKHtkUR3SsgOGmEDMsS5WMhoA==
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <0b13a08d-ba2d-b9dc-4fd9-1f6bad5cd1ee@gmail.com>
Date: Fri, 11 May 2018 16:18:01 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805111221180.8@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 11.05.2018 um 15:28 schrieb Finn Thain:
> On Fri, 11 May 2018, Michael Schmitz wrote:
> 
>>>> Which begs the question: why can' you set up all Nubus bus devices' 
>>>> DMA masks in nubus_device_register(), or nubus_add_board()?
>>>
>>> I am expecting to see the same WARNING from the nubus sonic driver but 
>>> it hasn't happened yet, so I don't have a patch for it yet. In 
>>> anycase, the nubus fix would be a lot like the zorro bus fix, so I 
>>> don't see a problem.
>>
>> That's odd. But what I meant to say is that by setting up 
>> dma_coherent_mask in nubus_add_board(), and pointing dma_mask to that, 
>> ypu won't need any patches to Nubus device drivers.
> 
> Right. I think I've already acknowledged that. But it's off-topic, because 
> the patches under review are for platform drivers. Those patches fix an 
> actual bug that I've observed. Whereas, the nubus driver dma mask issue 
> that you raised is purely theoretical at this stage.

I had lost track of the fact that macsonic can be probed as either Nubus
or platform device. Sorry for the noise.

I'm afraid using platform_device_register() (which you already use for
the SCC devices) is the only option handling this on a per-device basis
without touching platform core code, while at the same time keeping the
DMA mask setup out of device drivers (I can see Geert's point there -
device driver code might be shared across implementations of the device
on platforms with different DMA mask requirements,, something the driver
can't be expected to know about).

Cheers,

	Michael
