Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ACC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6043720883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6043720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeGKJgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:36:44 -0400
Received: from foss.arm.com ([217.140.101.70]:59976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbeGKJgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:36:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00CCEED1;
        Wed, 11 Jul 2018 02:33:19 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A41523F318;
        Wed, 11 Jul 2018 02:33:18 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 11C526818E4; Wed, 11 Jul 2018 10:33:17 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:33:17 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 4/4] drm/arm/malidp: Added support for AFBC modifiers
 for all layers except DE_SMART
Message-ID: <20180711093316.GQ15340@e110455-lin.cambridge.arm.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
 <1531228737-5450-5-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531228737-5450-5-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:18:57PM +0100, Ayan Kumar Halder wrote:
> On planes which support AFBC, expose an AFBC modifier for use with BGR888.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> 
> Changes from v2:
> - Removed the gerrit change-id
> - Replaced DRM_ERROR() with DRM_DEBUG_KMS() in malidp_format_mod_supported()
> to report unsupported modifiers.
> ---
>  drivers/gpu/drm/arm/malidp_drv.c    |  1 +
>  drivers/gpu/drm/arm/malidp_planes.c | 46 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 262a830..4f6e52e 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -392,6 +392,7 @@ static int malidp_init(struct drm_device *drm)
>  	drm->mode_config.max_height = hwdev->max_line_size;
>  	drm->mode_config.funcs = &malidp_mode_config_funcs;
>  	drm->mode_config.helper_private = &malidp_mode_config_helpers;
> +	drm->mode_config.allow_fb_modifiers = true;
>  
>  	ret = malidp_crtc_init(drm);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 0122091..605c5ae 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -124,6 +124,35 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
>  	drm_printf(p, "\tn_planes=%u\n", ms->n_planes);
>  }
>  
> +static bool malidp_format_mod_supported(struct drm_plane *plane,
> +					u32 format, u64 modifier)
> +{
> +	if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
> +		return false;
> +
> +	/* All the pixel formats are supported without any modifier */
> +	if (modifier == DRM_FORMAT_MOD_LINEAR)
> +		return true;
> +
> +	if ((modifier >> 56) != DRM_FORMAT_MOD_VENDOR_ARM)
> +		return false;
> +
> +	if (modifier &
> +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> +		DRM_DEBUG_KMS("Unsupported modifiers\n");
> +		return false;
> +	}
> +
> +	switch (modifier) {
> +	case DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> +				AFBC_FORMAT_MOD_YTR |
> +				AFBC_FORMAT_MOD_SPARSE):
> +		if (format == DRM_FORMAT_BGR888)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -132,6 +161,7 @@ static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.atomic_duplicate_state = malidp_duplicate_plane_state,
>  	.atomic_destroy_state = malidp_destroy_plane_state,
>  	.atomic_print_state = malidp_plane_atomic_print_state,
> +	.format_mod_supported = malidp_format_mod_supported,
>  };
>  
>  static int malidp_se_check_scaling(struct malidp_plane *mp,
> @@ -526,6 +556,13 @@ int malidp_de_planes_init(struct drm_device *drm)
>  	u32 *formats;
>  	int ret, i, j, n;
>  
> +	static const u64 modifiers[] = {
> +		DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> +			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPARSE),
> +		DRM_FORMAT_MOD_LINEAR,
> +		DRM_FORMAT_MOD_INVALID
> +	};
> +
>  	formats = kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KERNEL);
>  	if (!formats) {
>  		ret = -ENOMEM;
> @@ -549,9 +586,14 @@ int malidp_de_planes_init(struct drm_device *drm)
>  
>  		plane_type = (i == 0) ? DRM_PLANE_TYPE_PRIMARY :
>  					DRM_PLANE_TYPE_OVERLAY;
> +
> +		/*
> +		 * All the layers except smart layer supports AFBC modifiers.
> +		 */
>  		ret = drm_universal_plane_init(drm, &plane->base, crtcs,
> -					       &malidp_de_plane_funcs, formats,
> -					       n, NULL, plane_type, NULL);
> +				&malidp_de_plane_funcs, formats, n,
> +				(id == DE_SMART) ? NULL : modifiers, plane_type, NULL);
> +
>  		if (ret < 0)
>  			goto cleanup;
>  
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
