Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD07C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420B72077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420B72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJJAic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:38:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:62790 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJJAic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:38:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 10:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,361,1534834800"; 
   d="scan'208";a="79802155"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 09 Oct 2018 10:20:28 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 09 Oct 2018 20:20:27 +0300
Date:   Tue, 9 Oct 2018 20:20:27 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v7 1/5] drm/atomic_helper: Disallow new modesets on
 unregistered connectors
Message-ID: <20181009172027.GK9144@intel.com>
References: <20181008232437.5571-1-lyude@redhat.com>
 <20181008232437.5571-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008232437.5571-2-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 07:24:30PM -0400, Lyude Paul wrote:
> With the exception of modesets which would switch the DPMS state of a
> connector from on to off, we want to make sure that we disallow all
> modesets which would result in enabling a new monitor or a new mode
> configuration on a monitor if the connector for the display in question
> is no longer registered. This allows us to stop userspace from trying to
> enable new displays on connectors for an MST topology that were just
> removed from the system, without preventing userspace from disabling
> DPMS on those connectors.
> 
> Changes since v5:
> - Fix typo in comment, nothing else
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 6f66777dca4b..e6a2cf72de5e 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -319,6 +319,26 @@ update_connector_routing(struct drm_atomic_state *state,
>  		return 0;
>  	}
>  
> +	crtc_state = drm_atomic_get_new_crtc_state(state,
> +						   new_connector_state->crtc);
> +	/*
> +	 * For compatibility with legacy users, we want to make sure that
> +	 * we allow DPMS On->Off modesets on unregistered connectors. Modesets
> +	 * which would result in anything else must be considered invalid, to
> +	 * avoid turning on new displays on dead connectors.
> +	 *
> +	 * Since the connector can be unregistered at any point during an
> +	 * atomic check or commit, this is racy. But that's OK: all we care
> +	 * about is ensuring that userspace can't do anything but shut off the
> +	 * display on a connector that was destroyed after its been notified,
> +	 * not before.
> +	 */
> +	if (!READ_ONCE(connector->registered) && crtc_state->active) {
> +		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
> +				 connector->base.id, connector->name);
> +		return -EINVAL;
> +	}

This broke my ilk (and presumably snb-bdw as well).

[   25.593121] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Updating routing for [CONNECTOR:55:eDP-1]
[   25.593131] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] [CONNECTOR:55:eDP-1] is not registered
[   25.593133] ------------[ cut here ]------------
[   25.593134] Could not determine valid watermarks for inherited state
[   25.593212] WARNING: CPU: 0 PID: 3060 at ../drivers/gpu/drm/i915/intel_display.c:14983 intel_modeset_init+0x12cf/0x1980 [i915]

Also I can't see that any of the repostings of this has undergone the
full CI run (just BAT results are visible). Not sure why that is.
Not that the full run would have caught this because we unwisely 
load the module before the tests start. Which means any failures
during initial readout/takeover will not be flagged :(

> +
>  	funcs = connector->helper_private;
>  
>  	if (funcs->atomic_best_encoder)
> @@ -363,7 +383,6 @@ update_connector_routing(struct drm_atomic_state *state,
>  
>  	set_best_encoder(state, new_connector_state, new_encoder);
>  
> -	crtc_state = drm_atomic_get_new_crtc_state(state, new_connector_state->crtc);
>  	crtc_state->connectors_changed = true;
>  
>  	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] using [ENCODER:%d:%s] on [CRTC:%d:%s]\n",
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
