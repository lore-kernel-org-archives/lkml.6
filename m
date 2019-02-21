Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C281207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfBUNGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:06:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:30280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBUNGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:06:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 05:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="148683055"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2019 05:06:31 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:INTEL DRM DRIVERS \(excluding Poulsbo\, Moorestow..." 
        <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm: move i915_kick_out_vgacon to drm_fb_helper
In-Reply-To: <20190221113534.20764-2-kraxel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190221113534.20764-1-kraxel@redhat.com> <20190221113534.20764-2-kraxel@redhat.com>
Date:   Thu, 21 Feb 2019 15:08:39 +0200
Message-ID: <87ef81thk8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019, Gerd Hoffmann <kraxel@redhat.com> wrote:
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

Please retain the original way of keeping conditional compilation
outside of functions.

BR,
Jani.

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

-- 
Jani Nikula, Intel Open Source Graphics Center
