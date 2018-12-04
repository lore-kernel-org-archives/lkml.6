Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D14C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7F20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Lb9pBldE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D7F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLDKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:47:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34740 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLDKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:47:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so13513449ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNe6aaylwA69fcVewHKuH1U0AZBhLWnzMNQSORvyauw=;
        b=Lb9pBldEavodzm+7buMbz7ibb4Wr7LjdL2RcxJR7yAkR3Z38gnUJKt4Fa0uZ+gvxru
         TELwvzdUo6QyBd/NW97Z9PR4QGxQfHSft8waaNaeECyerB1sjAMkrPu5htAnIiOY+4Xv
         ZNSPuV1j6IZUoQahpvirI7obiaw5U8aEVxERk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sNe6aaylwA69fcVewHKuH1U0AZBhLWnzMNQSORvyauw=;
        b=bsnfXZItlhV9wv54XaPCrBAsS2Lykz1JYnHIGNSxPQSKtRSQmSz6TBUcudWVjjkerm
         pyzMfmj5MhHEZVrfbTPwv+oYHM04unCqfptSXN1ALGvE4rJ8M7g3/vRVjBGZaGYCnNuR
         wuKQJPQPlx+EOh4Ajeg++JXSxcUWKqvnY76e73MkY4/kG4+njc8VgLrIJn50I2mskNIw
         Te7BsFQ+WF0ODJzbKDX+kUzx0YUBObPzgk9jgszCKpQqEhsvJf1inMuNAKS/9xUjYBH2
         ptUMxoOpUq7A//YqJGTQaxQf/1PqNWvZ1kfrKhPBafjC6+dHXBMseI1NPQEmchfYHOt3
         M9xA==
X-Gm-Message-State: AA+aEWZFsEKFfSmUefZAANMxTU6yC+std8eBsjunN+DREqYFrtKhH6Lz
        2xJQNMzjEbT4CwXfeCbf/KysHA==
X-Google-Smtp-Source: AFSGD/XCk2pdDEnq721jQNyknpOKZBMy2pC6mItSwcNiq8ltpnjb7ujzrphQABloUt7VrvR8RXG0MQ==
X-Received: by 2002:aa7:c248:: with SMTP id y8mr17209708edo.205.1543920442117;
        Tue, 04 Dec 2018 02:47:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n3-v6sm2639699ejd.35.2018.12.04.02.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 02:47:21 -0800 (PST)
Date:   Tue, 4 Dec 2018 11:47:19 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/vkms: Remove set but not used variable
 'vkms_obj'
Message-ID: <20181204104719.GB21184@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1543634444-186448-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543634444-186448-1-git-send-email-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 03:20:44AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/vkms/vkms_plane.c: In function 'vkms_prepare_fb':
> drivers/gpu/drm/vkms/vkms_plane.c:144:26: warning:
>  variable 'vkms_obj' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> 8ce1bb0b5337 ("drm/vkms: map/unmap buffers in [prepare/cleanup]_fb hooks")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/vkms/vkms_plane.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e3bcea4..4188176 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -141,14 +141,12 @@ static int vkms_prepare_fb(struct drm_plane *plane,
>  			   struct drm_plane_state *state)
>  {
>  	struct drm_gem_object *gem_obj;
> -	struct vkms_gem_object *vkms_obj;
>  	int ret;
>  
>  	if (!state->fb)
>  		return 0;
>  
>  	gem_obj = drm_gem_fb_get_obj(state->fb, 0);
> -	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
>  	ret = vkms_gem_vmap(gem_obj);
>  	if (ret)
>  		DRM_ERROR("vmap failed: %d\n", ret);
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
