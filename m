Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEDJi5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:38:57 -0400
Received: from foss.arm.com ([217.140.101.70]:51576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEDJi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:38:56 -0400
Date: Fri, 4 May 2018 10:38:54 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/kms/mode: added a new helper for calculating
 videomode from crtc's display mode
Message-ID: <20180504093854.GJ1027@e110455-lin.cambridge.arm.com>
References: <1525419600-1774-1-git-send-email-satendra.t@samsung.com>
 <CGME20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a@epcas5p4.samsung.com>
 <1525424523-3367-1-git-send-email-satendra.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525424523-3367-1-git-send-email-satendra.t@samsung.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:32:03PM +0530, Satendra Singh Thakur wrote:
> On Thu, May 03, 2018 at 11:36:39 +0100, Liviu Dudau wrote:
> > On Thu, May 03, 2018 at 11:28:37AM +0530, Satendra Singh Thakur wrote:
> > > 1.
> > > -Added a new helper drm_display_mode_crtc_to_videomode
> > > -This helper calculates mode parameters like
> > >   horizontal front_porch, back_porch, sync length
> > >   vertical front_porch, back_porch, sync length
> > >   using crtc_* fields of struct drm_display_mode
> > > -It uses following fields of crtc mode
> > >  horizontal sync start/end, active and total length
> > >  vertical sync start/end, active and total length
> > > 2.
> > > -Most of the driver use user-supplied mode for calculating videomode
> > > -However, few drivers use HW (crtc) mode for calculating videomode
> > > -This helper will be useful for such drivers
> > > 3.
> > > -Currently following drivers will be using this new helper
> > > -arm hdlcd
> > > -atmel hlcdc
> > > -exynos 5433 decon
> > > -exynos7 decon
> > > -exynos fimd
> > > 4.
> > > -This patch removes related duplicate code from above mentioned drivers
> > > 
> > > Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> > > Cc: Madhur Verma <madhur.verma@samsung.com>
> > > Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> > > ---
> > >  drivers/gpu/drm/arm/hdlcd_crtc.c               |  8 +-------
> > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  7 +------
> > >  drivers/gpu/drm/drm_modes.c                    | 20 ++++++++++++++++++++
> > >  drivers/gpu/drm/exynos/exynos5433_drm_decon.c  | 22 ++++++++++------------
> > >  drivers/gpu/drm/exynos/exynos7_drm_decon.c     | 23 ++++++++++-------------
> > >  drivers/gpu/drm/exynos/exynos_drm_fimd.c       | 22 +++++++++-------------
> > >  include/drm/drm_modes.h                        |  2 ++
> > >  7 files changed, 53 insertions(+), 51 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > > index cf5cbd6..d20e471 100644
> > > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > > @@ -130,13 +130,7 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> > >  	struct videomode vm;
> > >  	unsigned int polarities, err;
> > >  
> > > -	vm.vfront_porch = m->crtc_vsync_start - m->crtc_vdisplay;
> > > -	vm.vback_porch = m->crtc_vtotal - m->crtc_vsync_end;
> > > -	vm.vsync_len = m->crtc_vsync_end - m->crtc_vsync_start;
> > > -	vm.hfront_porch = m->crtc_hsync_start - m->crtc_hdisplay;
> > > -	vm.hback_porch = m->crtc_htotal - m->crtc_hsync_end;
> > > -	vm.hsync_len = m->crtc_hsync_end - m->crtc_hsync_start;
> > > -
> > > +	drm_display_mode_crtc_to_videomode(m, &vm);
> > >  	polarities = HDLCD_POLARITY_DATAEN | HDLCD_POLARITY_DATA;
> > >  
> > >  	if (m->flags & DRM_MODE_FLAG_PHSYNC)
> >
> > For the HDLCD part:
> > 
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> > 
> > If you're not sending the final version through drm-misc then let me
> > know and I can pick up the HDLCD part separately.
> >
> > Best regards,
> > Liviu
> >
> >
> 
> Hi Mr Liviu,
> Thanks for accepting the patch.
> I don't know how to send patch through drm-misc.
> You may please go ahead and pick HDLCD part separately.

Lets wait for the maintainers of other drivers to give their ACKs and
then we'll sort out the submission. Usually it is just a matter of
asking for the patch to be pulled from the relevant people. For drm-misc
there are quite a few people and with enough patches accepted others can
join too. I'll just put here some names, in no particular order, that
you can ask for the patch to be pulled.

Gustavo Padovan <gustavo@padovan.org>
Daniel Stone <daniel@fooishbar.org>
Eric Anholt <eric@anholt.net>
Jani Nikula <jani.nikula@intel.com>
Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Sean Paul <seanpaul@chromium.org>
Daniel Vetter <daniel.vetter@intel.com>

Best regards,
Liviu

> 
> Thanks
> -Satendra

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
