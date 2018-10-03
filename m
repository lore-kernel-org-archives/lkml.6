Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3099720878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r66F6whZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3099720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeJCMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeJCMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:42:54 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C929020835;
        Wed,  3 Oct 2018 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538546162;
        bh=CJ6awt8fMuMaOMIo6OcnF1Mm9DyzE4LLAQwoYkjVnpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r66F6whZFILkej8NY0bRcPf8ab/ZNqfAJFLZVgEEeoDvmo3zBr4kd1P2rQQD3sMJd
         H9y2ghRJxKYmJN5BQeOSL9c1C20tQlwOkKTvz43nHg911Z4/1Nm/Bu3Q/B8Soov3c5
         dMwXRR/jBuGUS1MVt2EN1O5vLSESQe4MIqOrUiWA=
Date:   Tue, 2 Oct 2018 22:56:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH net-next v6 21/23] crypto: port ChaCha20 to Zinc
Message-ID: <20181003055559.GA745@sol.localdomain>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-22-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925145622.29959-22-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:56:20PM +0200, Jason A. Donenfeld wrote:
> diff --git a/crypto/chacha20_zinc.c b/crypto/chacha20_zinc.c
> new file mode 100644
> index 000000000000..f7d70b3efc31
> --- /dev/null
> +++ b/crypto/chacha20_zinc.c
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <crypto/algapi.h>
> +#include <crypto/internal/skcipher.h>
> +#include <zinc/chacha20.h>
> +#include <linux/module.h>
> +
> +static int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
> +				  unsigned int keysize)
> +{
> +	struct chacha20_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +	if (keysize != CHACHA20_KEY_SIZE)
> +		return -EINVAL;
> +	chacha20_init(ctx, key, 0);
> +	return 0;
> +}
> +
> +static int crypto_chacha20_crypt(struct skcipher_request *req)
> +{
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	struct chacha20_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct skcipher_walk walk;
> +	simd_context_t simd_context;
> +	int err, i;
> +
> +	err = skcipher_walk_virt(&walk, req, true);
> +	if (unlikely(err))
> +		return err;
> +
> +	for (i = 0; i < ARRAY_SIZE(ctx->counter); ++i)
> +		ctx->counter[i] = get_unaligned_le32(walk.iv + i * sizeof(u32));
> +

Multiple threads may use the same tfm concurrently, so the tfm context must not
be used to store per-request information such as the IV.

- Eric
