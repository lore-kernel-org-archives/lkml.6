Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCLVMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:12:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:6160 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932242AbeCLVMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:12:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="37574549"
Date: Mon, 12 Mar 2018 23:12:26 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Manasi Navare <manasi.d.navare@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] drm/i915: Implement proper fallback training for
 MST
Message-ID: <20180312211226.GT5453@intel.com>
References: <20180308232421.14049-1-lyude@redhat.com>
 <20180309213232.19855-1-lyude@redhat.com>
 <20180309213232.19855-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180309213232.19855-5-lyude@redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 04:32:31PM -0500, Lyude Paul wrote:
> @@ -6266,25 +6368,98 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
>  	return false;
>  }
>  
> +static void intel_dp_mst_retrain_link_work(struct work_struct *work)
> +{

Why do we need another work for this? Can't we just retrain from the
hotplug work always?

> +	struct drm_modeset_acquire_ctx ctx;
> +	struct intel_dp *intel_dp = container_of(work, typeof(*intel_dp),
> +						 mst_retrain_work);
> +	struct intel_encoder *intel_encoder = &dp_to_dig_port(intel_dp)->base;
> +	struct drm_device *dev = intel_encoder->base.dev;
> +	int ret;
> +	bool had_error = false;
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +	for (;;) {
> +		ret = intel_dp_retrain_link(intel_encoder, &ctx);
> +		if (ret == -EDEADLK) {
> +			drm_modeset_backoff(&ctx);
> +			continue;
> +		}
> +
> +		break;
> +	}
> +	if (!ret) {
> +		DRM_DEBUG_KMS("Retrain complete\n");
> +		goto out;
> +	} else if (ret == -EIO) {
> +		DRM_ERROR("IO error with sink during retrain? Aborting\n");
> +		had_error = true;
> +		goto out;
> +	}
> +
> +	DRM_DEBUG_KMS("Retraining failed with %d, marking link status as bad\n",
> +		      ret);
> +
> +	/* We ran out of retries, if the sink hasn't changed the link rate in
> +	 * it's dpcd yet force us to fallback to a lower link rate/count */
> +	if (ret == -EINVAL) {
> +		ret = intel_dp_get_dpcd(intel_dp);
> +		if (!ret) {
> +			DRM_ERROR("IO error while reading dpcd from sink\n");
> +			had_error = true;
> +			goto out;
> +		}
> +
> +		if (intel_dp->link_rate == intel_dp_max_link_rate(intel_dp) &&
> +		    intel_dp->lane_count == intel_dp_max_lane_count(intel_dp)) {
> +			intel_dp_get_link_train_fallback_values(
> +			    intel_dp, intel_dp_max_link_rate(intel_dp),
> +			    intel_dp_max_lane_count(intel_dp));
> +		}
> +	}
> +
> +	intel_dp->mst_link_is_bad = true;
> +	intel_dp->mst_bw_locked = false;
> +	schedule_work(&intel_dp->modeset_retry_work);
> +out:
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +	if (had_error)
> +		drm_kms_helper_hotplug_event(dev);
> +}
> +

-- 
Ville Syrjälä
Intel OTC
