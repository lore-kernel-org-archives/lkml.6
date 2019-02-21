Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C811D2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RrorxX0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfBUMUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:20:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfBUMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:20:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so22921224edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oD3AQrEAuqIqs/JNzkQTOonBnjczKUPTolwL93v+HpI=;
        b=RrorxX0A2R0B0oHAWpYEro6sKoiuhdDBEjq6+mmDZuk50ab5XE0kD1bFR0MxzQiHzD
         IoAy1HFxkkSK5Wh925vdJ20ZVE3Rn/3jKMkwnEA53j3Bk72xF5voqDVI6QXcLKV5qHU5
         Vw1unX48l8p/stG9HonA29RpahSjfVxkRrKV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oD3AQrEAuqIqs/JNzkQTOonBnjczKUPTolwL93v+HpI=;
        b=r4GVPEfymTjdNG2CUr5I06h+Vig5Exx/kyPKNzXurDeyFHHE8oxcEOP4xb8AJODXLC
         ohS76Fw6U/0TZ8PHiA4kP001+5No/AvBkR8lki05W4OiOT/B8SO4nkJIx4yUdxmOqFcg
         mylzrSXsdO7HesDpVZYFTNGEvNsohOUo5XxmIvfev7VeHc2OllUsax5lO2ItCz3O594Q
         AQ/i49fGUit6vItPiL89Q7D+58nk6HS+uYz66+2cq3XPeyWSvjo4D1vZsmjitQkTZtos
         RZandb0kJNiGiaZ22Gpxbe7QIk1RPj5f5iaASs4Tf0WAKZPfnvvE3e7xT01ZAc6rA+oc
         an8g==
X-Gm-Message-State: AHQUAuZuMsXHYZOzeU3rcNlyN/nrSnB1epzHfyMyWgnWCEDqLTOd7GlE
        i/zcGnSkrZBnCVIyhp13lPdpsQ==
X-Google-Smtp-Source: AHgI3Ia6mpiRmm8owINf4iLK26P/sJHiayB2Soz3eHyf4FHayU/WZBmfzfMVZt131WB3ZQMebciNAQ==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr1476542edq.14.1550751614206;
        Thu, 21 Feb 2019 04:20:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c25sm4147469ejx.59.2019.02.21.04.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 04:20:13 -0800 (PST)
Date:   Thu, 21 Feb 2019 13:20:11 +0100
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
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Message-ID: <20190221122011.GP2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221113534.20764-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:35:34PM +0100, Gerd Hoffmann wrote:
> Problem:  qxl switches from native mode back into vga compatibility mode
> when it notices someone is accessing vga registers.  And vgacon does
> exactly that before fbcon takes over.  So make sure we kick out vgacon
> early enough that it wouldn't disturb us.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index bb81e310eb..08446561aa 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -95,6 +95,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto modeset_cleanup;
>  
>  	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> +	drm_fb_helper_kick_out_vgacon();

I was thinking of checking whether pdev is a VGA class device and whether
it decodes vga access, and in that case automatically calling
kick_out_vgacon from remove_conflicting_pci_framebuffer. Since that's what
drivers want anyway, and those who don't can open code it.

Or is there an issue with that?
-Daniel

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
