Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E25920875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LczVpFoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E25920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeJEORr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:17:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41877 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeJEORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:17:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so10749996edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyR8A6AehlqWdICKzKNbC9Z2f5M8A9MRnlp9QAbgGBM=;
        b=LczVpFoBYHPWTjk+Qu3XZBKHQZXay5qWds1DnnyqTHL3jlPY8htjBJ9ndGqmVmk4mX
         KQ7OyUom1/t87GY0t4PIA9czeurOYm8+tIvaJMNSFymbSHSm0EDxUvBf49MDtrvDVjKG
         op7WxsWvPEQyeiaepDdN9QFwyGoYE/mbjjpo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tyR8A6AehlqWdICKzKNbC9Z2f5M8A9MRnlp9QAbgGBM=;
        b=phOK3rAk4yvwGF4fN915pPKVBVfKoW7JSJ7BeKGALTzAnBiHe4xslO59BdVwGI9k6X
         DaHjeI3shyA9XGE/pFvGcO5qv2ziADfGYh0ID2QL3bGfL2onBYs7cfEcx4UeVM9gJyK7
         +gWw84uFZ0FlPe4vRQgtUx3FnliT3C9pKmKWe6rEHtz8Kn5NsScKf4LHrnPDf9MYVplo
         +YIPYM53YZLeLwfdA2Erko6pFU9mOVgTnSH+nIT5A8pI5QnxD3Hjr2iw1r2ib21EttV5
         JB5t9WRbWdViFaWFQAFF9LbokttI22uD2PyRbYXQWp7iOQUB3fJWP9+EDYbsLJ7Fj3M5
         +CUA==
X-Gm-Message-State: ABuFfoj+DANRJ7HuR//m2f/MZH0BsjeFo/AQ9ZICFpKvM/uAgoTFUCQi
        UHpKjjTjthKjewGSvj4hw2GzgQUarPc=
X-Google-Smtp-Source: ACcGV62gJcs/IHHGFl5V0Zfv2/cDABlocXRZJh9Hrkeh+3R3Obl7EgGd08aBSL05L2+fQAKznSE0Ww==
X-Received: by 2002:a50:d78b:: with SMTP id w11-v6mr13311731edi.19.1538724020941;
        Fri, 05 Oct 2018 00:20:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v1-v6sm2092740edf.3.2018.10.05.00.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 00:20:19 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:20:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] drm/i915: Leave intel_conn->mst_port set, use
 mst_port_gone instead
Message-ID: <20181005072017.GV31561@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181005002956.7317-1-lyude@redhat.com>
 <20181005002956.7317-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005002956.7317-4-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:29:52PM -0400, Lyude Paul wrote:
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
> Changes since v2:
> - Add a comment to mst_port_gone (Jani Nikula)
> - Change mst_port_gone to a u8 instead of a bool, per the kernel bot.
>   Apparently bool is discouraged in structs these days
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/i915/intel_dp_mst.c | 14 +++++++-------
>  drivers/gpu/drm/i915/intel_drv.h    |  6 ++++++
>  2 files changed, 13 insertions(+), 7 deletions(-)
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

Just use the same READ_ONCE(conn->registered) trick as in the core? Imo no
need to track this twice ...

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

I think if we've move the conn->registered check into drm_probe_helper.c
we could drop all these checks here too. And fixup nouveau/amdgpu while at
it - trying to get modes for a disconnected mst sink is somewhat silly :-)

From a functional pov the patch lgtm. With mst_port_gone removed and the
READ_ON(!conn->registered) trick everywhere instead this has my

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

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
> index 8fc61e96754f..8261d4579452 100644
> --- a/drivers/gpu/drm/i915/intel_drv.h
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> @@ -410,6 +410,12 @@ struct intel_connector {
>  
>  	struct intel_dp *mst_port;
>  
> +	/*
> +	 * Set to 1 if this is an MST connector that was removed from the
> +	 * system and unregistered from sysfs
> +	 */
> +	u8 mst_port_gone;
-Daniel
> +
>  	/* Work struct to schedule a uevent on link train failure */
>  	struct work_struct modeset_retry_work;
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
