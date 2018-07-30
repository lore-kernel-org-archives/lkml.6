Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01044160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD820894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SlfbYX+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BD820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeG3RRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:17:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40828 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3RRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:17:07 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F9F11AC2;
        Mon, 30 Jul 2018 17:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532965292;
        bh=pX1GhZbZ7Qq4DDDLd+Jzbe/Dvesa36BsrGeP8XkjAN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlfbYX+VHk4cf/+zW1CN3T0nHW3Zyefjsn2BkZ9tEPfF/0PsPNrK6A5iiuygxHnEW
         y5xlZi1eOYVAx9z5GDUKWIlOSqnw0dNr/LnP8cZyIi77dJZcnZrQpuflexdMevkbbv
         +yMfIqy/tsSnxw1gemfynflGDpe1LUL3fyOzQrvI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans de Goede <hdegoede@redhat.com>, hverkuil@xs4all.nl,
        mchehab@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Mon, 30 Jul 2018 18:42:11 +0300
Message-ID: <76651769.nC7tqkMZWM@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <31826cf1b99fa2372cd4cf0b6cee8ba0ba4288f1.camel@collabora.com>
References: <20180617143625.32133-1-matwey@sai.msu.ru> <CAJs94EZjTLLCN=oy3aapMsbLEHU69iO9yq=hXdm4_G1H2UMcyQ@mail.gmail.com> <31826cf1b99fa2372cd4cf0b6cee8ba0ba4288f1.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Friday, 20 July 2018 02:36:40 EEST Ezequiel Garcia wrote:
> On Wed, 2018-07-18 at 15:10 +0300, Matwey V. Kornilov wrote:
> > 2018-07-17 23:10 GMT+03:00 Ezequiel Garcia <ezequiel@collabora.com>:
> >> On Mon, 2018-06-18 at 10:10 +0300, Matwey V. Kornilov wrote:
> >>> 2018-06-18 8:11 GMT+03:00 Ezequiel Garcia <ezequiel@collabora.com>:
> >>>> On Sun, 2018-06-17 at 17:36 +0300, Matwey V. Kornilov wrote:
> >>>>> DMA cocherency slows the transfer down on systems without hardware
> >>>>> coherent DMA.
> >>>>> 
> >>>>> Based on previous commit the following performance benchmarks have
> >>>>> been carried out. Average memcpy() data transfer rate (rate) and
> >>>>> handler completion time (time) have been measured when running
> >>>>> video stream at 640x480 resolution at 10fps.
> >>>>> 
> >>>>> x86_64 based system (Intel Core i5-3470). This platform has
> >>>>> hardware coherent DMA support and proposed change doesn't make big
> >>>>> difference here.
> >>>>> 
> >>>>>  * kmalloc:            rate = (4.4 +- 1.0) GBps
> >>>>>                        time = (2.4 +- 1.2) usec
> >>>>>  
> >>>>>  * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
> >>>>>                        time = (2.5 +- 1.0) usec
> >>>>> 
> >>>>> We see that the measurements agree well within error ranges in
> >>>>> this case. So no performance downgrade is introduced.
> >>>>> 
> >>>>> armv7l based system (TI AM335x BeagleBone Black). This platform
> >>>>> has no hardware coherent DMA support. DMA coherence is implemented
> >>>>> via disabled page caching that slows down memcpy() due to memory
> >>>>> controller behaviour.
> >>>>> 
> >>>>>  * kmalloc:            rate =  (190 +-  30) MBps
> >>>>>                        time =   (50 +-  10) usec
> >>>>>  
> >>>>>  * usb_alloc_coherent: rate =   (33 +-   4) MBps
> >>>>>                        time = (3000 +- 400) usec
> >>>>> 
> >>>>> Note, that quantative difference leads (this commit leads to 5
> >>>>> times acceleration) to qualitative behavior change in this case.
> >>>>> As it was stated before, the video stream can not be successfully
> >>>>> received at AM335x platforms with MUSB based USB host controller
> >>>>> due to performance issues [1].
> >>>>> 
> >>>>> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> >>>> 
> >>>> This is quite interesting! I have receive similar complaints
> >>>> from users wanting to use stk1160 on BBB and Raspberrys,
> >>>> without much luck on either, due to insufficient isoc bandwidth.
> >>>> 
> >>>> I'm guessing other ARM platforms could be suffering
> >>>> from the same issue.
> >>>> 
> >>>> Note that stk1160 and uvcvideo drivers use kmalloc on platforms
> >>>> where DMA_NONCOHERENT is defined, but this is not the case
> >>>> on ARM platforms.
> >>> 
> >>> There are some ARMv7 platforms that have coherent DMA (for instance
> >>> Broadcome Horthstar Plus series), but the most of them don't have. It
> >>> is defined in device tree file, and there is no way to recover this
> >>> information at runtime in USB perepherial driver.
> >>> 
> >>>> So, what is the benefit of using consistent
> >>>> for these URBs, as opposed to streaming?
> >>> 
> >>> I don't know, I think there is no real benefit and all we see is a
> >>> consequence of copy-pasta when some webcam drivers were inspired by
> >>> others and development priparily was going at x86 platforms.
> >> 
> >> You are probably right about the copy-pasta.
> >> 
> >>> It would be great if somebody corrected me here. DMA Coherence is quite
> >>> strong property and I cannot figure out how can it help when streaming
> >>> video. The CPU host always reads from the buffer and never writes to.
> >>> Hardware perepherial always writes to and never reads from. Moreover,
> >>> buffer access is mutually exclusive and separated in time by Interrupt
> >>> fireing and URB starting (when we reuse existing URB for new request).
> >>> Only single one memory barrier is really required here.
> >> 
> >> Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
> >> create DMA mappings and use the streaming API. Which makes more
> >> sense in hardware without hardware coherency.
> >> 
> >> The only thing that bothers me with this patch is that it's not
> >> really something specific to this driver. If this fix is valid
> >> for pwc, then it's valid for all the drivers allocating coherent
> >> memory.
> >> 
> >> And also, this path won't prevent further copy-paste spread
> >> of the coherent allocation.
> >> 
> >> Is there any chance we can introduce a helper to allocate
> >> isoc URBs, and then change all drivers to use it? No need
> >> to do all of them now, but it would be good to at least have
> >> a plan for it.
> > 
> > Well, basically I am agree with you.
> > However, I don't have all possible hardware to test, so I can't fix
> > all possible drivers.
> 
> Sure. And keep in mind this is more about the USB host controller,
> than about this specific driver. So it's the controller what we
> would have to test!
> 
> > Also I can not figure out how could the helper looked like. What do
> > you think about usb_alloc() (c.f. usb_alloc_coherent()) ?
> 
> I do not know that either. But it's something we can think about.
> 
> Meanwhile, it would be a shame to loose or stall this excellent
> effort (which is effectively enabling a cameras on a bunch of devices).
> 
> How about you introduce a driver parameter (or device attribute),
> to avoid changing the behavior for USB host controllers we don't know
> about?
> 
> Something like 'alloc_coherent_urbs=y/n'. Perhaps set that
> to 'yes' by default in x86, and 'no' by default in the rest?
> 
> We can think about a generic solution later.

A generic solution would be much better though. Could we still try to achieve 
one, and only go for a hack as a last resort ? With an analysis of code flows 
and performances on x86 vs. ARM I don't think it would be too difficult to 
decide what to do.

-- 
Regards,

Laurent Pinchart



