Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83236C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A182081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iecI2uaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfBVJvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:51:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32983 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfBVJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:51:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id c55so1293277edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbQP4DXzlR/5IPIlcVrIXCOB5gKA2Rmh4BgZUF002co=;
        b=iecI2uaYbEBkxw7U2OOcJbFtN0E371AgIijdcXUQyJr7wQNV5BGFH9rEXXzJck5KMG
         22YsrGO68J1iLg9B2O7e/MlEeBZVuTl/gMxRbF2xwvtqJs5JucyuqbSvDfMipGNCNuS7
         TOt1v26jpzLKm21xrkVswkk/AfvAAhk92pfts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MbQP4DXzlR/5IPIlcVrIXCOB5gKA2Rmh4BgZUF002co=;
        b=jkt5fyFGqoAlyQMkatfuCO0AGeslLfXtr7EiJgM4ErVXebbJUVVQISmq2VnXaxCHrf
         rwLHpUtFS1SY26gaASkGyxr9kSd9ZH2bPm3DRBq4bU+onIb79d6q0lprYP284bLiBDxQ
         EVfZiNvXKyxdg1qpKKjg2L6fCBeQV9wjlKaLjYAsIksAv3OV5H6SXneFQW4nDjXaPbKV
         pDudntpWHR3Qb+TUHRR9Cv0h6tqblrizQvFt1tLNKTz99vIYESOCJbgGEFvcGvLSC40i
         Uk3Zr5iFmwmeotbPPf1yKSHcEioYZs5YoZVcCFWH8OcQbfPlFdZppwePK0Fhco3H4/u1
         Hiow==
X-Gm-Message-State: AHQUAubm7zllfOMW2J+eMLXjs9v5guRF3lD1heWXGQ1Gk2m2pTsfTzGU
        kO2uMFMTzyryHK/8mi0LXUpoBA==
X-Google-Smtp-Source: AHgI3Ia04rMPJdmmZ/r+Sz6ZZ6vtf29ig2MAsHJ4jzZ6A+U4pSXnZ7FpUNTHBnlk2l+n3STqUSFeaQ==
X-Received: by 2002:a17:906:a456:: with SMTP id cb22mr2278350ejb.80.1550829086710;
        Fri, 22 Feb 2019 01:51:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f6sm168527eja.33.2019.02.22.01.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 01:51:25 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:51:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] drm/qxl: remove conflicting framebuffers earlier
Message-ID: <20190222095123.GA2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190222071604.26024-1-kraxel@redhat.com>
 <20190222071604.26024-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222071604.26024-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:16:04AM +0100, Gerd Hoffmann wrote:
> Add error checking while being at it.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index bb81e310eb6d..578d867a81d5 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -79,6 +79,10 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto free_dev;
>  
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> +	if (ret)
> +		goto disable_pci;
> +
>  	ret = qxl_device_init(qdev, &qxl_driver, pdev);
>  	if (ret)
>  		goto disable_pci;
> @@ -94,7 +98,6 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto modeset_cleanup;
>  
> -	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
>  	drm_fbdev_generic_setup(&qdev->ddev, 32);
>  	return 0;
>  
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
