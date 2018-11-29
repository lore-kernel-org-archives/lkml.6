Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C86C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A9D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeK2Rxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:53:35 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:52908 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeK2Rxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:53:34 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gSG8Q-0006p9-KF; Thu, 29 Nov 2018 14:49:14 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gSG8P-0004p5-2w; Thu, 29 Nov 2018 14:49:13 +0800
Date:   Thu, 29 Nov 2018 14:49:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David CARLIER <devnexen@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: use memzero_explicit instead of memset to clear
 contexts.
Message-ID: <20181129064913.wbudlexjzszpa7dq@gondor.apana.org.au>
References: <CA+XhMqz7ZaGVNpkrRM-t4h2f9UZVQPjLVB5Txco4bKGRm8k=mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqz7ZaGVNpkrRM-t4h2f9UZVQPjLVB5Txco4bKGRm8k=mA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 07:36:50PM +0000, David CARLIER wrote:
> There might be a little performance drop but to make sure it stands
> by it comments, we really wipe the whole context after usage.
> ---
>  crypto/chacha20poly1305.c | 3 ++-
>  crypto/md5.c              | 2 +-
>  crypto/rmd128.c           | 3 ++-
>  crypto/rmd160.c           | 3 ++-
>  crypto/rmd256.c           | 3 ++-
>  crypto/rmd320.c           | 3 ++-
>  crypto/sha3_generic.c     | 3 ++-
>  7 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
> index 600afa99941f..6e93d998109e 100644
> --- a/crypto/chacha20poly1305.c
> +++ b/crypto/chacha20poly1305.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/string.h>
> 
>  #include "internal.h"
> 
> @@ -388,7 +389,7 @@ static int poly_genkey(struct aead_request *req)
>         }
> 
>         sg_init_table(creq->src, 1);
> -       memset(rctx->key, 0, sizeof(rctx->key));
> +       memzero_explicit(rctx->key, sizeof(rctx->key));

Please explain the purpose of this patch.  As it stands this
makes no sense.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
