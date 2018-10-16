Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE78A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Mbe7nqEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE78A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJPUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:20:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37883 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:20:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id c22-v6so21132416edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CddyRYnzNEsksPzwej6j8Dr2rlsiVXlGL7dbnElQkTM=;
        b=Mbe7nqEhC+fagPCzBS52K1cK5YC0Z/6Q6B+5XOKei5WT32KmVXb0f2gxkNPJkIL6IY
         bK499pb0ava/pokaqu/qLWU8qnnniBEIpHl6TH/oVK0960PQyXe2vMfe7k6iaJTVv9w0
         uM9yPUDEW9eKdqufFyIuyU0dc2D3dqx3vh8Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CddyRYnzNEsksPzwej6j8Dr2rlsiVXlGL7dbnElQkTM=;
        b=VAM4N7SEox4c51APiGa+ixTP1ukNP6XhaYy5c8awOCof9KZw7Qy2CITwMV4v/N848A
         HmsEUz2Z8NJOQk/f55pro3+9a5iArgRm8J94lrHGy6ZEiY0n0L3cD9+MhrTwmEnX0Iqc
         qO1/heI4zmqEreDfZwC1ECTrq+3eZjP4JTzgV4Kw25KYflteQtpE8PZQ7J2QeqdDylIP
         TuQ+Y6vatA+qGcssGIwOccOX4/OemZWBAaLRmxPT+zLMPfbhPCmS/d5pkKNluWHjbMTH
         q+MLmJ6tbEoyKGpas3vFWMGWZP+3zIUCbXUqS+70Cdp2XQ5GMh3QVAbfqxZU15oV6QFY
         ukKA==
X-Gm-Message-State: ABuFfogLKSTmDKyTAbh5SkbFVjCCcW6Wu+e4ZLgyLGhD3F+EzdIonLov
        Et7athLBTPyc3QBnYH45A9/V/Q==
X-Google-Smtp-Source: ACcGV62mH5IGlfXKpw3HLVlRg25nKecaS5bh9INdMfv7LMU+KQlSKlc4zls8o/cFYFvmGCCvJZICgA==
X-Received: by 2002:a50:ee19:: with SMTP id g25-v6mr30115908eds.66.1539692989201;
        Tue, 16 Oct 2018 05:29:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m25-v6sm2778505ejb.18.2018.10.16.05.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:29:48 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:29:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch v4 5/8] drm/omap: Add global state as a private atomic
 object
Message-ID: <20181016122946.GU31561@phenom.ffwll.local>
Mail-Followup-To: Benoit Parrot <bparrot@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
 <20181012201703.29065-6-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012201703.29065-6-bparrot@ti.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 03:17:00PM -0500, Benoit Parrot wrote:
