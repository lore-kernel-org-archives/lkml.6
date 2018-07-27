Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD47F208A5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD47F208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeG0N1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:27:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:62706 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbeG0N1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:27:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 05:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,409,1526367600"; 
   d="scan'208";a="249480514"
Received: from eberhars-mobl1.ger.corp.intel.com (HELO [10.252.50.199]) ([10.252.50.199])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2018 05:05:37 -0700
Subject: Re: [PATCH] drm/kms/crtc: Improving the func drm_mode_setcrtc
To:     Satendra Singh Thakur <satendra.t@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com
References: <CGME20180727101302epcas5p22561edd1d60101e611933ccff3e3d008@epcas5p2.samsung.com>
 <20180727101302epcas5p22561edd1d60101e611933ccff3e3d008~FMiUBZnCN2101321013epcas5p2Z@epcas5p2.samsung.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <66ead941-3c64-45e4-7835-949360e2b01f@linux.intel.com>
Date:   Fri, 27 Jul 2018 14:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727101302epcas5p22561edd1d60101e611933ccff3e3d008~FMiUBZnCN2101321013epcas5p2Z@epcas5p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Op 27-07-18 om 12:12 schreef Satendra Singh Thakur:
> Following changes are done to this func:
> 1. Currently there are many redundant error checks for
> count_connectors, mode, fb and mode_valid.
> if (crtc_req->mode_valid)
> if (crtc_req->count_connectors == 0 && mode)
> if (crtc_req->count_connectors > 0 && (!mode || !fb))
> if (crtc_req->count_connectors > 0)
> if (crtc_req->count_connectors > config->num_connector)
>
> These 5 checks are replaced by just 2 checks.
> if (!crtc_req->mode_valid)
> if (!crtc_req->count_connectors ||
> crtc_req->count_connectors > config->num_connector)

