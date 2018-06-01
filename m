Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeFASdu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:33:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39508 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeFASdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:33:47 -0400
X-Google-Smtp-Source: ADUXVKKZfgHJ0d+BI+hvGCQiyE92y2+RlGQ/RxIPvM7j3gbiK987Ham4RQMSjEh4ZpfE++EMZj7XoA==
Date: Fri, 1 Jun 2018 11:33:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Message-ID: <20180601183343.GA222005@dtor-ws>
References: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jun 01, 2018 at 11:31:18AM +0300, Andy Shevchenko wrote:
> A lot of code become ugly because of open coding allocations for bitmaps.
> 
> Introduce three helpers to allow users be more clear of intention
> and keep their code neat.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This looks nice and I like how it simplifies drivers. How do we merge
this? 

> ---
>  include/linux/bitmap.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1ee46f492267..845822425393 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> +#include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/kernel.h>
>  
> @@ -104,6 +105,21 @@
>   * contain all bit positions from 0 to 'bits' - 1.
>   */
>  
> +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> +{
> +	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
> +}
> +
> +static inline unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
> +{
> +	return kcalloc(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);

	retrun bitmap_alloc(nbits, flags | __GFP_ZERO);

?

> +}
> +
> +static inline void bitmap_free(const unsigned long *bitmap)
> +{
> +	kfree(bitmap);
> +}
> +
>  /*
>   * lib/bitmap.c provides these functions:
>   */
> -- 
> 2.17.0
> 

Thanks.

-- 
Dmitry
