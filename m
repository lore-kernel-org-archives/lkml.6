Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D4DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3647A2403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3647A2403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeGEK7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:59:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53675 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbeGEK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:59:11 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fb1yd-0006uu-KP; Thu, 05 Jul 2018 12:59:07 +0200
Message-ID: <1530788347.15725.2.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] drm/v3d: Delay the scheduler timeout if we're still
 making progress.
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 05 Jul 2018 12:59:07 +0200
In-Reply-To: <20180703170515.6298-1-eric@anholt.net>
References: <20180703170515.6298-1-eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 03.07.2018, 10:05 -0700 schrieb Eric Anholt:
> GTF-GLES2.gtf.GL.acos.acos_float_vert_xvary submits jobs that take 4
> seconds at maximum resolution, but we still want to reset quickly if a
> job is really hung.  Sample the CL's current address and the return
> address (since we call into tile lists repeatedly) and if either has
> changed then assume we've made progress.

So this means you are doubling your timeout? AFAICS for the first time
you hit the timeout handler the cached ctca and ctra values will
probably always differ from the current values. Maybe this warrants a
mention in the commit message, as it's changing the behavior of the
scheduler timeout.

Also how easy is it for userspace to construct such an infinite loop in
the CL? Thinking about a rogue client DoSing the GPU while exploiting
this check in the timeout handler to stay under the radar...

Regards,
Lucas

> Signed-off-by: Eric Anholt <eric@anholt.net>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/v3d/v3d_drv.h   |  2 ++
>  drivers/gpu/drm/v3d/v3d_regs.h  |  1 +
>  drivers/gpu/drm/v3d/v3d_sched.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index f546e0ab9562..a5d96d823416 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -189,6 +189,8 @@ struct v3d_job {
>  
> >  	/* GPU virtual addresses of the start/end of the CL job. */
> >  	u32 start, end;
> +
> > +	u32 timedout_ctca, timedout_ctra;
>  };
>  
>  struct v3d_exec_info {
> diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
> index fc13282dfc2f..854046565989 100644
> --- a/drivers/gpu/drm/v3d/v3d_regs.h
> +++ b/drivers/gpu/drm/v3d/v3d_regs.h
> @@ -222,6 +222,7 @@
>  #define V3D_CLE_CTNCA(n) (V3D_CLE_CT0CA + 4 * n)
>  #define V3D_CLE_CT0RA                                  0x00118
>  #define V3D_CLE_CT1RA                                  0x0011c
> +#define V3D_CLE_CTNRA(n) (V3D_CLE_CT0RA + 4 * n)
>  #define V3D_CLE_CT0LC                                  0x00120
>  #define V3D_CLE_CT1LC                                  0x00124
>  #define V3D_CLE_CT0PC                                  0x00128
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 808bc901f567..00667c733dca 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -153,7 +153,25 @@ v3d_job_timedout(struct drm_sched_job *sched_job)
> >  	struct v3d_job *job = to_v3d_job(sched_job);
> >  	struct v3d_exec_info *exec = job->exec;
> >  	struct v3d_dev *v3d = exec->v3d;
> > +	enum v3d_queue job_q = job == &exec->bin ? V3D_BIN : V3D_RENDER;
> >  	enum v3d_queue q;
> > +	u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(job_q));
> > +	u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(job_q));
> +
> > +	/* If the current address or return address have changed, then
> > +	 * the GPU has probably made progress and we should delay the
> > +	 * reset.  This could fail if the GPU got in an infinite loop
> > +	 * in the CL, but that is pretty unlikely outside of an i-g-t
> > +	 * testcase.
> > +	 */
> > +	if (job->timedout_ctca != ctca || job->timedout_ctra != ctra) {
> > +		job->timedout_ctca = ctca;
> > +		job->timedout_ctra = ctra;
> +
> > +		schedule_delayed_work(&job->base.work_tdr,
> > +				      job->base.sched->timeout);
> > +		return;
> > +	}
>  
> >  	mutex_lock(&v3d->reset_lock);
>  
