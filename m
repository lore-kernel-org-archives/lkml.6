Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3841C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94F520855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="IEt8BOPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBUOMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:12:36 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:34234 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=y0yrI0otAj7WOE7DN2wpA+gCya66EMRYI9Hi8hzp8Kg=;
        b=IEt8BOPjftTtbQyDahuAT26VGsw3F4lod1HV20HuvvYkwYmqf2dtlflCpQNZ3okyMIHxePDxymSSDOwk7Pi5q0d0BAaJpP2GkGdAGKENn1SHv4zu6e7XCIkj4REd6yhUlNeWwcU+avc35Js6sQFCqyd4IkJehWGYAu0BNJgh9oFNN6gkx4JxKoLls1oLm7kcyuziaLr/tvk77e1bgjqcyyrdYrqyot3eLyo45PTX0x6JiSzofyOMFy7N50gBNogb3xafnjW7DurY+zW1ILFOl30o1kJb6O6ryWGcVkrNYuv/WK/py+Dnm61w0nunNNqOZL1d9BjuxSizM3Mp/kqwQA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:63349 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gwp5V-0000Mc-8w; Thu, 21 Feb 2019 15:12:33 +0100
Subject: Re: [PATCH v2 1/2] drm: move i915_kick_out_vgacon to drm_fb_helper
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:INTEL DRM DRIVERS excluding Poulsbo, Moorestow..." 
        <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <64292443-e784-5c15-9e3b-d52afc861991@tronnes.org>
Date:   Thu, 21 Feb 2019 15:12:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221113534.20764-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 21.02.2019 12.35, skrev Gerd Hoffmann:
> It'll be useful for other drivers too, so move it to drm_fb_helper.c
> (and rename it of course).  Also add docs.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fb_helper.h     |  2 ++
>  drivers/gpu/drm/drm_fb_helper.c | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/i915/i915_drv.c | 35 +----------------------------------
>  3 files changed, 42 insertions(+), 34 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index bb9acea613..a401ba47ad 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -649,4 +649,6 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
>  #endif
>  }
>  
> +int drm_fb_helper_kick_out_vgacon(void);
> +

Don't you need a dummy version as well for this one, like how it's done
for the other functions, to cover the case when DRM_FBDEV_EMULATION is
not selected?

Noralf.

>  #endif
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 0e9349ff2d..a2d7e5bc51 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -35,6 +35,7 @@
>  #include <linux/sysrq.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/vt_kern.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_fb_helper.h>
> @@ -3353,3 +3354,41 @@ int __init drm_fb_helper_modinit(void)
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_fb_helper_modinit);
> +
> +/**
> + * drm_fb_helper_kick_out_vgacon - deactivate vgacon driver.
> + *
> + * Deactivate vgacon driver so it stops accessing vga io ports.
> + * Should be called after
> + * drm_fb_helper_remove_conflicting_pci_framebuffers().
> + *
> + * Returns:
> + * Zero on success or negative error code on failure.
> + */
> +int drm_fb_helper_kick_out_vgacon(void)
> +{
> +#if !defined(CONFIG_VGA_CONSOLE)
> +        return 0;
> +#elif !defined(CONFIG_DUMMY_CONSOLE)
> +        return -ENODEV;
> +#else
> +        int ret = 0;
> +
> +        DRM_INFO("Replacing VGA console driver\n");
> +
> +        console_lock();
> +        if (con_is_bound(&vga_con))
> +                ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
> +        if (ret == 0) {
> +                ret = do_unregister_con_driver(&vga_con);
> +
> +                /* Ignore "already unregistered". */
> +                if (ret == -ENODEV)
> +                        ret = 0;
> +        }
> +        console_unlock();
> +
> +        return ret;
> +#endif
> +}
> +EXPORT_SYMBOL(drm_fb_helper_kick_out_vgacon);
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 6630212f2f..3edd4d7d55 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -757,39 +757,6 @@ static int i915_kick_out_firmware_fb(struct drm_i915_private *dev_priv)
>  	return ret;
>  }
>  
> -#if !defined(CONFIG_VGA_CONSOLE)
> -static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
> -{
> -	return 0;
> -}
> -#elif !defined(CONFIG_DUMMY_CONSOLE)
> -static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
> -{
> -	return -ENODEV;
> -}
> -#else
> -static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
> -{
> -	int ret = 0;
> -
> -	DRM_INFO("Replacing VGA console driver\n");
> -
> -	console_lock();
> -	if (con_is_bound(&vga_con))
> -		ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
> -	if (ret == 0) {
> -		ret = do_unregister_con_driver(&vga_con);
> -
> -		/* Ignore "already unregistered". */
> -		if (ret == -ENODEV)
> -			ret = 0;
> -	}
> -	console_unlock();
> -
> -	return ret;
> -}
> -#endif
> -
>  static void intel_init_dpio(struct drm_i915_private *dev_priv)
>  {
>  	/*
> @@ -1420,7 +1387,7 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
>  		goto err_ggtt;
>  	}
>  
> -	ret = i915_kick_out_vgacon(dev_priv);
> +	ret = drm_fb_helper_kick_out_vgacon();
>  	if (ret) {
>  		DRM_ERROR("failed to remove conflicting VGA console\n");
>  		goto err_ggtt;
> 
