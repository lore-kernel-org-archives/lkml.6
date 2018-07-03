Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAEB24422
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ehI46MMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAEB24422
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeGCJ2p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:28:45 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35107 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932388AbeGCJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:28:42 -0400
Received: by mail-ed1-f46.google.com with SMTP id b10-v6so1120383edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=stFyypa+F8Bh0Y/Qfm9/C20/iG/R3Jmt3DHmGWZxfEo=;
        b=ehI46MMCgvSI5KjdCJOUeMaf7XMeTk2Ts2locX2WIrLUseSUnsRYNawweJl1kwzKLM
         qrw7dra6kIFQoAsHuBwmfDlvEmkEl8Dod3U4Kf2qCJdsZA3HzScYRVxsmzf0FggFxlZ/
         ZmYODzLIgt+LcnsIKpxexAdcjcsjRKhiy2KA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=stFyypa+F8Bh0Y/Qfm9/C20/iG/R3Jmt3DHmGWZxfEo=;
        b=ZVUsndkVgvcQT1dK5DH5R0X2kdYyG1m069xm095WapP5apalQGYIQsOvHImZ1PWwlS
         ODoLIyaY/OZ6jm2SmMt9HFU/Tx1lH3ddUQo+IS+y/ZQGk4oFl9+dvBeEwP4v89esWo9m
         Izw/fFHriE976+EKWU5KoMmzCRBOqtB1c+EnFjw4HEqDUCvrmYZC9In+LZH2qlbJlyfC
         uNciwA5Efd+UPB4ktn7YjHtytt9VCjEyAhoI3G5dnhhJ1ch7fRMhFwCVY62NRvvEsbvn
         bFXesMikAQZ7wuPnHIfQd1zGzpk8eer304DZXZRVmX0cKvYtCQAQyQ/6lmV6YxxxyBBF
         mG2Q==
X-Gm-Message-State: APt69E3U75D9Op+vliWstZJBgzPZJ2PpHBylbXsLBrkznsuR0J8Ny0nv
        wZTcwI32C1CyW4ewg9B+mJsmnA==
X-Google-Smtp-Source: AAOMgpdVz8/mygJnEQ2zHPUYp5cVbAxDGtehth/4tGqL65ONmjEglE6Azo+8h8VEH9NJqud8udSVeQ==
X-Received: by 2002:a50:91da:: with SMTP id h26-v6mr26714359eda.87.1530610121258;
        Tue, 03 Jul 2018 02:28:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id s9-v6sm552291edk.66.2018.07.03.02.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:28:40 -0700 (PDT)
Date:   Tue, 3 Jul 2018 11:28:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/7] drm: add hook to print encoder status
Message-ID: <20180703092838.GM7880@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
 <20180605135407.20214-3-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605135407.20214-3-benjamin.gaignard@linaro.org>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:54:02PM +0200, Benjamin Gaignard wrote:
> Even if encoders don't have state it could be useful to get information
> from them when dumping of the other elements state.
> Add an optional hook in drm_encoder_funcs structure and call it after crtc
> print state.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 15 +++++++++++++++
>  include/drm/drm_encoder.h    | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index cd1d677617c8..6a9f5be01172 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -28,6 +28,7 @@
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_mode.h>
>  #include <drm/drm_print.h>
>  #include <linux/sync_file.h>
> @@ -1799,6 +1800,15 @@ int drm_atomic_nonblocking_commit(struct drm_atomic_state *state)
>  }
>  EXPORT_SYMBOL(drm_atomic_nonblocking_commit);
>  
> +static void drm_atomic_encoder_print(struct drm_printer *p,
> +				     struct drm_encoder *encoder)
> +{
> +	drm_printf(p, "encoder[%u]: %s\n", encoder->base.id, encoder->name);
> +
> +	if (encoder->funcs->atomic_print)
> +		encoder->funcs->atomic_print(p, encoder);
> +}
> +
>  static void drm_atomic_print_state(const struct drm_atomic_state *state)
>  {
>  	struct drm_printer p = drm_info_printer(state->dev->dev);
> @@ -1828,6 +1838,7 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
>  	struct drm_mode_config *config = &dev->mode_config;
>  	struct drm_plane *plane;
>  	struct drm_crtc *crtc;
> +	struct drm_encoder *encoder;
>  	struct drm_connector *connector;
>  	struct drm_connector_list_iter conn_iter;
>  
> @@ -1850,6 +1861,10 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
>  			drm_modeset_unlock(&crtc->mutex);
>  	}
>  
> +	drm_for_each_encoder(encoder, dev) {
> +		drm_atomic_encoder_print(p, encoder);
> +	}

This doesn't make sense to me at all. There's no encoder state, what
exactly do you want to print here?

Note that if you just want to dump hw state from your atomic state
functions (which might be useful sometimes, who knows) you can also dump
encoders by looking at connector_state->best_encoder.

Of have your own sti_dump_state which also adds this loop here.

Ack on the first patch from me.
-Daniel

> +
>  	drm_connector_list_iter_begin(dev, &conn_iter);
>  	if (take_locks)
>  		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> index fb299696c7c4..b847dad817b0 100644
> --- a/include/drm/drm_encoder.h
> +++ b/include/drm/drm_encoder.h
> @@ -80,6 +80,18 @@ struct drm_encoder_funcs {
>  	 * before data structures are torndown.
>  	 */
>  	void (*early_unregister)(struct drm_encoder *encoder);
> +
> +	/**
> +	 * @atomic_print
> +	 *
> +	 * If driver could implement this optional hook for printing
> +	 * additional driver specific information.
> +	 *
> +	 * Do not call this directly, use drm_atomic_encoder_print()
> +	 * instead.
> +	 */
> +	void (*atomic_print)(struct drm_printer *p,
> +			     struct drm_encoder *encoder);
>  };
>  
>  /**
> -- 
> 2.15.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
