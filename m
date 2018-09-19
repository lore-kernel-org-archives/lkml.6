Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8903AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E21214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEXQXTuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E21214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbeISGne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbeISGne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:43:34 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3F5214C2;
        Wed, 19 Sep 2018 01:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537319298;
        bh=olxPAX3xdTYidXZ7YEqWcYcGdUo6/MNgxMGtvPcx1Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEXQXTuT3BJEjR/xkYVf+3Mdn0vJyJdcbwr+v4+dqP0BWfLFufczDMOC4bASbriRT
         StZbHIo1YJL/JxtHiQy3PqOJKg1jIuVbeQpdjSOB3VoM/nYT7bX84APU1EXNmWqXVJ
         ZHKfSZi5MSCKmqxGVXRqzHzybbiorQKz9NfWOTWs=
Date:   Tue, 18 Sep 2018 18:08:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH net-next v5 03/20] zinc: ChaCha20 generic C
 implementation and selftest
Message-ID: <20180919010816.GD74746@gmail.com>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918161646.19105-4-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:16:29PM +0200, Jason A. Donenfeld wrote:
> diff --git a/lib/zinc/chacha20/chacha20.c b/lib/zinc/chacha20/chacha20.c
> new file mode 100644
> index 000000000000..3f00e1edd4c8
> --- /dev/null
> +++ b/lib/zinc/chacha20/chacha20.c
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + *
> + * Implementation of the ChaCha20 stream cipher.
> + *
> + * Information: https://cr.yp.to/chacha.html
> + */
> +
> +#include <zinc/chacha20.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <crypto/algapi.h>
> +
> +#ifndef HAVE_CHACHA20_ARCH_IMPLEMENTATION
> +void __init chacha20_fpu_init(void)
> +{
> +}
> +static inline bool chacha20_arch(u8 *out, const u8 *in, const size_t len,
> +				 const u32 key[8], const u32 counter[4],
> +				 simd_context_t *simd_context)
> +{
> +	return false;
> +}
> +static inline bool hchacha20_arch(u8 *derived_key, const u8 *nonce,
> +				  const u8 *key, simd_context_t *simd_context)
> +{
> +	return false;
> +}
> +#endif
> +
> +#define EXPAND_32_BYTE_K 0x61707865U, 0x3320646eU, 0x79622d32U, 0x6b206574U
> +
> +#define QUARTER_ROUND(x, a, b, c, d) ( \
> +	x[a] += x[b], \
> +	x[d] = rol32((x[d] ^ x[a]), 16), \
> +	x[c] += x[d], \
> +	x[b] = rol32((x[b] ^ x[c]), 12), \
> +	x[a] += x[b], \
> +	x[d] = rol32((x[d] ^ x[a]), 8), \
> +	x[c] += x[d], \
> +	x[b] = rol32((x[b] ^ x[c]), 7) \
> +)
> +
> +#define C(i, j) (i * 4 + j)
> +
> +#define DOUBLE_ROUND(x) ( \
> +	/* Column Round */ \
> +	QUARTER_ROUND(x, C(0, 0), C(1, 0), C(2, 0), C(3, 0)), \
> +	QUARTER_ROUND(x, C(0, 1), C(1, 1), C(2, 1), C(3, 1)), \
> +	QUARTER_ROUND(x, C(0, 2), C(1, 2), C(2, 2), C(3, 2)), \
> +	QUARTER_ROUND(x, C(0, 3), C(1, 3), C(2, 3), C(3, 3)), \
> +	/* Diagonal Round */ \
> +	QUARTER_ROUND(x, C(0, 0), C(1, 1), C(2, 2), C(3, 3)), \
> +	QUARTER_ROUND(x, C(0, 1), C(1, 2), C(2, 3), C(3, 0)), \
> +	QUARTER_ROUND(x, C(0, 2), C(1, 3), C(2, 0), C(3, 1)), \
> +	QUARTER_ROUND(x, C(0, 3), C(1, 0), C(2, 1), C(3, 2)) \
> +)
> +
> +#define TWENTY_ROUNDS(x) ( \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x), \
> +	DOUBLE_ROUND(x) \
> +)

Does this consistently perform as well as an implementation that organizes the
operations such that the quarterrounds for all columns/diagonals are
interleaved?  As-is, there are tight dependencies in QUARTER_ROUND() (as well as
in the existing chacha20_block() in lib/chacha20.c, for that matter), so we're
heavily depending on the compiler to do the needed interleaving so as to not get
potentially disastrous performance.  Making it explicit could be a good idea.

> +
> +static void chacha20_block_generic(__le32 *stream, u32 *state)
> +{
> +	u32 x[CHACHA20_BLOCK_WORDS];
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(x); ++i)
> +		x[i] = state[i];
> +
> +	TWENTY_ROUNDS(x);
> +
> +	for (i = 0; i < ARRAY_SIZE(x); ++i)
> +		stream[i] = cpu_to_le32(x[i] + state[i]);
> +
> +	++state[12];
> +}
> +
> +static void chacha20_generic(u8 *out, const u8 *in, u32 len, const u32 key[8],
> +			     const u32 counter[4])
> +{
> +	__le32 buf[CHACHA20_BLOCK_WORDS];
> +	u32 x[] = {
> +		EXPAND_32_BYTE_K,
> +		key[0], key[1], key[2], key[3],
> +		key[4], key[5], key[6], key[7],
> +		counter[0], counter[1], counter[2], counter[3]
> +	};
> +
> +	if (out != in)
> +		memmove(out, in, len);
> +
> +	while (len >= CHACHA20_BLOCK_SIZE) {
> +		chacha20_block_generic(buf, x);
> +		crypto_xor(out, (u8 *)buf, CHACHA20_BLOCK_SIZE);
> +		len -= CHACHA20_BLOCK_SIZE;
> +		out += CHACHA20_BLOCK_SIZE;
> +	}
> +	if (len) {
> +		chacha20_block_generic(buf, x);
> +		crypto_xor(out, (u8 *)buf, len);
> +	}
> +}

If crypto_xor_cpy() is used instead of crypto_xor(), and 'in' is incremented
along with 'out', then the memmove() is not needed.

- Eric
