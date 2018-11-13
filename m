Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1BDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710A320684
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710A320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeKMUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:20:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44066 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeKMUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:20:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2E5C020726; Tue, 13 Nov 2018 11:22:49 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1F7A20714;
        Tue, 13 Nov 2018 11:22:48 +0100 (CET)
Date:   Tue, 13 Nov 2018 11:22:49 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 3/4] drm/v3d: Clean up the reservation object setup.
Message-ID: <20181113112249.532ed593@bbrezillon>
In-Reply-To: <20181108161654.19888-4-eric@anholt.net>
References: <20181108161654.19888-1-eric@anholt.net>
        <20181108161654.19888-4-eric@anholt.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 08:16:53 -0800
Eric Anholt <eric@anholt.net> wrote:

> The extra to_v3d_bo() calls came from copying this from the vc4
> driver, which stored the cma gem object in the structs.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index b88c96911453..d0dfdcbbd42c 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -214,10 +214,8 @@ v3d_attach_object_fences(struct v3d_exec_info *exec)
>  	int i;
>  
>  	for (i = 0; i < exec->bo_count; i++) {
> -		bo = to_v3d_bo(&exec->bo[i]->base);
> -
>  		/* XXX: Use shared fences for read-only objects. */
> -		reservation_object_add_excl_fence(bo->resv, out_fence);
> +		reservation_object_add_excl_fence(exec->bo[i]->resv, out_fence);
>  	}
>  }
>  
> @@ -228,11 +226,8 @@ v3d_unlock_bo_reservations(struct drm_device *dev,
>  {
>  	int i;
>  
> -	for (i = 0; i < exec->bo_count; i++) {
> -		struct v3d_bo *bo = to_v3d_bo(&exec->bo[i]->base);
> -
> -		ww_mutex_unlock(&bo->resv->lock);
> -	}
> +	for (i = 0; i < exec->bo_count; i++)
> +		ww_mutex_unlock(&exec->bo[i]->resv->lock);
>  
>  	ww_acquire_fini(acquire_ctx);
>  }
> @@ -251,13 +246,13 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>  {
>  	int contended_lock = -1;
>  	int i, ret;
> -	struct v3d_bo *bo;
>  
>  	ww_acquire_init(acquire_ctx, &reservation_ww_class);
>  
>  retry:
>  	if (contended_lock != -1) {
> -		bo = to_v3d_bo(&exec->bo[contended_lock]->base);
> +		struct v3d_bo *bo = exec->bo[contended_lock];
> +
>  		ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
>  						       acquire_ctx);
>  		if (ret) {
> @@ -270,19 +265,16 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>  		if (i == contended_lock)
>  			continue;
>  
> -		bo = to_v3d_bo(&exec->bo[i]->base);
> -
> -		ret = ww_mutex_lock_interruptible(&bo->resv->lock, acquire_ctx);
> +		ret = ww_mutex_lock_interruptible(&exec->bo[i]->resv->lock,
> +						  acquire_ctx);
>  		if (ret) {
>  			int j;
>  
> -			for (j = 0; j < i; j++) {
> -				bo = to_v3d_bo(&exec->bo[j]->base);
> -				ww_mutex_unlock(&bo->resv->lock);
> -			}
> +			for (j = 0; j < i; j++)
> +				ww_mutex_unlock(&exec->bo[j]->resv->lock);
>  
>  			if (contended_lock != -1 && contended_lock >= i) {
> -				bo = to_v3d_bo(&exec->bo[contended_lock]->base);
> +				struct v3d_bo *bo = exec->bo[contended_lock];
>  
>  				ww_mutex_unlock(&bo->resv->lock);
>  			}
> @@ -303,9 +295,7 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>  	 * before we commit the CL to the hardware.
>  	 */
>  	for (i = 0; i < exec->bo_count; i++) {
> -		bo = to_v3d_bo(&exec->bo[i]->base);
> -
> -		ret = reservation_object_reserve_shared(bo->resv, 1);
> +		ret = reservation_object_reserve_shared(exec->bo[i]->resv, 1);
>  		if (ret) {
>  			v3d_unlock_bo_reservations(dev, exec, acquire_ctx);
>  			return ret;

