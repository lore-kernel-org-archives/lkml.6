Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B809CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860C220811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860C220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeLMKdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:33:00 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50518 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeLMKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:33:00 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXOIV-0003QJ-K2; Thu, 13 Dec 2018 18:32:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXOIV-0007Rw-G6; Thu, 13 Dec 2018 18:32:51 +0800
Date:   Thu, 13 Dec 2018 18:32:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, paulcrowley@google.com,
        martin@strongswan.org, gmazyland@gmail.com, Jason@zx2c4.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] crypto: x86_64 optimized XChaCha and NHPoly1305
 (for Adiantum)
Message-ID: <20181213103251.laob3i3jejwfolyj@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205062005.27727-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> Hello,
> 
> This series optimizes the Adiantum encryption mode for x86_64 by adding
> SSE2 and AVX2 accelerated implementations of NHPoly1305, specifically
> the NH part; and by modifying the existing x86_64 SSSE3/AVX2/AVX-512VL
> implementation of ChaCha20 to support XChaCha20 and XChaCha12.
> 
> This greatly improves Adiantum performance on x86_64.  
> 
> For example, encrypting 4096-byte messages (single-threaded) on a
> Skylake-based processor (Intel Xeon, supports AVX-512VL and AVX2):
> 
>                           Before                After
>                           --------              ---------
> adiantum(xchacha12,aes)    348 MB/s              1493 MB/s
> adiantum(xchacha20,aes)    266 MB/s              1261 MB/s
> 
> And on a Zen-based processor (Threadripper 1950X, supports AVX2):
> 
>                           Before                After
>                           --------              ---------
> adiantum(xchacha12,aes)    505 MB/s              1292 MB/s
> adiantum(xchacha20,aes)    387 MB/s              1037 MB/s
> 
> Decryption is almost exactly the same speed as encryption.
> 
> The biggest benefit comes from accelerating XChaCha.  Accelerating NH
> gives a somewhat smaller, but still significant benefit.
> 
> Performance on 512-byte inputs is also improved, though that is much
> slower in the first place.  When Adiantium is used with dm-crypt (or
> cryptsetup), we recommend using a 4096-byte sector size.
> 
> For comparison, AES-256-XTS is 2710 MB/s on the Skylake CPU and
> 4140 MB/s on the Zen CPU.  However, AES has the benefit of direct AES-NI
> hardware support whereas Adiantum is implemented entirely with
> general-purpose instructions (scalar and SIMD).  Adiantum is also a
> super-pseudorandom permutation over the entire sector, unlike XTS.
> 
> Note that XChaCha20 and XChaCha12 can be used for other purposes too.
> 
> Changed since v2:
>  - Yield the FPU once per 4096 bytes rather than once per skcipher_walk
>    step.
>  - Create full stack frame in hchacha_block_ssse3() and
>    chacha_block_xor_ssse3().
> 
> Changed since v1:
>  - Rebase on top of latest cryptodev with the AVX-512VL accelerated
>    ChaCha20 from Martin Willi.
> 
> Eric Biggers (6):
>  crypto: x86/nhpoly1305 - add SSE2 accelerated NHPoly1305
>  crypto: x86/nhpoly1305 - add AVX2 accelerated NHPoly1305
>  crypto: x86/chacha20 - add XChaCha20 support
>  crypto: x86/chacha20 - refactor to allow varying number of rounds
>  crypto: x86/chacha - add XChaCha12 support
>  crypto: x86/chacha - yield the FPU occasionally
> 
> arch/x86/crypto/Makefile                      |  15 +-
> ...a20-avx2-x86_64.S => chacha-avx2-x86_64.S} |  33 +-
> ...12vl-x86_64.S => chacha-avx512vl-x86_64.S} |  35 +--
> ...0-ssse3-x86_64.S => chacha-ssse3-x86_64.S} | 104 +++---
> arch/x86/crypto/chacha20_glue.c               | 208 ------------
> arch/x86/crypto/chacha_glue.c                 | 297 ++++++++++++++++++
> arch/x86/crypto/nh-avx2-x86_64.S              | 157 +++++++++
> arch/x86/crypto/nh-sse2-x86_64.S              | 123 ++++++++
> arch/x86/crypto/nhpoly1305-avx2-glue.c        |  77 +++++
> arch/x86/crypto/nhpoly1305-sse2-glue.c        |  76 +++++
> crypto/Kconfig                                |  28 +-
> 11 files changed, 861 insertions(+), 292 deletions(-)
> rename arch/x86/crypto/{chacha20-avx2-x86_64.S => chacha-avx2-x86_64.S} (97%)
> rename arch/x86/crypto/{chacha20-avx512vl-x86_64.S => chacha-avx512vl-x86_64.S} (97%)
> rename arch/x86/crypto/{chacha20-ssse3-x86_64.S => chacha-ssse3-x86_64.S} (92%)
> delete mode 100644 arch/x86/crypto/chacha20_glue.c
> create mode 100644 arch/x86/crypto/chacha_glue.c
> create mode 100644 arch/x86/crypto/nh-avx2-x86_64.S
> create mode 100644 arch/x86/crypto/nh-sse2-x86_64.S
> create mode 100644 arch/x86/crypto/nhpoly1305-avx2-glue.c
> create mode 100644 arch/x86/crypto/nhpoly1305-sse2-glue.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
