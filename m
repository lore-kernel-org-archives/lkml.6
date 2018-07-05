Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64C23FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kz5QjLRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64C23FF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbeGEPs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:48:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46693 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeGEPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:48:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so6520063edo.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nOIuSxUJ93lpkBnvZE72TAfzIBJpI3SWbGj7im3seM=;
        b=kz5QjLRbMihsA/X8/nmgO9IfVoGwQZj+4aDIu6xAJToSvJpWf+kkbqqukSUDd9t80D
         io1CYtmwWOYCXyhAPJZvhHgQeKXvJcOGqbcIYcjO/8wv/28IkoKJzP5JjDPgJUh6vI69
         zBGjlFU+ZjD00ESypfFHID8avb7FNH8PIYu5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2nOIuSxUJ93lpkBnvZE72TAfzIBJpI3SWbGj7im3seM=;
        b=qwhIq5awCS8cZC3TUnNp+1Vd9UrcdBnB9Ce5jdVW9cuiso7atYq7Qbz/rrkow6ZjoF
         tDDNpTT2dWHYkxQ+3YxHLPfP43YfnbCjBRomTJBQG2K2Fj0uMlWrR1GTjOTeyf/dcpBd
         xgYEqRbUKRJ4kSlkjX8NgMRZnPXrTHPYdffOgJ6O0fntTu8pCPl04cfkQHXj2tSs/oYc
         CLpE6XeidACseWfq6XAlY6FjHiB5f9lfYnyxL9+nXJqdez0ka9733Hprw8UNvUvc66g8
         teV9uX7PUERyZSVlz0hH4mCz2+N8NGSnLNGHM1i2Ya4qB8hYoqFf/ZHXYx/b3eyyh80r
         9v1Q==
X-Gm-Message-State: APt69E0q7Pod+rlbZ0dixPcnZj0JrsfG0PiUZmHYqan2KROLiPRJoYp+
        xVuMmnALg0PxXUzQQGva3LobDQ==
X-Google-Smtp-Source: AAOMgpdY45Q19KhZMkXFz3fO9QkTb3xmHme/q/5l77TsQoxqlGUfocoszJjHcV/P32dbYCcKEU4b5w==
X-Received: by 2002:aa7:d40a:: with SMTP id z10-v6mr7243481edq.203.1530805705644;
        Thu, 05 Jul 2018 08:48:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2808373edr.24.2018.07.05.08.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 08:48:24 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:48:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [RFC PATCH v2] drm/arm/malidp: Added support for AFBC modifiers
 for all layers except DE_SMART
Message-ID: <20180705154822.GC4273@phenom.ffwll.local>
Mail-Followup-To: Ayan Kumar Halder <ayan.halder@arm.com>,
        liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
References: <1530800743-2250-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530800743-2250-1-git-send-email-ayan.halder@arm.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:25:43PM +0100, Ayan Kumar Halder wrote:
> On planes which support AFBC, expose an AFBC modifier for use with BGR888.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
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
> index 7b6a848..7bcd679 100644
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
> index 3950504..914cc58 100644
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

I think the core checks for that by now, or at least Ville had some
patches to make that happen ...

I also don't see the ARM_AFBC modifier in upstream yet, is that still
in-flight somewhere?
-Daniel

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
> @@ -524,6 +554,13 @@ int malidp_de_planes_init(struct drm_device *drm)
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
> @@ -547,9 +584,14 @@ int malidp_de_planes_init(struct drm_device *drm)
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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
