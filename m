Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeDTILL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:11:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44683 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbeDTILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:11:04 -0400
X-Google-Smtp-Source: AIpwx4/Dc1JWHduUCMJ+K2T05QYRHNfQHKc65I+g8sa8vPSP2oQb+doP4orlShRlOjYIWx+AXDlhJw==
Date: Fri, 20 Apr 2018 10:11:00 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCHv3 3/8] drm/omap: add support for manually updated displays
Message-ID: <20180420081100.GO31310@phenom.ffwll.local>
Mail-Followup-To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-omap@vger.kernel.org
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-4-sebastian.reichel@collabora.co.uk>
 <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 10:09:38AM +0300, Tomi Valkeinen wrote:
> Hi Sebastian,
> 
> On 30/03/18 20:18, Sebastian Reichel wrote:
> > This adds the required infrastructure for manually
> > updated displays, such as DSI command mode panels.
> > 
> > While those panels often support partial updates
> > we currently always do a full refresh. Display
> > will be refreshed when something calls the dirty
> > callback, such as libdrm's drmModeDirtyFB().
> > 
> > This is currently being implemented for the kernel
> > console and for Xorg. Weston currently does not
> > implement this and is known not to work on manually
> > updated displays.
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/gpu/drm/omapdrm/omap_crtc.c | 107 +++++++++++++++++++++++++++++++++---
> >  drivers/gpu/drm/omapdrm/omap_crtc.h |   1 +
> >  drivers/gpu/drm/omapdrm/omap_fb.c   |  20 +++++++
> >  3 files changed, 120 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
> > index b893985e4efb..1b91bff5bac6 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> > @@ -51,6 +51,7 @@ struct omap_crtc {
> >  	bool pending;
> >  	wait_queue_head_t pending_wait;
> >  	struct drm_pending_vblank_event *event;
> > +	struct delayed_work update_work;
> >  
> >  	void (*framedone_handler)(void *);
> >  	void *framedone_handler_data;
> > @@ -146,6 +147,25 @@ static void omap_crtc_dss_disconnect(struct omap_drm_private *priv,
> >  static void omap_crtc_dss_start_update(struct omap_drm_private *priv,
> >  				       enum omap_channel channel)
> >  {
> > +	priv->dispc_ops->mgr_enable(priv->dispc, channel, true);
> > +}
> > +
> > +static bool omap_crtc_is_manually_updated(struct drm_crtc *crtc)
> > +{
> > +	struct drm_connector *connector;
> > +	struct drm_connector_list_iter conn_iter;
> > +	bool result = false;
> > +
> > +	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
> > +	drm_for_each_connector_iter(connector, &conn_iter) {
> > +		if (connector->state->crtc != crtc)
> > +			continue;
> > +		result = omap_connector_get_manually_updated(connector);
> > +		break;
> > +	}
> > +	drm_connector_list_iter_end(&conn_iter);
> 
> It would be much nicer if the is-manual flag was somehow conveyed from
> connector/encoder to the crtc when doing modesetting. I don't know how
> or where, so just thinking out loud. However, if we need to do such loop
> as above, I think we should just do it once, perhaps in
> omap_crtc_atomic_enable, and store the value in omap_crtc's private data.

Do it in your atomic_check code, and store it as a omap private bit in
omap_crtc_state. That guarantees you that it's always up-to-date, and will
never change (except when you get a completely new state).

Recomputing derived state like this as part of your atomic_commit code
isn't recommended much.
-Daniel

> 
> > +
> > +	return result;
> >  }
> >  
> >  /* Called only from the encoder enable/disable and suspend/resume handlers. */
> > @@ -157,12 +177,17 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
> >  	enum omap_channel channel = omap_crtc->channel;
> >  	struct omap_irq_wait *wait;
> >  	u32 framedone_irq, vsync_irq;
> > +	bool is_manual = omap_crtc_is_manually_updated(crtc);
> > +	enum omap_display_type type = omap_crtc_output[channel]->output_type;
> >  	int ret;
> >  
> >  	if (WARN_ON(omap_crtc->enabled == enable))
> >  		return;
> >  
> > -	if (omap_crtc_output[channel]->output_type == OMAP_DISPLAY_TYPE_HDMI) {
> > +	if (is_manual)
> > +		omap_irq_enable_framedone(crtc, enable);
> > +
> > +	if (is_manual || type == OMAP_DISPLAY_TYPE_HDMI) {
> >  		priv->dispc_ops->mgr_enable(priv->dispc, channel, enable);
> >  		omap_crtc->enabled = enable;
> >  		return;
> 
> This doesn't look correct, omap_crtc_dss_start_update() already sets the
> enable bit for manual update displays. And you don't want to set the
> enable to false with manual update displays.
> 
> HDMI handling here is already a special case due to HW issues, so I'd
> rather see the manual update handled separately from the HDMI.
> 
> > @@ -214,7 +239,6 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
> >  	}
> >  }
> >  
> > -
> >  static int omap_crtc_dss_enable(struct omap_drm_private *priv,
> >  				enum omap_channel channel)
> >  {
> > @@ -378,6 +402,53 @@ void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus)
> >  	wake_up(&omap_crtc->pending_wait);
> >  }
> >  
> > +void omap_crtc_flush(struct drm_crtc *crtc)
> > +{
> > +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> > +
> > +	if (!omap_crtc_is_manually_updated(crtc))
> > +		return;
> > +
> > +	if (!delayed_work_pending(&omap_crtc->update_work))
> > +		schedule_delayed_work(&omap_crtc->update_work, 0);
> > +}
> 
> Why delayed work here?
> 
> It's actually not quite clear to me how manual update displays work with
> DRM...
> 
> As far as I see, we have essentially two cases: 1) single buffering,
> where the userspace must set an area in the fb dirty, which then
> triggers the update, 2) multi buffering, which doesn't need fb dirty,
> but just a page flip which triggers the update.
> 
> In the 2) case (which I think is the optimal case which all the modern
> apps should use), there's no need for delayed work or any work, and the
> code flow should be very similar to the auto-update model.
> 
> Also, as Daniel mentioned in "drm/omapdrm: Nuke
> omap_framebuffer_get_next_connector()" thread, the dirtying mechanism in
> the series is not valid.
> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
