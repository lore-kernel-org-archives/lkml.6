Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8FFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59687214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59687214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbeHPJvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:51:45 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:54862 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHPJvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:51:45 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fqCBo-0000sk-Fd; Thu, 16 Aug 2018 14:55:24 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fqCBk-00008g-R9; Thu, 16 Aug 2018 14:55:20 +0800
Date:   Thu, 16 Aug 2018 14:55:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Megha Dey <megha.dey@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] crypto: Remove mcryptd
Message-ID: <20180816065520.pojqi7pplpnknlv5@gondor.apana.org.au>
References: <1526089453-6542-1-git-send-email-megha.dey@linux.intel.com>
 <20180720035325.m5tzeuqsfej3y6wd@gondor.apana.org.au>
 <1532651107.19157.24.camel@megha-Z97X-UD7-TH>
 <20180808095621.h7ecacftx5ofe5ki@gondor.apana.org.au>
 <1533868833.19050.19.camel@megha-Z97X-UD7-TH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533868833.19050.19.camel@megha-Z97X-UD7-TH>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 07:40:33PM -0700, Megha Dey wrote:
>
> 1. 
> @@ -495,7 +534,10 @@ static void cryptd_skcipher_encrypt(struct
> crypto_async_request *base,
>         skcipher_request_set_crypt(subreq, req->src, req->dst,
> req->cryptlen, req->iv);
>  
> -       err = crypto_skcipher_encrypt(subreq);
> +       subreq->base.data = req->base.data;
> +       subreq->base.complete = rctx->complete;
> +       rctx->desc = *subreq;
> +       err = crypto_skcipher_encrypt(&rctx->desc);
>         skcipher_request_zero(subreq);
> 
> This change is necessary because for the multibuffer algorithms, the
> inner algorithm needs a pointer to the original request. In the slow
> path, since we allocate a skcipher_request on the stack, there is no
> easy way to retrieve the request. In the mcryptd_layer, we had extra
> logic to store this pointer. 

Why do you need the original request?

I think the fact that you need this at all indicates that you're
not using cryptd correctly.  cryptd should be completely transparent
to the underlying algorithm.  All it's doing is making sure that
the underlying algorithm gets called in a context that allows SIMD
use.

> Lastly, for hashes, we have
> struct cryptd_hash_request_ctx {
>         crypto_completion_t complete;
>         struct shash_desc desc;
> };
> 
> If we were to use this(with the added fields for multibuffer), we should
> update the shash_desc to ahash_request since we are an async algorithm
> right?

That's a good point.  More importantly, you also need to extend
cryptd to allow an ASYNC underlying algorithm, for skcipher as well
as hashes.  This is not as simple as just modifying the type/mask
during algorithm creation.  But you also need to modify the run-time
(e.g., cryptd_skcipher_encrypt) to defer the completion in case of an
async return value.

The same change also needs to be made to crypto/simd.c, but at least
there the run-time doesn't need any changes AFAICS.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
