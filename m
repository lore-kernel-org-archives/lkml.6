Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B11F223FB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ht+9zOlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B11F223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeHJLVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:21:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45652 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJLVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:21:50 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59884CD;
        Fri, 10 Aug 2018 10:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533891172;
        bh=VyA66tJux7/G54N72hXqsj8bR/KB0ihQtI5efmpd6lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht+9zOlECJTZbFN3BJ1fl14YwD9C5PHhAyO5Hh1EJ7p8wKOqJK/uBjG/Lueorc/vM
         /CHenZNyRZHz0CYf5NwvUWT4dE64IA/Huab92NxTPuLOMYAgZVvK7SlcNSSLRExgd1
         uLWu7jXSwFHlSLHaQraitSxO3Xb4Ama19Hb7dYds=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: Re: [PATCH v4 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Fri, 10 Aug 2018 11:53:36 +0300
Message-ID: <2131343.ieGLTDdppT@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180809181103.15437-3-matwey@sai.msu.ru>
References: <20180809181103.15437-1-matwey@sai.msu.ru> <20180809181103.15437-3-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matwey,

Thank you for the patch.

On Thursday, 9 August 2018 21:11:03 EEST Matwey V. Kornilov wrote:
> DMA cocherency slows the transfer down on systems without hardware
> coherent DMA.
> Instead we use noncocherent DMA memory and explicit sync at data receive
> handler.
> 
> Based on previous commit the following performance benchmarks have been
> carried out. Average memcpy() data transfer rate (rate) and handler
> completion time (time) have been measured when running video stream at
> 640x480 resolution at 10fps.
> 
> x86_64 based system (Intel Core i5-3470). This platform has hardware
> coherent DMA support and proposed change doesn't make big difference here.
> 
>  * kmalloc:            rate = (2.0 +- 0.4) GBps
>                        time = (5.0 +- 3.0) usec
>  * usb_alloc_coherent: rate = (3.4 +- 1.2) GBps
>                        time = (3.5 +- 3.0) usec
> 
> We see that the measurements agree within error ranges in this case.
> So theoretically predicted performance downgrade cannot be reliably
> measured here.
> 
> armv7l based system (TI AM335x BeagleBone Black @ 300MHz). This platform
> has no hardware coherent DMA support. DMA coherence is implemented via
> disabled page caching that slows down memcpy() due to memory controller
> behaviour.
> 
>  * kmalloc:            rate =  (114 +- 5) MBps
>                        time =   (84 +- 4) usec
>  * usb_alloc_coherent: rate = (28.1 +- 0.1) MBps
>                        time =  (341 +- 2) usec
> 
> Note, that quantative difference leads (this commit leads to 4 times
> acceleration) to qualitative behavior change in this case. As it was
> stated before, the video stream cannot be successfully received at AM335x
> platforms with MUSB based USB host controller due to performance issues
> [1].
> 
> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/media/usb/pwc/pwc-if.c | 56 +++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
> index 72d2897a4b9f..e9c826be1ba6 100644
> --- a/drivers/media/usb/pwc/pwc-if.c
> +++ b/drivers/media/usb/pwc/pwc-if.c
> @@ -159,6 +159,32 @@ static const struct video_device pwc_template = {
>  /**************************************************************************
> */ /* Private functions */
> 
> +static void *pwc_alloc_urb_buffer(struct device *dev,
> +				  size_t size, dma_addr_t *dma_handle)
> +{
> +	void *buffer = kmalloc(size, GFP_KERNEL);
> +
> +	if (!buffer)
> +		return NULL;
> +
> +	*dma_handle = dma_map_single(dev, buffer, size, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, *dma_handle)) {
> +		kfree(buffer);
> +		return NULL;
> +	}
> +
> +	return buffer;
> +}
> +
> +static void pwc_free_urb_buffer(struct device *dev,
> +				size_t size,
> +				void *buffer,
> +				dma_addr_t dma_handle)
> +{
> +	dma_unmap_single(dev, dma_handle, size, DMA_FROM_DEVICE);
> +	kfree(buffer);
> +}
> +
>  static struct pwc_frame_buf *pwc_get_next_fill_buf(struct pwc_device *pdev)
> {
>  	unsigned long flags = 0;
> @@ -306,6 +332,11 @@ static void pwc_isoc_handler(struct urb *urb)
>  	/* Reset ISOC error counter. We did get here, after all. */
>  	pdev->visoc_errors = 0;
> 
> +	dma_sync_single_for_cpu(&urb->dev->dev,
> +				urb->transfer_dma,
> +				urb->transfer_buffer_length,
> +				DMA_FROM_DEVICE);
> +

Aren't you're missing a dma_sync_single_for_device() call before submitting 
the URB ? IIRC that's required for correct operation of the DMA mapping API on 
some platforms, depending on the cache architecture. The additional sync can 
affect performances, so it would be useful to re-run the perf test.

>  	/* vsync: 0 = don't copy data
>  		  1 = sync-hunt
>  		  2 = synched
> @@ -428,16 +459,15 @@ static int pwc_isoc_init(struct pwc_device *pdev)
>  		urb->dev = udev;
>  		urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
>  		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
> -		urb->transfer_buffer = usb_alloc_coherent(udev,
> -							  ISO_BUFFER_SIZE,
> -							  GFP_KERNEL,
> -							  &urb->transfer_dma);
> +		urb->transfer_buffer_length = ISO_BUFFER_SIZE;
> +		urb->transfer_buffer = pwc_alloc_urb_buffer(&udev->dev,
> +							    urb->transfer_buffer_length,
> +							    &urb->transfer_dma);
>  		if (urb->transfer_buffer == NULL) {
>  			PWC_ERROR("Failed to allocate urb buffer %d\n", i);
>  			pwc_isoc_cleanup(pdev);
>  			return -ENOMEM;
>  		}
> -		urb->transfer_buffer_length = ISO_BUFFER_SIZE;
>  		urb->complete = pwc_isoc_handler;
>  		urb->context = pdev;
>  		urb->start_frame = 0;
> @@ -488,15 +518,17 @@ static void pwc_iso_free(struct pwc_device *pdev)
> 
>  	/* Freeing ISOC buffers one by one */
>  	for (i = 0; i < MAX_ISO_BUFS; i++) {
> -		if (pdev->urbs[i]) {
> +		struct urb *urb = pdev->urbs[i];
> +
> +		if (urb) {
>  			PWC_DEBUG_MEMORY("Freeing URB\n");
> -			if (pdev->urbs[i]->transfer_buffer) {
> -				usb_free_coherent(pdev->udev,
> -					pdev->urbs[i]->transfer_buffer_length,
> -					pdev->urbs[i]->transfer_buffer,
> -					pdev->urbs[i]->transfer_dma);
> +			if (urb->transfer_buffer) {
> +				pwc_free_urb_buffer(&urb->dev->dev,
> +						    urb->transfer_buffer_length,
> +						    urb->transfer_buffer,
> +						    urb->transfer_dma);
>  			}

No need for curly braces.

> -			usb_free_urb(pdev->urbs[i]);
> +			usb_free_urb(urb);
>  			pdev->urbs[i] = NULL;
>  		}
>  	}

-- 
Regards,

Laurent Pinchart



