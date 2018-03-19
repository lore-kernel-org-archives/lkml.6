Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755619AbeCSOQi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:16:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51103 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755566AbeCSOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:16:31 -0400
X-Google-Smtp-Source: AG47ELubtnB9daMm0zasA9JVLMCW7Hepm8BKIID1GTiwY/i5MNoInU9D6AUJzl0Clbl1/UdCRg0riA==
Date: Mon, 19 Mar 2018 15:16:27 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Joe Perches <joe@perches.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Reduce object size of DRM_DEV_<LEVEL> uses
Message-ID: <20180319141627.GR14155@phenom.ffwll.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <e5c164946e15375ac71b69b75f296efdf0b76e6d.1521233717.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c164946e15375ac71b69b75f296efdf0b76e6d.1521233717.git.joe@perches.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:56:27PM -0700, Joe Perches wrote:
> These macros are similar to the DRM_<LEVEL> with the addition
> of a struct device * to the arguments.
> 
> Convert the single drm_dev_printk function into 2 separate functions.
> drm_dev_printk with a KERN_<LEVEL> * for generic use and drm_dev_dbg
> for conditional masked use.
> 
> Remove the __func__ argument and use __builtin_return_address(0) to be
> similar to the DRM_<LEVEL> macros uses.
> 
> Convert the DRM_DEV_<LEVEL> macros to remove now unnecessary arguments
> and use a consistent style.
> 
> These macros are rarely used in the generic gpu/drm code so the code
> size does not change much for a defconfig, but when more drivers are
> enabled, there is ~4k savings.
> 
> Many of these macros have no existing use at all.
> 
> $ size -t drivers/gpu/drm/built-in.a | tail -1
> 1877530	  44651	    995	1923176	 1d5868	(TOTALS)
> 
> $ size -t drivers/gpu/drm/built-in.a | tail -1
> 1877527	  44651	    995	1923173	 1d5865	(TOTALS)
> 
> $ size -t drivers/gpu/drm/built-in.a | tail -1
> 17166750	2689238	 108352	19964340	130a1b4	(TOTALS)
> 
> $ size -t drivers/gpu/drm/built-in.a | tail -1
> 17168888	2691734	 108352	19968974	130b3ce	(TOTALS)
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks for the resend, applied.
-Daniel

