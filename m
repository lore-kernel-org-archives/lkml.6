Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E420880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sc+SXOrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBUJ55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:57:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34655 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:57:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id a16so1064346edn.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHYOidw9+QazQ6rMBNGIIBvow7tlpZ5RHBGhKMEw2a4=;
        b=Sc+SXOrbv3L62e19V71cHbPUSKeLi62HmiQ/nbTERpTcxygSc0QG36cPK0YhaJC2ii
         Malycsr/fLkEoy+JLLioDGajcCuwaCUdXAWI5/PjZNAC3D9AroECdh2YHFUfSfE6aMcO
         iiuEHbRwYqgBqg2fhQ8lkAurr+wqHwXt7sRzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qHYOidw9+QazQ6rMBNGIIBvow7tlpZ5RHBGhKMEw2a4=;
        b=OwaKndEqF+06XvzUzIZS8w/UVIdT1Gj6lmyK3FAhc6QEgBdh8nxR9JlQrEYDKW3Zc0
         VrHSXY3xE94W91LMDSMpF8SDM/9PIYq4DI4MFRi9PIGFJlRXdY44gbxzO4UDBJi1S6k4
         MgbehfwQA8sQpMaXwOYvbc8yyZKf/pistakFJabrAL5ZSwsxdLna+5Eclwkb6RpAZJQS
         iMdPJv0I200m74OOKvcGq2N31/gq+L0Ty9nvxn1gp9yzH5Uw1YFuhkECh+zUKm/oKkka
         y5J+Edk36s5CCuzvJs3ONyEK31/PPa8U7xVwM1Wk8+l5XArwijYEhGCxLsoDnn8psEpd
         ecAA==
X-Gm-Message-State: AHQUAuZGkq2n3vZ5DjBWJY/eUjM0jTHUK3uisp8zkA7D4pDRazngigFa
        tfsTwJcvdvGBeooxA5PcRQL1kDCiaKb++g==
X-Google-Smtp-Source: AHgI3IbjNzT7MhlNxjlkpeRdGkOhj+J4lDwrAA7dADxSAeEGO5AbMHhvuIfZZCBiz9hmlf0U6Zfp9w==
X-Received: by 2002:a17:906:6c8f:: with SMTP id s15mr17502784ejr.133.1550743074474;
        Thu, 21 Feb 2019 01:57:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c5sm6555342edm.36.2019.02.21.01.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 01:57:53 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/qxl: unbind vgacon
Message-ID: <20190221095751.GN2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190220143640.9970-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220143640.9970-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:36:40PM +0100, Gerd Hoffmann wrote:
> Problem:  qxl switches from native mode back into vga compatibility mode
> when it notices someone is accessing vga registers.  And vgacon does
> exactly that before fbcon takes over.
> 
> Before qxl switched to the generic fbdev emulation that didn't cause any
> problems.  With the generic fbdev emulation the switch to vga mode
> happens now and then, probably caused by a initialization order change
> and triggered by a printk in a bad moment.
> 
> So make sure we take vgacon out of the picture by making dummycon
> taking over the console early enough.
> 
> Not entriely happy with the approach, I'm open to better ideas.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index bb81e310eb..88349dc13e 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -30,6 +30,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/console.h>
> +#include <linux/vt_kern.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm.h>
> @@ -89,6 +90,11 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	drm_kms_helper_poll_init(&qdev->ddev);
>  
> +	/* unbind vgacon to make sure it doesn't touch our vga registers */
> +	console_lock();
> +	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, true);
> +	console_unlock();

Still seems very late, in i915 we kick out vgacon as pretty much the first
thing in driver load. See i915_kick_out_vgacon.

I wonder whether we should integrate that logic into
drm_fb_helper_remove_conflicting_pci_framebuffers, by checking whether
that pci device can decode VGA and kick out vgacon in that case. Instead
of sprinkling the same logic over all drivers.
-Daniel

> +
>  	/* Complete initialization. */
>  	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
>  	if (ret)
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
