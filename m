Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5ADC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2AA2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2AA2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeKAGCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:02:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47440 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729909AbeKAGCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:02:41 -0400
X-IronPort-AV: E=Sophos;i="5.54,449,1534802400"; 
   d="scan'208";a="353685568"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 22:02:53 +0100
Date:   Wed, 31 Oct 2018 22:02:53 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] drm: Rename crtc_idr as object_idr
 to KMS cleanups
In-Reply-To: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
Message-ID: <alpine.DEB.2.21.1810312200520.2391@hadrien>
References: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Oct 2018, Shayenne da Luz Moura wrote:

> Rename 'drm_mode_config.crtc_idr' as 'drm_mode_config.object_idr',
> as proposed in the task description in TODO list for KMS cleanups.

Is object_idr a field that already exists?  If so, "Rename" is not the
best choice of words.  It should be something like "use the object_idr
field instead of the crtc_idr field" and then explain why.  "task
description in TODO list for KMS cleanups" isn't very helpful to
understand why the change should be made.

julia

>
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/drm_lease.c       | 6 +++---
>  drivers/gpu/drm/drm_mode_config.c | 4 ++--
>  drivers/gpu/drm/drm_mode_object.c | 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index f4702f23c11d..4f8de2217049 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -222,7 +222,7 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
>
>  	idr_for_each_entry(leases, entry, object) {
>  		error = 0;
> -		if (!idr_find(&dev->mode_config.crtc_idr, object))
> +		if (!idr_find(&dev->mode_config.object_idr, object))
>  			error = -ENOENT;
>  		else if (!_drm_lease_held_master(lessor, object))
>  			error = -EACCES;
> @@ -438,7 +438,7 @@ static int fill_object_idr(struct drm_device *dev,
>  		/*
>  		 * We're using an IDR to hold the set of leased
>  		 * objects, but we don't need to point at the object's
> -		 * data structure from the lease as the main crtc_idr
> +		 * data structure from the lease as the main object_idr
>  		 * will be used to actually find that. Instead, all we
>  		 * really want is a 'leased/not-leased' result, for
>  		 * which any non-NULL pointer will work fine.
> @@ -679,7 +679,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
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
> --
> 2.19.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20181031205737.cingeaqget7hkbs6%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
