Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F11C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B320811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730B320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeLMKbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:31:33 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50482 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeLMKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:31:33 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXOH4-0003Nd-W3; Thu, 13 Dec 2018 18:31:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXOH0-0007Qg-Jk; Thu, 13 Dec 2018 18:31:18 +0800
Date:   Thu, 13 Dec 2018 18:31:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, paulcrowley@google.com,
        ard.biesheuvel@linaro.org, Jason@zx2c4.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] crypto: ARM64 NEON optimized XChaCha and
 NHPoly1305 (for Adiantum)
Message-ID: <20181213103118.qkrsjvsjtcq5pzrr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204035252.14853-1-ebiggers@kernel.org>
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
> This series optimizes the Adiantum encryption mode for ARM64 by adding
> an ARM64 NEON accelerated implementation of NHPoly1305, specifically the
> NH part; and by modifying the existing ARM64 NEON implementation of
> ChaCha20 to support XChaCha20 and XChaCha12.
> 
> This greatly improves Adiantum performance on ARM64.  For example,
> encrypting 4096-byte messages (single-threaded) on a Raspberry Pi 3
> Model B v1.2, which has a Cortex-A53 processor:
> 
>                           Before            After
>                           ---------         ---------
> adiantum(xchacha12,aes)    44.1 MB/s         82.7 MB/s
> adiantum(xchacha20,aes)    35.5 MB/s         65.7 MB/s
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
> For comparison, on the same hardware AES-256-XTS encryption is only
> 24.5 MB/s and decryption 21.6 MB/s, both using the NEON-bitsliced
> implementation ("xts-aes-neonbs").  That is the fastest AES-256-XTS
> implementation on this processor, since it doesn't have the ARMv8
> Cryptography Extensions.  This is despite Adiantum also being a super-
> pseudorandom permutation (SPRP) over the entire sector, unlike XTS.
> 
> Note that XChaCha20 and XChaCha12 can be used for other purposes too.
> 
> Changed since v1:
>  - Create full stack frame in hchacha_block_neon() and
>    chacha_block_xor_neon().
>  - Use x30 instead of lr.
>  - Fix whitespace in nh-neon-core.S.
> 
> Eric Biggers (4):
>  crypto: arm64/nhpoly1305 - add NEON-accelerated NHPoly1305
>  crypto: arm64/chacha20 - add XChaCha20 support
>  crypto: arm64/chacha20 - refactor to allow varying number of rounds
>  crypto: arm64/chacha - add XChaCha12 support
> 
> arch/arm64/crypto/Kconfig                     |   7 +-
> arch/arm64/crypto/Makefile                    |   7 +-
> ...hacha20-neon-core.S => chacha-neon-core.S} |  92 +++++---
> arch/arm64/crypto/chacha-neon-glue.c          | 207 ++++++++++++++++++
> arch/arm64/crypto/chacha20-neon-glue.c        | 133 -----------
> arch/arm64/crypto/nh-neon-core.S              | 103 +++++++++
> arch/arm64/crypto/nhpoly1305-neon-glue.c      |  77 +++++++
> 7 files changed, 461 insertions(+), 165 deletions(-)
> rename arch/arm64/crypto/{chacha20-neon-core.S => chacha-neon-core.S} (90%)
> create mode 100644 arch/arm64/crypto/chacha-neon-glue.c
> delete mode 100644 arch/arm64/crypto/chacha20-neon-glue.c
> create mode 100644 arch/arm64/crypto/nh-neon-core.S
> create mode 100644 arch/arm64/crypto/nhpoly1305-neon-glue.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
