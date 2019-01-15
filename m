Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC62C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389EB20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AwVXDG+e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iXOr3znJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfAORpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:45:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfAORpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:45:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA309607DD; Tue, 15 Jan 2019 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547574319;
        bh=6LzK1x8PswcmWcdv1mu0II9Jq7KgJdXCBagLiBl6yok=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AwVXDG+ebIj5wglg62UBmTANXNfEYpZaTb2B0yi7FwgCnWKklPqej1YBbxmM0fqJR
         01sesgWzhY/bKgPo1aRhRFpQGNidk/VF8gU//jsIquwz5ZVE6ksW8Wbcb3R54uYaVw
         mqCdiQrhzbtXyUP/5Z4+pnqXM9Kx0Xke710fvYIY=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05B9A6024C;
        Tue, 15 Jan 2019 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547574318;
        bh=6LzK1x8PswcmWcdv1mu0II9Jq7KgJdXCBagLiBl6yok=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iXOr3znJwCExkWmjaB/69y8I6T3G3gfF2+iaZ4lfLeSp5TFdy+g4tfH8q6HzjDCBZ
         pdaHGvKaUyUKGfR2AiI7HhTgLQ/FzJm3/x5MDG/+ZiRCB+YihfMSNa4SeLrESYNGFq
         Z5Rm7Tp8l93MvtazXRpNVCKTn76ajyzOdc4ZDMeU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05B9A6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 15 Jan 2019 09:45:17 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
In-Reply-To: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
Message-ID: <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
References: <20190111180523.27862-1-afd@ti.com> <20190111180523.27862-14-afd@ti.com> <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com> <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019, Andrew F. Davis wrote:

> On 1/14/19 11:13 AM, Liam Mark wrote:
> > On Fri, 11 Jan 2019, Andrew F. Davis wrote:
> > 
> >> Buffers may not be mapped from the CPU so skip cache maintenance here.
> >> Accesses from the CPU to a cached heap should be bracketed with
> >> {begin,end}_cpu_access calls so maintenance should not be needed anyway.
> >>
> >> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >> ---
> >>  drivers/staging/android/ion/ion.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> >> index 14e48f6eb734..09cb5a8e2b09 100644
> >> --- a/drivers/staging/android/ion/ion.c
> >> +++ b/drivers/staging/android/ion/ion.c
> >> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
> >>  
> >>  	table = a->table;
> >>  
> >> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> >> -			direction))
> >> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> >> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))
> > 
> > Unfortunately I don't think you can do this for a couple reasons.
> > You can't rely on {begin,end}_cpu_access calls to do cache maintenance.
> > If the calls to {begin,end}_cpu_access were made before the call to 
> > dma_buf_attach then there won't have been a device attached so the calls 
> > to {begin,end}_cpu_access won't have done any cache maintenance.
> > 
> 
> That should be okay though, if you have no attachments (or all
> attachments are IO-coherent) then there is no need for cache
> maintenance. Unless you mean a sequence where a non-io-coherent device
> is attached later after data has already been written. Does that
> sequence need supporting? 

Yes, but also I think there are cases where CPU access can happen before 
in Android, but I will focus on later for now.

> DMA-BUF doesn't have to allocate the backing
> memory until map_dma_buf() time, and that should only happen after all
> the devices have attached so it can know where to put the buffer. So we
> shouldn't expect any CPU access to buffers before all the devices are
> attached and mapped, right?
> 

Here is an example where CPU access can happen later in Android.

Camera device records video -> software post processing -> video device 
(who does compression of raw data) and writes to a file

In this example assume the buffer is cached and the devices are not 
IO-coherent (quite common).

ION buffer is allocated.

//Camera device records video
dma_buf_attach
dma_map_attachment (buffer needs to be cleaned)
[camera device writes to buffer]
dma_buf_unmap_attachment (buffer needs to be invalidated)
dma_buf_detach  (device cannot stay attached because it is being sent down 
the pipeline and Camera doesn't know the end of the use case)

//buffer is send down the pipeline

// Usersapce software post processing occurs
mmap buffer
DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CMO since no 
devices attached to buffer
[CPU reads/writes to the buffer]
DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO since no 
devices attached to buffer
munmap buffer

//buffer is send down the pipeline
// Buffer is send to video device (who does compression of raw data) and 
writes to a file
dma_buf_attach
dma_map_attachment (buffer needs to be cleaned)
[video device writes to buffer]
dma_buf_unmap_attachment 
dma_buf_detach  (device cannot stay attached because it is being sent down 
the pipeline and Video doesn't know the end of the use case)



> > Also ION no longer provides DMA ready memory, so if you are not doing CPU 
> > access then there is no requirement (that I am aware of) for you to call 
> > {begin,end}_cpu_access before passing the buffer to the device and if this 
> > buffer is cached and your device is not IO-coherent then the cache maintenance
> > in ion_map_dma_buf and ion_unmap_dma_buf is required.
> > 
> 
> If I am not doing any CPU access then why do I need CPU cache
> maintenance on the buffer?
> 

Because ION no longer provides DMA ready memory.
Take the above example.

ION allocates memory from buddy allocator and requests zeroing.
Zeros are written to the cache.

You pass the buffer to the camera device which is not IO-coherent.
The camera devices writes directly to the buffer in DDR.
Since you didn't clean the buffer a dirty cache line (one of the zeros) is 
evicted from the cache, this zero overwrites data the camera device has 
written which corrupts your data.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
