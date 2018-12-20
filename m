Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856D421773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dtj/iQxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeLTHOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:14:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40991 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLTHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:14:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so816869edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbxJF9mqsYoKKUKwU+h+kSxEYT9ed4xvSgf/F/vUVD0=;
        b=dtj/iQxhvTO8ClmK43GPiUX3H+xlLGssJJwuzQbGSEOB4ajRK/9+kaPgdQrv022n9B
         r03zfhnZrIhU1bneZi6ikaFaglkXNNLhaTtKw+bj8/DJTS2EZbsCAIuZZQDa7KM+2Kkp
         YE4psXbjoDlh19X+2GWn2VdHBNni011A5rrZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WbxJF9mqsYoKKUKwU+h+kSxEYT9ed4xvSgf/F/vUVD0=;
        b=NTkVbgGTkwHronQJBoS0aQwU9EYqFZwuKCKjCVnZ2E9KdFdoXa8cyJ9a/BsBrhShb7
         e8np8ZbhjadSquvu77qo+wKnTbZdWwVqNkM8XS7lCzJO8KJzitzJW587c6okeLqz6ZgC
         U0tptkjzydi1otg2PWqI2tcBmlDQYmChtHWjX8g66PXtG8faEbDcT2vedP0VFO1S42ab
         VM7CVEIAs+yAnlroLyTRJTPlKgymVHVcdvfeNgKvR0w+KLAXF8WFjJP0c5EIV4rcCMt0
         hXAD054IOuH3LcVTzAZuGggCZ8o55GNaZsabS0fz2GFp8z3/cjfUdT2lAWnL28W4Muqu
         4aNQ==
X-Gm-Message-State: AA+aEWaBTB0lSWptfTpf0JIEITmsdZMSH0fCqRF+SOeLrSjIgmOKttk7
        7qHiN4X6P4zfTVMaaMX5cA+uXSp7vv8=
X-Google-Smtp-Source: AFSGD/UP17M1RN4n4FY2Zf/9voG2+reI1w/+2mFMRTS6YMwa/siYhPuBSwyL8D+8dzv3NFuoVNWyDw==
X-Received: by 2002:a50:b536:: with SMTP id y51mr22136940edd.201.1545290047921;
        Wed, 19 Dec 2018 23:14:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e53sm5957653ede.90.2018.12.19.23.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 23:14:06 -0800 (PST)
Date:   Thu, 20 Dec 2018 08:14:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ioctl: Fix Spectre v1 vulnerabilities
Message-ID: <20181220071404.GD21184@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20181220000015.GA18973@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220000015.GA18973@embeddedor>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 06:00:15PM -0600, Gustavo A. R. Silva wrote:
> nr is indirectly controlled by user-space, hence leading to a
> potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/gpu/drm/drm_ioctl.c:805 drm_ioctl() warn: potential spectre issue 'dev->driver->ioctls' [r]
> drivers/gpu/drm/drm_ioctl.c:810 drm_ioctl() warn: potential spectre issue 'drm_ioctls' [r] (local cap)
> drivers/gpu/drm/drm_ioctl.c:892 drm_ioctl_flags() warn: potential spectre issue 'drm_ioctls' [r] (local cap)
> 
> Fix this by sanitizing nr before using it to index dev->driver->ioctls
> and drm_ioctls.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

lgtm and I think there's no other obvious place where we need
array_index_nospec in drm core. Applied to drm-misc-fixes.
-Daniel

> ---
>  drivers/gpu/drm/drm_ioctl.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 94bd872d56c4..7e6746b2d704 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -37,6 +37,7 @@
>  
>  #include <linux/pci.h>
>  #include <linux/export.h>
> +#include <linux/nospec.h>
>  
>  /**
>   * DOC: getunique and setversion story
> @@ -800,13 +801,17 @@ long drm_ioctl(struct file *filp,
>  
>  	if (is_driver_ioctl) {
>  		/* driver ioctl */
> -		if (nr - DRM_COMMAND_BASE >= dev->driver->num_ioctls)
> +		unsigned int index = nr - DRM_COMMAND_BASE;
> +
> +		if (index >= dev->driver->num_ioctls)
>  			goto err_i1;
> -		ioctl = &dev->driver->ioctls[nr - DRM_COMMAND_BASE];
> +		index = array_index_nospec(index, dev->driver->num_ioctls);
> +		ioctl = &dev->driver->ioctls[index];
>  	} else {
>  		/* core ioctl */
>  		if (nr >= DRM_CORE_IOCTL_COUNT)
>  			goto err_i1;
> +		nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
>  		ioctl = &drm_ioctls[nr];
>  	}
>  
> @@ -888,6 +893,7 @@ bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
>  
>  	if (nr >= DRM_CORE_IOCTL_COUNT)
>  		return false;
> +	nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
>  
>  	*flags = drm_ioctls[nr].flags;
>  	return true;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
