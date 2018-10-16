Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B93C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DA920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XX2u+RVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DA920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJPUiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:38:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33604 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJPUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:38:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id l14-v6so12206842edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TNCq3rU+vUbF45TFOze9zOJGq6W+xML8NdK59MUQfFQ=;
        b=XX2u+RVnXA+hF9dTJaMsUhz4jSftSbjjqVqV3QICyFTyOlPRDgbDCkaMy3fXMB2IIk
         VLimi9AcNLpOrRmK+zyI4VzmMzsBAKyyRXLqGu+aVU66lcB3EPqxN5SMmBLxITBGpm0d
         evlBswLba1l5atjLB/6Xg3dwzA93lwNwukWPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TNCq3rU+vUbF45TFOze9zOJGq6W+xML8NdK59MUQfFQ=;
        b=P7tDWqgkNPivnylzF0ovhx4xMhe9oOOBHzMR02ch9ENmhIzZbipWoNBYbVSfq4TxEv
         UUZ6fQojeFPvoZW+7z6rsoxyO2s/73nLaSQuiCljKfSWgLafFpbbbIuSGP4RRFrYlaSs
         R1YN0GDLoh4ZuQIRK0pfAfEknyHOChplTVaOwiqmNFbGYg+TLETkItsTFmhvKiUVwcsx
         1mFsV8ct35Eit88dD98p0/66GePQjt/hrCRKp/uf+89B2nT+aYKgZiRhZ34P9hJpCn3/
         77+P7QprmSXm5qUsxb8ZZV03hfCIQGRUpR+I+iRC6ZfkV2hCa0r1PeDpzy+OAIbjcyGU
         hqBw==
X-Gm-Message-State: ABuFfogYa24x32N1vXHQNrXEGl4YHK0UMokRxsTgMtCpAn+9oUHB13fM
        zYUUR/8t7W/nKQ/zmRX4rn7sNw==
X-Google-Smtp-Source: ACcGV631GfUGPgr7ZRSffHPbNh9jdo5HS6h6Vi45HM+sa50D4+owlcQ3vF86iL0aHNu8cBCWkxVUEw==
X-Received: by 2002:a50:9873:: with SMTP id h48-v6mr29372859edb.247.1539694110961;
        Tue, 16 Oct 2018 05:48:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x14-v6sm5245285edb.84.2018.10.16.05.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:48:30 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:48:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atomic_helper: Stop modesets on unregistered
 connectors harder
