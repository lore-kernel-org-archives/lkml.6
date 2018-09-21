Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA88EECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6686A208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WkqrCvpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6686A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbeIUPPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:15:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41566 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbeIUPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:15:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so10166335edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5XwSENopEtGbBRTUOZ9V3blrpgmXH0yZHw2IW8kCPg=;
        b=WkqrCvpCbAm5yOtQPx50nQE0s4dnpM+H6O/784WVMmQ7kZrDJ3FcCoJ56zyfl13ehY
         g4oLBGTMZSI0mJ8wUNpC2Rce6JXBQExftTE/Qvd6esL3qCaGBSLKtE3W4wncfrbR7pMd
         aijA7OVgzvL9XuJZuzHJJS2sz6id8AR02fhZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/5XwSENopEtGbBRTUOZ9V3blrpgmXH0yZHw2IW8kCPg=;
        b=W/r5vozBzU7XKWYP3kYGeTZVeX/au2Od/bxpwt4viUqdfRjSaE8hOGTpZcYhS5XnLJ
         mHpSv8XXnwdbqqZjkgj6YAoesuA6qZMGKTW0lAfdtaQPkGgg58nZNUYS2CmU+bYhxHou
         vZMAXkRwAnGisvLZpXQu8hT2ssoynmST0QatmezKXwhG5+K7+Lp414ytOkdFpDky+RBG
         oE5Apbx87mwEwtIZrqGjsKhCsKZWm0QAGqBGckibtpeuapv8UadZk4qJWYxgScazN2gK
         KpinXYlLA7NKuxf4TYEl+NPEhfWWtY/ogAZGeKGpJLCd0g7pI+1D9qdgablfVdMSLlnn
         vTww==
X-Gm-Message-State: APzg51BqSsp7QuTsvm0FRsbx2nSlUiDTJdjCiKdin3rKd1yboEhhXt+h
        rBHubcgs52osSQkswlzHmBT2qQ==
X-Google-Smtp-Source: ANB0VdZwvyct+QE8gsQU71c1VS9Cx8eFz2j+nHmR1gO3WvMM50tpCD4rH2z96J/WCL2TRjhhOXsyRQ==
X-Received: by 2002:a50:9732:: with SMTP id c47-v6mr10238261edb.89.1537522069845;
        Fri, 21 Sep 2018 02:27:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s36-v6sm3592392edb.56.2018.09.21.02.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:27:48 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:27:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: Leave intel_conn->mst_port
 set, use mst_port_gone instead
Message-ID: <20180921092746.GC11082@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20180918230637.20700-1-lyude@redhat.com>
 <20180918230637.20700-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918230637.20700-4-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 07:06:19PM -0400, Lyude Paul wrote:
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

Hm, how exactly do legacy DPMS setprop blow up here? Or at least I can't
come up with a scenario that's specific to legacy props, atomic should be
equally affected. By the time we land in this code, the core code already
remapping it to be purely an atomic update.

Another thought: Should we handle at least some of this in the probe
helpers? I.e. once you unplugged a drm_connector, it always shows
disconnected and mode list is gone, instead of duplicating this over all
drivers. We could just check connector->registered.

Thanks, Daniel
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
> +	bool mst_port_gone;
>  
>  	/* Work struct to schedule a uevent on link train failure */
>  	struct work_struct modeset_retry_work;
> -- 
> 2.17.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
