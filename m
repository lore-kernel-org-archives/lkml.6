Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69FEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD31218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548319718;
	bh=X3gwpEkwvJ3V0dgsIcGcNVeFQJnX1X46o5BLb7Rq1B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RlsVh3BzWZzPoTpeO+Hk8FBJW5gl6SpEh6suhiGWG6LUpWR2fZEBwkOyFHIE+oK6K
	 ot88YvI9lgjSumo1ytFb0tmjDFjFcVpzZhHqRNxcIW+9tmBIJYOTWownIyDoAJ9wSt
	 UnHQe5l17CWZYxHLn6B/sti6YxQ1cOW4fZywoa2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfAXIsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbfAXIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:48:36 -0500
Received: from sol.localdomain (c-24-23-143-129.hsd1.ca.comcast.net [24.23.143.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B50D2184A;
        Thu, 24 Jan 2019 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548319715;
        bh=X3gwpEkwvJ3V0dgsIcGcNVeFQJnX1X46o5BLb7Rq1B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wBk3lrJj0LqrUYAl5ZkKtn0UGIDGMXPHqU3An21CnNY9t1s0iDlKtaErTBbwUGCxf
         2NP1NUKh5LT+2zehH7Dv7jpQ9Qhqaidt5wanmT78SX45aWMk2aMAK1lblS0CY27nO9
         TsUNxWkmkMovsLefgQAGorw9OzAmPNmgt9Rcr/6U=
Date:   Thu, 24 Jan 2019 00:48:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC/RFT PATCH 00/15] crypto: improved skcipher, aead, and hash
 tests
Message-ID: <20190124084818.GA650@sol.localdomain>
References: <20190123224926.250525-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123224926.250525-1-ebiggers@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:49:11PM -0800, Eric Biggers wrote:
> Hello,
> 
> Crypto algorithms must produce the same output for the same input
> regardless of data layout, i.e. how the src and dst scatterlists are
> divided into chunks and how each chunk is aligned.  Request flags such
> as CRYPTO_TFM_REQ_MAY_SLEEP must not affect the result either.
> 
> However, testing of this currently has many gaps.  For example,
> individual algorithms are responsible for providing their own chunked
> test vectors.  But many don't bother to do this or test only one or two
> cases, providing poor test coverage.  Also, other things such as
> misaligned IVs and CRYPTO_TFM_REQ_MAY_SLEEP are never tested at all.
> 
> Test code is also duplicated between the chunked and non-chunked cases,
> making it difficult to make other improvements.
> 
> To improve the situation, this patch series basically moves the chunk
> descriptions into the testmgr itself so that they are shared by all
> algorithms.  However, it's done in an extensible way via a new struct
> 'testvec_config', which describes not just the scaled chunk lengths but
> also all other aspects of the crypto operation besides the data itself
> such as the buffer alignments, the request flags, whether the operation
> is in-place or not, the IV alignment, and for hash algorithms when to do
> each update() and when to use finup() vs. final() vs. digest().
> 
> Then, this patch series makes skcipher, aead, and hash algorithms be
> tested against a list of default testvec_configs, replacing the current
> test code.  This improves overall test coverage, without reducing test
> performance too much.  Note that the test vectors themselves are not
> changed, except for removing the chunk lists.
> 
> This series also adds randomized fuzz tests, enabled by a new kconfig
> option intended for developer use only, where skcipher, aead, and hash
> algorithms are tested against many randomly generated testvec_configs.
> This provides much more comprehensive test coverage.
> 
> These improved tests have already found many bugs.  Patches 1-7 fix the
> bugs found so far (*).  However, I've only tested implementations that I
> can easily test.  There will be more bugs found, especially in
> hardware-specific drivers.  Anyone reading this can help by applying
> these patches on your system (especially if it's non-x86 and/or has
> crypto accelerators), enabling CONFIG_CRYPTO_MANAGER_EXTRA_TESTS, and
> reporting or fixing any test failures.

On an arm64 system with the crypto extensions, crct10dif-arm64-ce and ccm-aes-ce
are failing too:

[    1.632623] alg: hash: crct10dif-arm64-ce test failed (wrong result) on test vector 0, cfg="init+update+update+final two even splits"
[   15.377921] alg: aead: ccm-aes-ce decryption failed with err -74 on test vector 11, cfg="uneven misaligned splits, may sleep"

Ard, I'll fix these when I have time but feel free to get to them first.

> 
> This patch series can also be found in git at
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
> branch "testmgr-improvements".
> 
> (*) Except that many AEADs incorrectly change aead_request::base.tfm.
>     I've left fixing that for later patches.
> 
> Eric Biggers (15):
>   crypto: aegis - fix handling chunked inputs
>   crypto: morus - fix handling chunked inputs
>   crypto: x86/aegis - fix handling chunked inputs and MAY_SLEEP
>   crypto: x86/morus - fix handling chunked inputs and MAY_SLEEP
>   crypto: x86/aesni-gcm - fix crash on empty plaintext
>   crypto: ahash - fix another early termination in hash walk
>   crypto: arm64/aes-neonbs - fix returning final keystream block
>   crypto: testmgr - add testvec_config struct and helper functions
>   crypto: testmgr - introduce CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
>   crypto: testmgr - implement random testvec_config generation
>   crypto: testmgr - convert skcipher testing to use testvec_configs
>   crypto: testmgr - convert aead testing to use testvec_configs
>   crypto: testmgr - convert hash testing to use testvec_configs
>   crypto: testmgr - check for skcipher_request corruption
>   crypto: testmgr - check for aead_request corruption
> 
>  arch/arm64/crypto/aes-neonbs-core.S    |    8 +-
>  arch/x86/crypto/aegis128-aesni-glue.c  |   38 +-
>  arch/x86/crypto/aegis128l-aesni-glue.c |   38 +-
>  arch/x86/crypto/aegis256-aesni-glue.c  |   38 +-
>  arch/x86/crypto/aesni-intel_glue.c     |   13 +-
>  arch/x86/crypto/morus1280_glue.c       |   40 +-
>  arch/x86/crypto/morus640_glue.c        |   39 +-
>  crypto/Kconfig                         |   10 +
>  crypto/aegis128.c                      |   14 +-
>  crypto/aegis128l.c                     |   14 +-
>  crypto/aegis256.c                      |   14 +-
>  crypto/ahash.c                         |   14 +-
>  crypto/morus1280.c                     |   13 +-
>  crypto/morus640.c                      |   13 +-
>  crypto/testmgr.c                       | 2552 +++++++++++++-----------
>  crypto/testmgr.h                       |  407 +---
>  16 files changed, 1558 insertions(+), 1707 deletions(-)
> 
> -- 
> 2.20.1.321.g9e740568ce-goog
> 
