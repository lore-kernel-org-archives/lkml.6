Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB37B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="leL7syyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB37B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeISG0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeISG0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:26:09 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB9A208A3;
        Wed, 19 Sep 2018 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537318256;
        bh=1ffihGFtFaM3vJUYgxBm13EYUcuUHLtdPdYldAk+TLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=leL7syyqaAX0rfgGxv8v3EMWfuEQm5VyMbk3pkfoy7BBTV01H/GGYfaorcFYDSSNg
         4/2VaVGrGGMXH5F9R9Nylj+jtMBb2TgjWERbQb4cZaEKyNNESsvswHqK/0JFrzUZIB
         sJatgIIN3LssF9CyLr+gsaSjupq1nh8Jj0P/PasM=
Date:   Tue, 18 Sep 2018 17:50:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C
 implementations and selftest
Message-ID: <20180919005054.GC74746@gmail.com>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918161646.19105-8-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:16:33PM +0200, Jason A. Donenfeld wrote:
> diff --git a/lib/zinc/poly1305/poly1305.c b/lib/zinc/poly1305/poly1305.c
> new file mode 100644
> index 000000000000..dbab82f33aa7
> --- /dev/null
> +++ b/lib/zinc/poly1305/poly1305.c
> @@ -0,0 +1,155 @@
> +/* SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + *
> + * Implementation of the Poly1305 message authenticator.
> + *
> + * Information: https://cr.yp.to/mac.html
> + */
> +
> +#include <zinc/poly1305.h>
> +
> +#include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +
> +#ifndef HAVE_POLY1305_ARCH_IMPLEMENTATION
> +static inline bool poly1305_init_arch(void *ctx,
> +				      const u8 key[POLY1305_KEY_SIZE])
> +{
> +	return false;
> +}
> +static inline bool poly1305_blocks_arch(void *ctx, const u8 *input,
> +					const size_t len, const u32 padbit,
> +					simd_context_t *simd_context)
> +{
> +	return false;
> +}
> +static inline bool poly1305_emit_arch(void *ctx, u8 mac[POLY1305_MAC_SIZE],
> +				      const u32 nonce[4],
> +				      simd_context_t *simd_context)
> +{
> +	return false;
> +}
> +void __init poly1305_fpu_init(void)
> +{
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
> +#include "poly1305-donna64.h"
> +#else
> +#include "poly1305-donna32.h"
> +#endif
> +
> +void poly1305_init(struct poly1305_ctx *ctx, const u8 key[POLY1305_KEY_SIZE])
> +{
> +	ctx->nonce[0] = get_unaligned_le32(&key[16]);
> +	ctx->nonce[1] = get_unaligned_le32(&key[20]);
> +	ctx->nonce[2] = get_unaligned_le32(&key[24]);
> +	ctx->nonce[3] = get_unaligned_le32(&key[28]);
> +
> +	if (!poly1305_init_arch(ctx->opaque, key))
> +		poly1305_init_generic(ctx->opaque, key);
> +
> +	ctx->num = 0;
> +}
> +EXPORT_SYMBOL(poly1305_init);
> +
> +static inline void poly1305_blocks(void *ctx, const u8 *input, const size_t len,
> +				   const u32 padbit,
> +				   simd_context_t *simd_context)
> +{
> +	if (!poly1305_blocks_arch(ctx, input, len, padbit, simd_context))
> +		poly1305_blocks_generic(ctx, input, len, padbit);
> +}
> +
> +static inline void poly1305_emit(void *ctx, u8 mac[POLY1305_KEY_SIZE],
> +				 const u32 nonce[4],
> +				 simd_context_t *simd_context)
> +{
> +	if (!poly1305_emit_arch(ctx, mac, nonce, simd_context))
> +		poly1305_emit_generic(ctx, mac, nonce);
> +}
> +
> +void poly1305_update(struct poly1305_ctx *ctx, const u8 *input, size_t len,
> +		     simd_context_t *simd_context)
> +{
> +	const size_t num = ctx->num % POLY1305_BLOCK_SIZE;
> +	size_t rem;

0 <= ctx->num < POLY1305_BLOCK_SIZE, so no need to mod by POLY1305_BLOCK_SIZE.

> +
> +	if (num) {
> +		rem = POLY1305_BLOCK_SIZE - num;
> +		if (len < rem) {
> +			memcpy(ctx->data + num, input, len);
> +			ctx->num = num + len;
> +			return;
> +		}
> +		memcpy(ctx->data + num, input, rem);
> +		poly1305_blocks(ctx->opaque, ctx->data, POLY1305_BLOCK_SIZE, 1,
> +				simd_context);
> +		input += rem;
> +		len -= rem;
> +	}
> +
> +	rem = len % POLY1305_BLOCK_SIZE;
> +	len -= rem;
> +
> +	if (len >= POLY1305_BLOCK_SIZE) {
> +		poly1305_blocks(ctx->opaque, input, len, 1, simd_context);
> +		input += len;
> +	}
> +
> +	if (rem)
> +		memcpy(ctx->data, input, rem);
> +
> +	ctx->num = rem;
> +}
> +EXPORT_SYMBOL(poly1305_update);
> +
> +void poly1305_final(struct poly1305_ctx *ctx, u8 mac[POLY1305_MAC_SIZE],
> +		    simd_context_t *simd_context)
> +{
> +	size_t num = ctx->num % POLY1305_BLOCK_SIZE;

Same here.

> +++ b/lib/zinc/selftest/poly1305.h
> @@ -0,0 +1,875 @@
> +/* SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#ifdef DEBUG
> +struct poly1305_testvec {
> +	u8 input[600];
> +	u8 output[POLY1305_MAC_SIZE];
> +	u8 key[POLY1305_KEY_SIZE];
> +	size_t ilen;
> +};
> +
> +static const struct poly1305_testvec poly1305_testvecs[] __initconst = {
> +{ /* RFC7539 */
> +	.input	= { 0x43, 0x72, 0x79, 0x70, 0x74, 0x6f, 0x67, 0x72,
> +		    0x61, 0x70, 0x68, 0x69, 0x63, 0x20, 0x46, 0x6f,
> +		    0x72, 0x75, 0x6d, 0x20, 0x52, 0x65, 0x73, 0x65,
> +		    0x61, 0x72, 0x63, 0x68, 0x20, 0x47, 0x72, 0x6f,
> +		    0x75, 0x70 },
> +	.ilen	= 34,
> +	.output	= { 0xa8, 0x06, 0x1d, 0xc1, 0x30, 0x51, 0x36, 0xc6,
> +		    0xc2, 0x2b, 0x8b, 0xaf, 0x0c, 0x01, 0x27, 0xa9 },
> +	.key	= { 0x85, 0xd6, 0xbe, 0x78, 0x57, 0x55, 0x6d, 0x33,
> +		    0x7f, 0x44, 0x52, 0xfe, 0x42, 0xd5, 0x06, 0xa8,
> +		    0x01, 0x03, 0x80, 0x8a, 0xfb, 0x0d, 0xb2, 0xfd,
> +		    0x4a, 0xbf, 0xf6, 0xaf, 0x41, 0x49, 0xf5, 0x1b },
> +}, { /* "The Poly1305-AES message-authentication code" */

Hardcoding the 'input' array to 600 bytes forces the full amount of space to be
reserved in the kernel image for every test vector.  Also, if anyone adds a
longer test vector they will need to remember to increase the value.

It should be a const pointer instead, like the test vectors in crypto/testmgr.h.

- Eric
