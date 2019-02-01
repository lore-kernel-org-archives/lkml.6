Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD7DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43C7218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Vte+43u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfBARyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:54:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38206 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfBARyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:54:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so6139823ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/cZFUYKVgQv2F4rbR25pmwRcRB3ASPRSD+v+qDRosU=;
        b=Vte+43u0N5X1mLzRojI2Xv8q1PemduEJt6FXpOOoHDmUuABFj4A/cDRKoBrK3IU40i
         ZkTMOu4dEjxZCktL8HcEmhMe+fhbf+JkfcX0p9hhuFAhhKVFoD7djb8QoRaBezUaL9KI
         RU+V+TcZJh9Afw/RFkKNnVRbs46qadzJCnmYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=r/cZFUYKVgQv2F4rbR25pmwRcRB3ASPRSD+v+qDRosU=;
        b=nx5SOPw9kieNC06rIsZyvJA0ZzbomXBHb+K86FzMEdHMoqGxkd6fgvxF65mlZxDW8m
         TcA93l7IthWfEEMyFPQd9wIKgT09Cj84SX7SZ9w/5Uxua+Y7SB6wF2xGRT0iaeVu8i3e
         VqW+DiR32fTEiS4mIQNsFIKNgBgnbD381/ltk7+Dtsh4mM7lX10NNvokRoVq4J7IfcKH
         G8Q+qBSgxAfKXoeeLtFkScXNNYhNfuD0kq9VRShRMO9dbQ0G5YX9Ar+WQ2IdbnGnrZJb
         kP+Se7sSKedBWMhGy15n+mYSUpT7VTJyC3ZOQ/vpuD2yF3PTAEewNglbI/t0DsUzUXmE
         V0FQ==
X-Gm-Message-State: AJcUukfdQdInCIJfc4k4rRW55tiqPu6QAoU76MmA0VQ9fEohEP8fnOwJ
        ygDFPQf3P+eL1YJ2lgCeztIH7A==
X-Google-Smtp-Source: ALg8bN4m8e889Fid5/PuMvCJTQC/uwySpYx1bo26pSpu3o9wR7UOveStiW7pkqast/pk2xQUbTBljA==
X-Received: by 2002:a50:a938:: with SMTP id l53mr38869427edc.194.1549043660504;
        Fri, 01 Feb 2019 09:54:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w56sm2201718edb.72.2019.02.01.09.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:54:19 -0800 (PST)
Date:   Fri, 1 Feb 2019 18:54:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <karolherbst@gmail.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/4] drm/dp_mst: Remove port validation in
 drm_dp_atomic_find_vcpi_slots()
Message-ID: <20190201175417.GG3271@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <karolherbst@gmail.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
References: <20190201011506.21055-1-lyude@redhat.com>
 <20190201011506.21055-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201011506.21055-3-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:14:49PM -0500, Lyude Paul wrote:
> Since we now have an easy way of refcounting drm_dp_mst_port structs and
> safely accessing their contents, there isn't any good reason to keep
> validating ports here. It doesn't prevent us from performing modesets on
> branch devices that have been removed either, and we already disallow
> enabling new displays on unregistered connectors in
> update_connector_routing() in drm_atomic_check_modeset(). All it does is
> cause us to have to make weird special exceptions in our atomic
> modesetting code. So, get rid of it entirely.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: eceae1472467 ("drm/dp_mst: Start tracking per-port VCPI allocations")
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c   | 12 ++----------
>  drivers/gpu/drm/i915/intel_dp_mst.c     | 17 ++++++-----------
>  drivers/gpu/drm/nouveau/dispnv50/disp.c |  3 +--
>  3 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index abb0ea8ba9d9..4325e1518286 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3117,10 +3117,6 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  	if (IS_ERR(topology_state))
>  		return PTR_ERR(topology_state);
>  
> -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> -	if (port == NULL)
> -		return -EINVAL;
> -
>  	/* Find the current allocation for this port, if any */
>  	list_for_each_entry(pos, &topology_state->vcpis, next) {
>  		if (pos->port == port) {

Also noticed that the WARN_ON() return -EINVAL; here gets fixed with this
patch.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> @@ -3153,10 +3149,8 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  	/* Add the new allocation to the state */
>  	if (!vcpi) {
>  		vcpi = kzalloc(sizeof(*vcpi), GFP_KERNEL);
> -		if (!vcpi) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> +		if (!vcpi)
> +			return -ENOMEM;
>  
>  		drm_dp_mst_get_port_malloc(port);
>  		vcpi->port = port;
> @@ -3165,8 +3159,6 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  	vcpi->vcpi = req_slots;
>  
>  	ret = req_slots;
> -out:
> -	drm_dp_mst_topology_put_port(port);
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index cdb83d294cdd..fb67cd931117 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -80,17 +80,12 @@ static int intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
>  	pipe_config->pbn = mst_pbn;
>  
> -	/* Zombie connectors can't have VCPI slots */
> -	if (!drm_connector_is_unregistered(connector)) {
> -		slots = drm_dp_atomic_find_vcpi_slots(state,
> -						      &intel_dp->mst_mgr,
> -						      port,
> -						      mst_pbn);
> -		if (slots < 0) {
> -			DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
> -				      slots);
> -			return slots;
> -		}
> +	slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr, port,
> +					      mst_pbn);
> +	if (slots < 0) {
> +		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
> +			      slots);
> +		return slots;
>  	}
>  
>  	intel_link_compute_m_n(bpp, lane_count,
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 2e8a5fd9b262..60d858c2f2ce 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -771,8 +771,7 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
>  	mstc->pbn = drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock,
>  					 bpp);
>  
> -	if (drm_atomic_crtc_needs_modeset(crtc_state) &&
> -	    !drm_connector_is_unregistered(connector)) {
> +	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>  		slots = drm_dp_atomic_find_vcpi_slots(state, &mstm->mgr,
>  						      mstc->port, mstc->pbn);
>  		if (slots < 0)
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
