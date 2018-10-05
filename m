Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5183BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09B020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UFWbQcbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09B020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeJEOMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:12:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39733 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:12:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so10743917edi.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9OUUPlPUIYd359pCrRelujMeGdy2teGRul9Hg6ZvQ0=;
        b=UFWbQcbWoIXgm82NeLiC6TyIjiMbLOXMsfkugusDRjourRVkl+VMV1WN+PaVWNvj9s
         PaDpbYfOaYL1eAV0b4V0Rujx2wnmtEvIPYDC1Gmj9VoL8FclYmj0Pk8TWpE/gPPc2sue
         TXdasSsN2viiJZj8zMVlbToX3voMwH32kEMcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=X9OUUPlPUIYd359pCrRelujMeGdy2teGRul9Hg6ZvQ0=;
        b=uAvxaeUMLz9QnKrPpccleE9BBmAL5+jEK2Gb3JAg9b8szzKJoz914Dsds3yGwUAwpi
         6HDp5+FjUy8Q38gtwcTUiLzUBw4KKPXDew2OLbavod1QrWUZ8rO+3OdsoJHW2SnK1VBU
         33bN5lLQ6exxXWrllp0LgZhJpnADdN8BpQBQIPxZnbmcIDqrrdpAQS0/rM+FXdImkmGY
         Ul0TdxBTDmLonZTwxNcIXmaEIv5kKIm0fOSKX2zXQgd2JMiebrTxSMl4mpR3NjU6RvxW
         A+ouOvpOvPZiKpWGoICI6R5GNUQbKrU1WWyR4poiZUgbSQXKbYJkd/xiQGH1zIsYmwVn
         6zJg==
X-Gm-Message-State: ABuFfohaxvBfS6bHNaJs6382QgIewLAW6IY2iLVh0527M2V4hjHBBOLk
        L21j8FSR5HJIPnBm73KWC9KhKg==
X-Google-Smtp-Source: ACcGV602WQTL/znw/FlMwD2w4wFEQ8jxaOOo+x9tP7yBS5Z8iT8QcaCM8mHSB6KqcpSYQYYALNvEYQ==
X-Received: by 2002:a17:906:6812:: with SMTP id k18-v6mr10090737ejr.47.1538723683180;
        Fri, 05 Oct 2018 00:14:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d23-v6sm2026355eds.47.2018.10.05.00.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 00:14:42 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:14:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] drm/nouveau: Fix nv50_mstc->best_encoder()
Message-ID: <20181005071440.GU31561@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
References: <20181005002956.7317-1-lyude@redhat.com>
 <20181005002956.7317-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005002956.7317-3-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:29:51PM -0400, Lyude Paul wrote:
> As mentioned in the previous commit, we currently prevent new modesets
> on recently-removed MST connectors by returning no encoder from our
> ->best_encoder() callback once the MST port has disappeared. This is
> wrong however, because it prevents legacy modesetting users from being
> able to disable CRTCs on MST connectors after the connector's respective
> topology has disappeared.
> 
> So, fix this by instead by just always returning a valid encoder.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> 
> Changes since v2:
> - Remove usage of atomic MST helper for now, since that got replaced
>   with a much simpler solution
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 5691dfa1db6f..63a23a80f279 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -843,22 +843,16 @@ nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
>  {
>  	struct nv50_head *head = nv50_head(connector_state->crtc);
>  	struct nv50_mstc *mstc = nv50_mstc(connector);
> -	if (mstc->port) {
> -		struct nv50_mstm *mstm = mstc->mstm;
> -		return &mstm->msto[head->base.index]->encoder;
> -	}
> -	return NULL;
> +
> +	return &mstc->mstm->msto[head->base.index]->encoder;
>  }
>  
>  static struct drm_encoder *
>  nv50_mstc_best_encoder(struct drm_connector *connector)
>  {
>  	struct nv50_mstc *mstc = nv50_mstc(connector);
> -	if (mstc->port) {
> -		struct nv50_mstm *mstm = mstc->mstm;
> -		return &mstm->msto[0]->encoder;
> -	}
> -	return NULL;
> +
> +	return &mstc->mstm->msto[0]->encoder;
>  }
>  
>  static enum drm_mode_status
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
