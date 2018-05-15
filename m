Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeEONpe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbeEONpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:45:31 -0400
Date: Tue, 15 May 2018 19:15:25 +0530
From: Vinod <vkoul@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Frank Mori Hess <fmh6jj@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
Message-ID: <20180515134525.GG13271@vkoul-mobl>
References: <2484918.HKVQc3yJkt@bear>
 <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
 <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
 <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com>
 <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
 <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
 <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
 <20180515062144.GC13271@vkoul-mobl>
 <bd1e3060-df5f-692c-f022-9dd3b06b553f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1e3060-df5f-692c-f022-9dd3b06b553f@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-18, 14:24, Marek Szyprowski wrote:
> Hi Vinod,
> 
> On 2018-05-15 08:21, Vinod wrote:
> > On 11-05-18, 14:57, Marek Szyprowski wrote:
> >> On 2018-05-10 18:04, Frank Mori Hess wrote:
> >>> On Thu, May 10, 2018 at 4:31 AM, Marek Szyprowski
> >>> <m.szyprowski@samsung.com> wrote:
> >>>> On 2018-05-09 19:48, Frank Mori Hess wrote:
> >>>>> On Wed, May 9, 2018 at 9:19 AM, Marek Szyprowski
> >>>>> <m.szyprowski@samsung.com> wrote:
> >>>>>> I understand that pl330 doesn't support real PAUSE, but as it has been
> >>>>>> implemented since 2015 the limited support is perfectly possible - just
> >>>>>> to let serial driver to read the amount of data transferred.
> >>>>>>
> >>>>>> Please note that DMA engine documentation clearly states that the best
> >>>>>> residue granularity the driver might expect is BURST granularity. There
> >>>>>> is no way to get the information about the data which still sits in the
> >>>>>> DMA engine fifo when transfer is paused/terminated. This means that
> >>>>>> the serial driver should set maxburst = 1 if it is interested in
> >>>>>> getting exact number of bytes received/sent. With maxburst = 1 there
> >>>>>> is no such thing as data loose in the DMA engine fifo.
> >>>>> That is not my understanding of the dmaengine pause requirements, but
> >>>>> of course Vinod can speak authoritatively on this.
> >>>> Basing on the comments in dma_residue_granularity enum documentation (see
> >>>> include/linux/dmaengine.h) there is no better granularity of residue
> >>>> reporting than BURST units. If driver needs byte accuracy, then it should
> >>>> use MAXBURST=1 and DMA_SLAVE_BUSWIDTH_1_BYTE configuration.
> >>> That's an interesting line of thought.  The 8250 serial driver clearly
> >>> assumes it can do the sequence
> >>>
> >>> dma pause
> >>> read residue
> >>> dma terminate
> >>>
> >>> without data loss.
> >> Right. From DMA engine API perspective this is the only valid way to
> >> read the
> >> residue when you terminate the transfer.
> > Not really, API allows you to read any point of time, you may support it or not
> > is different matter. Granularity of reporting is also a different point.
> 
> I mean to read the residue in stable conditions (the incoming bytes has 
> been either
> read by dma or still sits in the uart fifo). Too bad that it is not 
> possible to read
> residue after terminating the transfer. This would remove the need for 
> this fake
> pause support.

you can read the residue before you call terminate. Terminate is basically a
cleanup job, so reading after that makes no sense, maybe you need to modify
calling sequence..

> 
> >>>     It checks for the capabilities
> >>>
> >>> cmd_pause
> >>> cmd_terminate
> >>> residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR
> >> Checking for cmd_pause is a bit too strict, because cmd_pause means 'driver
> >> supports both pause and resume', but the serial driver doesn't use resume at
> >> all. A check for residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR
> >> is on the other hand a bit too loose.
> > thats true and it was added for audio which does pause/resume. If you feel it
> > helps in serial to get pause & resume capabilities independently we can split
> > them up, feel free to send a patch
> 
> Okay, I will prepare a patch for this.
> 
> > For Pause/resume data loss is _not_ expected.
> >
> >>> and some of the 8250 drivers like 8250_dw.c set a maxburst > 1.  If it
> >>> can't count on the pause/residue/terminate working without data loss
> >>> then it is just broken.  As is the 8250_omap.c driver.  Is the
> >>> description of dmaengine_pause in the documentation of "This pauses
> >>> activity on the DMA channel without data loss" to be interpreted as
> >>> "as long as you resume afterwards"?
> >> I assume that this requirement is for both - resuming and terminating.
> > Terminate is abort, data loss may happen here.
> 
> Okay. Then it is up to the drivers to rely on this or not.

