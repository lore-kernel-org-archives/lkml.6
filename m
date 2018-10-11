Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E77C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457432087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QzLZPCJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457432087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJKQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:06:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33829 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeJKQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:06:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so7473391eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wYwW+VEExLl8Bgdtp71uT2YwZWVLLMO4u7FAv/lySMc=;
        b=QzLZPCJxp+FSbT50Nn4O0KfO5LHzVNSfZFwYVO5VM2YWVZLP+ZH5KBAg9CSymINpOr
         gAi3y3mXKzWUp7NgCsgy+eIeEevI7mack1SzqCmehjhEwhmzV16yRUZAA+Vae21asABc
         czylGQqxlDN6gsp0dymxxnnjZx6OqyIOQ8gsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wYwW+VEExLl8Bgdtp71uT2YwZWVLLMO4u7FAv/lySMc=;
        b=YOxSgsDm6ApEkZ76EKM7m8b/2rfxL6X8ekGQf7eEBQvl9uMLMkh/KePgL8PUdAZs5r
         uVtlk3gNUn/IdbJxEyBVem69dlYMXi0xMFsMsuAM551MeaKpJ8MyKVDXh4nLxW0cKNEJ
         EyOXMTuqnFYC5HySIrxPsd46ijmsJ0Uqi3VXEr4YxyNzm+ejJAV8uWeBUvFOzRFNILsu
         XYz5GsqCYSeNnhY9LPnaThg1NKEE+NTtBY9JmZ7JmemrB7313pzOdQp5r/1HrmX6Wib+
         LvYNahjZzwg1NEss4eJK5brIiq15Mq4oHiZ6phNPqihG1X5Eh1wbTUj6jmMV7iz5jheQ
         jjPw==
X-Gm-Message-State: ABuFfojnNG08aDn4HAAyGD8hjRvTNBb+to93Y1FDuTFA3FFm1D5n5UN9
        N4xZ6sycpA9yBYrac08V/4Hrtw==
X-Google-Smtp-Source: ACcGV61vP0fwTQyfa4jPqFae7C6opzkc2vePXRwkowBLUzw5RaiWr05eZEdXqC4jw6QlNK1XqeEbRg==
X-Received: by 2002:a50:c109:: with SMTP id l9-v6mr1424225edf.221.1539247218889;
        Thu, 11 Oct 2018 01:40:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k20-v6sm4654336ejb.28.2018.10.11.01.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:40:17 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:40:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v7 1/5] drm/atomic_helper: Disallow new modesets on
 unregistered connectors
Message-ID: <20181011084015.GX31561@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Paul <sean@poorly.run>
References: <20181008232437.5571-1-lyude@redhat.com>
 <20181008232437.5571-2-lyude@redhat.com>
 <20181009172027.GK9144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181009172027.GK9144@intel.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 08:20:27PM +0300, Ville Syrjälä wrote:
> On Mon, Oct 08, 2018 at 07:24:30PM -0400, Lyude Paul wrote:
> > With the exception of modesets which would switch the DPMS state of a
> > connector from on to off, we want to make sure that we disallow all
> > modesets which would result in enabling a new monitor or a new mode
> > configuration on a monitor if the connector for the display in question
> > is no longer registered. This allows us to stop userspace from trying to
> > enable new displays on connectors for an MST topology that were just
> > removed from the system, without preventing userspace from disabling
> > DPMS on those connectors.
> > 
> > Changes since v5:
> > - Fix typo in comment, nothing else
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 6f66777dca4b..e6a2cf72de5e 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -319,6 +319,26 @@ update_connector_routing(struct drm_atomic_state *state,
> >  		return 0;
> >  	}
> >  
> > +	crtc_state = drm_atomic_get_new_crtc_state(state,
> > +						   new_connector_state->crtc);
> > +	/*
> > +	 * For compatibility with legacy users, we want to make sure that
> > +	 * we allow DPMS On->Off modesets on unregistered connectors. Modesets
> > +	 * which would result in anything else must be considered invalid, to
> > +	 * avoid turning on new displays on dead connectors.
> > +	 *
> > +	 * Since the connector can be unregistered at any point during an
> > +	 * atomic check or commit, this is racy. But that's OK: all we care
> > +	 * about is ensuring that userspace can't do anything but shut off the
> > +	 * display on a connector that was destroyed after its been notified,
> > +	 * not before.
> > +	 */
> > +	if (!READ_ONCE(connector->registered) && crtc_state->active) {
> > +		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
> > +				 connector->base.id, connector->name);
> > +		return -EINVAL;
> > +	}
> 
> This broke my ilk (and presumably snb-bdw as well).
> 
> [   25.593121] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Updating routing for [CONNECTOR:55:eDP-1]
> [   25.593131] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] [CONNECTOR:55:eDP-1] is not registered
> [   25.593133] ------------[ cut here ]------------
> [   25.593134] Could not determine valid watermarks for inherited state
> [   25.593212] WARNING: CPU: 0 PID: 3060 at ../drivers/gpu/drm/i915/intel_display.c:14983 intel_modeset_init+0x12cf/0x1980 [i915]
> 
> Also I can't see that any of the repostings of this has undergone the
> full CI run (just BAT results are visible). Not sure why that is.
> Not that the full run would have caught this because we unwisely 
> load the module before the tests start. Which means any failures
> during initial readout/takeover will not be flagged :(

Ugh, so we need a special bool for "unplugged", to differentiate it from
the "it's real, but not yet registered because the driver isn't fully
loaded yet" case.
-Daniel

> 
> > +
> >  	funcs = connector->helper_private;
> >  
> >  	if (funcs->atomic_best_encoder)
> > @@ -363,7 +383,6 @@ update_connector_routing(struct drm_atomic_state *state,
> >  
> >  	set_best_encoder(state, new_connector_state, new_encoder);
> >  
> > -	crtc_state = drm_atomic_get_new_crtc_state(state, new_connector_state->crtc);
> >  	crtc_state->connectors_changed = true;
> >  
> >  	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] using [ENCODER:%d:%s] on [CRTC:%d:%s]\n",
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
