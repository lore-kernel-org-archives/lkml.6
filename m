Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeCMXYX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:24:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37663 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbeCMXYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:24:22 -0400
X-Google-Smtp-Source: AG47ELvTsbJCIX5uPhVWUEmYGWtwqmfNp39vs43oyYM0iRxaUMTnK6SG5QbKXRHVofd2JGpoFP6PEg==
Message-ID: <1520983460.24712.3.camel@redhat.com>
Subject: Re: [PATCH v3 1/5] drm/i915: Move DP modeset retry work into
 intel_dp
From: Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Manasi Navare <manasi.d.navare@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 19:24:20 -0400
In-Reply-To: <20180312210102.GR5453@intel.com>
References: <20180308232421.14049-1-lyude@redhat.com>
         <20180309213232.19855-1-lyude@redhat.com> <20180312210102.GR5453@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 23:01 +0200, Ville Syrjälä wrote:
> On Fri, Mar 09, 2018 at 04:32:27PM -0500, Lyude Paul wrote:
> > While having the modeset_retry_work in intel_connector makes sense with
> > SST, this paradigm doesn't make a whole ton of sense when it comes to
> > MST since we have to deal with multiple connectors. In most cases, it's
> > more useful to just use the intel_dp struct since it indicates whether
> > or not we're dealing with an MST device, along with being able to easily
> > trace the intel_dp struct back to it's respective connector (if there is
> > any). So, move the modeset_retry_work function out of the
> > intel_connector struct and into intel_dp.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > V2:
> >  - Remove accidental duplicate modeset_retry_work in intel_connector
> > V3:
> >  - Also check against eDP in intel_hpd_poll_fini() - mdnavare
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/i915/intel_display.c          | 25 +++++++++++++++++++++++-
> > -
> >  drivers/gpu/drm/i915/intel_dp.c               | 10 ++++------
> >  drivers/gpu/drm/i915/intel_dp_link_training.c |  2 +-
> >  drivers/gpu/drm/i915/intel_drv.h              |  6 +++---
> >  4 files changed, 31 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_display.c
> > b/drivers/gpu/drm/i915/intel_display.c
> > index f424fff477f6..3b7fa430a84a 100644
> > --- a/drivers/gpu/drm/i915/intel_display.c
> > +++ b/drivers/gpu/drm/i915/intel_display.c
> > @@ -15394,16 +15394,37 @@ static void intel_hpd_poll_fini(struct drm_device
> > *dev)
> >  {
> >  	struct intel_connector *connector;
> >  	struct drm_connector_list_iter conn_iter;
> > +	struct work_struct *work;
> > +	int conn_type;
> >  
> >  	/* Kill all the work that may have been queued by hpd. */
> >  	drm_connector_list_iter_begin(dev, &conn_iter);
> >  	for_each_intel_connector_iter(connector, &conn_iter) {
> > -		if (connector->modeset_retry_work.func)
> > -			cancel_work_sync(&connector->modeset_retry_work);
> >  		if (connector->hdcp_shim) {
> >  			cancel_delayed_work_sync(&connector-
> > >hdcp_check_work);
> >  			cancel_work_sync(&connector->hdcp_prop_work);
> >  		}
> > +
> > +		conn_type = connector->base.connector_type;
> > +		if (conn_type != DRM_MODE_CONNECTOR_eDP &&
> > +		    conn_type != DRM_MODE_CONNECTOR_DisplayPort)
> > +			continue;
> > +
> > +		if (connector->mst_port) {
> > +			work = &connector->mst_port->modeset_retry_work;
> > +		} else {
> > +			struct intel_encoder *intel_encoder =
> > +				connector->encoder;
> > +			struct intel_dp *intel_dp;
> > +
> > +			if (!intel_encoder)
> > +				continue;
> > +
> > +			intel_dp = enc_to_intel_dp(&intel_encoder->base);
> > +			work = &intel_dp->modeset_retry_work;
> > +		}
> > +
> > +		cancel_work_sync(work);
> 
> Why are we even walking the connectors for this? Can't we just
> walk the encoders instead?
We could walk the encoders for this, but seeing as we're already walking the
connectors for the HDCP prop doesn't it make more sense to just stick our code
there? or is there a simpler solution for this I'm missing
> 
> >  	}
> >  	drm_connector_list_iter_end(&conn_iter);
> >  }
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > b/drivers/gpu/drm/i915/intel_dp.c
> > index 4dd1b2287dd6..5abf0c95725a 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -6261,12 +6261,10 @@ static bool intel_edp_init_connector(struct intel_dp
> > *intel_dp,
> >  
> >  static void intel_dp_modeset_retry_work_fn(struct work_struct *work)
> >  {
> > -	struct intel_connector *intel_connector;
> > -	struct drm_connector *connector;
> > +	struct intel_dp *intel_dp = container_of(work, typeof(*intel_dp),
> > +						 modeset_retry_work);
> > +	struct drm_connector *connector = &intel_dp->attached_connector-
> > >base;
> >  
> > -	intel_connector = container_of(work, typeof(*intel_connector),
> > -				       modeset_retry_work);
> > -	connector = &intel_connector->base;
> >  	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
> >  		      connector->name);
> >  
> > @@ -6295,7 +6293,7 @@ intel_dp_init_connector(struct intel_digital_port
> > *intel_dig_port,
> >  	int type;
> >  
> >  	/* Initialize the work for modeset in case of link train failure */
> > -	INIT_WORK(&intel_connector->modeset_retry_work,
> > +	INIT_WORK(&intel_dp->modeset_retry_work,
> >  		  intel_dp_modeset_retry_work_fn);
> >  
> >  	if (WARN(intel_dig_port->max_lanes < 1,
> > diff --git a/drivers/gpu/drm/i915/intel_dp_link_training.c
> > b/drivers/gpu/drm/i915/intel_dp_link_training.c
> > index f59b59bb0a21..2cfa58ce1f95 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_link_training.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_link_training.c
> > @@ -340,7 +340,7 @@ intel_dp_start_link_train(struct intel_dp *intel_dp)
> >  							     intel_dp-
> > >link_rate,
> >  							     intel_dp-
> > >lane_count))
> >  			/* Schedule a Hotplug Uevent to userspace to start
> > modeset */
> > -			schedule_work(&intel_connector-
> > >modeset_retry_work);
> > +			schedule_work(&intel_dp->modeset_retry_work);
> >  	} else {
> >  		DRM_ERROR("[CONNECTOR:%d:%s] Link Training failed at link
> > rate = %d, lane count = %d",
> >  			  intel_connector->base.base.id,
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index 83e5ca889d9c..3f19dc80997f 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -406,9 +406,6 @@ struct intel_connector {
> >  
> >  	struct intel_dp *mst_port;
> >  
> > -	/* Work struct to schedule a uevent on link train failure */
> > -	struct work_struct modeset_retry_work;
> > -
> >  	const struct intel_hdcp_shim *hdcp_shim;
> >  	struct mutex hdcp_mutex;
> >  	uint64_t hdcp_value; /* protected by hdcp_mutex */
> > @@ -1135,6 +1132,9 @@ struct intel_dp {
> >  
> >  	/* Displayport compliance testing */
> >  	struct intel_dp_compliance compliance;
> > +
> > +	/* Work struct to schedule a uevent on link train failure */
> > +	struct work_struct modeset_retry_work;
> >  };
> >  
> >  struct intel_lspcon {
> > -- 
> > 2.14.3
> 
> 
