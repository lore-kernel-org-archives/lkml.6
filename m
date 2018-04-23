Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeDWIDf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:03:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41659 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeDWIDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:03:31 -0400
X-Google-Smtp-Source: AIpwx484z8OPYQ9yQCGJ+4jz/FsyBShj3HqjDgJe2ePgmm4aRQq6jnW2BDFxAeBRe5oHBgpcHodO8w==
Date: Mon, 23 Apr 2018 16:03:28 +0800
From: Geliang Tang <geliangtang@gmail.com>
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
        Nick Terrell <terrelln@fb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: add zstd compression support
Message-ID: <20180423080328.x37v4cvovxoxnqak@OptiPlex>
References: <9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 08:29:31PM +0800, Geliang Tang wrote:
> This patch added the 6th compression algorithm support for pstore: zstd.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> Depend on 'crypto: Add zstd support' by Nick Terrell <terrelln@fb.com>

Hi Kees,

The patch 'crypto: zstd - Add zstd support' has been applied to
linux-next tree, 20180423, already. So we can use zstd in pstore
compression now. Please reconsider if my patch can be applied.

Thanks.
-Geliang

> ---
>  fs/pstore/Kconfig    | 17 ++++++++++++++---
>  fs/pstore/platform.c | 16 ++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 09c19ef91526..63cf4813559a 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -50,12 +50,19 @@ config PSTORE_842_COMPRESS
>  	help
>  	  This option enables 842 compression algorithm support.
>  
> +config PSTORE_ZSTD_COMPRESS
> +	tristate "zstd compression"
> +	depends on PSTORE
> +	select CRYPTO_ZSTD
> +	help
> +	  This option enables zstd compression algorithm support.
> +
>  config PSTORE_COMPRESS
>  	def_bool y
>  	depends on PSTORE
>  	depends on PSTORE_DEFLATE_COMPRESS || PSTORE_LZO_COMPRESS ||	\
>  		   PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||	\
> -		   PSTORE_842_COMPRESS
> +		   PSTORE_842_COMPRESS || PSTORE_ZSTD_COMPRESS
>  
>  choice
>  	prompt "Default pstore compression algorithm"
> @@ -65,8 +72,8 @@ choice
>  	  This change be changed at boot with "pstore.compress=..." on
>  	  the kernel command line.
>  
> -	  Currently, pstore has support for 5 compression algorithms:
> -	  deflate, lzo, lz4, lz4hc and 842.
> +	  Currently, pstore has support for 6 compression algorithms:
> +	  deflate, lzo, lz4, lz4hc, 842 and zstd.
>  
>  	  The default compression algorithm is deflate.
>  
> @@ -85,6 +92,9 @@ choice
>  	config PSTORE_842_COMPRESS_DEFAULT
>  		bool "842" if PSTORE_842_COMPRESS
>  
> +	config PSTORE_ZSTD_COMPRESS_DEFAULT
> +		bool "zstd" if PSTORE_ZSTD_COMPRESS
> +
>  endchoice
>  
>  config PSTORE_COMPRESS_DEFAULT
> @@ -95,6 +105,7 @@ config PSTORE_COMPRESS_DEFAULT
>  	default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT
>  	default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT
>  	default "842" if PSTORE_842_COMPRESS_DEFAULT
> +	default "zstd" if PSTORE_ZSTD_COMPRESS_DEFAULT
>  
>  config PSTORE_CONSOLE
>  	bool "Log kernel console messages"
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 1143ef351c58..9df8cdc378f5 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -34,6 +34,9 @@
>  #if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
>  #include <linux/lz4.h>
>  #endif
> +#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
> +#include <linux/zstd.h>
> +#endif
>  #include <linux/crypto.h>
>  #include <linux/string.h>
>  #include <linux/timer.h>
> @@ -192,6 +195,13 @@ static int zbufsize_842(size_t size)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
> +static int zbufsize_zstd(size_t size)
> +{
> +	return ZSTD_compressBound(size);
> +}
> +#endif
> +
>  static const struct pstore_zbackend *zbackend __ro_after_init;
>  
>  static const struct pstore_zbackend zbackends[] = {
> @@ -224,6 +234,12 @@ static const struct pstore_zbackend zbackends[] = {
>  		.zbufsize	= zbufsize_842,
>  		.name		= "842",
>  	},
> +#endif
> +#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
> +	{
> +		.zbufsize	= zbufsize_zstd,
> +		.name		= "zstd",
> +	},
>  #endif
>  	{ }
>  };
> -- 
> 2.14.1
