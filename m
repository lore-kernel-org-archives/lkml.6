Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1899621E5E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azIVVG7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1899621E5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeHIQzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:55:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44398 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHIQzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:55:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id l9-v6so4343927ywc.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRw+42Q9dgTz80oSmMRx435xPB9+1RjJdXwyT8g1epM=;
        b=azIVVG7lj7cNOClgd/lvvD3JoKyM4XWPYW7Mwp0WMonCZn0ejtU/TrjcuZ7i4lvXID
         OpKpaEfI6YN0kifIGGlR7GbxCGTnGjZBVeQRVzAvi+sFv55xxwyt9m+cG355X5l5uj0A
         Wv2aVCji/9szWGwspjbp/Nf515tnFNMGa6iKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRw+42Q9dgTz80oSmMRx435xPB9+1RjJdXwyT8g1epM=;
        b=N9VSbA2djew2C1VB6j5IoogPGbFoV4qk2XKucusXwK/7POgJWqi4I61cjnC91dxEaJ
         tGsm2hbaho00regxFcQdeYJFQ0nSLzfjvBKWO1PkjXLHPElR6HkgG5q+uuh+IWToHIo4
         6BNogkO9+fOefucjrsHH9N5M2Xpf7i/UJW+xTCTWI4bmeSrUolRkC8g4P1jVk3hbeTZ9
         EWlRG2tBICt9XFjRDhUHnd/VYoqAnlSSk7/bxiiNvwqLeVHBzOOd8jnFELAWGsXMd/O2
         2P2NxsvB39+Wl9zCme2eTDTLpoJPBdASwExEqfUcNBnp2cuk8Gm3LcDa/Se/cS3zspPH
         j5kA==
X-Gm-Message-State: AOUpUlEK9hCUbnZRaDXn5k4fKPt8HhWmO/nn6/GSjDfNGxOhKIuMPR2C
        6qEFDtr321MmW4U5jt1oKLsW1XXnxGg=
X-Google-Smtp-Source: AA+uWPx35vbqDfNMpu3m3oaVO1dOadmFRsNCa9oKY1/LdxyeRR/0zJgx68gHO9OPsDkkgqi29s4z7g==
X-Received: by 2002:a0d:e501:: with SMTP id o1-v6mr1176096ywe.409.1533825023075;
        Thu, 09 Aug 2018 07:30:23 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id x7-v6sm3649934ywd.43.2018.08.09.07.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 07:30:21 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id 139-v6so4338813ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 07:30:21 -0700 (PDT)
X-Received: by 2002:a25:2084:: with SMTP id g126-v6mr1109971ybg.405.1533825021148;
 Thu, 09 Aug 2018 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180622120419.7675-1-matwey@sai.msu.ru> <2175835.YAv5WQJWxC@avalon>
 <CAJs94EYX13oPHiD=Ck5E9cG=z3JMZ9Szs5kRaKHn9F90+uxQ8Q@mail.gmail.com> <2106168.1BipQ1ylgj@avalon>