Message-ID: <20181016124827.GY31561@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181016023306.27417-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016023306.27417-1-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:33:06PM -0400, Lyude Paul wrote:
> Unfortunately, it appears our fix in:
> commit b5d29843d8ef ("drm/atomic_helper: Allow DPMS On<->Off changes
> for unregistered connectors")
> 
> Which attempted to work around the problems introduced by:
> commit 4d80273976bf ("drm/atomic_helper: Disallow new modesets on
> unregistered connectors")
> 
> Is still not the right solution, as modesets can still be triggered
> outside of drm_atomic_set_crtc_for_connector().
> 
> So in order to fix this, while still being careful that we don't break
> modesets that a driver may perform before being registered with
> userspace, we replace connector->registered with a tristate member,
> connector->registration_state. This allows us to keep track of whether
> or not a connector is still initializing and hasn't been exposed to
> userspace, is currently registered and exposed to userspace, or has been
> legitimately removed from the system after having once been present.
> 
> Using this info, we can prevent userspace from performing new modesets
> on unregistered connectors while still allowing the driver to perform
> modesets on unregistered connectors before the driver has finished being
> registered.
> 
> Fixes: b5d29843d8ef ("drm/atomic_helper: Allow DPMS On<->Off changes for unregistered connectors")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: stable@vger.kernel.org
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 60 +++++++++++++++++++++----
>  drivers/gpu/drm/drm_atomic_uapi.c   | 21 ---------
>  drivers/gpu/drm/drm_connector.c     | 10 ++---
>  drivers/gpu/drm/i915/intel_dp_mst.c |  8 ++--
>  include/drm/drm_connector.h         | 68 ++++++++++++++++++++++++++++-
>  5 files changed, 127 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 6f66777dca4b..6cadeaf28ae4 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -529,6 +529,35 @@ mode_valid(struct drm_atomic_state *state)
>  	return 0;
>  }
>  
> +static int
> +unregistered_connector_check(struct drm_atomic_state *state,
> +			     struct drm_connector *connector,
> +			     struct drm_connector_state *old_conn_state,
> +			     struct drm_connector_state *new_conn_state)
> +{
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc *crtc;
> +
> +	if (!drm_connector_unregistered(connector))
> +		return 0;
> +
> +	crtc = new_conn_state->crtc;
> +	if (!crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	if (!crtc_state || !drm_atomic_crtc_needs_modeset(crtc_state))
> +		return 0;
> +
> +	if (crtc_state->mode_changed) {
> +		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] can't change mode on unregistered connector\n",
> +				 connector->base.id, connector->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_atomic_helper_check_modeset - validate state object for modeset changes
>   * @dev: DRM device
> @@ -684,18 +713,33 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  			return ret;
>  	}
>  
> -	/*
> -	 * Iterate over all connectors again, to make sure atomic_check()
> -	 * has been called on them when a modeset is forced.
> -	 */
>  	for_each_oldnew_connector_in_state(state, connector, old_connector_state, new_connector_state, i) {
>  		const struct drm_connector_helper_funcs *funcs = connector->helper_private;
>  
> -		if (connectors_mask & BIT(i))
> -			continue;
> +		/* Make sure atomic_check() is called on any unchecked
> +		 * connectors when a modeset has been forced
> +		 */
> +		if (connectors_mask & BIT(i) && funcs->atomic_check) {
> +			ret = funcs->atomic_check(connector,
> +						  new_connector_state);
> +			if (ret)
> +				return ret;
> +		}
>  
> -		if (funcs->atomic_check)
> -			ret = funcs->atomic_check(connector, new_connector_state);
> +		/*
> +		 * Prevent userspace from turning on new displays or setting
> +		 * new modes using connectors which have been removed from
> +		 * userspace. This is racy since an unplug could happen at any
> +		 * time including after this check, but that's OK: we only
> +		 * care about preventing userspace from trying to set invalid
> +		 * state using destroyed connectors that it's been notified
> +		 * about. No one can save us after the atomic check completes
> +		 * but ourselves.
> +		 */
> +		ret = unregistered_connector_check(state,
> +						   connector,
> +						   old_connector_state,
> +						   new_connector_state);

I expect a functional revert of b5d29843d8ef ("drm/atomic_helper: Allow
DPMS On<->Off changes for unregistered connectors"), but with
drm_connector_unregistered() instead of the READ_ONCE. This here is
entirely different, and I'm not clear on why.

Aside from this looks good to me.

[snip]

> +/**
> + * drm_connector_unregistered - has the connector been unregistered from
> + * userspace?
> + * @connector: DRM connector
> + *
> + * Checks whether or not @connector has been unregistered from userspace.
> + *
> + * Returns:
> + * True if the connector was unregistered, false if the connector is
> + * registered or has not yet been registered with userspace.
> + */
> +static inline bool drm_connector_unregistered(struct drm_connector *connector)

Bikeshed: I'd call this drm_connector_is_unregistered(). C is imperative,
functions without verbs always look a bit funny to me :-)

Feel free to ignore the bikeshed.

Cheers, Daniel

> +{
> +	return READ_ONCE(connector->registration_state) ==
> +		DRM_CONNECTOR_UNREGISTERED;
> +}
> +
>  const char *drm_get_connector_status_name(enum drm_connector_status status);
>  const char *drm_get_subpixel_order_name(enum subpixel_order order);
>  const char *drm_get_dpms_name(int val);
> -- 
> 2.17.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
