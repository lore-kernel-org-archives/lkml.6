Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeD3KSY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:18:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:36323 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbeD3KSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:18:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51101736"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jingoo Han <jingoohan1@gmail.com>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] backlight: Nuke unused backlight.props.state states
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Date: Mon, 30 Apr 2018 13:21:02 +0300
Message-ID: <87o9i19er5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> The backlight power state handling is supremely confusing. We have:
> - props.power, using FB_BLANK_* defines
> - props.fb_blank, using the same, but deprecated int favour of
>   props.state
> - props.state, using the BL_CORE_* defines
> - and finally a bunch of backlight drivers treat brightness == 0 as
>   off. But of course not all of them.
>
> This is way too much confusion to fix in a simple patch, but at least
> prevent more hilarity from spreading by removing the unused BL_CORE_*
> defines. I have no idea why exactly anyone would need that.
>
> Wrt the ideal state, we really just want a boolean state. The 4 power
> saving states that the fbdev subsystem uses are overkill in todays hw
> (this was only relevant for VGA and similar analog circuits like
> TV-out), the new drm atomic modeset api simplified even the uapi to a
> simple bool. And there was never a valid technical reason to have the
> intermediate fbdev power states for backlights (those really only can
> be either off or on).
>
> Cleanup motivated by Meghana's questions about all this.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  include/linux/backlight.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 2baab6f3861d..1db67662bfcb 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -84,9 +84,6 @@ struct backlight_properties {
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
>  #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
> -#define BL_CORE_DRIVER4		(1 << 28)	/* reserved for driver specific use */
> -#define BL_CORE_DRIVER3		(1 << 29)	/* reserved for driver specific use */
> -#define BL_CORE_DRIVER2		(1 << 30)	/* reserved for driver specific use */
>  #define BL_CORE_DRIVER1		(1 << 31)	/* reserved for driver specific use */
>  
>  };

-- 
Jani Nikula, Intel Open Source Technology Center
