Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BA0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EHQR/34A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BA0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeJEOKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:10:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeJEOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:10:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so3048922edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UGbw4knS7I2QbYewj8+sJjwz+dSpYUpEFBRGNwAK1tk=;
        b=EHQR/34AcdNHfkN3Np0btogId27DxdGuGGwb9bW/IN7Brm3WWr/z5HTNDN5aC+Vdam
         2El91cCtz7BQiVNt/AdhQ8z4dH8aocVHRZZqfllPZzslGScnHl+K9qlIZuex/oFZ3eq/
         Pot58w+O8eSHwKZyBbQXl9klx9aavbjoovx3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UGbw4knS7I2QbYewj8+sJjwz+dSpYUpEFBRGNwAK1tk=;
        b=pWRn15XEaiI4aV/io4M087MToLh/NZyIrMsTLAbEJEqDCp2waHG4v7UXa1odGbBPZJ
         fWW8L0Aj8DlLEyh4c0Ogq8yCY8L9TA6vqdirjnxK49/5FfXt0edsCVGsEGtoBqweYPaT
         NOteCaqemnL5v3OFrGI8FhkM7RdltQ0/GEDmWz9Gty97nvY5nBcBv3nYW/MN/HStGE7v
         FbFswlfTc9D4SOeodtW05voIhUk1eY+cPQB/mwpUE4O43iuq9lLxobbzORlWytA4Yt6v
         2U4W77Cqja53YZcLqiWGg7Vi57NgSdGDAV4wjaqF1NHKT2Ud72bQl8VAdqWFnrnMbfFK
         kgZQ==
X-Gm-Message-State: ABuFfoj0kyE26dLkZ47dkuT3Km/ZMJN4rjz8G2wuvZnmRLkrx4k9OUSQ
        2EMWwX1DUYSjguVd9zcLeGZFlg==
X-Google-Smtp-Source: ACcGV62ep8an+Tu8YJDsje1A7CDj6qBQXyzRv/BAAGXHPN1L7Zqs6KUlfkRMwpB6wlDOl1lCYTMUtg==
X-Received: by 2002:a50:9a81:: with SMTP id p1-v6mr176091edb.112.1538723586876;
        Fri, 05 Oct 2018 00:13:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s7-v6sm1246238eju.51.2018.10.05.00.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 00:13:05 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:13:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] drm/atomic_helper: Disallow new modesets on
 unregistered connectors
Message-ID: <20181005071303.GT31561@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20181005002956.7317-1-lyude@redhat.com>
 <20181005002956.7317-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005002956.7317-2-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:29:50PM -0400, Lyude Paul wrote:
> With the exception of modesets which would switch the DPMS state of a
> connector from on to off, we want to make sure that we disallow all
> modesets which would result in enabling a new monitor or a new mode
> configuration on a monitor if the connector for the display in question
> is no longer registered. This allows us to stop userspace from trying to
> enable new displays on connectors for an MST topology that were just
> removed from the system, without preventing userspace from disabling
> DPMS on those connectors.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 80be74df7ba6..ce2decfc6826 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -307,6 +307,26 @@ update_connector_routing(struct drm_atomic_state *state,
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
> +	 * display on a connector that was destroyed after it's been notified,
> +	 * not before.
> +	 */
> +	if (!READ_ONCE(connector->registered) && crtc_state->active) {
> +		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
> +				 connector->base.id, connector->name);
> +		return -EINVAL;
> +	}
> +
>  	funcs = connector->helper_private;
>  
>  	if (funcs->atomic_best_encoder)
> @@ -351,7 +371,6 @@ update_connector_routing(struct drm_atomic_state *state,
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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
