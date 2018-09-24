Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBCAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92951206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92951206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeIXMyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:54:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:28311 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeIXMyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:54:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2018 23:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,296,1534834800"; 
   d="scan'208";a="92674666"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2018 23:53:44 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] drm/i915: Leave intel_conn->mst_port set, use mst_port_gone instead
In-Reply-To: <20180919230913.16894-4-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180919230913.16894-1-lyude@redhat.com> <20180919230913.16894-4-lyude@redhat.com>
Date:   Mon, 24 Sep 2018 09:53:47 +0300
Message-ID: <87sh1zwflw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Lyude Paul <lyude@redhat.com> wrote:
> Currently we set intel_connector->mst_port to NULL to signify that the
> MST port has been removed from the system so that we can prevent further
> action on the port such as connector probes, mode probing, etc.
> However, we're going to need access to intel_connector->mst_port in
> order to fixup ->best_encoder() so that it can always return the correct
> encoder for an MST port to prevent legacy DPMS prop changes from
> failing. This should be safe, so instead keep intel_connector->mst_port
> always set and instead add intel_connector->mst_port_gone in order to
> signify whether or not the connector has disappeared from the system.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/i915/intel_dp_mst.c | 14 +++++++-------
>  drivers/gpu/drm/i915/intel_drv.h    |  1 +
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index 4ecd65375603..fcb9b87b9339 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -311,9 +311,8 @@ static int intel_dp_mst_get_ddc_modes(struct drm_connector *connector)
>  	struct edid *edid;
>  	int ret;
>  
> -	if (!intel_dp) {
> +	if (intel_connector->mst_port_gone)
>  		return intel_connector_update_modes(connector, NULL);
> -	}
>  
>  	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr, intel_connector->port);
>  	ret = intel_connector_update_modes(connector, edid);
> @@ -328,9 +327,10 @@ intel_dp_mst_detect(struct drm_connector *connector, bool force)
>  	struct intel_connector *intel_connector = to_intel_connector(connector);
>  	struct intel_dp *intel_dp = intel_connector->mst_port;
>  
> -	if (!intel_dp)
> +	if (intel_connector->mst_port_gone)
>  		return connector_status_disconnected;
> -	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr, intel_connector->port);
> +	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> +				      intel_connector->port);
>  }
>  
>  static void
> @@ -370,7 +370,7 @@ intel_dp_mst_mode_valid(struct drm_connector *connector,
>  	int bpp = 24; /* MST uses fixed bpp */
>  	int max_rate, mode_rate, max_lanes, max_link_clock;
>  
> -	if (!intel_dp)
> +	if (intel_connector->mst_port_gone)
>  		return MODE_ERROR;
>  
>  	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> @@ -402,7 +402,7 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
>  	struct intel_dp *intel_dp = intel_connector->mst_port;
>  	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
>  
> -	if (!intel_dp)
> +	if (intel_connector->mst_port_gone)
>  		return NULL;
>  	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
>  }
> @@ -514,7 +514,7 @@ static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>  						   connector);
>  	/* prevent race with the check in ->detect */
>  	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
> -	intel_connector->mst_port = NULL;
> +	intel_connector->mst_port_gone = true;
>  	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
>  
>  	drm_connector_put(connector);
> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
> index 8fc61e96754f..87ce772ae7f8 100644
> --- a/drivers/gpu/drm/i915/intel_drv.h
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> @@ -409,6 +409,7 @@ struct intel_connector {
>  	void *port; /* store this opaque as its illegal to dereference it */
>  
>  	struct intel_dp *mst_port;

	/*
	 * please explain mst_port_gone here too instead of just the
	 * commit message!
	 */

> +	bool mst_port_gone;
>  
>  	/* Work struct to schedule a uevent on link train failure */
>  	struct work_struct modeset_retry_work;

-- 
Jani Nikula, Intel Open Source Graphics Center
