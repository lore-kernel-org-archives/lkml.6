Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F82081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLJadPiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155F82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeK1Rry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeK1Rry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:47:54 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7B82081C;
        Wed, 28 Nov 2018 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543387638;
        bh=49uL3aKayr8gGNhrRgtgskoDn0V6OK/PammZ9eWo87w=;
        h=From:To:Cc:Subject:Date:From;
        b=LLJadPiUqN06tgTyFRk00Rv+HzKiXevVHPHBVEnkAexPZM6Srl0PB5T0MLWz0XYH0
         9KwtXAOTvu5dIKVKwt/t4ad1ckLFUX0+J6z5sSoGklrphRAJRt/2CwSZ6BfNtuxt24
         52MhAA6VuPFD5bXZzXIQuupY5lnI/TL1SLpWn1J8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] crypto: x86_64 optimized XChaCha and NHPoly1305 (for Adiantum)
Date:   Tue, 27 Nov 2018 22:44:39 -0800
Message-Id: <20181128064445.3813-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
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
the NH part; and by modifying the existing x86_64 SSSE3/AVX2 ChaCha20
implementation to support XChaCha20 and XChaCha12.

This greatly improves Adiantum performance on x86_64.  For example, with
a 4096-byte input size on a Zen-based processor, which supports AVX2:

                           Before                After
                           --------              ---------
adiantum(xchacha12,aes)    505 MB/s              1250 MB/s
adiantum(xchacha20,aes)    387 MB/s              989 MB/s

Encryption and decryption are the same speed.

The biggest benefit comes from accelerating XChaCha.  Accelerating NH
gives a somewhat smaller, but still significant benefit.

Performance on 512-byte inputs is also improved, though that is much
slower in the first place.  When Adiantium is used with dm-crypt (or
cryptsetup), we recommend using a 4096-byte sector size.

For comparison, AES-256-XTS is 4140 MB/s on the same processor, but it
has the benefit of direct AES-NI hardware support for AES whereas
Adiantum is implemented entirely with general-purpose instructions
(scalar and SIMD).  The corresponding C implementation of AES-256-XTS is
only 288 MB/s, and AES isn't particularly well-suited for optimizing
with general-purpose SIMD instructions.  Also unlike Adiantum, XTS isn't
a super-pseudorandom permutation over the entire sector.

Note that XChaCha20 and XChaCha12 can be used for other purposes too.

Eric Biggers (6):
  crypto: x86/nhpoly1305 - add SSE2 accelerated NHPoly1305
  crypto: x86/nhpoly1305 - add AVX2 accelerated NHPoly1305
  crypto: x86/chacha20 - limit the preemption-disabled section
  crypto: x86/chacha20 - add XChaCha20 support
  crypto: x86/chacha20 - refactor to allow varying number of rounds
  crypto: x86/chacha - add XChaCha12 support

 arch/x86/crypto/Makefile                      |  13 +-
 ...a20-avx2-x86_64.S => chacha-avx2-x86_64.S} |  33 ++-
 ...0-ssse3-x86_64.S => chacha-ssse3-x86_64.S} |  99 +++++---
 arch/x86/crypto/chacha20_glue.c               | 168 -------------
 arch/x86/crypto/chacha_glue.c                 | 236 ++++++++++++++++++
 arch/x86/crypto/nh-avx2-x86_64.S              | 157 ++++++++++++
 arch/x86/crypto/nh-sse2-x86_64.S              | 123 +++++++++
 arch/x86/crypto/nhpoly1305-avx2-glue.c        |  77 ++++++
 arch/x86/crypto/nhpoly1305-sse2-glue.c        |  76 ++++++
 crypto/Kconfig                                |  28 ++-
 10 files changed, 778 insertions(+), 232 deletions(-)
 rename arch/x86/crypto/{chacha20-avx2-x86_64.S => chacha-avx2-x86_64.S} (97%)
 rename arch/x86/crypto/{chacha20-ssse3-x86_64.S => chacha-ssse3-x86_64.S} (93%)
 delete mode 100644 arch/x86/crypto/chacha20_glue.c
 create mode 100644 arch/x86/crypto/chacha_glue.c
 create mode 100644 arch/x86/crypto/nh-avx2-x86_64.S
 create mode 100644 arch/x86/crypto/nh-sse2-x86_64.S
 create mode 100644 arch/x86/crypto/nhpoly1305-avx2-glue.c
 create mode 100644 arch/x86/crypto/nhpoly1305-sse2-glue.c

-- 
2.19.2