Yes...

> 
> >>>>> I also don't agree
> >>>>> that data loss cannot happen for single transfers.  It only becomes
> >>>>> less likely since there are fewer bytes in the dma controller fifo and
> >>>>> they stay there for a shorter period of time.  But even so, there is
> >>>>> nothing stopping the DMAKILL from killing the transfer thread after it
> >>>>> does a single byte load but before it does the associated single byte
> >>>>> store, as they are performed by separate instructions.  As far as your
> >>>>> serial port goes, the byte has been read by the host, even though it
> >>>>> never made it to memory, so it is gone forever.  The dma-330 does have
> >>>>> a load lock which prevents some operations from interrupting a
> >>>>> load/store combination, but in my observations DMAKILL does not
> >>>>> respect the load lock.
> >>>> For the last 3 years no one observed any issue with the current design
> >>>> (single transfers with DMA_SLAVE_BUSWIDTH_1_BYTE). By removing this
> >>>> feature we will loose ability to use DMA in the serial drivers, what is
> >>>> mainly useful for low-power bluetooth operation (serial console is really
> >>>> negligible case).
> >>> It's not surprising it hasn't been reported.  It is a race that
> >>> requires a DMAKILL to be issued just as a byte is in-flight through
> >>> the dma controller.  The only reason a driver would pause the
> >>> un-resumeable pl330 would be because the driver either knows or
> >>> suspects no more data will be arriving and it gives up on the
> >>> transfer.  The only reason I noticed is we had a test which sent data
> >>> to a serial port, waited just long enough for the serial port rx to
> >>> timeout, then sent more data just as the pause was issuing DMAKILL.
> >>> And then the test did this a few hundred thousand times until it
> >>> noticed bad data.  Also, given the way 8250 rx timeouts work, a person
> >>> typing into a serial console wouldn't type fast enough to trigger the
> >>> bug unless the baud rate was set extremely low.  And if someone lost a
> >>> keystroke every 10^5 bytes, who would blame the dma controller?
> >> Like I already said, console is not a proper use case for serial dma.
> >> The more appropriate is bluetooth and still, I'm not aware of the issue
> >> with the current code.
> > Why do you say serial is not important?
> 
> I mean that using DMA engine for uart/serial device for implementing only a
> console support is a bit pointless, because typically console doesn't 
> transfer
> much data and overhead of using DMA mode (setting up dma engine) is bigger
> than doing all the transfers in PIO mode.

Well that depends on your system and outweighing dma complexity vs perf gains
you get..

> >>> I do admit I didn't do this test using single transfers, because our
> >>> goal was getting bursts to work.  Unfortunately, the test program
> >>> relies on some custom hardware I no longer have access to so I can't
> >>> easily re-run the test now.  However, since the DMA-330 manual
> >>> documents the DMAKILL instruction to:
> >>>
> >>> "Remove all entries in the MFIFO for the DMA channel."
> >>> "Remove all entries in the read buffer queue and write buffer queue
> >>> for the DMA channel."
> >>>
> >>> Relying on it to work as a safe pause for single transfers seems like
> >>> wishful thinking.  I sure didn't want to believe the DMA-330 couldn't
> >>> be safely paused, but I eventually had to resign myself to it.
> >> Okay, so you don't have any evidence that DMA transfers done in single
> >> reads/writes is broken with the current cmd_pause implementation.
> >>
> >> This revert in fact at best disables DMA mode in the serial drivers (or
> >> in worse case, i.e. Exynos, causes current drivers to do trashed
> >> transfers due to lack of checking for the needed dma engine
> >> capabilities).
> >>
> >> Maybe instead of reverting support for it, there should be a check for
> >> BURST vs. SINGLE mode and we would keep the current implementation for
> >> SINGLE transfers?
> >>
> >> Vinod, could you comment a bit this discussion from the DMA engine
> >> maintainer perspective?
> > So I will try to summarise here:
> >
> > - Pause/resume does not expect data loss
> > - Status can be queried any point of time
> > - Granularity reporting is upto device
> > - To support a use case and device limitations it is okay to support only
> >    singles.
> 
> What about the revert this thread is about? I would really like to have some
> evidence of broken data in single transfer modes before removing 
> functionality
> that was present for years.

I do not mind dropping this, do both of you agree to that and agree to fix other
issues?

> The discussed use case (pause+terminate) is crucial for serial devices at
> least on Samsung SoCs and this revert break them.
> 
> Quick grep shows that PL330 is being used by a few other SoC families too,
> but I didn't check if any of them use it for serial device.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland

-- 
~Vinod
