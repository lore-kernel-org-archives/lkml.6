Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9214AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C3F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bKjltQbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C3F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK2UlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:41:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39222 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2UlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:41:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so1309227edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tp8IF23/eAyu/YBYFhXCD31vr6/bITP0QCtfxdJcLfg=;
        b=bKjltQbAezI0cbNZnQXGhKpNsmWubePhg22dX5l8GgglztiVAjoKDdJPu2hBFyhEcQ
         giQlMz2mlksZOAUs3pZBHQSu8TcBqEkSVSrW8+aXdkrtKOWWcMNHlz47abtnyomDgMS9
         TMIQ+xq6ftm/IWzAyBRS9LvPNGw+/V5brCzUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Tp8IF23/eAyu/YBYFhXCD31vr6/bITP0QCtfxdJcLfg=;
        b=eDSEDOF5VNJZWkvR50LLXmWCEYQHi5wvT4pToF1KzYDFpxtE+chRRwCtysR4zkDgSg
         EgxQ2SdvZqEHUSttPADOAnvhPMWFpyZfM/7QbEl6bmKqjMm8gQzJHKhaXHI7JDHRjGyV
         Fr2A0YET+dLAYtBw0A4VHv4o6lDyCNXjeGg8j25DPg6pig4gISvjYqpNY3kJ/SNowQFU
         3W/i49iO4RgOZL1Ceyu43bIosjlTtBnX1uFnpMMQDIAoB+fPzdbr3moNEBPAfujl0kuj
         VFCHMBD0Y6HHjIDHNPUEJN1Dvit2tma8tFqIiZvWb788GhxGe8YljHE8urR7fYcFT6qs
         77VQ==
X-Gm-Message-State: AA+aEWYUgHb9riiDBzjt4jwfUSmhAqfIzNglafQ37dyAuaU6wxWG6aAD
        S+DfVml2I5sHk6zWjfwfO81z/w==
X-Google-Smtp-Source: AFSGD/USHKSxXkwc0o7cVyu/dE44xPoVsa/eIzRZJsO1fDNKleMOlriZAzgTN9XR94NEjdHvepEa6A==
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17-v6mr1024293ejh.148.1543484197222;
        Thu, 29 Nov 2018 01:36:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g40sm451963edg.39.2018.11.29.01.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 01:36:36 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:36:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Dave Emett <david.emett@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/v3d: Drop the "dev" argument to lock/unlock of
 BO reservations.
Message-ID: <20181129093634.GI21184@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org,
        Dave Emett <david.emett@broadcom.com>, linux-kernel@vger.kernel.org
References: <20181128230927.10951-1-eric@anholt.net>
 <20181128230927.10951-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128230927.10951-2-eric@anholt.net>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:09:26PM -0800, Eric Anholt wrote:
> They were unused, as Dave Emett noticed in TFU review.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Dave Emett <david.emett@broadcom.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 41cbe2cdad50..778657d9b6e7 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -219,8 +219,7 @@ v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
>  }
>  
>  static void
> -v3d_unlock_bo_reservations(struct drm_device *dev,
> -			   struct v3d_bo **bos,
> +v3d_unlock_bo_reservations(struct v3d_bo **bos,
>  			   int bo_count,
>  			   struct ww_acquire_ctx *acquire_ctx)
>  {
> @@ -240,8 +239,7 @@ v3d_unlock_bo_reservations(struct drm_device *dev,
>   * to v3d, so we don't attach dma-buf fences to them.
>   */
>  static int
> -v3d_lock_bo_reservations(struct drm_device *dev,
> -			 struct v3d_bo **bos,
> +v3d_lock_bo_reservations(struct v3d_bo **bos,
>  			 int bo_count,
>  			 struct ww_acquire_ctx *acquire_ctx)
>  {
> @@ -298,7 +296,7 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>  	for (i = 0; i < bo_count; i++) {
>  		ret = reservation_object_reserve_shared(bos[i]->resv, 1);
>  		if (ret) {
> -			v3d_unlock_bo_reservations(dev, bos, bo_count,
> +			v3d_unlock_bo_reservations(bos, bo_count,
>  						   acquire_ctx);
>  			return ret;
>  		}
> @@ -566,7 +564,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  	if (ret)
>  		goto fail;
>  
> -	ret = v3d_lock_bo_reservations(dev, exec->bo, exec->bo_count,
> +	ret = v3d_lock_bo_reservations(exec->bo, exec->bo_count,
>  				       &acquire_ctx);
>  	if (ret)
>  		goto fail;
> @@ -604,7 +602,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  	v3d_attach_object_fences(exec->bo, exec->bo_count,
>  				 exec->render_done_fence);
>  
> -	v3d_unlock_bo_reservations(dev, exec->bo, exec->bo_count, &acquire_ctx);
> +	v3d_unlock_bo_reservations(exec->bo, exec->bo_count, &acquire_ctx);
>  
>  	/* Update the return sync object for the */
>  	sync_out = drm_syncobj_find(file_priv, args->out_sync);
> @@ -620,7 +618,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  
>  fail_unreserve:
>  	mutex_unlock(&v3d->sched_lock);
> -	v3d_unlock_bo_reservations(dev, exec->bo, exec->bo_count, &acquire_ctx);
> +	v3d_unlock_bo_reservations(exec->bo, exec->bo_count, &acquire_ctx);
>  fail:
>  	v3d_exec_put(exec);
>  
> @@ -691,7 +689,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>  	}
>  	spin_unlock(&file_priv->table_lock);
>  
> -	ret = v3d_lock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
> +	ret = v3d_lock_bo_reservations(job->bo, bo_count, &acquire_ctx);
>  	if (ret)
>  		goto fail;
>  
> @@ -710,7 +708,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>  
>  	v3d_attach_object_fences(job->bo, bo_count, sched_done_fence);
>  
> -	v3d_unlock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
> +	v3d_unlock_bo_reservations(job->bo, bo_count, &acquire_ctx);
>  
>  	/* Update the return sync object */
>  	sync_out = drm_syncobj_find(file_priv, args->out_sync);
> @@ -726,7 +724,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
>  
>  fail_unreserve:
>  	mutex_unlock(&v3d->sched_lock);
> -	v3d_unlock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
> +	v3d_unlock_bo_reservations(job->bo, bo_count, &acquire_ctx);
>  fail:
>  	v3d_tfu_job_put(job);
>  
> -- 
> 2.20.0.rc1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
