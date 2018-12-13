Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECD2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DC920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Dwc1PNi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DC920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeLMVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:45:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42331 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeLMVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:45:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so3286078edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZ0bqykfwfS7xqXXkH9yOxSZXFj0skiY2tdj9DxaqIs=;
        b=Dwc1PNi4+HnvyitTPIoYHQ/NA9pq8yAmwCVYYWSg0TOrLxILoJeo17CDjxxTmDlSdg
         8/ncWP2sbTubTdqrYgPRSLpurftOSBE13ryNzqRQZiu+zVc6rL8Ml8vZiXy2QOUBJwxU
         PojrqIG+Sqx+EKmOt3ME8fz6LaC9TqB55LX7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uZ0bqykfwfS7xqXXkH9yOxSZXFj0skiY2tdj9DxaqIs=;
        b=AUAAwqNOKGV8rSt8x/MYJbJmy8Xq/y6UOQp6JYQqLZ08g46HnnmjAcYmoRGr5ofGrm
         C3vQmhcbVyhpW+d2eFCMcrbXtGqUMRlup5hE0xtR717yr6pG9nLDBU4OFa5GoL4a96m5
         sZCd822hXNCd1kFmWBOMC9LLoVbuv5MBPaCHrbl4v5FtQwaR2/27SsKBqnnhapk7y1hZ
         be905eWAkctdRgQE7HqYZOGLGxDuII+m95YoTzrNy4QWj/Sb2M18zd+GIYjMXg92QfbM
         Mv5JDugRtImhgBG5A8hBdOWAj29Cu/7g3ebJTAUxZgppcyJkehkZE0MEL1hjBgtsUA12
         vzmQ==
X-Gm-Message-State: AA+aEWYihsDCOQw3MXQaw8GVuFQwLQwNhe13+6wgXemcbLpa/WVE8IXa
        4D9JTESOT+X2ciGSISTI8i6bA3njQlA=
X-Google-Smtp-Source: AFSGD/Vt/eTlwWvciYamFvvSk0MX0MaBUrO+dLTmoi5vpWiBMGRXfEXqGXiCky27QDgYVXvNWCuP4w==
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr618247ejq.19.1544737556854;
        Thu, 13 Dec 2018 13:45:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b46sm906181edc.57.2018.12.13.13.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 13:45:55 -0800 (PST)
Date:   Thu, 13 Dec 2018 22:45:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH v2] drm: Rename crtc_idr as
 object_idr to KMS cleanups
Message-ID: <20181213214553.GH21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20181213212957.vkitkyl5cj2qh7qr@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213212957.vkitkyl5cj2qh7qr@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 07:29:57PM -0200, Shayenne da Luz Moura wrote:
> This patch solves this TODO task:
>  drm_mode_config.crtc_idr is misnamed, since it contains all KMS object.
>  Should be renamed to drm_mode_config.object_idr.
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> 
> ---
> Changes in v2:
>  - Make commit message more clear and change header file

Applied now, thanks for your patch. For next time around, pls ping after a
week already, likely no answer after a week means the patch simply fell
through the cracks :-/

Can you pls follow up with a patch to remove the todo item, now that it's
completed?

Thanks, Daniel

