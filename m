Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCONWj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:22:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:14294 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbeCONWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:22:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="211588067"
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
To: Joe Perches <joe@perches.com>, Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <7dac9dbd-b57b-6e37-c1bb-9ab6c2711613@linux.intel.com>
Date: Thu, 15 Mar 2018 14:22:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 13-03-18 om 23:02 schreef Joe Perches:
> drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> arguments that can be removed by creating separate functins.
>
> Create specific functions for these calls to reduce x86/64 defconfig
> size by ~20k.
>
> Modify the existing macros to use the specific calls.
>
> new:
> $ size -t drivers/gpu/drm/built-in.a | tail -1
> 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
>
> old:
> $ size -t drivers/gpu/drm/built-in.a | tail -1
> 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
>
> Miscellanea:
>
> o intel_display requires a change to use the specific calls.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
I guess this adds up. Nice reduction. :)


>  drivers/gpu/drm/drm_print.c          | 28 +++++++++++++++++++++-------
>  drivers/gpu/drm/i915/intel_display.c | 15 ++++-----------
>  include/drm/drm_print.h              | 27 ++++++++++++++-------------
>  3 files changed, 39 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 781518fd88e3..79abf6d5b4db 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -89,23 +89,37 @@ void drm_dev_printk(const struct device *dev, const char *level,
>  }
>  EXPORT_SYMBOL(drm_dev_printk);
>  
> -void drm_printk(const char *level, unsigned int category,
> -		const char *format, ...)
> +void drm_dbg(unsigned int category, const char *format, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (category != DRM_UT_NONE && !(drm_debug & category))
> +	if (!(drm_debug & category))
>  		return;
>  
>  	va_start(args, format);
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	printk("%s" "[" DRM_NAME ":%ps]%s %pV",
> -	       level, __builtin_return_address(0),
> -	       strcmp(level, KERN_ERR) == 0 ? " *ERROR*" : "", &vaf);
> +	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +	       __builtin_return_address(0), &vaf);
> +
> +	va_end(args);
> +}
> +EXPORT_SYMBOL(drm_dbg);
> +
> +void drm_err(const char *format, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, format);
> +	vaf.fmt = format;
> +	vaf.va = &args;
> +
> +	printk(KERN_ERR "[" DRM_NAME ":%ps] *ERROR* %pV",
> +	       __builtin_return_address(0), &vaf);
>  
>  	va_end(args);
>  }
> -EXPORT_SYMBOL(drm_printk);
> +EXPORT_SYMBOL(drm_err);
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index 2933ad38094f..d8e522e3cd39 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -11059,24 +11059,17 @@ intel_compare_link_m_n(const struct intel_link_m_n *m_n,
>  static void __printf(3, 4)
>  pipe_config_err(bool adjust, const char *name, const char *format, ...)
>  {
> -	char *level;
> -	unsigned int category;
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (adjust) {
> -		level = KERN_DEBUG;
> -		category = DRM_UT_KMS;
> -	} else {
> -		level = KERN_ERR;
> -		category = DRM_UT_NONE;
> -	}
> -
>  	va_start(args, format);
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	drm_printk(level, category, "mismatch in %s %pV", name, &vaf);
> +	if (adjust)
> +		drm_dbg(DRM_UT_KMS, "mismatch in %s %pV", name, &vaf);
> +	else
> +		drm_err("mismatch in %s %pV", name, &vaf);
Could this use DRM_DEBUG_KMS/DRM_ERROR?

Rest looks good, so I can fix up if you want.

~Maarten
