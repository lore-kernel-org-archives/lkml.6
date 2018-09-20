Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67889ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF602152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JJId3ruC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF602152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbeITRF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:05:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50424 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbeITRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:05:27 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A3741A9C;
        Thu, 20 Sep 2018 13:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537442545;
        bh=w7waZhxXDIPvFCB/7tk7b+hBROvy477pj9Mf8lZRuJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJId3ruC/lk2VcNQkCWLu8hFGyRBsivEiDlKVrlWPBLFbluX/cPIXfLywO9eM9AU6
         eN5QO3cWWwdyfSnqsKoLjDdXFHI5VjsHazs1ZL8wHfOlGX8YjDAaVQBu6Mc/z4XGJb
         sG+AMRpEob1mpQTBuDLmc89QZnliE/MT3SJagAU0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm: rcar-du: Enable alpha property on primary planes
Date:   Thu, 20 Sep 2018 14:22:38 +0300
Message-ID: <1604918.OXgyMDt7RE@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180919155700.10342-3-kieran.bingham+renesas@ideasonboard.com>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com> <20180919155700.10342-3-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Wednesday, 19 September 2018 18:56:59 EEST Kieran Bingham wrote:
> If the alpha property is not added to a plane, a default value will be
> used, which can result in a non-visible layer if the alpha is
> initialised as 0.
> 
> Provide an alpha blend property on all planes.
> 
> Fixes: 161ad653d6c9 ("drm: rcar-du: Use __drm_atomic_helper_plane_reset
> instead of copying the logic")
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> b/drivers/gpu/drm/rcar-du/rcar_du_plane.c index 9e07758a755c..72399a19d8a6
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> @@ -783,13 +783,18 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
>  		drm_plane_helper_add(&plane->plane,
>  				     &rcar_du_plane_helper_funcs);
> 
> +		/*
> +		 * The alpha property needs to be initialised on all planes
> +		 * to ensure the correct setting at the output.
> +		 */
> +		drm_plane_create_alpha_property(&plane->plane);
> +

As mentioned in the cover letter, both patches in this series fix the issue at 
hand. The first patch is more generic as it will fix it for all drivers, while 
this patch is specific to the R-Car DU driver. It however makes sense to merge 
it, as it adds alpha support to the primary plane, which can be useful.

Once the first patch gets merged, the above comment won't be correct anymore. 
I wonder whether we shouldn't change the patch description and comment to 
focus on usage of the alpha property for primary planes, and not on the bug 
fix. What's your opinion ?

>  		if (type == DRM_PLANE_TYPE_PRIMARY)
>  			continue;
> 
>  		drm_object_attach_property(&plane->plane.base,
>  					   rcdu->props.colorkey,
>  					   RCAR_DU_COLORKEY_NONE);
> -		drm_plane_create_alpha_property(&plane->plane);
>  		drm_plane_create_zpos_property(&plane->plane, 1, 1, 7);
>  	}

-- 
Regards,

Laurent Pinchart



