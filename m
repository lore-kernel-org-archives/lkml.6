Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38881C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87D521523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dag99xXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87D521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIVOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:43:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46210 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIVOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 10:43:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so12486063edr.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rCHjjJBsUDoS78Ttteke58H3YSR7mCZGEDyvJ7MpFac=;
        b=dag99xXaHWE15Tpeblf/hAgD0Rv/r6+rolVNYz7QjXY62Mz7V+V7wHk37uGfAjvY7y
         o02fuAg1AtMMPoCDREXhPd8E8MzdL/qgkPAJH0nvYRH41yoVi6vvnQYFmj59R94KJreh
         sZoD5pgOajNhgx3Jl3mkjti95/ULuILhctaNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rCHjjJBsUDoS78Ttteke58H3YSR7mCZGEDyvJ7MpFac=;
        b=InUT75ypTJ3MXurp+vHfoa9SGa/B9SJZtxrM9k3PNzxjfokbFqhdcENI92oUYa3wDi
         4mNbD9FByl4ZOhsgKfvGeokdyxzKcr8Rttk+Gy4H+UwVdfW3MYb0VkP3+ayJWXcdiCGt
         k3hJLXUvPOfJjkk8VncUwOF1Bbmr0xwMA1kjrJostx6w+fjVNXc/GQRCOAn0bHIuU1pw
         /v6K+y0/JLLV9EbEodoEG2ONu+JGYLjrzIHEqcPDY5za3vvIxf1G7Pu7ouCmgm/zutQI
         zNp9FybFkWPoMG4DSXC8y4HIyYTHqEOWg+iJ2EmVtonnUqNnVFciaYDXpXu1m5yUiES4
         4IIg==
X-Gm-Message-State: ABuFfogq+tZicLF9ia26yGnpD5QUxwSI8ZVjb04YaTtTQNxka5nFhNz9
        kRFYm1GOMIlhctWKFY/bx8xHfg==
X-Google-Smtp-Source: ANB0Vdbrbv2er2flIfaMNoBblA2eLsJduwiqV6/pProPXBaLvBctp3L97dlso5pYo7lBXvO5ckENdA==
X-Received: by 2002:a50:9806:: with SMTP id g6-v6mr1208920edb.235.1537606265638;
        Sat, 22 Sep 2018 01:51:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h40-v6sm2955635edh.88.2018.09.22.01.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 01:51:03 -0700 (PDT)
Date:   Sat, 22 Sep 2018 10:51:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: Leave intel_conn->mst_port
 set, use mst_port_gone instead
Message-ID: <20180922085101.GK11082@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20180918230637.20700-1-lyude@redhat.com>
 <20180918230637.20700-4-lyude@redhat.com>
 <20180921092746.GC11082@phenom.ffwll.local>
 <472fd6a7a46d44c079ce45b67ed23dee35dd96cf.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472fd6a7a46d44c079ce45b67ed23dee35dd96cf.camel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:17:16PM -0400, Lyude Paul wrote:
> On Fri, 2018-09-21 at 11:27 +0200, Daniel Vetter wrote:
> > On Tue, Sep 18, 2018 at 07:06:19PM -0400, Lyude Paul wrote:
> > > Currently we set intel_connector->mst_port to NULL to signify that the
> > > MST port has been removed from the system so that we can prevent further
> > > action on the port such as connector probes, mode probing, etc.
> > > However, we're going to need access to intel_connector->mst_port in
> > > order to fixup ->best_encoder() so that it can always return the correct
> > > encoder for an MST port to prevent legacy DPMS prop changes from
> > > failing. This should be safe, so instead keep intel_connector->mst_port
> > > always set and instead add intel_connector->mst_port_gone in order to
> > > signify whether or not the connector has disappeared from the system.
> > > 
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Cc: stable@vger.kernel.org
> > 
> > Hm, how exactly do legacy DPMS setprop blow up here? Or at least I can't
> > come up with a scenario that's specific to legacy props, atomic should be
> > equally affected. By the time we land in this code, the core code already
> > remapping it to be purely an atomic update.
> So, what I've been seeing with X that's been blowing this up:
>  * Hotplug event gets received, X does reprobe
>  * Notices MST connectors are now disconnected, sets DPMS from on->off
>  * During atomic_check, drm_atomic_helper_check_modeset() is called
>  * update_connector_routing() gets called
>  * funcs->best_encoder() returns NULL for the encoder
>  * update_connector_routing() fails atomic commit with "No suitable encoder
>    found", line 320 of drm_atomic_helper

