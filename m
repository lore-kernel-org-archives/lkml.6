Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C86C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C721476
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCXeZ45X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJIGfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJIGfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:35:07 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BB72089D;
        Mon,  8 Oct 2018 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539040861;
        bh=D0KOIXumy2AIFtaIU+/OeaglhgwOUxXJJxi4G555iYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCXeZ45X+2BoOynuFlYORloD+Ik/TglVZpbs37VtnOU/C+NsJJGAHhaFCjjltKtG+
         JzRv4J42KnRt2z6l8+xXLJT/+X1Y3FQrZCYO5gah9SJkUAfSTvtuAfOvoFyV3pkFag
         pwIAXdI+oQ8xeRfC/k+yw41zD1nk7zu+S8p+FOHQ=
Date:   Mon, 8 Oct 2018 16:21:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v7 25/28] crypto: port Poly1305 to Zinc
Message-ID: <20181008232059.GA164708@gmail.com>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-26-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006025709.4019-26-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 04:57:06AM +0200, Jason A. Donenfeld wrote:
> diff --git a/crypto/poly1305_zinc.c b/crypto/poly1305_zinc.c
> new file mode 100644
> index 000000000000..4794442edf26
> --- /dev/null
> +++ b/crypto/poly1305_zinc.c
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <crypto/algapi.h>
> +#include <crypto/internal/hash.h>
> +#include <zinc/poly1305.h>
> +#include <linux/crypto.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/simd.h>
> +
> +struct poly1305_desc_ctx {
> +	struct poly1305_ctx ctx;
> +	u8 key[POLY1305_KEY_SIZE];
> +	unsigned int rem_key_bytes;
> +};
> +
> +static int crypto_poly1305_init(struct shash_desc *desc)
> +{
> +	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
> +	dctx->rem_key_bytes = POLY1305_KEY_SIZE;
> +	return 0;
> +}
> +
> +static int crypto_poly1305_update(struct shash_desc *desc, const u8 *src,
> +				  unsigned int srclen)
> +{
> +	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
> +	simd_context_t simd_context;
> +
> +	if (unlikely(dctx->rem_key_bytes)) {
> +		unsigned int key_bytes = min(srclen, dctx->rem_key_bytes);
> +		memcpy(dctx->key + (POLY1305_KEY_SIZE - dctx->rem_key_bytes),
> +		       src, key_bytes);
> +		src += key_bytes;
> +		srclen -= key_bytes;
> +		dctx->rem_key_bytes -= key_bytes;
> +		if (!dctx->rem_key_bytes) {
> +			poly1305_init(&dctx->ctx, dctx->key);
> +			memzero_explicit(dctx->key, sizeof(dctx->key));
> +		}
> +		if (!srclen)
> +			return 0;
> +	}
> +
> +	simd_get(&simd_context);
> +	poly1305_update(&dctx->ctx, src, srclen, &simd_context);
> +	simd_put(&simd_context);
> +
> +	return 0;
> +}
> +
> +static int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
> +{
> +	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
> +	simd_context_t simd_context;
> +
> +	simd_get(&simd_context);
> +	poly1305_final(&dctx->ctx, dst, &simd_context);
> +	simd_put(&simd_context);
> +	return 0;
> +}

This crashes on very short inputs.  crypto_poly1305_final() is missing:

	if (dctx->rem_key_bytes)
		return -ENOKEY;

- Eric
