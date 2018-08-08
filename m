Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A3CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D038921990
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gkxxSWAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D038921990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeHIBHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:07:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38806 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIBHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:07:34 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1E3CCD;
        Thu,  9 Aug 2018 00:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533768346;
        bh=szrNatQhqPIx3pPwp0gXhWJ6IjnP4HlhTbzwE2EBZ+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkxxSWAAE3rYtx9Fv3g8qCV4wlj8NXcvPCD2hhY8AxA2BGnLNymZwLgotT2tM0A7R
         N6OGtAnIrp5+n558rRuzmnprT3K+dVscA6K/ReNUpcN2THeVFQQl9T7urA9fKk9XJq
         amQGNS9EVBx8OYY0Z4pFwTxYnhyQAqBRQf3CD2og=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, isely@pobox.com, bhumirks@gmail.com,
        colin.king@canonical.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ezequiel@collabora.com
Subject: Re: [PATCH v2 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Thu, 09 Aug 2018 01:46:30 +0300
Message-ID: <2175835.YAv5WQJWxC@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180622120419.7675-3-matwey@sai.msu.ru>
References: <20180622120419.7675-1-matwey@sai.msu.ru> <20180622120419.7675-3-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matwey,

Thank you for the patch.

On Friday, 22 June 2018 15:04:19 EEST Matwey V. Kornilov wrote:
> DMA cocherency slows the transfer down on systems without hardware
> coherent DMA.
> 
> Based on previous commit the following performance benchmarks have been
> carried out. Average memcpy() data transfer rate (rate) and handler
> completion time (time) have been measured when running video stream at
> 640x480 resolution at 10fps.
> 
> x86_64 based system (Intel Core i5-3470). This platform has hardware
> coherent DMA support and proposed change doesn't make big difference here.
> 
>  * kmalloc:            rate = (4.4 +- 1.0) GBps
>                        time = (2.4 +- 1.2) usec
>  * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
>                        time = (2.5 +- 1.0) usec
> 
> We see that the measurements agree well within error ranges in this case.
> So no performance downgrade is introduced.
> 
> armv7l based system (TI AM335x BeagleBone Black). This platform has no
> hardware coherent DMA support. DMA coherence is implemented via disabled
> page caching that slows down memcpy() due to memory controller behaviour.
> 
>  * kmalloc:            rate =  (190 +-  30) MBps
>                        time =   (50 +-  10) usec
>  * usb_alloc_coherent: rate =   (33 +-   4) MBps
>                        time = (3000 +- 400) usec
> 
> Note, that quantative difference leads (this commit leads to 5 times
> acceleration) to qualitative behavior change in this case. As it was
> stated before, the video stream can not be successfully received at AM335x
> platforms with MUSB based USB host controller due to performance issues
> [1].
> 
> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/media/usb/pwc/pwc-if.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
> index 72d2897a4b9f..339a285600d1 100644
> --- a/drivers/media/usb/pwc/pwc-if.c
> +++ b/drivers/media/usb/pwc/pwc-if.c
> @@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
>  		urb->interval = 1; // devik
>  		urb->dev = udev;
>  		urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
> -		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
> -		urb->transfer_buffer = usb_alloc_coherent(udev,
> -							  ISO_BUFFER_SIZE,
> -							  GFP_KERNEL,
> -							  &urb->transfer_dma);
> +		urb->transfer_flags = URB_ISO_ASAP;
> +		urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE, GFP_KERNEL);

ISO_BUFFER_SIZE is 970 bytes, well below a page size, so this should be fine. 
However, for other USB camera drivers, we might require larger buffers 
spanning multiple pages, and kmalloc() wouldn't be a very good choice there. I 
thus believe we should implement a helper function, possibly in the for of 
usb_alloc_noncoherent(), to allow picking the right allocation mechanism based 
on the buffer size (and possibly other parameters). Ideally the helper and the 
USB core should cooperate to avoid any overhead from DMA operations when DMA 
is coherent on the platform (on x86 and some ARM platforms).

That being said, I don't see a reason why this patch should be blocked until 
we get such a helper function, we can also implement it when needed for 
another USB webcam driver (likely uvcvideo given the recent discussions) and 
then use it in the pwc driver.

We have also determined that performances can be further improved by keeping 
mappings around and using the dma_sync_* operations at runtime. That's again 
not a reason to block this patch, as the performance improvement is already 
impressive, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

But I would still like to see the above two issues addressed. If you'd like to 
give them a go, with or without getting v2 of this series merged first, please 
do so, and I'll happily review patches.

>  		if (urb->transfer_buffer == NULL) {
>  			PWC_ERROR("Failed to allocate urb buffer %d\n", i);
>  			pwc_isoc_cleanup(pdev);
> @@ -491,10 +488,7 @@ static void pwc_iso_free(struct pwc_device *pdev)
>  		if (pdev->urbs[i]) {
>  			PWC_DEBUG_MEMORY("Freeing URB\n");
>  			if (pdev->urbs[i]->transfer_buffer) {
> -				usb_free_coherent(pdev->udev,
> -					pdev->urbs[i]->transfer_buffer_length,
> -					pdev->urbs[i]->transfer_buffer,
> -					pdev->urbs[i]->transfer_dma);
> +				kfree(pdev->urbs[i]->transfer_buffer);
>  			}
>  			usb_free_urb(pdev->urbs[i]);
>  			pdev->urbs[i] = NULL;

-- 
Regards,

Laurent Pinchart



