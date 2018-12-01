Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4CAC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BBC20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BBC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strongswan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeLBDxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:53:38 -0500
Received: from sitav-80046.hsr.ch ([152.96.80.46]:41214 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeLBDxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:53:37 -0500
Received: from book (unknown [IPv6:2a01:2a8:8106:7c01:b5f0:8f23:2aa:553])
        by mail.strongswan.org (Postfix) with ESMTPSA id F0FCE40128;
        Sat,  1 Dec 2018 17:40:40 +0100 (CET)
Message-ID: <99ed681fa4d3233b18ae9328a14f9e23971073cb.camel@strongswan.org>
Subject: Re: [PATCH v2 4/6] crypto: x86/chacha20 - add XChaCha20 support
From:   Martin Willi <martin@strongswan.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 01 Dec 2018 17:40:40 +0100
In-Reply-To: <20181129230217.158038-5-ebiggers@kernel.org>
References: <20181129230217.158038-1-ebiggers@kernel.org>
         <20181129230217.158038-5-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> An SSSE3 implementation of single-block HChaCha20 is also added so
> that XChaCha20 can use it rather than the generic
> implementation.  This required refactoring the ChaCha permutation
> into its own function. 

> [...]

> +ENTRY(chacha20_block_xor_ssse3)
> +	# %rdi: Input state matrix, s
> +	# %rsi: up to 1 data block output, o
> +	# %rdx: up to 1 data block input, i
> +	# %rcx: input/output length in bytes
> +
> +	# x0..3 = s0..3
> +	movdqa		0x00(%rdi),%xmm0
> +	movdqa		0x10(%rdi),%xmm1
> +	movdqa		0x20(%rdi),%xmm2
> +	movdqa		0x30(%rdi),%xmm3
> +	movdqa		%xmm0,%xmm8
> +	movdqa		%xmm1,%xmm9
> +	movdqa		%xmm2,%xmm10
> +	movdqa		%xmm3,%xmm11
> +
> +	mov		%rcx,%rax
> +	call		chacha20_permute
> +
>  	# o0 = i0 ^ (x0 + s0)
>  	paddd		%xmm8,%xmm0
>  	cmp		$0x10,%rax
> @@ -189,6 +198,23 @@ ENTRY(chacha20_block_xor_ssse3)
>  
>  ENDPROC(chacha20_block_xor_ssse3)
>  
> +ENTRY(hchacha20_block_ssse3)
> +	# %rdi: Input state matrix, s
> +	# %rsi: output (8 32-bit words)
> +
> +	movdqa		0x00(%rdi),%xmm0
> +	movdqa		0x10(%rdi),%xmm1
> +	movdqa		0x20(%rdi),%xmm2
> +	movdqa		0x30(%rdi),%xmm3
> +
> +	call		chacha20_permute

AFAIK, the general convention is to create proper stack frames using
FRAME_BEGIN/END for non leaf-functions. Should chacha20_permute()
callers do so?

For the other parts:

Reviewed-by: Martin Willi <martin@strongswan.org>