> Global shared resources (like hw overlays) for omapdrm are implemented
> as a part of atomic state using the drm_private_obj infrastructure
> available in the atomic core.
> 
> omap_global_state is introduced as a drm atomic private object. The two
> funcs omap_get_global_state() and omap_get_existing_global_state() are
> the two variants that will be used to access omap_global_state.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_drv.c | 97 +++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/omapdrm/omap_drv.h | 23 +++++++++
>  2 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 2921cc90f2d8..94658ec79c76 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -129,6 +129,94 @@ static const struct drm_mode_config_funcs omap_mode_config_funcs = {
>  	.atomic_commit = drm_atomic_helper_commit,
>  };
>  
> +/* Global/shared object state funcs */
> +
> +/*
> + * This is a helper that returns the private state currently in operation.
> + * Note that this would return the "old_state" if called in the atomic check
> + * path, and the "new_state" after the atomic swap has been done.
> + */
> +struct omap_global_state *
> +omap_get_existing_global_state(struct omap_drm_private *priv)
> +{
> +	return to_omap_global_state(priv->glob_obj.state);
> +}
> +
> +/*
> + * This acquires the modeset lock set aside for global state, creates
> + * a new duplicated private object state.
> + */
> +struct omap_global_state *__must_check
> +omap_get_global_state(struct drm_atomic_state *s)
> +{
> +	struct omap_drm_private *priv = s->dev->dev_private;
> +	struct drm_private_state *priv_state;
> +	int ret;
> +
> +	if (!drm_modeset_is_locked(&priv->glob_obj_lock)) {
> +		ret = drm_modeset_lock(&priv->glob_obj_lock, s->acquire_ctx);
> +		if (ret) {
> +			DBG("getting priv->glob_obj_lock (%p) failed %d",
> +			    &priv->glob_obj_lock, ret);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	priv_state = drm_atomic_get_private_obj_state(s, &priv->glob_obj);

One of the refactors I had in mind (and which would be possible now that
private state structs are implemented as properly structs, instead of void
* pointers): Add a drm_modeset_lock to drm_private_obj and avoid having to
duplicate that over all implementations. Not everyone wants a per-obj
lock, but no one will be hurt by having a per-obj lock - drm_modeset_lock
is very extensible in that way. And we could drop the custom locking code
everyone has to roll themselves.

Just a drive-by refactor idea.
-Daniel

> +	if (IS_ERR(priv_state))
> +		return ERR_CAST(priv_state);
> +
> +	return to_omap_global_state(priv_state);
> +}
> +
> +static struct drm_private_state *
> +omap_global_duplicate_state(struct drm_private_obj *obj)
> +{
> +	struct omap_global_state *state;
> +
> +	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return NULL;
> +
> +	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
> +
> +	return &state->base;
> +}
> +
> +static void omap_global_destroy_state(struct drm_private_obj *obj,
> +				      struct drm_private_state *state)
> +{
> +	struct omap_global_state *omap_state = to_omap_global_state(state);
> +
> +	kfree(omap_state);
> +}
> +
> +static const struct drm_private_state_funcs omap_global_state_funcs = {
> +	.atomic_duplicate_state = omap_global_duplicate_state,
> +	.atomic_destroy_state = omap_global_destroy_state,
> +};
> +
> +static int omap_global_obj_init(struct omap_drm_private *priv)
> +{
> +	struct omap_global_state *state;
> +
> +	drm_modeset_lock_init(&priv->glob_obj_lock);
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	drm_atomic_private_obj_init(&priv->glob_obj, &state->base,
> +				    &omap_global_state_funcs);
> +	return 0;
> +}
> +
> +static void omap_global_obj_fini(struct omap_drm_private *priv)
> +{
> +	drm_atomic_private_obj_fini(&priv->glob_obj);
> +	drm_modeset_lock_fini(&priv->glob_obj_lock);
> +}
> +
>  static void omap_disconnect_pipelines(struct drm_device *ddev)
>  {
>  	struct omap_drm_private *priv = ddev->dev_private;
> @@ -569,10 +657,14 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
>  
>  	omap_gem_init(ddev);
>  
> -	ret = omap_hwoverlays_init(priv);
> +	ret = omap_global_obj_init(priv);
>  	if (ret)
>  		goto err_gem_deinit;
>  
> +	ret = omap_hwoverlays_init(priv);
> +	if (ret)
> +		goto err_free_priv_obj;
> +
>  	ret = omap_modeset_init(ddev);
>  	if (ret) {
>  		dev_err(priv->dev, "omap_modeset_init failed: ret=%d\n", ret);
> @@ -612,6 +704,8 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
>  err_cleanup_modeset:
>  	drm_mode_config_cleanup(ddev);
>  	omap_drm_irq_uninstall(ddev);
> +err_free_priv_obj:
> +	omap_global_obj_fini(priv);
>  err_free_overlays:
>  	omap_hwoverlays_destroy(priv);
>  err_gem_deinit:
> @@ -644,6 +738,7 @@ static void omapdrm_cleanup(struct omap_drm_private *priv)
>  	omap_drm_irq_uninstall(ddev);
>  	omap_gem_deinit(ddev);
>  
> +	omap_global_obj_fini(priv);
>  	omap_hwoverlays_destroy(priv);
>  
>  	destroy_workqueue(priv->wq);
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
> index 929f04e7cc3b..f374dc100447 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -23,6 +23,7 @@
>  #include <linux/workqueue.h>
>  
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_gem.h>
>  #include <drm/omap_drm.h>
> @@ -54,6 +55,17 @@ struct omap_drm_pipeline {
>  	struct omap_dss_device *display;
>  };
>  
> +/*
> + * Global private object state for tracking resources that are shared across
> + * multiple kms objects (planes/crtcs/etc).
> + */
> +#define to_omap_global_state(x) container_of(x, struct omap_global_state, base)
> +struct omap_global_state {
> +	struct drm_private_state base;
> +
> +	struct drm_atomic_state *state;
> +};
> +
>  struct omap_drm_private {
>  	struct drm_device *ddev;
>  	struct device *dev;
> @@ -73,6 +85,13 @@ struct omap_drm_private {
>  	unsigned int num_ovls;
>  	struct omap_hw_overlay *overlays[8];
>  
> +	/*
> +	 * Global private object state, Do not access directly, use
> +	 * omap_global_get_state()
> +	 */
> +	struct drm_modeset_lock glob_obj_lock;
> +	struct drm_private_obj glob_obj;
> +
>  	struct drm_fb_helper *fbdev;
>  
>  	struct workqueue_struct *wq;
> @@ -100,5 +119,9 @@ struct omap_drm_private {
>  
>  
>  int omap_debugfs_init(struct drm_minor *minor);
> +struct omap_global_state *__must_check
> +omap_get_global_state(struct drm_atomic_state *s);
> +struct omap_global_state *
> +omap_get_existing_global_state(struct omap_drm_private *priv);
>  
>  #endif /* __OMAPDRM_DRV_H__ */
> -- 
> 2.9.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
