Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1761C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B120645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ejb8GX0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948B120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJBPHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:07:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41925 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJBPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:07:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so1261268edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZDOYgXPq/Atau0/sfbO5zBQo0dKNKEv2RuA/29kKH0=;
        b=Ejb8GX0Rz1BMJow7VT/EAT/toWPa8Byzz7qqLdT60Yku+M5EHcbWDhO1OJQ5jLROHG
         IY9FQB9QsV8LA1yg8Ei9buiEkI4n7KK6I86Xww4wAAP8Fpra/WHGzlRgvQrjXcWgnWz7
         aK0MrEYqlS74koKsS0AK/wY+/muzI7owx1voY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mZDOYgXPq/Atau0/sfbO5zBQo0dKNKEv2RuA/29kKH0=;
        b=l4eZTFgPhFZcNpl6HUrUa3iHmR9mrVbRNEssdk/GHVz/bGgBR+vpIUvxViUPIjpxdN
         hH0uIhZQ7sdgtaI7hThehPgXcwAYyl/acIu+4QwAGuWdGkwCMdx6EZqPad6O6yvq1tkf
         qnSbgFwSvCaENk5g/MuxpeVzgCAB5OPVoY6oUcpp0hT/w0JyPKXJifDId6uzrapMj+bv
         FjtxZ75Fh8Gmk4DbeOCB/hdkVCOIe8CYLHZNQWruthGh5i8ch16RsGLu9aSVCmDnWFO8
         Gjt0AYFaYpl6F6/BlGiHsEr8QbvFWaEzHYlWZP91smhfgRrd75ugUeYK2GGMjHq/6eWH
         8ILQ==
X-Gm-Message-State: ABuFfoj+KfFBCipUQqxWm6s3d7vaak9LKaUmBYVSeqgFV4dzzphyJnK5
        0mTGXA/pyn7qISlIVwTYaaeSBQ==
X-Google-Smtp-Source: ACcGV63wihgzYZKRpUjHd9MqCIBb/zMzAsQoiJS8g7jQ5r3pirHseV1Yd8+uGrGZGGBK5YHxE+kc7A==
X-Received: by 2002:a50:fb8f:: with SMTP id e15-v6mr22985716edq.153.1538468695955;
        Tue, 02 Oct 2018 01:24:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w8-v6sm2271209eda.37.2018.10.02.01.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:24:52 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:24:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jann Horn <jannh@google.com>
Cc:     Keith Packard <keithp@keithp.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm: fix use-after-free read in
 drm_mode_create_lease_ioctl()
Message-ID: <20181002082450.GJ11082@phenom.ffwll.local>
Mail-Followup-To: Jann Horn <jannh@google.com>,
        Keith Packard <keithp@keithp.com>, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20181001153117.216923-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001153117.216923-1-jannh@google.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 05:31:17PM +0200, Jann Horn wrote:
> fd_install() moves the reference given to it into the file descriptor table
> of the current process. If the current process is multithreaded, then
> immediately after fd_install(), another thread can close() the file
> descriptor and cause the file's resources to be cleaned up.
> 
> Since the reference to "lessee" is held by the file, we must not access
> "lessee" after the fd_install() call.
> 
> As far as I can tell, to reach this codepath, the caller must have an open
> file descriptor to a DRI device in master mode. I'm not sure what the
> requirements for that are.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Fixes: 62884cd386b8 ("drm: Add four ioctls for managing drm mode object leases [v7]")
> Cc: stable@vger.kernel.org
> ---
> I'm not sure how to actually use this ioctl, so I have neither verified
> the bug experimentally nor experimentally verified the fix. I would
> appreciate it if someone could confirm my analysis.
> 
> There have been a number of fd_install() bugs over time; I think it's
> probably time to rename fd_install() to fd_install_dropref(), or
> something like that.

Publishing an object to the world needs to happen last, only once it's
fully set up. It's unfortunately a very common bug, and definitely not
limited to use-after-free fun. E.g. here you could also confuse the kernel
if you manage to sneak in an ioctl on the new fd, while it's not yet fully
ready for those. fd_install() is just one of these.

Except review and maybe automatic analysis tools for the common I'm not
sure how to catch these better. Because the race is generally small,
tests&fuzzing tend to not hit these.

Thanks a lot for spotting this issue, patch applied.

Cheers, Daniel
 
>  drivers/gpu/drm/drm_lease.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index b54fb78a283c..b82da96ded5c 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -566,14 +566,14 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  	lessee_priv->is_master = 1;
>  	lessee_priv->authenticated = 1;
>  
> -	/* Hook up the fd */
> -	fd_install(fd, lessee_file);
> -
>  	/* Pass fd back to userspace */
>  	DRM_DEBUG_LEASE("Returning fd %d id %d\n", fd, lessee->lessee_id);
>  	cl->fd = fd;
>  	cl->lessee_id = lessee->lessee_id;
>  
> +	/* Hook up the fd */
> +	fd_install(fd, lessee_file);
> +
>  	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
>  	return 0;
>  
> -- 
> 2.19.0.605.g01d371f741-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
