Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC1BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD7D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLD+tGWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD7D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeK2Rje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbeK2Rje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:39:34 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4C020834;
        Thu, 29 Nov 2018 06:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543473316;
        bh=qE6um5/Ld25wimfRkRA8oMVIpoIiqUxz8qZNKUwE4sA=;
        h=From:To:Cc:Subject:Date:From;
        b=FLD+tGWNDtFwP00HHNn5/C8o2GyLevi+e2tmOoWcNR3SWnUuuPf07clJmn8SQloCy
         Po2LgZs4eCMHD14ZR4gm5gUle2SbAlwMYLA0BSa/RBrCwELvRGgUjLqqNh2HObYFOi
         F7HxtgUALkj4AxZgthQYvtFKpD6R2ow0Baa+p6BM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: ARM64 NEON optimized XChaCha and NHPoly1305 (for Adiantum)
Date:   Wed, 28 Nov 2018 22:34:18 -0800
Message-Id: <20181129063422.24307-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series optimizes the Adiantum encryption mode for ARM64 by adding
an ARM64 NEON accelerated implementation of NHPoly1305, specifically the
NH part; and by modifying the existing ARM64 NEON ChaCha20
implementation to support XChaCha20 and XChaCha12.

This greatly improves Adiantum performance on ARM64.  For example,
encrypting 4096-byte messages (single-threaded) on a Raspberry Pi 3
Model B v1.2, which has a Cortex-A53 processor:

                           Before            After
                           ---------         ---------
adiantum(xchacha12,aes)    44.1 MB/s         82.7 MB/s
adiantum(xchacha20,aes)    35.5 MB/s         65.7 MB/s

Decryption is the same speed as encryption.

The biggest benefit comes from accelerating XChaCha.  Accelerating NH
gives a somewhat smaller, but still significant benefit.

Performance on 512-byte inputs is also improved, though that is much
slower in the first place.  When Adiantium is used with dm-crypt (or
cryptsetup), we recommend using a 4096-byte sector size.

For comparison, on the same hardware AES-256-XTS encryption is only
24.5 MB/s and decryption 21.6 MB/s, both using the NEON-bitsliced
implementation ("xts-aes-neonbs").  That is the fastest AES-256-XTS
implementation on this processor, since it doesn't have the ARMv8
Cryptography Extensions.  This is despite Adiantum also being a super-
pseudorandom permutation (SPRP) over the entire sector, unlike XTS.

Note that XChaCha20 and XChaCha12 can be used for other purposes too.

Eric Biggers (4):
  crypto: arm64/nhpoly1305 - add NEON-accelerated NHPoly1305
  crypto: arm64/chacha20 - add XChaCha20 support
  crypto: arm64/chacha20 - refactor to allow varying number of rounds
  crypto: arm64/chacha - add XChaCha12 support

 arch/arm64/crypto/Kconfig                     |   7 +-
 arch/arm64/crypto/Makefile                    |   7 +-
 ...hacha20-neon-core.S => chacha-neon-core.S} |  89 +++++---
 arch/arm64/crypto/chacha-neon-glue.c          | 207 ++++++++++++++++++
 arch/arm64/crypto/chacha20-neon-glue.c        | 133 -----------
 arch/arm64/crypto/nh-neon-core.S              | 103 +++++++++
 arch/arm64/crypto/nhpoly1305-neon-glue.c      |  77 +++++++
 7 files changed, 457 insertions(+), 166 deletions(-)
 rename arch/arm64/crypto/{chacha20-neon-core.S => chacha-neon-core.S} (90%)
 create mode 100644 arch/arm64/crypto/chacha-neon-glue.c
 delete mode 100644 arch/arm64/crypto/chacha20-neon-glue.c
 create mode 100644 arch/arm64/crypto/nh-neon-core.S
 create mode 100644 arch/arm64/crypto/nhpoly1305-neon-glue.c

-- 
2.19.2

