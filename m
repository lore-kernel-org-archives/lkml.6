Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeCUHuB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:50:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35445 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeCUHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:49:54 -0400
X-Google-Smtp-Source: AG47ELu4w6xvVq5wLSB/HI8d/8Znp3vBAfB0jFL0bqmKnwLrH2JD3kYkhB14QPwyEgWkz1cWdO03Gw==
Date: Wed, 21 Mar 2018 16:49:48 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, akpm@linux-foundation.org,
        colin.king@canonical.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/1] lz4: Implement lz4 with dynamic offset length.
Message-ID: <20180321074948.GA2746@jagdpanzerIV>
References: <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
 <CGME20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd@epcas5p1.samsung.com>
 <1521607242-3968-2-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521607242-3968-2-git-send-email-maninder1.s@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/21/18 10:10), Maninder Singh wrote:
[..]
> +static struct crypto_alg alg_lz4_dyn = {
> +	.cra_name		= "lz4_dyn",
> +	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
> +	.cra_ctxsize		= sizeof(struct lz4_ctx),
> +	.cra_module		= THIS_MODULE,
> +	.cra_list		= LIST_HEAD_INIT(alg_lz4_dyn.cra_list),
> +	.cra_init		= lz4_init,
> +	.cra_exit		= lz4_exit,
> +	.cra_u			= { .compress = {
> +	.coa_compress		= lz4_compress_crypto_dynamic,
> +	.coa_decompress		= lz4_decompress_crypto_dynamic } }
> +};

[..]

> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 4ed0a78..5bc5aab 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -17,11 +17,15 @@
>  #include <linux/crypto.h>
>  
>  #include "zcomp.h"
> +#define KB	(1 << 10)
>  
>  static const char * const backends[] = {
>  	"lzo",
>  #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
>  	"lz4",
> +#if (PAGE_SIZE < (32 * KB))
> +	"lz4_dyn",
> +#endif

This is not the list of supported algorithms. It's the list of
recommended algorithms. You can configure zram to use any of
available and known to Crypto API algorithms. Including lz4_dyn
on PAGE_SIZE > 32K systems.

	-ss
