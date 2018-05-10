Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966505AbeEJQEM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:04:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34520 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966464AbeEJQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:04:09 -0400
X-Google-Smtp-Source: AB8JxZrA+e65rGGDLxs0j63wptKvRUpGRfspRbbp92c2enU4xmod/mDUNxvfNcIuaD18b0SXDCWI9pZ/uQ0JbKZ2sZw=
MIME-Version: 1.0
In-Reply-To: <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
References: <CGME20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1@eucas1p1.samsung.com>
 <2484918.HKVQc3yJkt@bear> <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
 <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
 <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com> <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Thu, 10 May 2018 12:04:08 -0400
Message-ID: <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 4:31 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Frank,
>
> On 2018-05-09 19:48, Frank Mori Hess wrote:
>> On Wed, May 9, 2018 at 9:19 AM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> I understand that pl330 doesn't support real PAUSE, but as it has been
>>> implemented since 2015 the limited support is perfectly possible - just
>>> to let serial driver to read the amount of data transferred.
>>>
>>> Please note that DMA engine documentation clearly states that the best
>>> residue granularity the driver might expect is BURST granularity. There
>>> is no way to get the information about the data which still sits in the
>>> DMA engine fifo when transfer is paused/terminated. This means that
>>> the serial driver should set maxburst = 1 if it is interested in
>>> getting exact number of bytes received/sent. With maxburst = 1 there
>>> is no such thing as data loose in the DMA engine fifo.
>> That is not my understanding of the dmaengine pause requirements, but
>> of course Vinod can speak authoritatively on this.
>
> Basing on the comments in dma_residue_granularity enum documentation (see
> include/linux/dmaengine.h) there is no better granularity of residue
> reporting than BURST units. If driver needs byte accuracy, then it should
> use MAXBURST=1 and DMA_SLAVE_BUSWIDTH_1_BYTE configuration.

That's an interesting line of thought.  The 8250 serial driver clearly
assumes it can do the sequence

dma pause
read residue
dma terminate

without data loss.  It checks for the capabilities

cmd_pause
cmd_terminate
residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR

and some of the 8250 drivers like 8250_dw.c set a maxburst > 1.  If it
can't count on the pause/residue/terminate working without data loss
then it is just broken.  As is the 8250_omap.c driver.  Is the
description of dmaengine_pause in the documentation of "This pauses
activity on the DMA channel without data loss" to be interpreted as
"as long as you resume afterwards"?

>> I also don't agree
>> that data loss cannot happen for single transfers.  It only becomes
>> less likely since there are fewer bytes in the dma controller fifo and
>> they stay there for a shorter period of time.  But even so, there is
>> nothing stopping the DMAKILL from killing the transfer thread after it
>> does a single byte load but before it does the associated single byte
>> store, as they are performed by separate instructions.  As far as your
>> serial port goes, the byte has been read by the host, even though it
>> never made it to memory, so it is gone forever.  The dma-330 does have
>> a load lock which prevents some operations from interrupting a
>> load/store combination, but in my observations DMAKILL does not
>> respect the load lock.
>
> For the last 3 years no one observed any issue with the current design
> (single transfers with DMA_SLAVE_BUSWIDTH_1_BYTE). By removing this
> feature we will loose ability to use DMA in the serial drivers, what is
> mainly useful for low-power bluetooth operation (serial console is really
> negligible case).

It's not surprising it hasn't been reported.  It is a race that
requires a DMAKILL to be issued just as a byte is in-flight through
the dma controller.  The only reason a driver would pause the
un-resumeable pl330 would be because the driver either knows or
suspects no more data will be arriving and it gives up on the
transfer.  The only reason I noticed is we had a test which sent data
to a serial port, waited just long enough for the serial port rx to
timeout, then sent more data just as the pause was issuing DMAKILL.
And then the test did this a few hundred thousand times until it
noticed bad data.  Also, given the way 8250 rx timeouts work, a person
typing into a serial console wouldn't type fast enough to trigger the
bug unless the baud rate was set extremely low.  And if someone lost a
keystroke every 10^5 bytes, who would blame the dma controller?

I do admit I didn't do this test using single transfers, because our
goal was getting bursts to work.  Unfortunately, the test program
relies on some custom hardware I no longer have access to so I can't
easily re-run the test now.  However, since the DMA-330 manual
documents the DMAKILL instruction to:

"Remove all entries in the MFIFO for the DMA channel."
"Remove all entries in the read buffer queue and write buffer queue
for the DMA channel."

Relying on it to work as a safe pause for single transfers seems like
wishful thinking.  I sure didn't want to believe the DMA-330 couldn't
be safely paused, but I eventually had to resign myself to it.
