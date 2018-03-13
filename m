Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeCMXSH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:18:07 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43920 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeCMXSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:18:06 -0400
X-Google-Smtp-Source: AG47ELtzd+xrHrbqBMF9i4/EeFvekIDZL799C8tjP4TWxdqiw3ZFOJKvdL+OrboC8LRz/57tytokHw==
Message-ID: <1520983083.24712.1.camel@redhat.com>
Subject: Re: [PATCH v3 2/5] drm/i915: Only use one link bw config for MST
 topologies
From: Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To: Manasi Navare <manasi.d.navare@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 19:18:03 -0400
In-Reply-To: <20180312204526.GA3022@intel.com>
References: <20180308232421.14049-1-lyude@redhat.com>
         <20180309213232.19855-1-lyude@redhat.com>
         <20180309213232.19855-2-lyude@redhat.com> <20180312204526.GA3022@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 13:45 -0700, Manasi Navare wrote:
> On Fri, Mar 09, 2018 at 04:32:28PM -0500, Lyude Paul wrote:
> > When a DP MST link needs retraining, sometimes the hub will detect that
> > the current link bw config is impossible and will update it's RX caps in
> > the DPCD to reflect the new maximum link rate. Currently, we make the
> > assumption that the RX caps in the dpcd will never change like this.
> > This means if the sink changes it's RX caps after we've already set up
> > an MST link and we attempt to add or remove another sink from the
> > topology, we could put ourselves into an invalid state where we've tried
> > to configure different sinks on the same MST topology with different
> > link rates. We could also run into this situation if a sink reports a
> > higher link rate after suspend, usually from us having trained it with a
> > fallback bw configuration before suspending.
> > 
> > So: "lock" the bw config by only using the max DP link rate/lane count
> > on the first modeset for an MST topology. For every modeset following,
> > we instead use the last configured link bw for this topology. We only
> > unlock the bw config when we've detected a new MST sink.
> > 
> 
> Just a nit here on commit message about where we unlock the link bw. So we
> also unlock it
> meaning set the mst_link_bw_locked to false when we read the dpcd again
> and obtain the fallback values since at that time the RX cap could have
> changed and so we do unlock the link_bw so that during retraining it reads
> the new max link rate and lane count during the mst compute config.
> Isnt that the case or am I missing something here?
I'm not sure I understand what you mean, are you talking about how we unlock the
link bw when retraining fails and we decide to fallback? If so, that's probably
something we should just mention in the patch that implements the actual
retraining as opposed to this patch.
> 
> Manasi
> 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/intel_dp.c     | 11 +++++++++--
> >  drivers/gpu/drm/i915/intel_dp_mst.c | 22 +++++++++++++++-------
> >  drivers/gpu/drm/i915/intel_drv.h    |  6 ++++++
> >  3 files changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > b/drivers/gpu/drm/i915/intel_dp.c
> > index 5abf0c95725a..5645a194de92 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -3871,18 +3871,25 @@ intel_dp_can_mst(struct intel_dp *intel_dp)
> >  static void
> >  intel_dp_configure_mst(struct intel_dp *intel_dp)
> >  {
> > +	bool was_mst;
> > +
> >  	if (!i915_modparams.enable_dp_mst)
> >  		return;
> >  
> >  	if (!intel_dp->can_mst)
> >  		return;
> >  
> > +	was_mst = intel_dp->is_mst;
> >  	intel_dp->is_mst = intel_dp_can_mst(intel_dp);
> >  
> > -	if (intel_dp->is_mst)
> > +	if (intel_dp->is_mst) {
> >  		DRM_DEBUG_KMS("Sink is MST capable\n");
> > -	else
> > +
> > +		if (!was_mst)
> > +			intel_dp->mst_bw_locked = false;
> > +	} else {
> >  		DRM_DEBUG_KMS("Sink is not MST capable\n");
> > +	}
> >  
> >  	drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
> >  					intel_dp->is_mst);
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index c3de0918ee13..c0553456b18e 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -42,7 +42,7 @@ static bool intel_dp_mst_compute_config(struct
> > intel_encoder *encoder,
> >  		to_intel_connector(conn_state->connector);
> >  	struct drm_atomic_state *state = pipe_config->base.state;
> >  	int bpp;
> > -	int lane_count, slots;
> > +	int lane_count, link_rate, slots;
> >  	const struct drm_display_mode *adjusted_mode = &pipe_config-
> > >base.adjusted_mode;
> >  	int mst_pbn;
> >  	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
> > @@ -56,16 +56,22 @@ static bool intel_dp_mst_compute_config(struct
> > intel_encoder *encoder,
> >  			      bpp);
> >  	}
> >  	/*
> > -	 * for MST we always configure max link bw - the spec doesn't
> > -	 * seem to suggest we should do otherwise.
> > +	 * for MST we always configure max link bw if we don't know better
> > -
> > +	 * the spec doesn't seem to suggest we should do otherwise. But,
> > +	 * ensure it always stays consistent with the rest of this hub's
> > +	 * state.
> >  	 */
> > -	lane_count = intel_dp_max_lane_count(intel_dp);
> > +	if (intel_dp->mst_bw_locked) {
> > +		lane_count = intel_dp->lane_count;
> > +		link_rate = intel_dp->link_rate;
> > +	} else {
> > +		lane_count = intel_dp_max_lane_count(intel_dp);
> > +		link_rate = intel_dp_max_link_rate(intel_dp);
> > +	}
> >  
> >  	pipe_config->lane_count = lane_count;
> > -
> >  	pipe_config->pipe_bpp = bpp;
> > -
> > -	pipe_config->port_clock = intel_dp_max_link_rate(intel_dp);
> > +	pipe_config->port_clock = link_rate;
> >  
> >  	if (drm_dp_mst_port_has_audio(&intel_dp->mst_mgr, connector->port))
> >  		pipe_config->has_audio = true;
> > @@ -221,6 +227,8 @@ static void intel_mst_pre_enable_dp(struct intel_encoder
> > *encoder,
> >  	connector->encoder = encoder;
> >  	intel_mst->connector = connector;
> >  
> > +	intel_dp->mst_bw_locked = true;
> > +
> >  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> >  
> >  	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port,
> > true);
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index 3f19dc80997f..fc338529e918 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -1107,6 +1107,12 @@ struct intel_dp {
> >  	bool can_mst; /* this port supports mst */
> >  	bool is_mst;
> >  	int active_mst_links;
> > +	/* Set when we've already decided on a link bw for mst, to prevent
> > us
> > +	 * from setting different link bandwiths if the hub tries to
> > confuse
> > +	 * us by changing it later
> > +	 */
> > +	bool mst_bw_locked;
> > +
> >  	/* connector directly attached - won't be use for modeset in mst
> > world */
> >  	struct intel_connector *attached_connector;
> >  
> > -- 
> > 2.14.3
> > 
