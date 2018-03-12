Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeCLWQ3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:16:29 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34019 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:16:28 -0400
X-Google-Smtp-Source: AG47ELuNxSKM6HwZjDe/pcskqsZWPw3O6t07njOKw2cpUenHABQjkwH81P6Wp4g7Hrj0LMVF+L/lRQ==
Message-ID: <1520892985.12372.14.camel@redhat.com>
Subject: Re: [PATCH v3 5/5] drm/i915: Implement proper fallback training for
 MST
From: Lyude Paul <lyude@redhat.com>
To: Manasi Navare <manasi.d.navare@intel.com>
Cc: intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date: Mon, 12 Mar 2018 18:16:25 -0400
In-Reply-To: <20180312220522.GC3022@intel.com>
References: <20180308232421.14049-1-lyude@redhat.com>
         <20180309213232.19855-1-lyude@redhat.com>
         <20180309213232.19855-5-lyude@redhat.com> <20180312220522.GC3022@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 15:05 -0700, Manasi Navare wrote:
> On Fri, Mar 09, 2018 at 04:32:31PM -0500, Lyude Paul wrote:
> > For a while we actually haven't had any way of retraining MST links with
> > fallback link parameters like we do with SST. While uncommon, certain
> > setups such as my Caldigit TS3 + EVGA MST hub require this since
> > otherwise, they end up getting stuck in an infinite MST retraining loop.
> > 
> > MST retraining is somewhat different then SST retraining. While it's
> > possible during the normal link retraining sequence for a hub to indicate
> > bad link status, it's also possible for a hub to only indicate this
> > status through ESI messages and it's possible for this to happen after
> > the initial link training succeeds. This can lead to a pattern that
> > looks like this:
> > 
> > - Train MST link
> > - Training completes successfully
> > - MST hub sets Channel EQ failed bit in ESI
> > - Retraining starts
> > - Retraining completes successfully
> > - MST hub sets Channel EQ failed bit in ESI again
> > - Rinse and repeat
> > 
> > In these situations, we need to be able to actually trigger fallback
> > link training from the ESI handler as well, along with using the ESI
> > handler during retraining to figure out whether or not our retraining
> > actually succeeded.
> > 
> > This gets a bit more complicated since we have to ensure that we don't
> > block the ESI handler at all while doing retraining. If we do, due to
> > DisplayPort's general issues with being sensitive to IRQ latency most
> > MST hubs will just stop responding to us if their interrupts aren't
> > handled in a timely manner.
> > 
> > So: move retraining into it's own seperate handler. Running in a
> > seperate handler allows us to avoid stalling the ESI during link
> > retraining, and we can have the ESI signal that the channel EQ bit was
> > cleared through a simple completion struct. Additionally, we take care
> > to stick as much of this into the SST retraining path as possible since
> > sharing is caring.
> > 
> 
> Thanks for the patch for MST retraining. So just to confirm my understanding
> of the
> cases where MS retraining is handled:
> 1. On link the first link training failure during the modeset, this would
> just
> use SST modeset retry function and set the link status to BAD through
> drm_dp_mst_topology_mgr_lower_link_rate()
This shoyuld be the  the case for hubs that are a bit less awkward then mine.
I haven't actually seen the link training fail during the initial modeset once
on my setup here, only the channel EQ bit in the ESI handler ever seems to get
set.
> 
> 2. In case that it suceeds here but then loses synchronization in between,
> that time it will send IRQ_HPD and
> indicate this through ESI and the way its handled is through
> intel_dp_mst_check_link_status() and then through
> the separate mst_retrain_link work. And this time we first try to retrain at
> the current values for 5 times and
> then fallback and retry by sending hotplug uevent.
Yes. As well, there's two ways we could run into a situation that would count
as a failure:

 * (Note, this doesn't happen because I forgot to include it in this patch
   series, but it'll be fixed in the next revision) If the hub does everything
   it's supposed to and actually reports the link training status as failing
   through the registers that intel_dp_start_link_train() relies on, then
   intel_dp_start_link_train() will try five times; fail; and then we'll skip
   any additional attempts in intel_dp_retrain_link() and start the modeset
   retry work.
 * If the hub doesn't do everything that it's supposed to like mine does and
   only reports channel EQ failures through the ESI handler, we'll end up
   successfully link training; time out waiting for the ESI handler to signal
   through mst_retrain_completion that the channel EQ bit has been cleared,
   and repeat five times until we give up and fall back to a lower link rate
   with the modeset retry work.

> 
> Is this correct?
> 
> Manasi
> 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/intel_dp.c     | 342 +++++++++++++++++++++++++++--
> > -------
> >  drivers/gpu/drm/i915/intel_dp_mst.c |  42 ++++-
> >  drivers/gpu/drm/i915/intel_drv.h    |   8 +
> >  3 files changed, 302 insertions(+), 90 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > b/drivers/gpu/drm/i915/intel_dp.c
> > index 5645a194de92..7626652732b6 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -45,6 +45,8 @@
> >  
> >  #define DP_DPRX_ESI_LEN 14
> >  
> > +#define DP_MST_RETRAIN_TIMEOUT (msecs_to_jiffies(100))
> > +
> >  /* Compliance test status bits  */
> >  #define INTEL_DP_RESOLUTION_SHIFT_MASK	0
> >  #define INTEL_DP_RESOLUTION_PREFERRED	(1 <<
> > INTEL_DP_RESOLUTION_SHIFT_MASK)
> > @@ -4224,6 +4226,118 @@ static void intel_dp_handle_test_request(struct
> > intel_dp *intel_dp)
> >  		DRM_DEBUG_KMS("Could not write test response to sink\n");
> >  }
> >  
> > +/* Get a mask of the CRTCs that are running on the given intel_dp struct.
> > For
> > + * MST, this returns a crtc mask containing all of the CRTCs driving
> > + * downstream sinks, for SST it just returns a mask of the attached
> > + * connector's CRTC.
> > + */
> > +int
> > +intel_dp_get_crtc_mask(struct intel_dp *intel_dp)
> > +{
> > +	struct drm_device *dev = dp_to_dig_port(intel_dp)->base.base.dev;
> > +	struct drm_connector *connector;
> > +	struct drm_connector_state *conn_state;
> > +	struct intel_connector *intel_connector;
> > +	struct drm_crtc *crtc;
> > +	int crtc_mask = 0;
> > +
> > +	WARN_ON(!drm_modeset_is_locked(&dev-
> > >mode_config.connection_mutex));
> > +
> > +	if (intel_dp->is_mst) {
> > +		struct drm_connector_list_iter conn_iter;
> > +
> > +		drm_connector_list_iter_begin(dev, &conn_iter);
> > +		for_each_intel_connector_iter(intel_connector,
> > &conn_iter) {
> > +			if (intel_connector->mst_port != intel_dp)
> > +				continue;
> > +
> > +			conn_state = intel_connector->base.state;
> > +			if (!conn_state->crtc)
> > +				continue;
> > +
> > +			crtc_mask |= drm_crtc_mask(conn_state->crtc);
> > +		}
> > +		drm_connector_list_iter_end(&conn_iter);
> > +	} else {
> > +		connector = &intel_dp->attached_connector->base;
> > +		crtc = connector->state->crtc;
> > +
> > +		if (crtc)
> > +			crtc_mask |= drm_crtc_mask(crtc);
> > +	}
> > +
> > +	return crtc_mask;
> > +}
> > +
> > +static bool
> > +intel_dp_needs_link_retrain(struct intel_dp *intel_dp,
> > +			    const u8 esi[DP_DPRX_ESI_LEN])
> > +{
> > +	u8 buf[max(DP_LINK_STATUS_SIZE, DP_DPRX_ESI_LEN)];
> > +	const u8 *link_status = NULL;
> > +
> > +	if (intel_dp->is_mst) {
> > +		if (!intel_dp->active_mst_links)
> > +			return false;
> > +		if (intel_dp->mst_link_is_bad)
> > +			return false;
> > +
> > +		if (esi) {
> > +			link_status = &esi[10];
> > +		} else {
> > +			/* We're not running from the ESI handler, so
> > wait a
> > +			 * little bit to see if the ESI handler lets us
> > know
> > +			 * that the link status is OK
> > +			 */
> > +			if (wait_for_completion_timeout(
> > +				&intel_dp->mst_retrain_completion,
> > +				DP_MST_RETRAIN_TIMEOUT))
> > +				return false;
> > +		}
> > +	} else {
> > +		if (intel_dp->link_trained)
> > +			return false;
> > +		if (!intel_dp_get_link_status(intel_dp, buf))
> > +			return false;
> > +
> > +		link_status = buf;
> > +	}
> > +
> > +	/*
> > +	 * Validate the cached values of intel_dp->link_rate and
> > +	 * intel_dp->lane_count before attempting to retrain.
> > +	 */
> > +	if (!intel_dp_link_params_valid(intel_dp, intel_dp->link_rate,
> > +					intel_dp->lane_count))
> > +		return false;
> > +
> > +	if (link_status) {
> > +		return !drm_dp_channel_eq_ok(link_status,
> > +					     intel_dp->lane_count);
> > +	} else {
> > +		return true;
> > +	}
> > +}
> > +
> > +static inline void
> > +intel_dp_mst_check_link_status(struct intel_dp *intel_dp,
> > +			       const u8 esi[DP_DPRX_ESI_LEN])
> > +{
> > +	if (intel_dp_needs_link_retrain(intel_dp, esi)) {
> > +		DRM_DEBUG_KMS("Channel EQ failing\n");
> > +
> > +		if (!work_busy(&intel_dp->mst_retrain_work)) {
> > +			reinit_completion(&intel_dp-
> > >mst_retrain_completion);
> > +			schedule_work(&intel_dp->mst_retrain_work);
> > +			DRM_DEBUG_KMS("Retraining started\n");
> > +		}
> > +	} else if (work_busy(&intel_dp->mst_retrain_work) &&
> > +		   !completion_done(&intel_dp->mst_retrain_completion)) {
> > +		DRM_DEBUG_KMS("Channel EQ stable\n");
> > +		complete_all(&intel_dp->mst_retrain_completion);
> > +	}
> > +}
> > +
> >  static int
> >  intel_dp_check_mst_status(struct intel_dp *intel_dp)
> >  {
> > @@ -4237,14 +4351,7 @@ intel_dp_check_mst_status(struct intel_dp
> > *intel_dp)
> >  		bret = intel_dp_get_sink_irq_esi(intel_dp, esi);
> >  go_again:
> >  		if (bret == true) {
> > -
> > -			/* check link status - esi[10] = 0x200c */
> > -			if (intel_dp->active_mst_links &&
> > -			    !drm_dp_channel_eq_ok(&esi[10], intel_dp-
> > >lane_count)) {
> > -				DRM_DEBUG_KMS("channel EQ not ok,
> > retraining\n");
> > -				intel_dp_start_link_train(intel_dp);
> > -				intel_dp_stop_link_train(intel_dp);
> > -			}
> > +			intel_dp_mst_check_link_status(intel_dp, esi);
> >  
> >  			DRM_DEBUG_KMS("got esi %3ph\n", esi);
> >  			ret = drm_dp_mst_hpd_irq(&intel_dp->mst_mgr, esi,
> > &handled);
> > @@ -4281,29 +4388,6 @@ intel_dp_check_mst_status(struct intel_dp
> > *intel_dp)
> >  	return -EINVAL;
> >  }
> >  
> > -static bool
> > -intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
> > -{
> > -	u8 link_status[DP_LINK_STATUS_SIZE];
> > -
> > -	if (!intel_dp->link_trained)
> > -		return false;
> > -
> > -	if (!intel_dp_get_link_status(intel_dp, link_status))
> > -		return false;
> > -
> > -	/*
> > -	 * Validate the cached values of intel_dp->link_rate and
> > -	 * intel_dp->lane_count before attempting to retrain.
> > -	 */
> > -	if (!intel_dp_link_params_valid(intel_dp, intel_dp->link_rate,
> > -					intel_dp->lane_count))
> > -		return false;
> > -
> > -	/* Retrain if Channel EQ or CR not ok */
> > -	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
> > -}
> > -
> >  /*
> >   * If display is now connected check links status,
> >   * there has been known issues of link loss triggering
> > @@ -4319,64 +4403,78 @@ intel_dp_needs_link_retrain(struct intel_dp
> > *intel_dp)
> >  int intel_dp_retrain_link(struct intel_encoder *encoder,
> >  			  struct drm_modeset_acquire_ctx *ctx)
> >  {
> > -	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
> > +	struct drm_device *dev = encoder->base.dev;
> > +	struct drm_i915_private *dev_priv = to_i915(dev);
> >  	struct intel_dp *intel_dp = enc_to_intel_dp(&encoder->base);
> > -	struct intel_connector *connector = intel_dp->attached_connector;
> > -	struct drm_connector_state *conn_state;
> > -	struct intel_crtc_state *crtc_state;
> > -	struct intel_crtc *crtc;
> > +	struct drm_crtc *crtc;
> > +	struct intel_crtc *intel_crtc;
> > +	int crtc_mask, retry_count = 0;
> >  	int ret;
> >  
> > -	/* FIXME handle the MST connectors as well */
> > -
> > -	if (!connector || connector->base.status !=
> > connector_status_connected)
> > -		return 0;
> > -
> >  	ret = drm_modeset_lock(&dev_priv-
> > >drm.mode_config.connection_mutex,
> >  			       ctx);
> >  	if (ret)
> >  		return ret;
> >  
> > -	conn_state = connector->base.state;
> > -
> > -	crtc = to_intel_crtc(conn_state->crtc);
> > -	if (!crtc)
> > -		return 0;
> > +	crtc_mask = intel_dp_get_crtc_mask(intel_dp);
> > +	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask) {
> > +		struct drm_crtc_state *crtc_state;
> > +		struct intel_crtc_state *intel_crtc_state;
> >  
> > -	ret = drm_modeset_lock(&crtc->base.mutex, ctx);
> > -	if (ret)
> > -		return ret;
> > +		crtc = &intel_crtc->base;
> > +		ret = drm_modeset_lock(&crtc->mutex, ctx);
> > +		if (ret)
> > +			return ret;
> >  
> > -	crtc_state = to_intel_crtc_state(crtc->base.state);
> > +		crtc_state = crtc->state;
> > +		intel_crtc_state = to_intel_crtc_state(crtc_state);
> > +		WARN_ON(!intel_crtc_has_dp_encoder(intel_crtc_state));
> >  
> > -	WARN_ON(!intel_crtc_has_dp_encoder(crtc_state));
> > +		if (crtc_state->commit &&
> > +		    !try_wait_for_completion(&crtc_state->commit-
> > >hw_done))
> > +			return 0;
> > +	}
> >  
> > -	if (!crtc_state->base.active)
> > +	if (!intel_dp_needs_link_retrain(intel_dp, NULL))
> >  		return 0;
> >  
> > -	if (conn_state->commit &&
> > -	    !try_wait_for_completion(&conn_state->commit->hw_done))
> > -		return 0;
> > +	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask) {
> > +		intel_set_cpu_fifo_underrun_reporting(
> > +		    dev_priv, intel_crtc->pipe, false);
> >  
> > -	if (!intel_dp_needs_link_retrain(intel_dp))
> > -		return 0;
> > +		if (intel_crtc->config->has_pch_encoder) {
> > +			intel_set_pch_fifo_underrun_reporting(
> > +			    dev_priv,
> > intel_crtc_pch_transcoder(intel_crtc),
> > +			    false);
> > +		}
> > +	}
> >  
> > -	/* Suppress underruns caused by re-training */
> > -	intel_set_cpu_fifo_underrun_reporting(dev_priv, crtc->pipe,
> > false);
> > -	if (crtc->config->has_pch_encoder)
> > -		intel_set_pch_fifo_underrun_reporting(dev_priv,
> > -						      intel_crtc_pch_tran
> > scoder(crtc), false);
> > +	do {
> > +		if (++retry_count > 5) {
> > +			DRM_DEBUG_KMS("Too many retries, can't
> > retrain\n");
> > +			return -EINVAL;
> > +		}
> >  
> > -	intel_dp_start_link_train(intel_dp);
> > -	intel_dp_stop_link_train(intel_dp);
> > +		intel_dp_start_link_train(intel_dp);
> > +		intel_dp_stop_link_train(intel_dp);
> > +	} while (intel_dp_needs_link_retrain(intel_dp, NULL));
> > +
> > +	/* Wait for things to become stable */
> > +	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask)
> > +		intel_wait_for_vblank(dev_priv, intel_crtc->pipe);
> >  
> > -	/* Keep underrun reporting disabled until things are stable */
> > -	intel_wait_for_vblank(dev_priv, crtc->pipe);
> > +	/* Now that we know everything is OK, finally re-enable underrun
> > +	 * reporting */
> > +	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask) {
> > +		intel_set_cpu_fifo_underrun_reporting(
> > +		    dev_priv, intel_crtc->pipe, true);
> >  
> > -	intel_set_cpu_fifo_underrun_reporting(dev_priv, crtc->pipe,
> > true);
> > -	if (crtc->config->has_pch_encoder)
> > -		intel_set_pch_fifo_underrun_reporting(dev_priv,
> > -						      intel_crtc_pch_tran
> > scoder(crtc), true);
> > +		if (intel_crtc->config->has_pch_encoder) {
> > +			intel_set_pch_fifo_underrun_reporting(
> > +			    dev_priv,
> > intel_crtc_pch_transcoder(intel_crtc),
> > +			    true);
> > +		}
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -4402,6 +4500,10 @@ static bool intel_dp_hotplug(struct intel_encoder
> > *encoder,
> >  
> >  	changed = intel_encoder_hotplug(encoder, connector);
> >  
> > +	/* We don't want to end up trying to retrain MST links! */
> > +	if (encoder && enc_to_intel_dp(&encoder->base)->is_mst)
> > +		return changed;
> > +
> >  	drm_modeset_acquire_init(&ctx, 0);
> >  
> >  	for (;;) {
> > @@ -4478,7 +4580,7 @@ intel_dp_short_pulse(struct intel_dp *intel_dp)
> >  	}
> >  
> >  	/* defer to the hotplug work for link retraining if needed */
> > -	if (intel_dp_needs_link_retrain(intel_dp))
> > +	if (intel_dp_needs_link_retrain(intel_dp, NULL))
> >  		return false;
> >  
> >  	if (intel_dp->compliance.test_type == DP_TEST_LINK_TRAINING) {
> > @@ -6266,25 +6368,98 @@ static bool intel_edp_init_connector(struct
> > intel_dp *intel_dp,
> >  	return false;
> >  }
> >  
> > +static void intel_dp_mst_retrain_link_work(struct work_struct *work)
> > +{
> > +	struct drm_modeset_acquire_ctx ctx;
> > +	struct intel_dp *intel_dp = container_of(work, typeof(*intel_dp),
> > +						 mst_retrain_work);
> > +	struct intel_encoder *intel_encoder = &dp_to_dig_port(intel_dp)-
> > >base;
> > +	struct drm_device *dev = intel_encoder->base.dev;
> > +	int ret;
> > +	bool had_error = false;
> > +
> > +	drm_modeset_acquire_init(&ctx, 0);
> > +
> > +	for (;;) {
> > +		ret = intel_dp_retrain_link(intel_encoder, &ctx);
> > +		if (ret == -EDEADLK) {
> > +			drm_modeset_backoff(&ctx);
> > +			continue;
> > +		}
> > +
> > +		break;
> > +	}
> > +	if (!ret) {
> > +		DRM_DEBUG_KMS("Retrain complete\n");
> > +		goto out;
> > +	} else if (ret == -EIO) {
> > +		DRM_ERROR("IO error with sink during retrain?
> > Aborting\n");
> > +		had_error = true;
> > +		goto out;
> > +	}
> > +
> > +	DRM_DEBUG_KMS("Retraining failed with %d, marking link status as
> > bad\n",
> > +		      ret);
> > +
> > +	/* We ran out of retries, if the sink hasn't changed the link
> > rate in
> > +	 * it's dpcd yet force us to fallback to a lower link rate/count
> > */
> > +	if (ret == -EINVAL) {
> > +		ret = intel_dp_get_dpcd(intel_dp);
> > +		if (!ret) {
> > +			DRM_ERROR("IO error while reading dpcd from
> > sink\n");
> > +			had_error = true;
> > +			goto out;
> > +		}
> > +
> > +		if (intel_dp->link_rate ==
> > intel_dp_max_link_rate(intel_dp) &&
> > +		    intel_dp->lane_count ==
> > intel_dp_max_lane_count(intel_dp)) {
> > +			intel_dp_get_link_train_fallback_values(
> > +			    intel_dp, intel_dp_max_link_rate(intel_dp),
> > +			    intel_dp_max_lane_count(intel_dp));
> > +		}
> > +	}
> > +
> > +	intel_dp->mst_link_is_bad = true;
> > +	intel_dp->mst_bw_locked = false;
> > +	schedule_work(&intel_dp->modeset_retry_work);
> > +out:
> > +	drm_modeset_drop_locks(&ctx);
> > +	drm_modeset_acquire_fini(&ctx);
> > +	if (had_error)
> > +		drm_kms_helper_hotplug_event(dev);
> > +}
> > +
> >  static void intel_dp_modeset_retry_work_fn(struct work_struct *work)
> >  {
> >  	struct intel_dp *intel_dp = container_of(work, typeof(*intel_dp),
> >  						 modeset_retry_work);
> > -	struct drm_connector *connector = &intel_dp->attached_connector-
> > >base;
> > +	struct intel_digital_port *intel_dig_port =
> > dp_to_dig_port(intel_dp);
> > +	struct drm_device *dev = intel_dig_port->base.base.dev;
> > +	struct drm_connector *connector;
> >  
> > -	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
> > -		      connector->name);
> > +	mutex_lock(&dev->mode_config.mutex);
> >  
> > -	/* Grab the locks before changing connector property*/
> > -	mutex_lock(&connector->dev->mode_config.mutex);
> > -	/* Set connector link status to BAD and send a Uevent to notify
> > -	 * userspace to do a modeset.
> > +	/* Set the connector link status of all (possibly downstream)
> > ports to
> > +	 * BAD and send a Uevent to notify userspace to do a modeset.
> >  	 */
> > -	drm_mode_connector_set_link_status_property(connector,
> > -						    DRM_MODE_LINK_STATUS_
> > BAD);
> > -	mutex_unlock(&connector->dev->mode_config.mutex);
> > +	if (intel_dp->is_mst) {
> > +		drm_dp_mst_topology_mgr_lower_link_rate(
> > +		    &intel_dp->mst_mgr,
> > +		    intel_dp_max_link_rate(intel_dp),
> > +		    intel_dp_max_lane_count(intel_dp));
> > +	} else {
> > +		connector = &intel_dp->attached_connector->base;
> > +
> > +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
> > +			      connector->base.id, connector->name);
> > +		drm_mode_connector_set_link_status_property(
> > +		    connector, DRM_MODE_LINK_STATUS_BAD);
> > +	}
> > +
> > +	mutex_unlock(&dev->mode_config.mutex);
> > +
> >  	/* Send Hotplug uevent so userspace can reprobe */
> > -	drm_kms_helper_hotplug_event(connector->dev);
> > +	drm_kms_helper_hotplug_event(dev);
> >  }
> >  
> >  bool
> > @@ -6302,6 +6477,9 @@ intel_dp_init_connector(struct intel_digital_port
> > *intel_dig_port,
> >  	/* Initialize the work for modeset in case of link train failure
> > */
> >  	INIT_WORK(&intel_dp->modeset_retry_work,
> >  		  intel_dp_modeset_retry_work_fn);
> > +	INIT_WORK(&intel_dp->mst_retrain_work,
> > +		  intel_dp_mst_retrain_link_work);
> > +	init_completion(&intel_dp->mst_retrain_completion);
> >  
> >  	if (WARN(intel_dig_port->max_lanes < 1,
> >  		 "Not enough lanes (%d) for DP on port %c\n",
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index c0553456b18e..31202f838e89 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -110,21 +110,32 @@ static int intel_dp_mst_atomic_check(struct
> > drm_connector *connector,
> >  	struct drm_connector_state *old_conn_state;
> >  	struct drm_crtc *old_crtc;
> >  	struct drm_crtc_state *crtc_state;
> > +	struct drm_dp_mst_topology_mgr *mgr;
> > +	struct drm_encoder *encoder;
> >  	int slots, ret = 0;
> > +	bool could_retrain = false;
> > +
> > +	if (new_conn_state->crtc) {
> > +		crtc_state = drm_atomic_get_new_crtc_state(
> > +		    state, new_conn_state->crtc);
> > +		if (crtc_state &&
> > drm_atomic_crtc_needs_modeset(crtc_state))
> > +			could_retrain = true;
> > +	}
> >  
> >  	old_conn_state = drm_atomic_get_old_connector_state(state,
> > connector);
> >  	old_crtc = old_conn_state->crtc;
> >  	if (!old_crtc)
> > -		return ret;
> > +		goto out;
> >  
> >  	crtc_state = drm_atomic_get_new_crtc_state(state, old_crtc);
> > -	slots = to_intel_crtc_state(crtc_state)->dp_m_n.tu;
> > -	if (drm_atomic_crtc_needs_modeset(crtc_state) && slots > 0) {
> > -		struct drm_dp_mst_topology_mgr *mgr;
> > -		struct drm_encoder *old_encoder;
> > +	if (!drm_atomic_crtc_needs_modeset(crtc_state))
> > +		goto out;
> > +	could_retrain = true;
> >  
> > -		old_encoder = old_conn_state->best_encoder;
> > -		mgr = &enc_to_mst(old_encoder)->primary->dp.mst_mgr;
> > +	slots = to_intel_crtc_state(crtc_state)->dp_m_n.tu;
> > +	if (slots > 0) {
> > +		encoder = old_conn_state->best_encoder;
> > +		mgr = &enc_to_mst(encoder)->primary->dp.mst_mgr;
> >  
> >  		ret = drm_dp_atomic_release_vcpi_slots(state, mgr,
> > slots);
> >  		if (ret)
> > @@ -132,6 +143,18 @@ static int intel_dp_mst_atomic_check(struct
> > drm_connector *connector,
> >  		else
> >  			to_intel_crtc_state(crtc_state)->dp_m_n.tu = 0;
> >  	}
> > +
> > +out:
> > +	if (could_retrain &&
> > +	    old_conn_state->link_status == DRM_MODE_LINK_STATUS_BAD) {
> > +		if (new_conn_state->best_encoder)
> > +			encoder = new_conn_state->best_encoder;
> > +		else
> > +			encoder = old_conn_state->best_encoder;
> > +
> > +		mgr = &enc_to_mst(encoder)->primary->dp.mst_mgr;
> > +		ret = drm_atomic_dp_mst_retrain_topology(state, mgr);
> > +	}
> >  	return ret;
> >  }
> >  
> > @@ -186,9 +209,12 @@ static void intel_mst_post_disable_dp(struct
> > intel_encoder *encoder,
> >  	intel_dp->active_mst_links--;
> >  
> >  	intel_mst->connector = NULL;
> > -	if (intel_dp->active_mst_links == 0)
> > +	if (intel_dp->active_mst_links == 0) {
> > +		intel_dp->mst_link_is_bad = false;
> > +
> >  		intel_dig_port->base.post_disable(&intel_dig_port->base,
> >  						  old_crtc_state, NULL);
> > +	}
> >  
> >  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> >  }
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index fc338529e918..f4a5861e4dff 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -1119,6 +1119,13 @@ struct intel_dp {
> >  	/* mst connector list */
> >  	struct intel_dp_mst_encoder *mst_encoders[I915_MAX_PIPES];
> >  	struct drm_dp_mst_topology_mgr mst_mgr;
> > +	/* We can't handle retraining from the dig workqueue, so... */
> > +	struct work_struct mst_retrain_work;
> > +	struct completion mst_retrain_completion;
> > +	/* Set when retraining the link at the current parameters is
> > +	 * impossible for an MST connection
> > +	 */
> > +	bool mst_link_is_bad;
> >  
> >  	uint32_t (*get_aux_clock_divider)(struct intel_dp *dp, int
> > index);
> >  	/*
> > @@ -1686,6 +1693,7 @@ void intel_dp_compute_rate(struct intel_dp
> > *intel_dp, int port_clock,
> >  bool intel_dp_source_supports_hbr2(struct intel_dp *intel_dp);
> >  bool
> >  intel_dp_get_link_status(struct intel_dp *intel_dp, uint8_t
> > link_status[DP_LINK_STATUS_SIZE]);
> > +int intel_dp_get_crtc_mask(struct intel_dp *intel_dp);
> >  
> >  static inline unsigned int intel_dp_unused_lane_mask(int lane_count)
> >  {
> > -- 
> > 2.14.3
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Cheers,
	Lyude Paul
