Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243BC2159D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243BC2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeI1Lay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:30:54 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42538 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeI1Lay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:30:54 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g5l1M-0008WV-7X; Fri, 28 Sep 2018 13:08:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g5l1I-0005zT-L8; Fri, 28 Sep 2018 13:08:52 +0800
Date:   Fri, 28 Sep 2018 13:08:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, nhorman@tuxdriver.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] crypto: Implement a generic crypto statistics
Message-ID: <20180928050852.zm5nofj4hwcjcqtv@gondor.apana.org.au>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:10:53AM +0000, Corentin Labbe wrote:
> This patch is a try to implement a generic crypto driver statistics.
> The goal is to have an "ifconfig" for crypto device.
> 
> Some driver tried to implement this via a debugfs interface.
> 
> This serie do it directly in the crypto API and give access to stats
> via the crypto_user(netlink) API.
> Then an userspace tool will collect information via netlink.
> Note that this userspace tool is heavily copied from libkcapi and if
> Stephan Mueller agree, I will made a PR for adding getstat to it unless
> tools/crypto is the good place for it.
> 
> Example of output:
> pkcs1pad(rsa-sun8i-ce,sha1)     Akcipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Sign: 0
>         Verify: 5
>         Errors: 0
> cryptd(__xts-aes-ce)    cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> xts-aes-ce      cipher
>         Encrypt: 17 bytes: 4384
>         Decrypt: 17 bytes: 4384
>         Errors: 0
> cryptd(__ctr-aes-ce)    cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> ctr-aes-ce      cipher
>         Encrypt: 19 bytes: 5551
>         Decrypt: 19 bytes: 5551
>         Errors: 0
> cryptd(__cbc-aes-ce)    cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> cbc-aes-ce      cipher
>         Encrypt: 19 bytes: 3040
>         Decrypt: 19 bytes: 3040
>         Errors: 0
> cryptd(__ecb-aes-ce)    cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> ecb-aes-ce      cipher
>         Encrypt: 14 bytes: 2624
>         Decrypt: 14 bytes: 2624
>         Errors: 0
> cbcmac-aes-ce   Hash
>         Hash: 20 bytes: 1244
>         Errors: 0
> xcbc-aes-ce     Hash
>         Hash: 28 bytes: 543
>         Errors: 0
> cmac-aes-ce     Hash
>         Hash: 36 bytes: 1472
>         Errors: 0
> __xts-aes-ce    cipher
>         Encrypt: 17 bytes: 4384
>         Decrypt: 17 bytes: 4384
>         Errors: 0
> ctr-aes-ce      cipher
>         Encrypt: 19 bytes: 5551
>         Decrypt: 19 bytes: 5551
>         Errors: 0
> __ctr-aes-ce    cipher
>         Encrypt: 19 bytes: 5551
>         Decrypt: 19 bytes: 5551
>         Errors: 0
> __cbc-aes-ce    cipher
>         Encrypt: 19 bytes: 3040
>         Decrypt: 19 bytes: 3040
>         Errors: 0
> __ecb-aes-ce    cipher
>         Encrypt: 14 bytes: 2624
>         Decrypt: 14 bytes: 2624
>         Errors: 0
> rsa-sun8i-ce    Akcipher
>         Encrypt: 7 bytes: 232
>         Decrypt: 6 bytes: 1152
>         Sign: 0
>         Verify: 5
>         Errors: 0
> sun8i_ce_rng    RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> ecb(des3_ede-generic)   cipher
>         Encrypt: 24 bytes: 4584
>         Decrypt: 24 bytes: 4584
>         Errors: 0
> ecb-des3-sun8i-ce       cipher
>         Encrypt: 18 bytes: 3072
>         Decrypt: 18 bytes: 3072
>         Errors: 0
> cbc(des3_ede-generic)   cipher
>         Encrypt: 14 bytes: 5104
>         Decrypt: 14 bytes: 5104
>         Errors: 0
> aes-ce  cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> des3_ede-generic        cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> des-generic     cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> aes-arm64       cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> crc32c-arm64-ce Hash
>         Hash: 92 bytes: 20649
>         Errors: 0
> cbc-des3-sun8i-ce       cipher
>         Encrypt: 10 bytes: 3488
>         Decrypt: 10 bytes: 3488
>         Errors: 0
> crc32-arm64-ce  Hash
>         Hash: 92 bytes: 20649
>         Errors: 0
> ecb-aes-sun8i-ce        cipher
>         Encrypt: 18 bytes: 3168
>         Decrypt: 18 bytes: 3168
>         Errors: 0
> cbc-aes-sun8i-ce        cipher
>         Encrypt: 24 bytes: 3712
>         Decrypt: 24 bytes: 3712
>         Errors: 0
> sha256-ce       Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> sha224-ce       Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> cts(cbc-aes-sun8i-ce)   cipher
>         Encrypt: 24 bytes: 956
>         Decrypt: 24 bytes: 956
>         Errors: 0
> sha224-arm64-neon       Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> sha256-arm64-neon       Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> sha224-arm64    Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> sha256-arm64    Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> ctr-aes-sun8i-ce        cipher
>         Encrypt: 24 bytes: 6738
>         Decrypt: 24 bytes: 6738
>         Errors: 0
> sha1-ce Hash
>         Hash: 28 bytes: 9191
>         Errors: 0
> ecdh-generic    KPP
>         Setsecret: 4
>         Generate public key: 3
>         Compute_shared_secret: 4
>         Errors: 0
> ghash-generic   Hash
>         Hash: 32 bytes: 4358
>         Errors: 0
> jitterentropy_rng       RNG
>         Seed: 0
>         Generate: 1 bytes: 48
>         Errors: 0
> drbg_nopr_hmac_sha256   RNG
>        Seed: 5
>         Generate: 9 bytes: 1056
>         Errors: 0
> drbg_nopr_hmac_sha512   RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> drbg_nopr_hmac_sha384   RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> drbg_nopr_hmac_sha1     RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> drbg_pr_hmac_sha256     RNG
>         Seed: 4
>         Generate: 8 bytes: 1024
>         Errors: 0
> drbg_pr_hmac_sha512     RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> drbg_pr_hmac_sha384     RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> drbg_pr_hmac_sha1       RNG
>         Seed: 0
>         Generate: 0 bytes: 0
>         Errors: 0
> crct10dif-generic       Hash
>         Hash: 24 bytes: 19893
>         Errors: 0
> crc32c-generic  Hash
>         Hash: 92 bytes: 20649
>         Errors: 0
> aes-generic     cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> sha224-generic  Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> sha256-generic  Hash
>         Hash: 26 bytes: 8860
>         Errors: 0
> sha1-generic    Hash
>         Hash: 28 bytes: 9191
>         Errors: 0
> digest_null-generic     Hash
>         Hash: 0 bytes: 0
>         Errors: 0
> compress_null-generic   Compress
>         Compress: 0 bytes: 0
>         Decompress: 0 bytes: 0
>         Errors: 0
> ecb-cipher_null cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> cipher_null-generic     cipher
>         Encrypt: 0 bytes: 0
>         Decrypt: 0 bytes: 0
>         Errors: 0
> rsa-generic     Akcipher
>         Encrypt: 17 bytes: 2832
>         Decrypt: 9 bytes: 1920
>         Sign: 0
>         Verify: 36
>         Errors: 0
> 
> Futur possible additions:
> - Add a "number of needed fallback" statistics.
> - statistics for maximum request size
> 
> Please let me know your opinions about it
> 
> Regards
> 
> Changes since v2:
> - added documentation on new struct crypto_alg members.
> 
> Changes since v1:
> - Do not use anymore CRYPTO_MSG_GETALG and added a dedicated CRYPTO_MSG_GETSTAT
> 
> Changes since RFC:
> - Use cryptouser(netlink) instead of /sys
> - Use atomic_t instead of unsigned long
> - moved stat code into dedicated inline function
> - spelling fixes
> 
> Corentin Labbe (2):
>   crypto: Implement a generic crypto statistics
>   crypto: tools: Add cryptostat userspace
> 
>  crypto/Kconfig                               |  11 +
>  crypto/Makefile                              |   1 +
>  crypto/ahash.c                               |  21 +-
>  crypto/algapi.c                              |   8 +
>  crypto/{crypto_user.c => crypto_user_base.c} |   9 +-
>  crypto/crypto_user_stat.c                    | 463 +++++++++++++++++++++++++++
>  crypto/rng.c                                 |   1 +
>  include/crypto/acompress.h                   |  38 ++-
>  include/crypto/aead.h                        |  51 ++-
>  include/crypto/akcipher.h                    |  76 ++++-
>  include/crypto/hash.h                        |  32 +-
>  include/crypto/internal/cryptouser.h         |   8 +
>  include/crypto/kpp.h                         |  51 ++-
>  include/crypto/rng.h                         |  29 +-
>  include/crypto/skcipher.h                    |  44 ++-
>  include/linux/crypto.h                       | 110 ++++++-
>  include/uapi/linux/cryptouser.h              |  52 +++
>  tools/crypto/getstat.c                       | 294 +++++++++++++++++
>  18 files changed, 1264 insertions(+), 35 deletions(-)
>  rename crypto/{crypto_user.c => crypto_user_base.c} (97%)
>  create mode 100644 crypto/crypto_user_stat.c
>  create mode 100644 include/crypto/internal/cryptouser.h
>  create mode 100644 tools/crypto/getstat.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
