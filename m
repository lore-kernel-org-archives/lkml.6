Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E07C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A102217C5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T2MGZJt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A102217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbeHIMIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:08:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58648 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbeHIMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:08:15 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AADFCD;
        Thu,  9 Aug 2018 11:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533807850;
        bh=Z6AQ+POHQxEtm0YlNUmxej3XSuN+PdoyeUqLUNopQ6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2MGZJt2HIhOd4zhzwUXvVTmgby9tw1Xm/Z9FKt4iRomFp8Gt7vu2Vuy10CEyluDT
         7YXQ9TcJ3K3KCFpM7q9Zvg6g0X3No+7GjhF7o+bd2PWMqHZKSjpwIL3HuMm08Tu/7y
         O4e2hcjW+v97o2jIkwG8CQcA01WRgvzV+2/IrS+I=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v2 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Thu, 09 Aug 2018 12:44:54 +0300
Message-ID: <2106168.1BipQ1ylgj@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAJs94EYX13oPHiD=Ck5E9cG=z3JMZ9Szs5kRaKHn9F90+uxQ8Q@mail.gmail.com>
References: <20180622120419.7675-1-matwey@sai.msu.ru> <2175835.YAv5WQJWxC@avalon> <CAJs94EYX13oPHiD=Ck5E9cG=z3JMZ9Szs5kRaKHn9F90+uxQ8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matwey,

On Thursday, 9 August 2018 12:18:13 EEST Matwey V. Kornilov wrote:
> 2018-08-09 1:46 GMT+03:00 Laurent Pinchart:
> > On Friday, 22 June 2018 15:04:19 EEST Matwey V. Kornilov wrote:
> >> DMA cocherency slows the transfer down on systems without hardware
> >> coherent DMA.
> >> 
> >> Based on previous commit the following performance benchmarks have been
> >> carried out. Average memcpy() data transfer rate (rate) and handler
> >> completion time (time) have been measured when running video stream at
> >> 640x480 resolution at 10fps.
> >> 
> >> x86_64 based system (Intel Core i5-3470). This platform has hardware
> >> coherent DMA support and proposed change doesn't make big difference
> >> here.
> >> 
> >>  * kmalloc:            rate = (4.4 +- 1.0) GBps
> >>                        time = (2.4 +- 1.2) usec
> >>  
> >>  * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
> >>                        time = (2.5 +- 1.0) usec
> >> 
> >> We see that the measurements agree well within error ranges in this case.
> >> So no performance downgrade is introduced.
> >> 
> >> armv7l based system (TI AM335x BeagleBone Black). This platform has no
> >> hardware coherent DMA support. DMA coherence is implemented via disabled
> >> page caching that slows down memcpy() due to memory controller behaviour.
> >> 
> >>  * kmalloc:            rate =  (190 +-  30) MBps
> >>                        time =   (50 +-  10) usec
> >>  
> >>  * usb_alloc_coherent: rate =   (33 +-   4) MBps
> >>                        time = (3000 +- 400) usec
> >> 
> >> Note, that quantative difference leads (this commit leads to 5 times
> >> acceleration) to qualitative behavior change in this case. As it was
> >> stated before, the video stream can not be successfully received at
> >> AM335x platforms with MUSB based USB host controller due to performance
> >> issues [1].
> >> 
> >> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> >> 
> >> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> >> ---
> >> 
> >>  drivers/media/usb/pwc/pwc-if.c | 12 +++---------
> >>  1 file changed, 3 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/drivers/media/usb/pwc/pwc-if.c
> >> b/drivers/media/usb/pwc/pwc-if.c index 72d2897a4b9f..339a285600d1 100644
> >> --- a/drivers/media/usb/pwc/pwc-if.c
> >> +++ b/drivers/media/usb/pwc/pwc-if.c
> >> @@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
> >>               urb->interval = 1; // devik
> >>               urb->dev = udev;
> >>               urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
> >> -             urb->transfer_flags = URB_ISO_ASAP |
> >> URB_NO_TRANSFER_DMA_MAP;
> >> -             urb->transfer_buffer = usb_alloc_coherent(udev,
> >> -                                                       ISO_BUFFER_SIZE,
> >> -                                                       GFP_KERNEL,
> >> -                                                      
> >> &urb->transfer_dma);
> >> +             urb->transfer_flags = URB_ISO_ASAP;
> >> +             urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE,
> >> GFP_KERNEL);
> > 
> > ISO_BUFFER_SIZE is 970 bytes, well below a page size, so this should be
> > fine. However, for other USB camera drivers, we might require larger
> > buffers spanning multiple pages, and kmalloc() wouldn't be a very good
> > choice there. I thus believe we should implement a helper function,
> > possibly in the for of usb_alloc_noncoherent(), to allow picking the
> > right allocation mechanism based on the buffer size (and possibly other
> > parameters). Ideally the helper and the USB core should cooperate to
> > avoid any overhead from DMA operations when DMA is coherent on the
> > platform (on x86 and some ARM platforms).
> 
> pwc/pwc.h:
> 
> #define ISO_FRAMES_PER_DESC     10
> #define ISO_MAX_FRAME_SIZE      960
> #define ISO_BUFFER_SIZE         (ISO_FRAMES_PER_DESC * ISO_MAX_FRAME_SIZE)
> 
> The buffer size is 9600 bytes, where did 970 come from?

From mistaking * for + at 2:00am :-/

That's three pages, so to reduce pressure on memory allocation it would be 
best to use an allocator that can be backed by CMA. A helper function to 
abstract this has just become more important.

> > That being said, I don't see a reason why this patch should be blocked
> > until we get such a helper function, we can also implement it when needed
> > for another USB webcam driver (likely uvcvideo given the recent
> > discussions) and then use it in the pwc driver.
> > 
> > We have also determined that performances can be further improved by
> > keeping mappings around and using the dma_sync_* operations at runtime.
> > That's again not a reason to block this patch, as the performance
> > improvement is already impressive, so
> 
> I've incorporated this changes in v3, I'll send it shortly.
> 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > But I would still like to see the above two issues addressed. If you'd
> > like to give them a go, with or without getting v2 of this series merged
> > first, please do so, and I'll happily review patches.
> > 
> >>               if (urb->transfer_buffer == NULL) {
> >>                       PWC_ERROR("Failed to allocate urb buffer %d\n", i);
> >>                       pwc_isoc_cleanup(pdev);
> >> @@ -491,10 +488,7 @@ static void pwc_iso_free(struct pwc_device *pdev)
> >>               if (pdev->urbs[i]) {
> >>                       PWC_DEBUG_MEMORY("Freeing URB\n");
> >>                       if (pdev->urbs[i]->transfer_buffer) {
> >> -                             usb_free_coherent(pdev->udev,
> >> -                                  pdev->urbs[i]->transfer_buffer_length,
> >> -                                  pdev->urbs[i]->transfer_buffer,
> >> -                                  pdev->urbs[i]->transfer_dma);
> >> +                             kfree(pdev->urbs[i]->transfer_buffer);
> >>                       }
> >>                       usb_free_urb(pdev->urbs[i]);
> >>                       pdev->urbs[i] = NULL;

-- 
Regards,

Laurent Pinchart