Uh ... And X then doesn't try to fully shut down the CRTC? That would be a
SETCRTC with num_connectors=0, mode=0.

The failure mode has nothing to do with legacy dpms, it's just anything
that touches the modeset state will fail (except when you fully turn
things off, not just dpms off). If we fix this, then a DPMS on will
probably also "work", with possibly some hilarious dmesg noise and driver
bugs. So we need to be careful that this only allows disabling, not
re-enabling afterwards.

Hm ... thinking a bit more, I think a full disable also will not quite
work. Definitely need to test that.

> > Another thought: Should we handle at least some of this in the probe
> > helpers? I.e. once you unplugged a drm_connector, it always shows
> > disconnected and mode list is gone, instead of duplicating this over all
> > drivers. We could just check connector->registered.
> oooh, good idea! I will certainly go do that

We'll probably also need some checks in atomic helpers to prevent
re-enabling of a ghost connector.
-Daniel

> > 
> > Thanks, Daniel
> > > ---
> > >  drivers/gpu/drm/i915/intel_dp_mst.c | 14 +++++++-------
> > >  drivers/gpu/drm/i915/intel_drv.h    |  1 +
> > >  2 files changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > > index 4ecd65375603..fcb9b87b9339 100644
> > > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > > @@ -311,9 +311,8 @@ static int intel_dp_mst_get_ddc_modes(struct
> > > drm_connector *connector)
> > >  	struct edid *edid;
> > >  	int ret;
> > >  
> > > -	if (!intel_dp) {
> > > +	if (intel_connector->mst_port_gone)
> > >  		return intel_connector_update_modes(connector, NULL);
> > > -	}
> > >  
> > >  	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr,
> > > intel_connector->port);
> > >  	ret = intel_connector_update_modes(connector, edid);
> > > @@ -328,9 +327,10 @@ intel_dp_mst_detect(struct drm_connector *connector,
> > > bool force)
> > >  	struct intel_connector *intel_connector =
> > > to_intel_connector(connector);
> > >  	struct intel_dp *intel_dp = intel_connector->mst_port;
> > >  
> > > -	if (!intel_dp)
> > > +	if (intel_connector->mst_port_gone)
> > >  		return connector_status_disconnected;
> > > -	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> > > intel_connector->port);
> > > +	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> > > +				      intel_connector->port);
> > >  }
> > >  
> > >  static void
> > > @@ -370,7 +370,7 @@ intel_dp_mst_mode_valid(struct drm_connector
> > > *connector,
> > >  	int bpp = 24; /* MST uses fixed bpp */
> > >  	int max_rate, mode_rate, max_lanes, max_link_clock;
> > >  
> > > -	if (!intel_dp)
> > > +	if (intel_connector->mst_port_gone)
> > >  		return MODE_ERROR;
> > >  
> > >  	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> > > @@ -402,7 +402,7 @@ static struct drm_encoder
> > > *intel_mst_atomic_best_encoder(struct drm_connector *c
> > >  	struct intel_dp *intel_dp = intel_connector->mst_port;
> > >  	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
> > >  
> > > -	if (!intel_dp)
> > > +	if (intel_connector->mst_port_gone)
> > >  		return NULL;
> > >  	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
> > >  }
> > > @@ -514,7 +514,7 @@ static void intel_dp_destroy_mst_connector(struct
> > > drm_dp_mst_topology_mgr *mgr,
> > >  						   connector);
> > >  	/* prevent race with the check in ->detect */
> > >  	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
> > > -	intel_connector->mst_port = NULL;
> > > +	intel_connector->mst_port_gone = true;
> > >  	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
> > >  
> > >  	drm_connector_put(connector);
> > > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > > b/drivers/gpu/drm/i915/intel_drv.h
> > > index 8fc61e96754f..87ce772ae7f8 100644
> > > --- a/drivers/gpu/drm/i915/intel_drv.h
> > > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > > @@ -409,6 +409,7 @@ struct intel_connector {
> > >  	void *port; /* store this opaque as its illegal to dereference it */
> > >  
> > >  	struct intel_dp *mst_port;
> > > +	bool mst_port_gone;
> > >  
> > >  	/* Work struct to schedule a uevent on link train failure */
> > >  	struct work_struct modeset_retry_work;
> > > -- 
> > > 2.17.1
> > > 
> > > _______________________________________________
> > > Intel-gfx mailing list
> > > Intel-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> > 
> > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
