Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0AC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADCA2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrTEDC/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADCA2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK3KKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbeK3KKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:10:33 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920BF20863;
        Thu, 29 Nov 2018 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543532605;
        bh=qbVpXqNV5w82mADZhfPndKlYoPKicqaXKIgyE6EH1lc=;
        h=From:To:Cc:Subject:Date:From;
        b=PrTEDC/utAmG/3aM1Zl1Imv2KXyllxJDl23XDrQSqsjFEZIIsf9L5PI7IN6aslaUB
         x5d6HWpgxgCCZSI4HXJB2golir6lHpRuZtnZv4vb9ZcC3a+96inDZo4TGwF1ygXbX4
         au02A3HM+UTF304WIny54HBod55NF1ce+Cy/UyYo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] crypto: x86_64 optimized XChaCha and NHPoly1305 (for Adiantum)
Date:   Thu, 29 Nov 2018 15:02:11 -0800
Message-Id: <20181129230217.158038-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series optimizes the Adiantum encryption mode for x86_64 by adding
SSE2 and AVX2 accelerated implementations of NHPoly1305, specifically
the NH part; and by modifying the existing x86_64 SSSE3/AVX2/AVX-512VL
ChaCha20 implementation to support XChaCha20 and XChaCha12.

This greatly improves Adiantum performance on x86_64.  

For example, encrypting 4096-byte messages (single-threaded) on a
Skylake-based processor (Intel Xeon, supports AVX-512VL and AVX2):

                           Before                After
                           --------              ---------
adiantum(xchacha12,aes)    348 MB/s              1458 MB/s
adiantum(xchacha20,aes)    265 MB/s              1240 MB/s

And on a Zen-based processor (Threadripper 1950X, supports AVX2):

                           Before                After
                           --------              ---------
adiantum(xchacha12,aes)    505 MB/s              1250 MB/s
adiantum(xchacha20,aes)    387 MB/s              989 MB/s

Decryption is almost exactly the same speed as encryption.

The biggest benefit comes from accelerating XChaCha.  Accelerating NH
gives a somewhat smaller, but still significant benefit.

Performance on 512-byte inputs is also improved, though that is much
slower in the first place.  When Adiantium is used with dm-crypt (or
cryptsetup), we recommend using a 4096-byte sector size.

For comparison, AES-256-XTS is 2699 MB/s on the Skylake CPU and
4140 MB/s on the Zen CPU.  However, AES has the benefit of direct AES-NI
hardware support whereas Adiantum is implemented entirely with
general-purpose instructions (scalar and SIMD).  Adiantum is also a
super-pseudorandom permutation over the entire sector, unlike XTS.

Note that XChaCha20 and XChaCha12 can be used for other purposes too.

Changed since v1:
  - Rebase on top of latest cryptodev with the AVX-512VL accelerated
    ChaCha20 from Martin Willi.

Eric Biggers (6):
  crypto: x86/nhpoly1305 - add SSE2 accelerated NHPoly1305
  crypto: x86/nhpoly1305 - add AVX2 accelerated NHPoly1305
  crypto: x86/chacha20 - limit the preemption-disabled section
  crypto: x86/chacha20 - add XChaCha20 support
  crypto: x86/chacha20 - refactor to allow varying number of rounds
  crypto: x86/chacha - add XChaCha12 support

 arch/x86/crypto/Makefile                      |  15 +-
 ...a20-avx2-x86_64.S => chacha-avx2-x86_64.S} |  33 +--
 ...12vl-x86_64.S => chacha-avx512vl-x86_64.S} |  35 +--
 ...0-ssse3-x86_64.S => chacha-ssse3-x86_64.S} |  99 ++++---
 arch/x86/crypto/chacha20_glue.c               | 208 -------------
 arch/x86/crypto/chacha_glue.c                 | 280 ++++++++++++++++++
 arch/x86/crypto/nh-avx2-x86_64.S              | 157 ++++++++++
 arch/x86/crypto/nh-sse2-x86_64.S              | 123 ++++++++
 arch/x86/crypto/nhpoly1305-avx2-glue.c        |  77 +++++
 arch/x86/crypto/nhpoly1305-sse2-glue.c        |  76 +++++
 crypto/Kconfig                                |  28 +-
 11 files changed, 839 insertions(+), 292 deletions(-)
 rename arch/x86/crypto/{chacha20-avx2-x86_64.S => chacha-avx2-x86_64.S} (97%)
 rename arch/x86/crypto/{chacha20-avx512vl-x86_64.S => chacha-avx512vl-x86_64.S} (97%)
 rename arch/x86/crypto/{chacha20-ssse3-x86_64.S => chacha-ssse3-x86_64.S} (93%)
 delete mode 100644 arch/x86/crypto/chacha20_glue.c
 create mode 100644 arch/x86/crypto/chacha_glue.c
 create mode 100644 arch/x86/crypto/nh-avx2-x86_64.S
 create mode 100644 arch/x86/crypto/nh-sse2-x86_64.S
 create mode 100644 arch/x86/crypto/nhpoly1305-avx2-glue.c
 create mode 100644 arch/x86/crypto/nhpoly1305-sse2-glue.c

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

