Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E190C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C313421570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C313421570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeHTOSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:18:31 -0400
Received: from foss.arm.com ([217.140.101.70]:36160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTOSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:18:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FA980D;
        Mon, 20 Aug 2018 04:03:21 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF49D3F2EA;
        Mon, 20 Aug 2018 04:03:20 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 350BD680882; Mon, 20 Aug 2018 12:03:19 +0100 (BST)
Date:   Mon, 20 Aug 2018 12:03:19 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     brian.starkey@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH] drm: Use horizontal and vertical chroma subsampling
 factor while calculating offsets in the physical address of framebuffer
Message-ID: <20180820110319.GV907@e110455-lin.cambridge.arm.com>
References: <1534527184-24552-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534527184-24552-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 06:33:04PM +0100, Ayan Kumar Halder wrote:
> For multi-planar formats, while calculating offsets in planes with index greater than 0
> (ie second plane, third plane, etc), one needs to divide (src_x * cpp) with horizontal
> chroma subsampling factor and (src_y * pitch) with vertical chroma subsampling factor.
> 
> The reason being that the planes contain subsampled (ie reduced) data (by a factor of 2) and thus the

drop the extraneous "the" at the end of the line.

> while calculating the byte position coresponding to the x and y co-ordinates, one needs to be

and drop the extraneous "be" at the end of this line.

> divide it with the sampling factor.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Otherwise, it looks good to me!

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index b127061..47e0e2f 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -86,14 +86,21 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
>  {
>  	struct drm_gem_cma_object *obj;
>  	dma_addr_t paddr;
> +	u8 h_div = 1, v_div = 1;
>  
>  	obj = drm_fb_cma_get_gem_obj(fb, plane);
>  	if (!obj)
>  		return 0;
>  
>  	paddr = obj->paddr + fb->offsets[plane];
> -	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
> -	paddr += fb->pitches[plane] * (state->src_y >> 16);
> +
> +	if (plane > 0) {
> +		h_div = fb->format->hsub;
> +		v_div = fb->format->vsub;
> +	}
> +
> +	paddr += (fb->format->cpp[plane] * (state->src_x >> 16)) / h_div;
> +	paddr += (fb->pitches[plane] * (state->src_y >> 16)) / v_div;
>  
>  	return paddr;
>  }
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
