Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB902083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Puoj8f2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfBEJAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:00:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42227 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbfBEJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:00:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id r15so735083eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUC6A92bmSL+7sFZtQ0Bpojb0vshrB0BTKDOzYn7otE=;
        b=Puoj8f2mFovONgFUqu+lMjiNeYdxWMzTtxm/Igt3aOBdV6gPPrDAwz1BnV6YrnNfeA
         2g8K5rEz5a5mhKBrDcrMMIdNQ9x4Io1KaO9/cuPpHXErhUEHIIgU3goee/RR1S07zwaA
         ue6CIBGeA4yelaJ8EERn2LG4qoXW6waweh/GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LUC6A92bmSL+7sFZtQ0Bpojb0vshrB0BTKDOzYn7otE=;
        b=AGN9YicOGQReyKFZ6/33YWdXsZAJV+Y/DHuBOP89wHugVwPtouxKWF1XXuKLrSh/r0
         UKlR5YL3+XxgZd0nUscoXJZOYi/Rqu6bzBj6JMUkbE9UyoKj9nRSuj4vXbZhc9SztlOc
         cKaEgHpFdfKhK/OopopYCO8pWuoedf3kDU3G4VjVFiR63lJMRCbM4yNQ11K6TLFajcUx
         6F3c+1wU08DYXeuBiklpmgtIurnWivpvN+MnxVIGOpQw+2J+jlP5X95SLwW852iVlmrJ
         B0gXMOAOBN2FS6gbh9GPbMNecsMwcmP5cMdnJZ694gbd8jPm1usIupB4+oDGF7vSa8Ah
         CIXA==
X-Gm-Message-State: AHQUAuZ4Sera07o42QF/y3FiSoxqcX3p1Fa7tK4IHy+khG48aSKYeJzw
        Y+UQMHCW9hAesZzBW4GJQQZGPg==
X-Google-Smtp-Source: AHgI3IY6oP4d+/StBUzrQGMFC6RahZ1j7B9bDxfsBpo3XJctHPrpN8nN/e2XDZRFTSvoYMUgQC1iQg==
X-Received: by 2002:a17:906:7f17:: with SMTP id d23mr2760789ejr.130.1549357207084;
        Tue, 05 Feb 2019 01:00:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g1-v6sm2909436eje.2.2019.02.05.01.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:00:06 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:00:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/cirrus: add plane setup
Message-ID: <20190205090004.GZ3271@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190204110131.21467-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204110131.21467-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:01:31PM +0100, Gerd Hoffmann wrote:
> Commit "f4bd542bca drm/fb-helper: Scale back depth to supported maximum"
> uncovered a bug in the cirrus driver.  It must create its own primary
> plane, using the correct format list, depending on the bpp module
> parameter, so it is consistent with mode_config->preferred_depth.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/cirrus/cirrus_mode.c | 67 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
> index a830e70fc0..2e966a22c5 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_mode.c
> +++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
> @@ -360,10 +360,67 @@ static const struct drm_crtc_helper_funcs cirrus_helper_funcs = {
>  };
>  
>  /* CRTC setup */
> +static const uint32_t cirrus_formats_16[] = {
> +	DRM_FORMAT_RGB565,
> +};
> +
> +static const uint32_t cirrus_formats_24[] = {
> +	DRM_FORMAT_RGB888,
> +};
> +
> +static const uint32_t cirrus_formats_32[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +};

I'd include the lower-res formats too here, without those you limit
userspace that looks at this stuff to only these formats. Not that this is
really important for cirrus ... So 24bits would include 16, and 32 would
include 24 and 16. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
> +static struct drm_plane *cirrus_primary_plane(struct drm_device *dev)
> +{
> +	const uint32_t *formats;
> +	uint32_t nformats;
> +	struct drm_plane *primary;
> +	int ret;
> +
> +	switch (cirrus_bpp) {
> +	case 16:
> +		formats = cirrus_formats_16;
> +		nformats = ARRAY_SIZE(cirrus_formats_16);
> +		break;
> +	case 24:
> +		formats = cirrus_formats_24;
> +		nformats = ARRAY_SIZE(cirrus_formats_24);
> +		break;
> +	case 32:
> +		formats = cirrus_formats_32;
> +		nformats = ARRAY_SIZE(cirrus_formats_32);
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
> +	if (primary == NULL) {
> +		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
> +		return NULL;
> +	}
> +
> +	ret = drm_universal_plane_init(dev, primary, 0,
> +				       &drm_primary_helper_funcs,
> +				       formats, nformats,
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		kfree(primary);
> +		primary = NULL;
> +	}
> +
> +	return primary;
> +}
> +
>  static void cirrus_crtc_init(struct drm_device *dev)
>  {
>  	struct cirrus_device *cdev = dev->dev_private;
>  	struct cirrus_crtc *cirrus_crtc;
> +	struct drm_plane *primary;
>  
>  	cirrus_crtc = kzalloc(sizeof(struct cirrus_crtc) +
>  			      (CIRRUSFB_CONN_LIMIT * sizeof(struct drm_connector *)),
> @@ -372,7 +429,15 @@ static void cirrus_crtc_init(struct drm_device *dev)
>  	if (cirrus_crtc == NULL)
>  		return;
>  
> -	drm_crtc_init(dev, &cirrus_crtc->base, &cirrus_crtc_funcs);
> +	primary = cirrus_primary_plane(dev);
> +	if (primary == NULL) {
> +		kfree(cirrus_crtc);
> +		return;
> +	}
> +
> +	drm_crtc_init_with_planes(dev, &cirrus_crtc->base,
> +				  primary, NULL,
> +				  &cirrus_crtc_funcs, NULL);
>  
>  	drm_mode_crtc_set_gamma_size(&cirrus_crtc->base, CIRRUS_LUT_SIZE);
>  	cdev->mode_info.crtc = cirrus_crtc;
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
