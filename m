Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2724C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2EE21738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R92t7AeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfAIKGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:06:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44645 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfAIKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:06:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so6782937edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJSwsJ1anxIH19VzksMjGn/FK5l8eTorG+Tl0wytk9I=;
        b=R92t7AeMq8I065xAzVNKei0dcBAnRaOH55PdCNXGvh0XfUUGNO9J+Jfmy8q/kATQjW
         RyobE9vTRyiHUDjkBzgU6H1jq5ykCjGs39ezULeHa7A76x7YpOBe+rqiFd+RkhgCySBs
         TKiLnQ2fzBd67HzF9b1HGWtUwzE4m196IIBjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XJSwsJ1anxIH19VzksMjGn/FK5l8eTorG+Tl0wytk9I=;
        b=EUW0UYPAjMsyJ5pfujiqRXujwWQ50SckttLg7/LIL4GwRnU89DUKArJLdkkZI+hcJJ
         yCphUZp3xQvHHx3gTRjl6ZeJtpyWXcK73ftJDWVkcjE9SUyHDOh3XwK+Gt6oyhBBgSLl
         481wR/TXfKE9G0oKM5PBTonmkKQX9CIS4fP5Qwhppt0G+qjZAXeElKYgMgn0Mg9H2uQa
         3DdmhR6QbTsmKklrF9Ar/r7l4Oz+kKa0Qq6Jn5p/J27/vtwXfOY5PAJ22d5QzPTeFnzb
         ZEnojBApfYrLXc/I+zY2NvWdpLx4mB2vANJy0G4bRSH5P/ME3KbxYptXCiinZ3bMr7YF
         gAbA==
X-Gm-Message-State: AJcUukf5O/57aUg15ketj+wv40BvLkeqlrMhs8zjbXvfWPehI9efoVWq
        uwvLpNTLjWs/rH0PAncqvQ5xyA==
X-Google-Smtp-Source: ALg8bN6vbm9/qc3qJp/1xKFX0VK6iq6/CkSLDXj5V8oLlYKmVLZjEHVU+LQz9oaV36T1e/YTnAiTCg==
X-Received: by 2002:a17:906:3e47:: with SMTP id t7-v6mr4918889eji.201.1547028380367;
        Wed, 09 Jan 2019 02:06:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r8sm786949edo.11.2019.01.09.02.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 02:06:19 -0800 (PST)
Date:   Wed, 9 Jan 2019 11:06:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 03/15] drm/bochs: atomic: add
 atomic_flush+atomic_enable callbacks.
Message-ID: <20190109100617.GR21184@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20190108112519.27473-1-kraxel@redhat.com>
 <20190108112519.27473-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108112519.27473-4-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:25:07PM +0100, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step one.
> Add atomic crtc helper callbacks.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index f7e6d1a9b3..2cbd406b1f 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -115,6 +115,29 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
>  	return 0;
>  }
>  
> +static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *old_crtc_state)
> +{
> +}

A patch to make this optional in the helpers would be neat.
-Daniel

> +
> +static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
> +				    struct drm_crtc_state *old_crtc_state)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_pending_vblank_event *event;
> +
> +	if (crtc->state && crtc->state->event) {
> +		unsigned long irqflags;
> +
> +		spin_lock_irqsave(&dev->event_lock, irqflags);
> +		event = crtc->state->event;
> +		crtc->state->event = NULL;
> +		drm_crtc_send_vblank_event(crtc, event);
> +		spin_unlock_irqrestore(&dev->event_lock, irqflags);
> +	}
> +}
> +
> +
>  /* These provide the minimum set of functions required to handle a CRTC */
>  static const struct drm_crtc_funcs bochs_crtc_funcs = {
>  	.set_config = drm_crtc_helper_set_config,
> @@ -128,6 +151,8 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
>  	.mode_set_base = bochs_crtc_mode_set_base,
>  	.prepare = bochs_crtc_prepare,
>  	.commit = bochs_crtc_commit,
> +	.atomic_enable = bochs_crtc_atomic_enable,
> +	.atomic_flush = bochs_crtc_atomic_flush,
>  };
>  
>  static const uint32_t bochs_formats[] = {
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
