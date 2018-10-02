Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A55C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986D920666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986D920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJBKHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:07:13 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:49768 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeJBKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:07:13 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g7BK7-00055F-5k; Tue, 02 Oct 2018 11:26:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g7BK5-0002IU-Br; Tue, 02 Oct 2018 11:26:09 +0800
Date:   Tue, 2 Oct 2018 11:26:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jason@zx2c4.com, sneves@dei.uc.pt,
        luto@kernel.org, jeanphilippe.aumasson@gmail.com,
        ebiggers@google.com
Subject: Re: [PATCH net-next v6 21/23] crypto: port ChaCha20 to Zinc
Message-ID: <20181002032609.o5i2hmphuqtkqgc4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925145622.29959-22-Jason@zx2c4.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Now that ChaCha20 is in Zinc, we can have the crypto API code simply
> call into it. The crypto API expects to have a stored key per instance
> and independent nonces, so we follow suite and store the key and
> initialize the nonce independently.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Samuel Neves <sneves@dei.uc.pt>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
> Cc: Eric Biggers <ebiggers@google.com>
> ---
> arch/arm/configs/exynos_defconfig       |   1 -
> arch/arm/configs/multi_v7_defconfig     |   1 -
> arch/arm/configs/omap2plus_defconfig    |   1 -
> arch/arm/crypto/Kconfig                 |   6 -
> arch/arm/crypto/Makefile                |   2 -
> arch/arm/crypto/chacha20-neon-core.S    | 521 --------------------
> arch/arm/crypto/chacha20-neon-glue.c    | 127 -----
> arch/arm64/configs/defconfig            |   1 -
> arch/arm64/crypto/Kconfig               |   6 -
> arch/arm64/crypto/Makefile              |   3 -
> arch/arm64/crypto/chacha20-neon-core.S  | 450 -----------------
> arch/arm64/crypto/chacha20-neon-glue.c  | 133 -----
> arch/x86/crypto/Makefile                |   3 -
> arch/x86/crypto/chacha20-avx2-x86_64.S  | 448 -----------------
> arch/x86/crypto/chacha20-ssse3-x86_64.S | 630 ------------------------
> arch/x86/crypto/chacha20_glue.c         | 146 ------
> crypto/Kconfig                          |  17 +-
> crypto/Makefile                         |   2 +-
> crypto/chacha20_generic.c               | 136 -----
> crypto/chacha20_zinc.c                  |  90 ++++
> crypto/chacha20poly1305.c               |   8 +-
> include/crypto/chacha20.h               |  12 -
> 22 files changed, 96 insertions(+), 2648 deletions(-)
> delete mode 100644 arch/arm/crypto/chacha20-neon-core.S
> delete mode 100644 arch/arm/crypto/chacha20-neon-glue.c
> delete mode 100644 arch/arm64/crypto/chacha20-neon-core.S
> delete mode 100644 arch/arm64/crypto/chacha20-neon-glue.c
> delete mode 100644 arch/x86/crypto/chacha20-avx2-x86_64.S
> delete mode 100644 arch/x86/crypto/chacha20-ssse3-x86_64.S
> delete mode 100644 arch/x86/crypto/chacha20_glue.c
> delete mode 100644 crypto/chacha20_generic.c
> create mode 100644 crypto/chacha20_zinc.c

Oh nice, so you did the conversion of the existing crypto code.

I presume someone has done the numbers and verified that there
is no performance regression?

If so it would be good to include those numbers somewhere in this
submission (within a patch description so that it goes into git).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
