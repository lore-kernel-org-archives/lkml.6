Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B0BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C9020652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C9020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJHU6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:58:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46480 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJHU6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:58:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A07E6208F4; Mon,  8 Oct 2018 15:46:10 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6927D207F3;
        Mon,  8 Oct 2018 15:46:00 +0200 (CEST)
Date:   Mon, 8 Oct 2018 15:46:01 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/v3d: Fix a use-after-free race accessing the
 scheduler's fences.
Message-ID: <20181008154601.21077f67@bbrezillon>
In-Reply-To: <20180928232126.4332-1-eric@anholt.net>
References: <20180928232126.4332-1-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 16:21:23 -0700
Eric Anholt <eric@anholt.net> wrote:

> Once we push the job, the scheduler could run it and free it.  So, if
> we want to reference their fences, we need to grab them before then.
> I haven't seen this happen in many days of conformance test runtime,
> but let's still close the race.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.h | 5 +++++
>  drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 5042573e97f4..83c55ab6e1c0 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -204,6 +204,11 @@ struct v3d_exec_info {
>  	 */
>  	struct dma_fence *bin_done_fence;
>  
> +	/* Fence for when the scheduler considers the render to be
> +	 * done, for when the BOs reservations should be complete.
> +	 */
> +	struct dma_fence *render_done_fence;
> +
>  	struct kref refcount;
>  
>  	/* This is the array of BOs that were looked up at the start of exec. */
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index e1fcbb4cd0ae..c98fbfbdb68e 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -209,7 +209,7 @@ v3d_flush_caches(struct v3d_dev *v3d)
>  static void
>  v3d_attach_object_fences(struct v3d_exec_info *exec)
>  {
> -	struct dma_fence *out_fence = &exec->render.base.s_fence->finished;
> +	struct dma_fence *out_fence = exec->render_done_fence;
>  	struct v3d_bo *bo;
>  	int i;
>  
> @@ -409,6 +409,7 @@ v3d_exec_cleanup(struct kref *ref)
>  	dma_fence_put(exec->render.done_fence);
>  
>  	dma_fence_put(exec->bin_done_fence);
> +	dma_fence_put(exec->render_done_fence);
>  
>  	for (i = 0; i < exec->bo_count; i++)
>  		drm_gem_object_put_unlocked(&exec->bo[i]->base);
> @@ -574,6 +575,9 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  	if (ret)
>  		goto fail_unreserve;
>  
> +	exec->render_done_fence =
> +		dma_fence_get(&exec->render.base.s_fence->finished);
> +
>  	kref_get(&exec->refcount); /* put by scheduler job completion */
>  	drm_sched_entity_push_job(&exec->render.base,
>  				  &v3d_priv->sched_entity[V3D_RENDER]);
> @@ -587,7 +591,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  	sync_out = drm_syncobj_find(file_priv, args->out_sync);
>  	if (sync_out) {
>  		drm_syncobj_replace_fence(sync_out,
> -					  &exec->render.base.s_fence->finished);
> +					  exec->render_done_fence);
>  		drm_syncobj_put(sync_out);
>  	}
>  

