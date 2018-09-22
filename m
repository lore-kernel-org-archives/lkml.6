Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E564EECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8671421532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NJI+rFLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8671421532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIVOvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:51:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39729 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIVOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 10:51:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so12516258edi.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6oyhHH4pEWKMQXHQNcpo/WFYAU/ju8nHriVFpjwGfXg=;
        b=NJI+rFLlLJQ0KzrrWfSQ+1EAbhj9s1sK9/rYwkp9rhpDxycsdMg2XOH28WZ5e6colI
         wHY29jmtfjAjLuQy4fRo9E1diibxqF7GGQTiIAbNEkqn9R72Aj/Wutr8KksddBYQoN2u
         dPCUKvQoiMvHQY56VP1ludzN6n6vOQWFEdtCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6oyhHH4pEWKMQXHQNcpo/WFYAU/ju8nHriVFpjwGfXg=;
        b=CE9tzvzot3cvA/krbkzzdmah09/KqsIVCTZ7sKNdFzZ9Qu3UuTpto8r7kWDC1+r/JC
         np+t/3e5Ac3UMLQfNInnKKmfDlErG5DJ3JjuIqF+YKsMxBKOPVWEoengJO9Nd2qw97k8
         yiT36mNEqYPZ0jOgdR9tvZaTk8ENgWk2B+wLoqzctrL8eM6Rv3ZKK20oF1iZzmQ0V2nF
         t5pTzfDHugIsxaW+z18oWwKpdtMkqfZTV/2v5oH1hQp9rrFjJvsp+r4H7QfTYNH6Xdjw
         yKNUfmaqLGbXgYQVGviVbe3cXx1fXnlxuSWtMQDf0bBofEjORdc+brR22UjOi23MJrY2
         MNLw==
X-Gm-Message-State: APzg51BwzbCSFKsiPO1gxc8DTMFxFTpspcIPJdfZFAZRBdK8iv7QKjWb
        1pL9i0TvO+dVDKkGXRBMBqYrJw==
X-Google-Smtp-Source: ACcGV62aoHYcY97RliFv8IEORiAlYLOQ0QMHttG7kXNsWJy0J867shFaDSq00ubXHTskG+cH8scEVA==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr2626577edd.30.1537606737916;
        Sat, 22 Sep 2018 01:58:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l48-v6sm3098915eda.94.2018.09.22.01.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 01:58:56 -0700 (PDT)
Date:   Sat, 22 Sep 2018 10:58:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        michel@daenzer.net, imirkin@alum.mit.edu,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] drm: use drm_driver_legacy_fb_format in
 drm_gem_fbdev_fb_create
Message-ID: <20180922085854.GN11082@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, michel@daenzer.net,
        imirkin@alum.mit.edu, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20180921134704.12826-1-kraxel@redhat.com>
 <20180921134704.12826-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921134704.12826-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:47:00PM +0200, Gerd Hoffmann wrote:
> Creating framebuffers for fbdev emulation should use the correct format
> code too, so switch drm_gem_fbdev_fb_create() over to use the new
> drm_driver_legacy_fb_format() function.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

First two patches look really neat now, you can upgrade to

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> index 7607f9cd6f..ded7a379ac 100644
> --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> @@ -316,8 +316,8 @@ drm_gem_fbdev_fb_create(struct drm_device *dev,
>  	if (pitch_align)
>  		mode_cmd.pitches[0] = roundup(mode_cmd.pitches[0],
>  					      pitch_align);
> -	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
> -							sizes->surface_depth);
> +	mode_cmd.pixel_format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
> +							    sizes->surface_depth);
>  	if (obj->size < mode_cmd.pitches[0] * mode_cmd.height)
>  		return ERR_PTR(-EINVAL);
>  
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
