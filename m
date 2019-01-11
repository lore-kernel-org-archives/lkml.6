Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF494C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBDE2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PeOI1ssU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAKWGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:06:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35460 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:06:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so14290938edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5t8aNtf7qt4in6pKjl0LVAnHXwRhW20pyP639gOd7X8=;
        b=PeOI1ssUllyIbVN8Nccyv9SDxUbdG33UBWWeCCTBdDNPzRUf84t+GS7GcYnjj0alV2
         +/iTSe5FtEzg/vaMmZGGrHJmp7hTLRBlav0EtCPLKM433BoasTGFvnRp1RfErz4+9bPA
         mHksJsfoG1xdqQZIZ5R4P7XfXE1gfMP9+TZXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5t8aNtf7qt4in6pKjl0LVAnHXwRhW20pyP639gOd7X8=;
        b=byQoHVeydCiOBEJBjbKrJi0C0yQrfmskPcXrxwvnVRYgAxXEC606vgo4UMKO1jEnJk
         wvPFiiU/8qGXXDMDhB/bo2KZjT+DsEdYqnGVb0j1lNop9RP9KipliEZBaPXxkzHFIFh1
         vCwMd1dbbdl9pTiC+Alo58o3kzkzO4EiN2/gkcCCNJKhLv1EzRZYt/O0Hazu2m8jLY2A
         dvVg3BJkqh5YtHCdA3GmF//ljB8lzZqoIXUlJ2oUrrTnYMvKSdkzm2Gt2Wy4qSjXf6QM
         1xSwjbYyRxIno2iCR3Z/U5Qfw2Gyr7P+3LH9vuiwfnwwv+VK6VOIVyh5IFjsbxSrCTR0
         srGA==
X-Gm-Message-State: AJcUukdgCV37/3X6O3jydim+kzB/MdMME3u7gfUgMClN6MSGpL7L8A9t
        h2WmgBElfc/4YZDS4k19zoFJig==
X-Google-Smtp-Source: ALg8bN6XxNcrVkjEb6b7QASaB2X7JRBUZ+czQW69saPymcseE33nJ60pNdZ7HLzHyUZLxyS9IRH8PQ==
X-Received: by 2002:a50:a5e2:: with SMTP id b31mr14256892edc.5.1547244383241;
        Fri, 11 Jan 2019 14:06:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gz20-v6sm1689296ejb.56.2019.01.11.14.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:06:22 -0800 (PST)
Date:   Fri, 11 Jan 2019 23:06:20 +0100
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
Message-ID: <20190111220620.GF21184@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111140242.29002-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:02:34AM -0500, Rob Clark wrote:
> This fixes an '*ERROR* connector VGA-2 leaked!' splat at driver unload.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> Similar case to the issue that was fixed recently in drm/ast

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> index 4dd499c7d1ba..bb379ec4c182 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> +++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> @@ -256,6 +256,8 @@ static int cirrus_fbdev_destroy(struct drm_device *dev,
>  {
>  	struct drm_framebuffer *gfb = gfbdev->gfb;
>  
> +	drm_crtc_force_disable_all(dev);
> +
>  	drm_fb_helper_unregister_fbi(&gfbdev->helper);
>  
>  	vfree(gfbdev->sysram);
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
