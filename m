Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeEBHoV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:44:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38980 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeEBHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:44:20 -0400
X-Google-Smtp-Source: AB8JxZqDvrJedGLWFnxb45EF0bQGq5q9uDmxcP6QKXAESdWTuW10cR2i3XIe6mWc+r8jLudT9bi0Cw==
Date: Wed, 2 May 2018 09:44:17 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v3d: fixup for submit alignment and check for zero flags
 in other ioctls.
Message-ID: <20180502074416.GW12521@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20180430181058.30181-3-eric@anholt.net>
 <20180501175845.14837-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501175845.14837-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:58:45AM -0700, Eric Anholt wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> airlied + danvet: this is the last change I think we need before I can
> merge v3d with your acks.  Sending as a diff so you don't have to look
> at the whole thing again.  Look good?

Hm I thought I've checked all your ioctl and made sure you're checking for
0 everywhere ... I guess I was blind. Anyway, lgtm, ack still holds.
-Daniel

> 
>  drivers/gpu/drm/v3d/v3d_bo.c  | 10 ++++++++++
>  drivers/gpu/drm/v3d/v3d_gem.c |  5 +++++
>  include/uapi/drm/v3d_drm.h    |  3 +++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 2be4e8b71604..7b1e2a549a71 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -325,6 +325,11 @@ int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
>  	struct v3d_bo *bo = NULL;
>  	int ret;
>  
> +	if (args->flags != 0) {
> +		DRM_INFO("unknown create_bo flags: %d\n", args->flags);
> +		return -EINVAL;
> +	}
> +
>  	bo = v3d_bo_create(dev, file_priv, PAGE_ALIGN(args->size));
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
> @@ -344,6 +349,11 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
>  	struct drm_gem_object *gem_obj;
>  	int ret;
>  
> +	if (args->flags != 0) {
> +		DRM_INFO("unknown mmap_bo flags: %d\n", args->flags);
> +		return -EINVAL;
> +	}
> +
>  	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
>  	if (!gem_obj) {
>  		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index fa39a1e35263..b513f9189caf 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -503,6 +503,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  	struct drm_syncobj *sync_out;
>  	int ret = 0;
>  
> +	if (args->pad != 0) {
> +		DRM_INFO("pad must be zero: %d\n", args->pad);
> +		return -EINVAL;
> +	}
> +
>  	exec = kcalloc(1, sizeof(*exec), GFP_KERNEL);
>  	if (!exec)
>  		return -ENOMEM;
> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index 201a07645bdd..7b6627783608 100644
> --- a/include/uapi/drm/v3d_drm.h
> +++ b/include/uapi/drm/v3d_drm.h
> @@ -101,6 +101,9 @@ struct drm_v3d_submit_cl {
>  
>  	/* Number of BO handles passed in (size is that times 4). */
>  	__u32 bo_handle_count;
> +
> +	/* Pad, must be zero-filled. */
> +	__u32 pad;
>  };
>  
>  /**
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