> 
>  drivers/gpu/drm/drm_lease.c       | 6 +++---
>  drivers/gpu/drm/drm_mode_config.c | 4 ++--
>  drivers/gpu/drm/drm_mode_object.c | 8 ++++----
>  include/drm/drm_mode_config.h     | 6 +++---
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 977f069f6d90..b2cbb58834bc 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -218,7 +218,7 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
>  
>  	idr_for_each_entry(leases, entry, object) {
>  		error = 0;
> -		if (!idr_find(&dev->mode_config.crtc_idr, object))
> +		if (!idr_find(&dev->mode_config.object_idr, object))
>  			error = -ENOENT;
>  		else if (!_drm_lease_held_master(lessor, object))
>  			error = -EACCES;
> @@ -434,7 +434,7 @@ static int fill_object_idr(struct drm_device *dev,
>  		/*
>  		 * We're using an IDR to hold the set of leased
>  		 * objects, but we don't need to point at the object's
> -		 * data structure from the lease as the main crtc_idr
> +		 * data structure from the lease as the main object_idr
>  		 * will be used to actually find that. Instead, all we
>  		 * really want is a 'leased/not-leased' result, for
>  		 * which any non-NULL pointer will work fine.
> @@ -675,7 +675,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>  
>  	if (lessee->lessor == NULL)
>  		/* owner can use all objects */
> -		object_idr = &lessee->dev->mode_config.crtc_idr;
> +		object_idr = &lessee->dev->mode_config.object_idr;
>  	else
>  		/* lessee can only use allowed object */
>  		object_idr = &lessee->leases;
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index ee80788f2c40..ab553b6465e2 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -381,7 +381,7 @@ void drm_mode_config_init(struct drm_device *dev)
>  	INIT_LIST_HEAD(&dev->mode_config.property_list);
>  	INIT_LIST_HEAD(&dev->mode_config.property_blob_list);
>  	INIT_LIST_HEAD(&dev->mode_config.plane_list);
> -	idr_init(&dev->mode_config.crtc_idr);
> +	idr_init(&dev->mode_config.object_idr);
>  	idr_init(&dev->mode_config.tile_idr);
>  	ida_init(&dev->mode_config.connector_ida);
>  	spin_lock_init(&dev->mode_config.connector_list_lock);
> @@ -484,7 +484,7 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>  
>  	ida_destroy(&dev->mode_config.connector_ida);
>  	idr_destroy(&dev->mode_config.tile_idr);
> -	idr_destroy(&dev->mode_config.crtc_idr);
> +	idr_destroy(&dev->mode_config.object_idr);
>  	drm_modeset_lock_fini(&dev->mode_config.connection_mutex);
>  }
>  EXPORT_SYMBOL(drm_mode_config_cleanup);
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index cd9bc0ce9be0..bb1dd46496cd 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -38,7 +38,7 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
>  	int ret;
>  
>  	mutex_lock(&dev->mode_config.idr_mutex);
> -	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL,
> +	ret = idr_alloc(&dev->mode_config.object_idr, register_obj ? obj : NULL,
>  			1, 0, GFP_KERNEL);
>  	if (ret >= 0) {
>  		/*
> @@ -79,7 +79,7 @@ void drm_mode_object_register(struct drm_device *dev,
>  			      struct drm_mode_object *obj)
>  {
>  	mutex_lock(&dev->mode_config.idr_mutex);
> -	idr_replace(&dev->mode_config.crtc_idr, obj, obj->id);
> +	idr_replace(&dev->mode_config.object_idr, obj, obj->id);
>  	mutex_unlock(&dev->mode_config.idr_mutex);
>  }
>  
> @@ -99,7 +99,7 @@ void drm_mode_object_unregister(struct drm_device *dev,
>  {
>  	mutex_lock(&dev->mode_config.idr_mutex);
>  	if (object->id) {
> -		idr_remove(&dev->mode_config.crtc_idr, object->id);
> +		idr_remove(&dev->mode_config.object_idr, object->id);
>  		object->id = 0;
>  	}
>  	mutex_unlock(&dev->mode_config.idr_mutex);
> @@ -131,7 +131,7 @@ struct drm_mode_object *__drm_mode_object_find(struct drm_device *dev,
>  	struct drm_mode_object *obj = NULL;
>  
>  	mutex_lock(&dev->mode_config.idr_mutex);
> -	obj = idr_find(&dev->mode_config.crtc_idr, id);
> +	obj = idr_find(&dev->mode_config.object_idr, id);
>  	if (obj && type != DRM_MODE_OBJECT_ANY && obj->type != type)
>  		obj = NULL;
>  	if (obj && obj->id != id)
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index d643d268693e..4750fccb5b4a 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -385,18 +385,18 @@ struct drm_mode_config {
>  	/**
>  	 * @idr_mutex:
>  	 *
> -	 * Mutex for KMS ID allocation and management. Protects both @crtc_idr
> +	 * Mutex for KMS ID allocation and management. Protects both @object_idr
>  	 * and @tile_idr.
>  	 */
>  	struct mutex idr_mutex;
>  
>  	/**
> -	 * @crtc_idr:
> +	 * @object_idr:
>  	 *
>  	 * Main KMS ID tracking object. Use this idr for all IDs, fb, crtc,
>  	 * connector, modes - just makes life easier to have only one.
>  	 */
> -	struct idr crtc_idr;
> +	struct idr object_idr;
>  
>  	/**
>  	 * @tile_idr:
> -- 
> 2.19.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20181213212957.vkitkyl5cj2qh7qr%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
