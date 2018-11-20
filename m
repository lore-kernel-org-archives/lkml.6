Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D6C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2BC206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cN4WgUly";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jRzR3b6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2BC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeKUCLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:11:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUCLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:11:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EE526024C; Tue, 20 Nov 2018 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542728513;
        bh=AW7+RojjFqcbeapuZfX7OCd2vxniTvZkHpv/RkIUt+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cN4WgUlydhOt7ODzYUtrHEvBNIPaulT9Kf+QhTay9DA05XZlFKy5vY8qj/sen4T5i
         jocFsCjHf8DyWDZ6+9t2kNypd8xUeZLONmHGAMw2LOMmwzK9adCLfpcrYzbXd7Il9d
         H+7q7lOOhcdUvrb3KAbTC2JOjPnufr5g8DAcYB1I=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 866136020B;
        Tue, 20 Nov 2018 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542728511;
        bh=AW7+RojjFqcbeapuZfX7OCd2vxniTvZkHpv/RkIUt+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRzR3b6aKjWgcDNa7K5izhbVYBWwJIdOyoM17/DltSxauXeECLC9Wfm6bLNOIdtRA
         PxpvcVlBkFXS5JqHOk+3Fzj8MlvEc/k6yefJnpRmTPG6jIPRjsipNbNMhOM6jXXo2A
         3/hRoeTDsFPci1UHwHrsyAT93LHH/j0B6Lyl7cgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 866136020B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 20 Nov 2018 08:41:48 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     robdclark@gmail.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tfiga@chromium.org
Subject: Re: [PATCH 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181120154148.GC31792@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        robdclark@gmail.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tfiga@chromium.org
References: <20181120095437.29820-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120095437.29820-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:24:37PM +0530, Vivek Gautam wrote:
> dma_map_sg() expects a DMA domain. However, the drm devices
> have been traditionally using unmanaged iommu domain which
> is non-dma type. Using dma mapping APIs with that domain is bad.
> 
> Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> to do the cache maintenance.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Tested on an MTP sdm845:
> https://github.com/vivekgautam1/linux/tree/v4.19/sdm845-mtp-display-working
> 
>  drivers/gpu/drm/msm/msm_gem.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 00c795ced02c..d7a7af610803 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -81,6 +81,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
>  		struct drm_device *dev = obj->dev;
>  		struct page **p;
>  		int npages = obj->size >> PAGE_SHIFT;
> +		struct scatterlist *s;
> +		int i;
>  
>  		if (use_pages(obj))
>  			p = drm_gem_get_pages(obj);
> @@ -107,9 +109,19 @@ static struct page **get_pages(struct drm_gem_object *obj)
>  		/* For non-cached buffers, ensure the new pages are clean
>  		 * because display controller, GPU, etc. are not coherent:
>  		 */
> -		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -			dma_map_sg(dev->dev, msm_obj->sgt->sgl,
> -					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +		if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED)) {
> +			/*
> +			 * Fake up the SG table so that dma_sync_sg_*()
> +			 * can be used to flush the pages associated with it.
> +			 */

We aren't really faking.  The table is real, we are just slightly abusing the
sg_dma_address() which makes this comment a bit misleading. Instead I would
probably say something like:

/* dma_sync_sg_* flushes pages using sg_dma_address() so point it at the
 * physical page for the right behavior */

Or something like that.

> +			for_each_sg(msm_obj->sgt->sgl, s,
> +				    msm_obj->sgt->nents, i)
> +				sg_dma_address(s) = sg_phys(s);
> +

I'm wondering - wouldn't we want to do this association for cached buffers to so
we could sync them correctly in cpu_prep and cpu_fini?  Maybe it wouldn't hurt
to put this association in the main path (obviously the sync should stay inside
the conditional for uncached buffers).

> +			dma_sync_sg_for_device(dev->dev, msm_obj->sgt->sgl,
> +					       msm_obj->sgt->nents,
> +					       DMA_TO_DEVICE);
> +		}
>  	}
>  
>  	return msm_obj->pages;
> @@ -137,10 +149,11 @@ static void put_pages(struct drm_gem_object *obj)
>  			 * pages are clean because display controller,
>  			 * GPU, etc. are not coherent:
>  			 */
> -			if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -				dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
> -					     msm_obj->sgt->nents,
> -					     DMA_BIDIRECTIONAL);
> +			if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
> +				dma_sync_sg_for_cpu(obj->dev->dev,
> +						    msm_obj->sgt->sgl,
> +						    msm_obj->sgt->nents,
> +						    DMA_FROM_DEVICE);
>  
>  			sg_free_table(msm_obj->sgt);
>  			kfree(msm_obj->sgt);

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
