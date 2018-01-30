Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeA3Jey (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:34:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52877 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeA3Jeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:34:50 -0500
X-Google-Smtp-Source: AH8x224FPLpvr9MSVqSHIHZhPldzjAlb9KzkKWq6MRCrj0oJXBh2R6nxNnz/mmb2Ec3R8zsOOAIchA==
Date: Tue, 30 Jan 2018 10:34:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Keith Packard <keithp@keithp.com>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Check for lessee in DROP_MASTER ioctl
Message-ID: <20180130093447.GG25930@phenom.ffwll.local>
Mail-Followup-To: Keith Packard <keithp@keithp.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <20180119015159.1606-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119015159.1606-1-keithp@keithp.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 05:51:59PM -0800, Keith Packard wrote:
> Don't let a lessee control what the current DRM master is set to;
> that's the job of the "real" master. Otherwise, the lessee would
> disable all access to master operations for the owner and all lessees
> under it.
> 
> This matches the same check made in the SET_MASTER ioctl.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>

Similar check for setmaster already exists, so looks all good. Do we have
an igt for all this? Iirc there was one floating around, but no idea
what's the status. Might also be good to resubmit them so i915 CI can run
the tests (now that the code has landed).

On the patch itself, minus lack of testcases:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_auth.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index aad468d170a7..d9c0f7573905 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -230,6 +230,12 @@ int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
>  	if (!dev->master)
>  		goto out_unlock;
>  
> +	if (file_priv->master->lessor != NULL) {
> +		DRM_DEBUG_LEASE("Attempt to drop lessee %d as master\n", file_priv->master->lessee_id);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	ret = 0;
>  	drm_drop_master(dev, file_priv);
>  out_unlock:
> -- 
> 2.15.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
