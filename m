Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD95C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC7A2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VLO6kMUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAKWQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:16:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38764 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfAKWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:16:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so14272759ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3sFaym4uEy8ypvOXHN+tAHMKc1hqXnDTWbWw4bN5oQ=;
        b=VLO6kMUfF3ipNhm4x4WPn6/FRg8JSqVbYOy+mjZr88EV/KdY8QqRpKGO+winbGnJ0M
         WoefMfNffhw8ivoUyrYTvwRxn8Rfyz/0tZaOm65F2h2WQQRoviShfTE95dQC8k4igU32
         /GntGb/eF4tHaEX9UC8WHAWBNS6Du0GPVmsOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=s3sFaym4uEy8ypvOXHN+tAHMKc1hqXnDTWbWw4bN5oQ=;
        b=Dv9XiLzavK6OS9wcSXYIF1m0c/hoLj9Zmoswlpzv9wlws81W8q2FOOUQ3YvhA+tVcN
         AQkUP9Ix44hO7y36vchvUSBjAqVjNr+7MmlbhIo5fWwh6xgg0395eRIfwl6okV2l3r7M
         gWwN3sEjHiwus5bdnoPI6AmPlE72g5A9wpRzHO7qwRYcFLEwGq7YMa3OZb2ZdVe2WGe2
         0GP/HxC58/l1TaoKdD4n8bO2yfV6AVvPHVsR88yHmRQaGGHPpd9lkfbsfNOZGzRxmEtm
         hXEW5CH2zmV5+zbB7Ew9iF0fOoE9ijlX/Y40xalZK+UqDtU2XclC9DtxYl9T6iTwcMeJ
         hPlw==
X-Gm-Message-State: AJcUukf89whNJhmUkiMqIoM0BtCDM2MMPAtquaRx4HFF2G0U9+3Ye8el
        YvCfyKSU+0J0ryQet4sbCs6Yaw==
X-Google-Smtp-Source: ALg8bN6eqQxMoMnVW9Ve7YewI3i1Q5ofg2z2El6O6SdfHa2+y7l7DTiaWrV75YX2USyyzu993qjgUA==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr14901167edq.30.1547245001182;
        Fri, 11 Jan 2019 14:16:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w56sm2646205edb.72.2019.01.11.14.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:16:40 -0800 (PST)
Date:   Fri, 11 Jan 2019 23:16:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Clark <rclark@redhat.com>,
        Daniel Stone <daniels@collabora.com>,
        David Airlie <airlied@linux.ie>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] drm/cirrus: fix connector leak at unload
Message-ID: <20190111221638.GG21184@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <rclark@redhat.com>,
        Daniel Stone <daniels@collabora.com>,
        David Airlie <airlied@linux.ie>, YueHaibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        Thierry Reding <treding@nvidia.com>
References: <20190111140242.29002-1-robdclark@gmail.com>
 <20190111220620.GF21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111220620.GF21184@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:06:20PM +0100, Daniel Vetter wrote:
> On Fri, Jan 11, 2019 at 09:02:34AM -0500, Rob Clark wrote:
> > This fixes an '*ERROR* connector VGA-2 leaked!' splat at driver unload.
> > 
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> > Similar case to the issue that was fixed recently in drm/ast
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Actually I just pushed a patch to drm-misc-next to rename this function to
drm_helper_force_disable_all(), so you need to respin ... My r-b still
holds.
-Daniel

> 
> > 
> >  drivers/gpu/drm/cirrus/cirrus_fbdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> > index 4dd499c7d1ba..bb379ec4c182 100644
> > --- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> > +++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> > @@ -256,6 +256,8 @@ static int cirrus_fbdev_destroy(struct drm_device *dev,
> >  {
> >  	struct drm_framebuffer *gfb = gfbdev->gfb;
> >  
> > +	drm_crtc_force_disable_all(dev);
> > +
> >  	drm_fb_helper_unregister_fbi(&gfbdev->helper);
> >  
> >  	vfree(gfbdev->sysram);
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