>
> 2. Also, currently, if user pass invalid args
> count_connectors=0, mode=NULL, fb=NULL, code wont throw
> any errors and eventually __drm_mode_set_config_internal
> will be called.
> With the modified code, this will be taken care.
>
> 3. Also, these error checks alongwith following
> if (!file_priv->aspect_ratio_allowed &&
> (crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK)
>
> has been  moved  before taking mutex and modeset lock
> because they don't need any lock. Moreover, after grabbing locks,
> if its found that user supplied  invalid args, it will
> be too late as getting lock may require considerable time.
>
> 4. Also, if modeset_lock is tried many times in case of EDEADLK
> error, then this will be the code flow
>
> retry:
> 	ret = drm_modeset_lock_all_ctx(crtc->dev, &ctx);
>
> if (ret)-->this is true
> 		goto out;
>
> out:
> 	if (fb)
> 	if (connector_set)
> 	drm_mode_destroy(dev, mode);
> 	if (ret == -EDEADLK)
> 		goto retry;
> It can be observed that checks on fb, connector_set and call to
> mode_destroy are redundant in retry-case.
> If we keep if (ret == -EDEADLK) just after out:,
> that will avoid redundant checks.
>
> In the normal case (non-retry), all checks will be required.
> Thus shifting of if (ret == -EDEADLK) right after out label
> won't affect normal case.
>
> 5. Also, kfree is moved inside if (connector_set).
> 6. Also, if major error checks are in the beginning of the func
> and if user supplied invalid params,  we will exit the func sooner
> without wasting much effort in finding crtc and framebuffer etc.
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> ---
>  drivers/gpu/drm/drm_crtc.c | 207 +++++++++++++++++++++------------------------
>  1 file changed, 98 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 98a36e6..15927e7 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -578,7 +578,25 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	 */
>  	if (crtc_req->x & 0xffff0000 || crtc_req->y & 0xffff0000)
>  		return -ERANGE;
> -
> +	if (!file_priv->aspect_ratio_allowed &&
> +		(crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK) !=
> +		DRM_MODE_FLAG_PIC_AR_NONE) {
> +		DRM_DEBUG_KMS("Unexpected aspect-ratio flag bits\n");
> +		return -EINVAL;
> +	}
> +	/* Check if the flag is set*/
> +	if (!crtc_req->mode_valid) {
> +		DRM_DEBUG_KMS("mode_valid flag [%d] is not set\n",
> +		crtc_req->mode_valid);
> +		return -EINVAL;
> +	}
It is allowed to pass crtc_id, mode_valid = false and count_connectors == 0, you're missing this check now.
It's used to disable a crtc:

https://cgit.freedesktop.org/drm/igt-gpu-tools/tree/lib/igt_kms.c#n1452


> +	/* Check the validity of count_connectors supplied by user */
> +	if (!crtc_req->count_connectors ||
> +		crtc_req->count_connectors > config->num_connector) {
> +		DRM_DEBUG_KMS("Invalid connectors' count %d\n",
> +		crtc_req->count_connectors);
> +		return -EINVAL;
> +	}
>  	crtc = drm_crtc_find(dev, file_priv, crtc_req->crtc_id);
>  	if (!crtc) {
>  		DRM_DEBUG_KMS("Unknown CRTC ID %d\n", crtc_req->crtc_id);
> @@ -595,134 +613,105 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	if (ret)
>  		goto out;
>  
> -	if (crtc_req->mode_valid) {
> -		/* If we have a mode we need a framebuffer. */
> -		/* If we pass -1, set the mode with the currently bound fb */
> -		if (crtc_req->fb_id == -1) {
> -			struct drm_framebuffer *old_fb;
> +	/* If we have a mode we need a framebuffer. */
> +	/* If we pass -1, set the mode with the currently bound fb */
> +	if (crtc_req->fb_id == -1) {
> +		struct drm_framebuffer *old_fb;
>  
> -			if (plane->state)
> -				old_fb = plane->state->fb;
> -			else
> -				old_fb = plane->fb;
> +		if (plane->state)
> +			old_fb = plane->state->fb;
> +		else
> +			old_fb = plane->fb;
>  
> -			if (!old_fb) {
> -				DRM_DEBUG_KMS("CRTC doesn't have current FB\n");
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -
> -			fb = old_fb;
> -			/* Make refcounting symmetric with the lookup path. */
> -			drm_framebuffer_get(fb);
> -		} else {
> -			fb = drm_framebuffer_lookup(dev, file_priv, crtc_req->fb_id);
> -			if (!fb) {
> -				DRM_DEBUG_KMS("Unknown FB ID%d\n",
> -						crtc_req->fb_id);
> -				ret = -ENOENT;
> -				goto out;
> -			}
> -		}
> -
> -		mode = drm_mode_create(dev);
> -		if (!mode) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -		if (!file_priv->aspect_ratio_allowed &&
> -		    (crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK) != DRM_MODE_FLAG_PIC_AR_NONE) {
> -			DRM_DEBUG_KMS("Unexpected aspect-ratio flag bits\n");
> +		if (!old_fb) {
> +			DRM_DEBUG_KMS("CRTC doesn't have current FB\n");
>  			ret = -EINVAL;
>  			goto out;
>  		}
>  
> -
> -		ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
> -		if (ret) {
> -			DRM_DEBUG_KMS("Invalid mode\n");
> +		fb = old_fb;
> +		/* Make refcounting symmetric with the lookup path. */
> +		drm_framebuffer_get(fb);
> +	} else {
> +		fb = drm_framebuffer_lookup(dev, file_priv, crtc_req->fb_id);
> +		if (!fb) {
> +			DRM_DEBUG_KMS("Unknown FB ID%d\n",
> +					crtc_req->fb_id);
> +			ret = -ENOENT;
>  			goto out;
>  		}
> -
> -		/*
> -		 * Check whether the primary plane supports the fb pixel format.
> -		 * Drivers not implementing the universal planes API use a
> -		 * default formats list provided by the DRM core which doesn't
> -		 * match real hardware capabilities. Skip the check in that
> -		 * case.
> -		 */
> -		if (!plane->format_default) {
> -			ret = drm_plane_check_pixel_format(plane,
> -							   fb->format->format,
> -							   fb->modifier);
> -			if (ret) {
> -				struct drm_format_name_buf format_name;
> -				DRM_DEBUG_KMS("Invalid pixel format %s, modifier 0x%llx\n",
> -					      drm_get_format_name(fb->format->format,
> -								  &format_name),
> -					      fb->modifier);
> -				goto out;
> -			}
> -		}
> -
> -		ret = drm_crtc_check_viewport(crtc, crtc_req->x, crtc_req->y,
> -					      mode, fb);
> -		if (ret)
> -			goto out;
> -
>  	}
>  
> -	if (crtc_req->count_connectors == 0 && mode) {
> -		DRM_DEBUG_KMS("Count connectors is 0 but mode set\n");
> -		ret = -EINVAL;
> +	mode = drm_mode_create(dev);
> +	if (!mode) {
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
> -		DRM_DEBUG_KMS("Count connectors is %d but no mode or fb set\n",
> -			  crtc_req->count_connectors);
> -		ret = -EINVAL;
> +	ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
> +	if (ret) {
> +		DRM_DEBUG_KMS("Invalid mode\n");
>  		goto out;
>  	}
>  
> -	if (crtc_req->count_connectors > 0) {
> -		u32 out_id;
> +	/*
> +	 * Check whether the primary plane supports the fb pixel format.
> +	 * Drivers not implementing the universal planes API use a
> +	 * default formats list provided by the DRM core which doesn't
> +	 * match real hardware capabilities. Skip the check in that
> +	 * case.
> +	 */
> +	if (!plane->format_default) {
> +		ret = drm_plane_check_pixel_format(plane,
> +						   fb->format->format,
> +						   fb->modifier);
> +		if (ret) {
> +			struct drm_format_name_buf format_name;
>  
> -		/* Avoid unbounded kernel memory allocation */
> -		if (crtc_req->count_connectors > config->num_connector) {
> -			ret = -EINVAL;
> +			DRM_DEBUG_KMS("Invalid pixel format %s, modifier 0x%llx\n",
> +				      drm_get_format_name(fb->format->format,
> +							  &format_name),
> +				      fb->modifier);
>  			goto out;
>  		}
> +	}
>  
> -		connector_set = kmalloc_array(crtc_req->count_connectors,
> +	ret = drm_crtc_check_viewport(crtc, crtc_req->x, crtc_req->y,
> +				      mode, fb);
> +	if (ret)
> +		goto out;
> +
> +	connector_set = kmalloc_array(crtc_req->count_connectors,
>  					      sizeof(struct drm_connector *),
>  					      GFP_KERNEL);
> -		if (!connector_set) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> +	if (!connector_set) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
> -		for (i = 0; i < crtc_req->count_connectors; i++) {
> -			connector_set[i] = NULL;
> -			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
> -			if (get_user(out_id, &set_connectors_ptr[i])) {
> -				ret = -EFAULT;
> -				goto out;
> -			}
> +	for (i = 0; i < crtc_req->count_connectors; i++) {
> +		u32 out_id;
>  
> -			connector = drm_connector_lookup(dev, file_priv, out_id);
> -			if (!connector) {
> -				DRM_DEBUG_KMS("Connector id %d unknown\n",
> -						out_id);
> -				ret = -ENOENT;
> -				goto out;
> -			}
> -			DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
> -					connector->base.id,
> -					connector->name);
> +		connector_set[i] = NULL;
> +		set_connectors_ptr =
> +		(uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
> +		if (get_user(out_id, &set_connectors_ptr[i])) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
>  
> -			connector_set[i] = connector;
> +		connector = drm_connector_lookup(dev, file_priv, out_id);
> +		if (!connector) {
> +			DRM_DEBUG_KMS("Connector id %d unknown\n",
> +					out_id);
> +			ret = -ENOENT;
> +			goto out;
>  		}
> +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
> +				connector->base.id,
> +				connector->name);
> +
> +		connector_set[i] = connector;
>  	}
>  
>  	set.crtc = crtc;
> @@ -735,6 +724,11 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	ret = __drm_mode_set_config_internal(&set, &ctx);
>  
>  out:
> +	if (ret == -EDEADLK) {
> +		ret = drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry;
> +	}
>  	if (fb)
>  		drm_framebuffer_put(fb);
>  
> @@ -743,14 +737,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  			if (connector_set[i])
>  				drm_connector_put(connector_set[i]);
>  		}
> +		kfree(connector_set);
>  	}
> -	kfree(connector_set);
>  	drm_mode_destroy(dev, mode);
> -	if (ret == -EDEADLK) {
> -		ret = drm_modeset_backoff(&ctx);
> -		if (!ret)
> -			goto retry;
> -	}
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
>  	mutex_unlock(&crtc->dev->mode_config.mutex);


