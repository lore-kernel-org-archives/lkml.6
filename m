Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C1ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9796D2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ei4n8W2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9796D2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeITQ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:59:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50288 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeITQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:59:53 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F9601A9C;
        Thu, 20 Sep 2018 13:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537442212;
        bh=609QVZ+QRTXJV8l5MN85V8w+qYIK7gYSodMUYIUSz2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ei4n8W2DgVEehaS4fuoqlzmKzvUTknGur5Oyog3kh4dzdwiyYpRrN8Q83I2lshm6L
         zJ3o5eSzpza0eg96bRro/RTOrdo/33Nax54HYpuS8W3uiJaIESzTFjqEOuPkDTrfwn
         9RMqaPo+/Hqdg7TgUvthVozf+rh+5g0wpgrVi7ak=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/atomic: Initialise planes with opaque alpha values
Date:   Thu, 20 Sep 2018 14:17:05 +0300
Message-ID: <1760492.77853pnPW8@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180919155700.10342-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com> <20180919155700.10342-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Wednesday, 19 September 2018 18:56:58 EEST Kieran Bingham wrote:
> Planes without an alpha property, using __drm_atomic_helper_plane_reset
> will have their plane state alpha initialised as zero, which represents
> a transparent alpha.
> 
> If this value is then used for the plane, it may not be visible by
> default, and thus doesn't represent a good initialisation state.
> 
> Update the default state->alpha value to DRM_BLEND_ALPHA_OPAQUE
> unconditionally when the plane is reset.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

I believe the decision to use plane->alpha_property->values[1] instead of 
hardcoding DRM_BLEND_ALPHA_OPAQUE comes from earlier versions of the alpha 
patch series that supported driver-specific ranges for the alpha value. The 
current implementation uses DRM_BLEND_ALPHA_OPAQUE unconditionally, and no 
driver modifies the maximum value behind the scene, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c index 3cf1aa132778..e49b22381048
> 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3569,9 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane
> *plane, state->plane = plane;
>  	state->rotation = DRM_MODE_ROTATE_0;
> 
> -	/* Reset the alpha value to fully opaque if it matters */
> -	if (plane->alpha_property)
> -		state->alpha = plane->alpha_property->values[1];
> +	state->alpha = DRM_BLEND_ALPHA_OPAQUE;
>  	state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> 
>  	plane->state = state;


-- 
Regards,

Laurent Pinchart



