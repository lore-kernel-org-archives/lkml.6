Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EMTqE9vuGFs9AQAAmS7hNA
	; Thu, 07 Jun 2018 08:37:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 409BB607F7; Thu,  7 Jun 2018 08:37:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A5ACC60452;
	Thu,  7 Jun 2018 08:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5ACC60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeFGIhn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:37:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40575 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeFGIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:37:39 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fQqQK-0006Na-9v; Thu, 07 Jun 2018 10:37:36 +0200
Message-ID: <1528360654.15027.2.camel@pengutronix.de>
Subject: Re: [PATCH 1/3 v2] drm/v3d: Take a lock across GPU scheduler job
 creation and queuing.
From: Lucas Stach <l.stach@pengutronix.de>
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Date: Thu, 07 Jun 2018 10:37:34 +0200
In-Reply-To: <20180606174851.12433-1-eric@anholt.net>
References: <1528274797.26063.6.camel@pengutronix.de>
         <20180606174851.12433-1-eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 06.06.2018, 10:48 -0700 schrieb Eric Anholt:
> Between creation and queueing of a job, you need to prevent any other
> job from being created and queued.  Otherwise the scheduler's fences
> may be signaled out of seqno order.
> 
> v2: move mutex unlock to the error label.
> 
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.h | 5 +++++
>  drivers/gpu/drm/v3d/v3d_gem.c | 4 ++++
>  2 files changed, 9 insertions(+)
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
> index b513f9189caf..269fe16379c0 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -550,6 +550,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >  	if (ret)
> >  		goto fail;
>  
> > +	mutex_lock(&v3d->sched_lock);
> >  	if (exec->bin.start != exec->bin.end) {
> >  		ret = drm_sched_job_init(&exec->bin.base,
> >  					 &v3d->queue[V3D_BIN].sched,
> @@ -576,6 +577,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >  	kref_get(&exec->refcount); /* put by scheduler job completion */
> >  	drm_sched_entity_push_job(&exec->render.base,
> >  				  &v3d_priv->sched_entity[V3D_RENDER]);
> > +	mutex_unlock(&v3d->sched_lock);
>  
> >  	v3d_attach_object_fences(exec);
>  
> @@ -594,6 +596,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >  	return 0;
>  
>  fail_unreserve:
> > +	mutex_unlock(&v3d->sched_lock);
> >  	v3d_unlock_bo_reservations(dev, exec, &acquire_ctx);
>  fail:
> >  	v3d_exec_put(exec);
> @@ -615,6 +618,7 @@ v3d_gem_init(struct drm_device *dev)
> >  	spin_lock_init(&v3d->job_lock);
> >  	mutex_init(&v3d->bo_lock);
> >  	mutex_init(&v3d->reset_lock);
> > +	mutex_init(&v3d->sched_lock);
>  
> >  	/* Note: We don't allocate address 0.  Various bits of HW
> >  	 * treat 0 as special, such as the occlusion query counters