In-Reply-To: <2106168.1BipQ1ylgj@avalon>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 9 Aug 2018 23:30:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B6nsyu5fpjonUdOsstvhTrNhpVev7MmUckQWb0kasJKQ@mail.gmail.com>
Message-ID: <CAAFQd5B6nsyu5fpjonUdOsstvhTrNhpVev7MmUckQWb0kasJKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 6:44 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Matwey,
>
> On Thursday, 9 August 2018 12:18:13 EEST Matwey V. Kornilov wrote:
> > 2018-08-09 1:46 GMT+03:00 Laurent Pinchart:
> > > On Friday, 22 June 2018 15:04:19 EEST Matwey V. Kornilov wrote:
> > >> DMA cocherency slows the transfer down on systems without hardware
> > >> coherent DMA.
> > >>
> > >> Based on previous commit the following performance benchmarks have been
> > >> carried out. Average memcpy() data transfer rate (rate) and handler
> > >> completion time (time) have been measured when running video stream at
> > >> 640x480 resolution at 10fps.
> > >>
> > >> x86_64 based system (Intel Core i5-3470). This platform has hardware
> > >> coherent DMA support and proposed change doesn't make big difference
> > >> here.
> > >>
> > >>  * kmalloc:            rate = (4.4 +- 1.0) GBps
> > >>                        time = (2.4 +- 1.2) usec
> > >>
> > >>  * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
> > >>                        time = (2.5 +- 1.0) usec
> > >>
> > >> We see that the measurements agree well within error ranges in this case.
> > >> So no performance downgrade is introduced.
> > >>
> > >> armv7l based system (TI AM335x BeagleBone Black). This platform has no
> > >> hardware coherent DMA support. DMA coherence is implemented via disabled
> > >> page caching that slows down memcpy() due to memory controller behaviour.
> > >>
> > >>  * kmalloc:            rate =  (190 +-  30) MBps
> > >>                        time =   (50 +-  10) usec
> > >>
> > >>  * usb_alloc_coherent: rate =   (33 +-   4) MBps
> > >>                        time = (3000 +- 400) usec
> > >>
> > >> Note, that quantative difference leads (this commit leads to 5 times
> > >> acceleration) to qualitative behavior change in this case. As it was
> > >> stated before, the video stream can not be successfully received at
> > >> AM335x platforms with MUSB based USB host controller due to performance
> > >> issues [1].
> > >>
> > >> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> > >>
> > >> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > >> ---
> > >>
> > >>  drivers/media/usb/pwc/pwc-if.c | 12 +++---------
> > >>  1 file changed, 3 insertions(+), 9 deletions(-)
> > >>
> > >> diff --git a/drivers/media/usb/pwc/pwc-if.c
> > >> b/drivers/media/usb/pwc/pwc-if.c index 72d2897a4b9f..339a285600d1 100644
> > >> --- a/drivers/media/usb/pwc/pwc-if.c
> > >> +++ b/drivers/media/usb/pwc/pwc-if.c
> > >> @@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
> > >>               urb->interval = 1; // devik
> > >>               urb->dev = udev;
> > >>               urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
> > >> -             urb->transfer_flags = URB_ISO_ASAP |
> > >> URB_NO_TRANSFER_DMA_MAP;
> > >> -             urb->transfer_buffer = usb_alloc_coherent(udev,
> > >> -                                                       ISO_BUFFER_SIZE,
> > >> -                                                       GFP_KERNEL,
> > >> -
> > >> &urb->transfer_dma);
> > >> +             urb->transfer_flags = URB_ISO_ASAP;
> > >> +             urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE,
> > >> GFP_KERNEL);
> > >
> > > ISO_BUFFER_SIZE is 970 bytes, well below a page size, so this should be
> > > fine. However, for other USB camera drivers, we might require larger
> > > buffers spanning multiple pages, and kmalloc() wouldn't be a very good
> > > choice there. I thus believe we should implement a helper function,
> > > possibly in the for of usb_alloc_noncoherent(), to allow picking the
> > > right allocation mechanism based on the buffer size (and possibly other
> > > parameters). Ideally the helper and the USB core should cooperate to
> > > avoid any overhead from DMA operations when DMA is coherent on the
> > > platform (on x86 and some ARM platforms).
> >
> > pwc/pwc.h:
> >
> > #define ISO_FRAMES_PER_DESC     10
> > #define ISO_MAX_FRAME_SIZE      960
> > #define ISO_BUFFER_SIZE         (ISO_FRAMES_PER_DESC * ISO_MAX_FRAME_SIZE)
> >
> > The buffer size is 9600 bytes, where did 970 come from?
>
> From mistaking * for + at 2:00am :-/
>
> That's three pages, so to reduce pressure on memory allocation it would be
> best to use an allocator that can be backed by CMA. A helper function to
> abstract this has just become more important.

Yes, that's a very valid point (which I raised earlier wrt possible
problems with replacing current usb_alloc_coherent() with kmalloc().
Not only it wouldn't be able to deal efficiently with contiguous
allocations, it would actually enforce contiguous allocations, even
for devices, which don't really need it, e.g. equipped with IOMMU.

Sounds like dma_alloc_noncoherent() (or dma_alloc_streaming())? In
theory, there is already DMA_ATTR_NON_CONSISTENT flag for
dma_alloc_attrs(), but almost no archs implement it (for sure ARM
doesn't and neither do the generic dma-mapping helpers).

Best regards,
Tomasz
