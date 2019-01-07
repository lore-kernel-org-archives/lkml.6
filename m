Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE19C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615BC2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A2iHxxaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAGKtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:49:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41124 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfAGKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:49:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so411195edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MxSd9oxRRK3lKouUtyZ8pdi4vnkopqeGvFVegdgq4kE=;
        b=A2iHxxaT95nbiHa/HRWcIALrkDDU9/sMCe6V8Ky+w8IDtuXxdrFmW+/0Lf/8IzTAfj
         +1yQZpoUS2yTfubwS4Ev2pO8pJBCErAG6R21kRPE40I/RZeAhEwnIcx8Lzftu48HHd5R
         +mf4DkFMYGRnBFS1EzTVaW/HLDkI0hh2Iv30s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MxSd9oxRRK3lKouUtyZ8pdi4vnkopqeGvFVegdgq4kE=;
        b=sOXhYIZlhjojNp45Juk7shjxLGOZv0Qch/HzBLNlg+i2dsij9hgxJVsrDT8AXNm//K
         eINmKZU44T7dMSQnlZXiwi4F8IM1gDkwQYvSnB6aFvcqXGWE+jNZ5Sl2k++vXjj9F5Hw
         wj+7TaeoGiVxHo4avoPBCn7Id3DdqGBhU9Bmvg+g5xKtdYr+OOO1my8eXvmfK0eFHgbQ
         EXkhlz7IhWK1u5ghPVfB0LO/XuaehA9sDUPiYJLxbxG0HXhyq1i6NVaC5r0msV4I/1xV
         pS7HbqlbirfeTnwLql1l/YNfcql38nEtiZj7JNYIksoNhENaaOwEWK7CpFDB0MOcojpG
         MH2Q==
X-Gm-Message-State: AA+aEWbl7v4/R5X17uh3QtHdDwgtOMxyyUXO6HEP2lGNXBYXTlsPDwcm
        bRp/BvnRyrx2e/fkACHBDydWw4BPSdTx3g==
X-Google-Smtp-Source: AFSGD/WVxMKvE4H+Yy9D6gVlidfUytD8yMOMq2h4X3wZhj43kAndZKIGTLHX4cFQp8xW9oPlIyNjWQ==
X-Received: by 2002:a17:906:4d2:: with SMTP id g18-v6mr46691968eja.182.1546858159030;
        Mon, 07 Jan 2019 02:49:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 24sm30600447eds.97.2019.01.07.02.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:49:18 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:49:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eric Anholt <eric@anholt.net>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: Auto-set allow_fb_modifiers when given modifiers at
 plane init
Message-ID: <20190107104916.GJ21184@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eric Anholt <eric@anholt.net>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20190104085610.5829-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104085610.5829-1-paul.kocialkowski@bootlin.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:56:10AM +0100, Paul Kocialkowski wrote:
> When drivers pass non-empty lists of modifiers for initializing their
> planes, we can infer that they allow framebuffer modifiers and set the
> driver's allow_fb_modifiers mode config element.
> 
> In case the allow_fb_modifiers element was not set (some drivers tend
> to set them after registering planes), the modifiers will still be
> registered but won't be available to userspace unless the flag is set
> later. However in that case, the IN_FORMATS blob won't be created.
> 
> In order to avoid this case and generally reduce the trouble associated
> with the flag, always set allow_fb_modifiers when a non-empty list of
> format modifiers is passed at plane init.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

The automatic primary plane drm_crtc_init() creates doesn't set this, so
looks correct in all cases.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

(boolin.com has a bunch of drm-misc committers, so I'll leave pushing to
them).
-Daniel

> ---
>  drivers/gpu/drm/drm_plane.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 5f650d8fc66b..4cfb56893b7f 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -220,6 +220,9 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
>  			format_modifier_count++;
>  	}
>  
> +	if (format_modifier_count)
> +		config->allow_fb_modifiers = true;
> +
>  	plane->modifier_count = format_modifier_count;
>  	plane->modifiers = kmalloc_array(format_modifier_count,
>  					 sizeof(format_modifiers[0]),
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
