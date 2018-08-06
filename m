Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEBFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F7821A77
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC+t9vxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F7821A77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbeHGArA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeHGAqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:46:12 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC94421A56;
        Mon,  6 Aug 2018 22:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533594898;
        bh=jVb/Zs4dTffzVQqDMnz/7zgdmwG89E75pqUBwQx2VnM=;
        h=From:To:Cc:Subject:Date:From;
        b=aC+t9vxWar/5yhQ9lf6wmCIzHwWTEomQ0rmLjNdnAlZbaTky9G/2oJIZ0lPKjefX+
         ieKUY7ZnJXlJwzTIlBUjWiXlxt5rmoeCSvPCIboKAMhI0rOgHEboJ0qAZJm/jfqiCi
         LrFZG/5QquFf3Mvtfplytb/mDU8EpbOcnqfx9LQw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: [RFC PATCH 0/9] crypto: HPolyC support
Date:   Mon,  6 Aug 2018 15:32:51 -0700
Message-Id: <20180806223300.113891-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Hi all,

(Please note that this patchset is a true RFC, i.e. we're not ready for
it to be merged quite yet!)

It was officially decided to *not* allow Android devices to use Speck
encryption [1].  We've been working to find an alternative way to bring
storage encryption to entry-level Android devices like the inexpensive
"Android Go" devices sold in developing countries.  Unfortunately, often
these devices still ship with no encryption, since for cost reasons they
have to use older CPUs like ARM Cortex-A7; and these CPUs lack the ARMv8
Cryptography Extensions, making AES-XTS much too slow.

As we explained in detail earlier, e.g. in [2], this is a very
challenging problem due to the lack of encryption algorithms that meet
the very strict performance requirements, while still being secure and
suitable for practical use in dm-crypt and fscrypt.  And as we saw with
Speck, in this day and age the choice of cryptographic primitives also
has a large political element, restricting the options even further.

Therefore, we (well, Paul Crowley did the real work) designed a new
encryption mode, HPolyC.  In essence, HPolyC makes it secure to use the
ChaCha stream cipher for disk encryption.  HPolyC is specified by our
paper here: https://eprint.iacr.org/2018/720.pdf ("HPolyC:
length-preserving encryption for entry-level processors").  Reference
code and test vectors are here: https://github.com/google/hpolyc.  Many
of the high-level concepts of HPolyC are not new; similar existing modes
include XCB, HCTR, HCH, and HMC.  HPolyC and these modes are true
wide-block modes (tweakable super-pseudorandom permutations), so they
actually provide a stronger notion of security than XTS.

HPolyC encrypts each message using XChaCha12 or XChaCha20 sandwiched
between two passes of Poly1305, plus a single block cipher invocation
(e.g. AES-256) per message.  On ARM Cortex-A7, on 4096-byte messages
HPolyC-XChaCha12-AES is slightly faster than Speck128/256-XTS.  Note
that for long messages, the block cipher is not performance-critical
since it's only invoked once per message; that's why we can use AES in
HPolyC, despite the fully AES-based encryption modes being too slow.

HPolyC is a construction, not a primitive.  It is proven secure if
XChaCha and AES are secure, subject to a security bound.  Unless there
is a mistake in this proof, one therefore does not need to trust HPolyC;
one need only trust XChaCha (which itself has a security reduction to
ChaCha) and AES.

This RFC patchset implements HPolyC for Linux's crypto API.  Patches 1-8
add support for XChaCha20, XChaCha12, and NEON-accelerated Poly1305.
The final patch adds the actual HPolyC template.  Note: my patches may
eventually need to be redone on top of Jason Donenfeld's new crypto
library for WireGuard.  But, I decided to send them out now anyway since
there was a strong desire to give HPolyC a wider audience and I had
already written the patches, and to inform the design discussion for the
new crypto library.

We attest that no "backdoor" or other weakness was inserted into HPolyC,
its implementation, or any other aspect of our work; and that to the
best of our knowledge, HPolyC's security proof is correct.  You don't
have to trust us, though: since HPolyC is a construction, not a
primitive, its security proof can be independently verified by anyone.
We invite additional independent review of HPolyC; and out of caution
(since we did publish our paper only very recently, and we are only
human, and humans can make mistakes even in proofs), we recommend that
this patchset not be merged or used in production quite yet.  Also, this
proposal is not final, and may yet be changed if improvements are found.

This patchset can also be found in git at
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
branch "hpolyc-v1".

Footnotes:

[1] Yes, that means we won't actually be needing my implementations of
    Speck for the crypto API.  So, we no longer have any objection to
    them being removed.  I just ask that if anyone would like to restart
    that discussion, you please start a new thread rather than using
    this one, so as to not derail any discussion on HPolyC.

[2] https://www.spinics.net/lists/linux-crypto/msg33000.html

Eric Biggers (9):
  crypto: chacha20-generic - add HChaCha20 library function
  crypto: chacha20-generic - add XChaCha20 support
  crypto: chacha20-generic - refactor to allow varying number of rounds
  crypto: chacha - add XChaCha12 support
  crypto: arm/chacha20 - add XChaCha20 support
  crypto: arm/chacha20 - refactor to allow varying number of rounds
  crypto: arm/chacha - add XChaCha12 support
  crypto: arm/poly1305 - add NEON accelerated Poly1305 implementation
  crypto: hpolyc - add support for the HPolyC encryption mode

 arch/arm/crypto/Kconfig                       |    7 +-
 arch/arm/crypto/Makefile                      |    6 +-
 ...hacha20-neon-core.S => chacha-neon-core.S} |  107 +-
 arch/arm/crypto/chacha-neon-glue.c            |  207 +++
 arch/arm/crypto/chacha20-neon-glue.c          |  127 --
 arch/arm/crypto/poly1305-neon-core.S          | 1115 ++++++++++++++
 arch/arm/crypto/poly1305-neon-glue.c          |  325 ++++
 arch/arm64/crypto/chacha20-neon-glue.c        |   40 +-
 arch/x86/crypto/chacha20_glue.c               |   52 +-
 crypto/Kconfig                                |   48 +-
 crypto/Makefile                               |    3 +-
 crypto/chacha20_generic.c                     |  136 --
 crypto/chacha20poly1305.c                     |   10 +-
 crypto/chacha_generic.c                       |  216 +++
 crypto/hpolyc.c                               |  577 ++++++++
 crypto/testmgr.c                              |   24 +
 crypto/testmgr.h                              | 1313 +++++++++++++++++
 drivers/char/random.c                         |   50 +-
 include/crypto/chacha.h                       |   56 +
 include/crypto/chacha20.h                     |   28 -
 lib/Makefile                                  |    2 +-
 lib/{chacha20.c => chacha.c}                  |   61 +-
 22 files changed, 4083 insertions(+), 427 deletions(-)
 rename arch/arm/crypto/{chacha20-neon-core.S => chacha-neon-core.S} (89%)
 create mode 100644 arch/arm/crypto/chacha-neon-glue.c
 delete mode 100644 arch/arm/crypto/chacha20-neon-glue.c
 create mode 100644 arch/arm/crypto/poly1305-neon-core.S
 create mode 100644 arch/arm/crypto/poly1305-neon-glue.c
 delete mode 100644 crypto/chacha20_generic.c
 create mode 100644 crypto/chacha_generic.c
 create mode 100644 crypto/hpolyc.c
 create mode 100644 include/crypto/chacha.h
 delete mode 100644 include/crypto/chacha20.h
 rename lib/{chacha20.c => chacha.c} (57%)

-- 
2.18.0.597.ga71716f1ad-goog

