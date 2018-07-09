Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23819C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF9820877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GO8SYpXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF9820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeGIQqB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:46:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44046 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeGIQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:45:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id d17-v6so2367884eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLkeX+3iTh/fW/LtwSQsb3ZFT/2uTDudF8WuDjThBQA=;
        b=GO8SYpXtoYow3BlLOny19oW0Yc+syCttASzoDy7D7cPJcWRth/6djzqn1wWRhAxaB8
         L8gC4F/ma2SFSNqoRro9Qhj74XsUmdmwmlfSsLodP+SZKZoCzsU/TEKPWhVklY9mCjXi
         o59jdqie5JITVijWLk9KUpKfiwt1vENFVCuUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GLkeX+3iTh/fW/LtwSQsb3ZFT/2uTDudF8WuDjThBQA=;
        b=KdKCE2ofpFgqgonWOFbel9LWN1ctN7bhRf4NbmfItlh0WcXCq5usDe4dkCpAcUsCej
         J/h1Qeg9Zl8HSVynis8jqW4R7gdTsXQ3Q6IXqLv7etN9g0S4y1gGjZQQoXIMoimAwuzw
         euZxrl8yXRxbjHupVz67ft9ODNCVbFP6yt6SRO08wmmIJ3Q+6/2ZhUkSy1s0a5rQwrrH
         siGh48LVg0bwceMZlybZ7Go380N171fDiG1IjiYXSHsrv47ieZZA5P9Q6N88rfhigI3Z
         bjMMPJ8diOpxp+dsmUFmQvPqNCC22K706OO9p1ckqp7BuoyNUeViYCBpXOlnmCEEz98M
         iTgg==
X-Gm-Message-State: APt69E0724AHIz3h0QoNZZG+3FgNwl7ilvRBB9fUqBGC1/btX+NYp4M6
        jQZmbV7o2lp/t+3bsWWr48jJIw==
X-Google-Smtp-Source: AAOMgpfUzzj7Ark6sooWWVN3ONqnq3u6GDJoyH0faxmeo1ZtYSu2unNQijnrpCBxU0BYQLRGZGyV6A==
X-Received: by 2002:a50:b0c2:: with SMTP id j60-v6mr24077090edd.188.1531154757975;
        Mon, 09 Jul 2018 09:45:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id j34-v6sm6440097edb.50.2018.07.09.09.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:45:57 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:45:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: vkms: select DRM_KMS_HELPER
Message-ID: <20180709164555.GF3008@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180709154901.1989316-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709154901.1989316-1-arnd@arndb.de>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:48:18PM +0200, Arnd Bergmann wrote:
> Without this, we get link errors during randconfig build:
> 
> drivers/gpu/drm/vkms/vkms_drv.o:(.rodata+0xa0): undefined reference to `drm_atomic_helper_check'
> drivers/gpu/drm/vkms/vkms_drv.o:(.rodata+0xa8): undefined reference to `drm_atomic_helper_commit'
> drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x0): undefined reference to `drm_atomic_helper_update_plane'
> drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x8): undefined reference to `drm_atomic_helper_disable_plane'
> drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x18): undefined reference to `drm_atomic_helper_plane_reset'
> drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x28): undefined reference to `drm_atomic_helper_plane_duplicate_state'
> drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x30): undefined reference to `drm_atomic_helper_plane_destroy_state'
> drivers/gpu/drm/vkms/vkms_output.o:(.rodata+0x1c0): undefined reference to `drm_helper_probe_single_connector_modes'
> drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x40): undefined reference to `drm_atomic_helper_crtc_reset'
> drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x70): undefined reference to `drm_atomic_helper_set_config'
> drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x78): undefined reference to `drm_atomic_helper_page_flip'
> drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x90): undefined reference to `drm_atomic_helper_crtc_duplicate_state'
> drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x98): undefined reference to `drm_atomic_helper_crtc_destroy_state'
> 
> Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")
> Fixes: 1c7c5fd916a0 ("drm/vkms: Introduce basic VKMS driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oops. Thanks for your patch, applied.
-Daniel

> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 516a8f5d1ac6..e527772f5ca6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -214,6 +214,7 @@ config DRM_VGEM
>  config DRM_VKMS
>  	tristate "Virtual KMS (EXPERIMENTAL)"
>  	depends on DRM
> +	select DRM_KMS_HELPER
>  	default n
>  	help
>  	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
> -- 
> 2.9.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
