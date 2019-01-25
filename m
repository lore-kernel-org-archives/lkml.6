Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75BDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E9C218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfAYOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:50:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52575 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfAYOug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:50:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7B6E720742; Fri, 25 Jan 2019 15:50:33 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 282A720397;
        Fri, 25 Jan 2019 15:50:23 +0100 (CET)
Message-ID: <0d136757267f4457527838065a5bf60fd6781835.camel@bootlin.com>
Subject: Re: [PATCH v3 1/4] drm/vc4: Wait for display list synchronization
 when completing commit
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Fri, 25 Jan 2019 15:50:23 +0100
In-Reply-To: <87d0onussr.fsf@anholt.net>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
         <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
         <87d0onussr.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-01-23 at 10:34 -0800, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > During an atomic commit, the HVS is configured with a display list
> > for the channel matching the associated CRTC. The Pixel Valve (CRTC)
> > and encoder are also configured for the new setup at that time.
> > While the Pixel Valve and encoder are reconfigured synchronously, the
> > HVS is only reconfigured after the display list address (DISPLIST) has
> > been updated to the current display list address (DISPLACTX), which is
> > the responsibility of the hardware.
> > 
> > The time frame during which the HVS is still running on its previous
> > configuration but the CRTC and encoder have been reconfigured already
> > can lead to a number of synchronization issues. They will eventually
> > cause errors reported on the FIFOs, such as underruns.
> > 
> > With underrun detection enabled (from Boris Brezillon's series), this
> > leads to unreliable underrun detection with random false positives.
> > 
> > To ensure a coherent state, wait for each enabled channel of the HVS
> > to synchronize its current display list address. This fixes the issue
> > of random underrun reporting on commits.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
> >  drivers/gpu/drm/vc4/vc4_hvs.c  | 17 +++++++++++++++++
> >  drivers/gpu/drm/vc4/vc4_kms.c  |  2 ++
> >  drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
> >  4 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> > index c24b078f0593..955f157f5ad0 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.h
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> > @@ -772,6 +772,7 @@ void vc4_irq_reset(struct drm_device *dev);
> >  extern struct platform_driver vc4_hvs_driver;
> >  void vc4_hvs_dump_state(struct drm_device *dev);
> >  int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> > +void vc4_hvs_sync_dlist(struct drm_device *dev);
> >  
> >  /* vc4_kms.c */
> >  int vc4_kms_load(struct drm_device *dev);
> > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> > index 5d8c749c9749..1ba60b8e0c2d 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> > @@ -166,6 +166,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_hvs *hvs,
> >  	return 0;
> >  }
> >  
> > +void vc4_hvs_sync_dlist(struct drm_device *dev)
> > +{
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	for (i = 0; i < SCALER_CHANNELS_COUNT; i++) {
> > +		if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
> > +			continue;
> > +
> > +		ret = wait_for(HVS_READ(SCALER_DISPLACTX(i)) ==
> > +			       HVS_READ(SCALER_DISPLISTX(i)), 1000);
> > +		WARN(ret, "Timeout waiting for channel %d display list sync\n",
> > +		     i);
> > +	}
> > +}
> > +
> >  static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> > diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> > index 0490edb192a1..2d66a2b57a91 100644
> > --- a/drivers/gpu/drm/vc4/vc4_kms.c
> > +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> > @@ -155,6 +155,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
> >  
> >  	drm_atomic_helper_commit_hw_done(state);
> >  
> > +	vc4_hvs_sync_dlist(dev);
> > +
> >  	drm_atomic_helper_wait_for_flip_done(dev, state);
> 
> wait_for_flip_done should already be waiting for DISPLACTX to match our
> crtc's display list, though, right (see vc4_crtc_handle_page_flip())?
> This seems like a no-op to me.

Right, at this stage it's pretty much a no-op. It does make a
difference when bringing-in vc4_hvs_unmask_underrun, because this
vc4_hvs_sync_dlist call comes before it.

When the display lists are not yet synchronized (and differ), an
underrun occurs so it will be reported although it's not related to the
new display list configuration. Waiting for the display lists to sync
before unmasking the interrupt prevents that.

I think waiting for the page flip to unmask the underrun interrupt
would be too late because the HVS should have finished processing the
new dlist by then (but maybe I'm mistaken about that), so we would miss
the underrun indication.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

