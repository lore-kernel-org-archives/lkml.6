Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeCOPFl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:05:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:1583 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeCOPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:05:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="39177486"
Date: Thu, 15 Mar 2018 17:05:24 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Joe Perches <joe@perches.com>, Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
Message-ID: <20180315150524.GS5453@intel.com>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
 <20180315133026.GR5453@intel.com>
 <1b50f5d8-97a6-2442-34bb-2782c35505fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b50f5d8-97a6-2442-34bb-2782c35505fd@linux.intel.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:04:52PM +0100, Maarten Lankhorst wrote:
> Op 15-03-18 om 14:30 schreef Ville Syrjälä:
> > On Tue, Mar 13, 2018 at 03:02:15PM -0700, Joe Perches wrote:
> >> drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> >> arguments that can be removed by creating separate functins.
> >>
> >> Create specific functions for these calls to reduce x86/64 defconfig
> >> size by ~20k.
> >>
> >> Modify the existing macros to use the specific calls.
> >>
> >> new:
> >> $ size -t drivers/gpu/drm/built-in.a | tail -1
> >> 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
> >>
> >> old:
> >> $ size -t drivers/gpu/drm/built-in.a | tail -1
> >> 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
> >>
> >> Miscellanea:
> >>
> >> o intel_display requires a change to use the specific calls.
> > How much would we lose if we move the (drm_debug&FOO) outside the
> > functions again? I'm somewhat concerned about all the function call
> > overhead when debugs aren't even enabled.
> 
> Upstream:
>    text    data     bss     dec     hex filename
>  377143    5689    4352  387184   5e870 drivers/gpu/drm/drm.ko
> 
> With this patch:
>  373831    5689    4352  383872   5db80 drivers/gpu/drm/drm.ko
> 
> Moving the if outside (below):
>  377629    5689    4352  387670   5ea56 drivers/gpu/drm/drm.ko
> 
> Bye savings..
> 
> I don't think there are any places in which the debug output is performance sensitive,
> so I'm ok with not inlining.

Not performance sensitive as such perhaps. But pointlessly wasting cpu
cycles for nop function calls isn't particularly great. Would be nice
to actually measure how much overhead there is on some weaker systems.
IIRC older Atoms were particularly bad at this stuff.

> ---
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 79abf6d5b4db..928822403a59 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -89,14 +89,11 @@ void drm_dev_printk(const struct device *dev, const char *level,
>  }
>  EXPORT_SYMBOL(drm_dev_printk);
>  
> -void drm_dbg(unsigned int category, const char *format, ...)
> +void __drm_dbg(const char *format, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (!(drm_debug & category))
> -		return;
> -
>  	va_start(args, format);
>  	vaf.fmt = format;
>  	vaf.va = &args;
> @@ -106,7 +103,7 @@ void drm_dbg(unsigned int category, const char *format, ...)
>  
>  	va_end(args);
>  }
> -EXPORT_SYMBOL(drm_dbg);
> +EXPORT_SYMBOL(__drm_dbg);
>  
>  void drm_err(const char *format, ...)
>  {
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 3a40c5a3a5fa..2a145b97bdfc 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -200,8 +200,17 @@ __printf(6, 7)
>  void drm_dev_printk(const struct device *dev, const char *level,
>  		    unsigned int category, const char *function_name,
>  		    const char *prefix, const char *format, ...);
> -__printf(2, 3)
> -void drm_dbg(unsigned int category, const char *format, ...);
> +
> +__printf(1, 2)
> +void __drm_dbg(const char *format, ...);
> +
> +
> +#define drm_dbg(category, format, ...) \
> +	do {	\
> +		if (drm_debug & category)	\
> +			__drm_dbg(format, ## __VA_ARGS__);	\
> +	} while (0)
> +
>  __printf(1, 2)
>  void drm_err(const char *format, ...);
>  

-- 
Ville Syrjälä
Intel OTC
