Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E986601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeFFIqo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:46:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49107 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932423AbeFFIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:46:42 -0400
Message-ID: <1528274797.26063.6.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] drm/v3d: Take a lock across GPU scheduler job
 creation and queuing.
From: Lucas Stach <l.stach@pengutronix.de>
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Date: Wed, 06 Jun 2018 10:46:37 +0200
In-Reply-To: <20180605190302.18279-1-eric@anholt.net>
References: <20180605190302.18279-1-eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 05.06.2018, 12:03 -0700 schrieb Eric Anholt:
> Between creation and queueing of a job, you need to prevent any other
> job from being created and queued.  Otherwise the scheduler's fences
> may be signaled out of seqno order.
> 
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> ---
> 
> ccing amd-gfx due to interaction of this series with the scheduler.
> 
>  drivers/gpu/drm/v3d/v3d_drv.h |  5 +++++
>  drivers/gpu/drm/v3d/v3d_gem.c | 11 +++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index a043ac3aae98..26005abd9c5d 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -85,6 +85,11 @@ struct v3d_dev {
> >  	 */
> >  	struct mutex reset_lock;
>  
> > +	/* Lock taken when creating and pushing the GPU scheduler
> > +	 * jobs, to keep the sched-fence seqnos in order.
> > +	 */
> > +	struct mutex sched_lock;
> +
> >  	struct {
> >  		u32 num_allocated;
> >  		u32 pages_allocated;
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index b513f9189caf..9ea83bdb9a30 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -550,13 +550,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >  	if (ret)
> >  		goto fail;
>  
> > +	mutex_lock(&v3d->sched_lock);
> >  	if (exec->bin.start != exec->bin.end) {
> >  		ret = drm_sched_job_init(&exec->bin.base,
> >  					 &v3d->queue[V3D_BIN].sched,
> >  					 &v3d_priv->sched_entity[V3D_BIN],
> >  					 v3d_priv);
> > -		if (ret)
> > +		if (ret) {
> > +			mutex_unlock(&v3d->sched_lock);
>  			goto fail_unreserve;

I don't see any path where you would go to fail_unreserve with the
mutex not yet locked, so you could just fold the mutex_unlock into this
error path for a bit less code duplication.

Otherwise this looks fine.

Regards,
Lucas

> +		}
>  
> >  		exec->bin_done_fence =
> >  			dma_fence_get(&exec->bin.base.s_fence->finished);
> @@ -570,12 +573,15 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >  				 &v3d->queue[V3D_RENDER].sched,
> >  				 &v3d_priv->sched_entity[V3D_RENDER],
> >  				 v3d_priv);
> > -	if (ret)
> > +	if (ret) {
> > +		mutex_unlock(&v3d->sched_lock);
> >  		goto fail_unreserve;
> > +	}
>  
> >  	kref_get(&exec->refcount); /* put by scheduler job completion */
> >  	drm_sched_entity_push_job(&exec->render.base,
> >  				  &v3d_priv->sched_entity[V3D_RENDER]);
> > +	mutex_unlock(&v3d->sched_lock);
>  
> >  	v3d_attach_object_fences(exec);
>  
> @@ -615,6 +621,7 @@ v3d_gem_init(struct drm_device *dev)
> >  	spin_lock_init(&v3d->job_lock);
> >  	mutex_init(&v3d->bo_lock);
> >  	mutex_init(&v3d->reset_lock);
> > +	mutex_init(&v3d->sched_lock);
>  
> >  	/* Note: We don't allocate address 0.  Various bits of HW
> >  	 * treat 0 as special, such as the occlusion query counters
