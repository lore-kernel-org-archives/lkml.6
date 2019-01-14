Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F065AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA752070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E1AjFzik";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B5HoLqBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfANRNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:13:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:13:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6288960851; Mon, 14 Jan 2019 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547486012;
        bh=aRCnqLJEuNYnNcQ1Ed6XhLUR2YS6+c7qQb41LIDJdNg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=E1AjFzikG7V5pwYoB1f/vwhPl9YXZ6bzONjaQK1uoTKszg5v1T55YJa7Mxya+CQ81
         9U02BneeYDdJdUmV1fOJzrvdymSQg1nBEf5lLMFHNpkU5BH7LaVCZ/Kun8vY7IY7Yz
         EEQbwtfUOjWQuaPHJjW4G8eQqEiT0jVRy9iSbfj4=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E51D5602FC;
        Mon, 14 Jan 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547486011;
        bh=aRCnqLJEuNYnNcQ1Ed6XhLUR2YS6+c7qQb41LIDJdNg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=B5HoLqBl1pz5CsbymXctOK+QzpQPUDxTSab+/j6WJCalAY/sXrdOfMb+lW3O87c4F
         519KM1iTYoeRpftEWFQGG+kZK7n6LPmdxv8bqwO50VoL3Pcn4iiAbVumDPHNKQeVYv
         E0CRhDHY0AGCQD8z5Hp9CfwWdmjCBq19j16PjlQ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E51D5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 14 Jan 2019 09:13:30 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
In-Reply-To: <20190111180523.27862-14-afd@ti.com>
Message-ID: <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
References: <20190111180523.27862-1-afd@ti.com> <20190111180523.27862-14-afd@ti.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Andrew F. Davis wrote:

> Buffers may not be mapped from the CPU so skip cache maintenance here.
> Accesses from the CPU to a cached heap should be bracketed with
> {begin,end}_cpu_access calls so maintenance should not be needed anyway.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/staging/android/ion/ion.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 14e48f6eb734..09cb5a8e2b09 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>  
>  	table = a->table;
>  
> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> -			direction))
> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))

Unfortunately I don't think you can do this for a couple reasons.
You can't rely on {begin,end}_cpu_access calls to do cache maintenance.
If the calls to {begin,end}_cpu_access were made before the call to 
dma_buf_attach then there won't have been a device attached so the calls 
to {begin,end}_cpu_access won't have done any cache maintenance.

Also ION no longer provides DMA ready memory, so if you are not doing CPU 
access then there is no requirement (that I am aware of) for you to call 
{begin,end}_cpu_access before passing the buffer to the device and if this 
buffer is cached and your device is not IO-coherent then the cache maintenance
in ion_map_dma_buf and ion_unmap_dma_buf is required.

>  		return ERR_PTR(-ENOMEM);
>  
>  	return table;
> @@ -272,7 +272,8 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
>  			      struct sg_table *table,
>  			      enum dma_data_direction direction)
>  {
> -	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
> +			   direction, DMA_ATTR_SKIP_CPU_SYNC);
>  }
>  
>  static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> -- 
> 2.19.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