> ---
>  drivers/gpu/drm/drm_print.c | 37 +++++++++++++-----
>  include/drm/drm_print.h     | 94 ++++++++++++++++++++++-----------------------
>  2 files changed, 74 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 79abf6d5b4db..b25f98f33f6c 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -63,16 +63,34 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
>  }
>  EXPORT_SYMBOL(drm_printf);
>  
> -#define DRM_PRINTK_FMT "[" DRM_NAME ":%s]%s %pV"
> -
>  void drm_dev_printk(const struct device *dev, const char *level,
> -		    unsigned int category, const char *function_name,
> -		    const char *prefix, const char *format, ...)
> +		    const char *format, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, format);
> +	vaf.fmt = format;
> +	vaf.va = &args;
> +
> +	if (dev)
> +		dev_printk(level, dev, "[" DRM_NAME ":%ps] %pV",
> +			   __builtin_return_address(0), &vaf);
> +	else
> +		printk("%s" "[" DRM_NAME ":%ps] %pV",
> +		       level, __builtin_return_address(0), &vaf);
> +
> +	va_end(args);
> +}
> +EXPORT_SYMBOL(drm_dev_printk);
> +
> +void drm_dev_dbg(const struct device *dev, unsigned int category,
> +		 const char *format, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (category != DRM_UT_NONE && !(drm_debug & category))
> +	if (!(drm_debug & category))
>  		return;
>  
>  	va_start(args, format);
> @@ -80,14 +98,15 @@ void drm_dev_printk(const struct device *dev, const char *level,
>  	vaf.va = &args;
>  
>  	if (dev)
> -		dev_printk(level, dev, DRM_PRINTK_FMT, function_name, prefix,
> -			   &vaf);
> +		dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
> +			   __builtin_return_address(0), &vaf);
>  	else
> -		printk("%s" DRM_PRINTK_FMT, level, function_name, prefix, &vaf);
> +		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +		       __builtin_return_address(0), &vaf);
>  
>  	va_end(args);
>  }
> -EXPORT_SYMBOL(drm_dev_printk);
> +EXPORT_SYMBOL(drm_dev_dbg);
>  
>  void drm_dbg(unsigned int category, const char *format, ...)
>  {
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 3a40c5a3a5fa..e1a46e9991cc 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -196,10 +196,13 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
>  #define DRM_UT_STATE		0x40
>  #define DRM_UT_LEASE		0x80
>  
> -__printf(6, 7)
> +__printf(3, 4)
>  void drm_dev_printk(const struct device *dev, const char *level,
> -		    unsigned int category, const char *function_name,
> -		    const char *prefix, const char *format, ...);
> +		    const char *format, ...);
> +__printf(3, 4)
> +void drm_dev_dbg(const struct device *dev, unsigned int category,
> +		 const char *format, ...);
> +
>  __printf(2, 3)
>  void drm_dbg(unsigned int category, const char *format, ...);
>  __printf(1, 2)
> @@ -208,10 +211,7 @@ void drm_err(const char *format, ...);
>  /* Macros to make printk easier */
>  
>  #define _DRM_PRINTK(once, level, fmt, ...)				\
> -	do {								\
> -		printk##once(KERN_##level "[" DRM_NAME "] " fmt,	\
> -			     ##__VA_ARGS__);				\
> -	} while (0)
> +	printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
>  
>  #define DRM_INFO(fmt, ...)						\
>  	_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
> @@ -234,8 +234,7 @@ void drm_err(const char *format, ...);
>   * @fmt: printf() like format string.
>   */
>  #define DRM_DEV_ERROR(dev, fmt, ...)					\
> -	drm_dev_printk(dev, KERN_ERR, DRM_UT_NONE, __func__, " *ERROR*",\
> -		       fmt, ##__VA_ARGS__)
> +	drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
>  #define DRM_ERROR(fmt, ...)						\
>  	drm_err(fmt, ##__VA_ARGS__)
>  
> @@ -258,8 +257,7 @@ void drm_err(const char *format, ...);
>  	DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_INFO(dev, fmt, ...)					\
> -	drm_dev_printk(dev, KERN_INFO, DRM_UT_NONE, __func__, "", fmt,	\
> -		       ##__VA_ARGS__)
> +	drm_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEV_INFO_ONCE(dev, fmt, ...)				\
>  ({									\
> @@ -276,53 +274,46 @@ void drm_err(const char *format, ...);
>   * @dev: device pointer
>   * @fmt: printf() like format string.
>   */
> -#define DRM_DEV_DEBUG(dev, fmt, args...)				\
> -	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_CORE, __func__, "", fmt,	\
> -		       ##args)
> +#define DRM_DEV_DEBUG(dev, fmt, ...)					\
> +	drm_dev_dbg(dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
>  #define DRM_DEBUG(fmt, ...)						\
>  	drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
>  
> -#define DRM_DEV_DEBUG_DRIVER(dev, fmt, args...)				\
> -	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_DRIVER, __func__, "",	\
> -		       fmt, ##args)
> +#define DRM_DEV_DEBUG_DRIVER(dev, fmt, ...)				\
> +	drm_dev_dbg(dev, DRM_UT_DRIVER,	fmt, ##__VA_ARGS__)
>  #define DRM_DEBUG_DRIVER(fmt, ...)					\
>  	drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
>  
> -#define DRM_DEV_DEBUG_KMS(dev, fmt, args...)				\
> -	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_KMS, __func__, "", fmt,	\
> -		       ##args)
> +#define DRM_DEV_DEBUG_KMS(dev, fmt, ...)				\
> +	drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
>  #define DRM_DEBUG_KMS(fmt, ...)						\
>  	drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
>  
> -#define DRM_DEV_DEBUG_PRIME(dev, fmt, args...)				\
> -	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_PRIME, __func__, "",	\
> -		       fmt, ##args)
> +#define DRM_DEV_DEBUG_PRIME(dev, fmt, ...)				\
> +	drm_dev_dbg(dev, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
>  #define DRM_DEBUG_PRIME(fmt, ...)					\
>  	drm_dbg(DRM_UT_PRIME, fmt, ##__VA_ARGS__)
>  
> -#define DRM_DEV_DEBUG_ATOMIC(dev, fmt, args...)				\
> -	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_ATOMIC, __func__, "",	\
> -		       fmt, ##args)
> +#define DRM_DEV_DEBUG_ATOMIC(dev, fmt, ...)				\
> +	drm_dev_dbg(dev, DRM_UT_ATOMIC,	fmt, ##__VA_ARGS__)
>  #define DRM_DEBUG_ATOMIC(fmt, ...)					\
>  	drm_dbg(DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
>  
> -#define DRM_DEV_DEBUG_VBL(dev, fmt, args...)				\
> -	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_VBL, __func__, "", fmt,	\
> -		       ##args)
> +#define DRM_DEV_DEBUG_VBL(dev, fmt, ...)				\
> +	drm_dev_dbg(dev, DRM_UT_VBL, fmt, ##__VA_ARGS__)
>  #define DRM_DEBUG_VBL(fmt, ...)						\
>  	drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
>  
>  #define DRM_DEBUG_LEASE(fmt, ...)					\
>  	drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
>  
> -#define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, level, fmt, args...)	\
> +#define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, category, fmt, ...)	\
>  ({									\
>  	static DEFINE_RATELIMIT_STATE(_rs,				\
>  				      DEFAULT_RATELIMIT_INTERVAL,	\
>  				      DEFAULT_RATELIMIT_BURST);		\
>  	if (__ratelimit(&_rs))						\
> -		drm_dev_printk(dev, KERN_DEBUG, DRM_UT_ ## level,	\
> -			       __func__, "", fmt, ##args);		\
> +		drm_dev_dbg(dev, category, fmt, ##__VA_ARGS__);		\
>  })
>  
>  /**
> @@ -331,21 +322,28 @@ void drm_err(const char *format, ...);
>   * @dev: device pointer
>   * @fmt: printf() like format string.
>   */
> -#define DRM_DEV_DEBUG_RATELIMITED(dev, fmt, args...)			\
> -	DEV__DRM_DEFINE_DEBUG_RATELIMITED(dev, CORE, fmt, ##args)
> -#define DRM_DEBUG_RATELIMITED(fmt, args...)				\
> -	DRM_DEV_DEBUG_RATELIMITED(NULL, fmt, ##args)
> -#define DRM_DEV_DEBUG_DRIVER_RATELIMITED(dev, fmt, args...)		\
> -	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRIVER, fmt, ##args)
> -#define DRM_DEBUG_DRIVER_RATELIMITED(fmt, args...)			\
> -	DRM_DEV_DEBUG_DRIVER_RATELIMITED(NULL, fmt, ##args)
> -#define DRM_DEV_DEBUG_KMS_RATELIMITED(dev, fmt, args...)		\
> -	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, KMS, fmt, ##args)
> -#define DRM_DEBUG_KMS_RATELIMITED(fmt, args...)				\
> -	DRM_DEV_DEBUG_KMS_RATELIMITED(NULL, fmt, ##args)
> -#define DRM_DEV_DEBUG_PRIME_RATELIMITED(dev, fmt, args...)		\
> -	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, PRIME, fmt, ##args)
> -#define DRM_DEBUG_PRIME_RATELIMITED(fmt, args...)			\
> -	DRM_DEV_DEBUG_PRIME_RATELIMITED(NULL, fmt, ##args)
> +#define DRM_DEV_DEBUG_RATELIMITED(dev, fmt, ...)			\
> +	_DEV_DRM_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_CORE,		\
> +					  fmt, ##__VA_ARGS__)
> +#define DRM_DEBUG_RATELIMITED(fmt, ...)					\
> +	DRM_DEV_DEBUG_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
> +
> +#define DRM_DEV_DEBUG_DRIVER_RATELIMITED(dev, fmt, ...)			\
> +	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_DRIVER,		\
> +					  fmt, ##__VA_ARGS__)
> +#define DRM_DEBUG_DRIVER_RATELIMITED(fmt, ...)				\
> +	DRM_DEV_DEBUG_DRIVER_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
> +
> +#define DRM_DEV_DEBUG_KMS_RATELIMITED(dev, fmt, ...)			\
> +	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_KMS,		\
> +					  fmt, ##__VA_ARGS__)
> +#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...)				\
> +	DRM_DEV_DEBUG_KMS_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
> +
> +#define DRM_DEV_DEBUG_PRIME_RATELIMITED(dev, fmt, ...)			\
> +	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_PRIME,		\
> +					  fmt, ##__VA_ARGS__)
> +#define DRM_DEBUG_PRIME_RATELIMITED(fmt, ...)				\
> +	DRM_DEV_DEBUG_PRIME_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
>  
>  #endif /* DRM_PRINT_H_ */
> -- 
> 2.15.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
