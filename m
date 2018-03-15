Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeCONad (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:30:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:42446 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751915AbeCONab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:30:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="24304478"
Date: Thu, 15 Mar 2018 15:30:26 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Joe Perches <joe@perches.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
Message-ID: <20180315133026.GR5453@intel.com>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 03:02:15PM -0700, Joe Perches wrote:
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

How much would we lose if we move the (drm_debug&FOO) outside the
functions again? I'm somewhat concerned about all the function call
overhead when debugs aren't even enabled.

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
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
>  
>  	va_end(args);
>  }
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 2a4a42e59a47..3a40c5a3a5fa 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -200,9 +200,10 @@ __printf(6, 7)
>  void drm_dev_printk(const struct device *dev, const char *level,
>  		    unsigned int category, const char *function_name,
>  		    const char *prefix, const char *format, ...);
> -__printf(3, 4)
> -void drm_printk(const char *level, unsigned int category,
> -		const char *format, ...);
> +__printf(2, 3)
> +void drm_dbg(unsigned int category, const char *format, ...);
> +__printf(1, 2)
> +void drm_err(const char *format, ...);
>  
>  /* Macros to make printk easier */
>  
> @@ -236,7 +237,7 @@ void drm_printk(const char *level, unsigned int category,
>  	drm_dev_printk(dev, KERN_ERR, DRM_UT_NONE, __func__, " *ERROR*",\
>  		       fmt, ##__VA_ARGS__)
>  #define DRM_ERROR(fmt, ...)						\
> -	drm_printk(KERN_ERR, DRM_UT_NONE, fmt,	##__VA_ARGS__)
> +	drm_err(fmt, ##__VA_ARGS__)
>  
>  /**
>   * Rate limited error output.  Like DRM_ERROR() but won't flood the log.
> @@ -279,40 +280,40 @@ void drm_printk(const char *level, unsigned int category,
>  	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_CORE, __func__, "", fmt,	\
>  		       ##args)
>  #define DRM_DEBUG(fmt, ...)						\
> -	drm_printk(KERN_DEBUG, DRM_UT_CORE, fmt, ##__VA_ARGS__)
> +	drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_DEBUG_DRIVER(dev, fmt, args...)				\
>  	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_DRIVER, __func__, "",	\
>  		       fmt, ##args)
>  #define DRM_DEBUG_DRIVER(fmt, ...)					\
> -	drm_printk(KERN_DEBUG, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
> +	drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_DEBUG_KMS(dev, fmt, args...)				\
>  	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_KMS, __func__, "", fmt,	\
>  		       ##args)
> -#define DRM_DEBUG_KMS(fmt, ...)					\
> -	drm_printk(KERN_DEBUG, DRM_UT_KMS, fmt, ##__VA_ARGS__)
> +#define DRM_DEBUG_KMS(fmt, ...)						\
> +	drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_DEBUG_PRIME(dev, fmt, args...)				\
>  	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_PRIME, __func__, "",	\
>  		       fmt, ##args)
>  #define DRM_DEBUG_PRIME(fmt, ...)					\
> -	drm_printk(KERN_DEBUG, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
> +	drm_dbg(DRM_UT_PRIME, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_DEBUG_ATOMIC(dev, fmt, args...)				\
>  	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_ATOMIC, __func__, "",	\
>  		       fmt, ##args)
>  #define DRM_DEBUG_ATOMIC(fmt, ...)					\
> -	drm_printk(KERN_DEBUG, DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
> +	drm_dbg(DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_DEBUG_VBL(dev, fmt, args...)				\
>  	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_VBL, __func__, "", fmt,	\
>  		       ##args)
> -#define DRM_DEBUG_VBL(fmt, ...)					\
> -	drm_printk(KERN_DEBUG, DRM_UT_VBL, fmt, ##__VA_ARGS__)
> +#define DRM_DEBUG_VBL(fmt, ...)						\
> +	drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEBUG_LEASE(fmt, ...)					\
> -	drm_printk(KERN_DEBUG, DRM_UT_LEASE, fmt, ##__VA_ARGS__)
> +	drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
>  
>  #define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, level, fmt, args...)	\
>  ({									\
> -- 
> 2.15.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel OTC
