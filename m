Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7AFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4942098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcth4H3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4942098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeJEPLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbeJEPLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so12564518wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KnHDBIUvlzt9rTbfCGWIVDG2qN/TNs+CUrI8dKvj7bI=;
        b=dcth4H3ROnKOQyOKfGZ3wqLPn8mtEolJcGhLyx8/0zKIcQk4TJIm7O7z4G7SlOSTnz
         ADXuQ1jpCFX+vFMMbgmBjMQkAEEQ3illmAB8I++XTVHTRcT2xR7sGGL04uEWMhdHhSOY
         r+yZxtiB9ejQw2hkDIA3w4InTwEjYyP2DEysE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KnHDBIUvlzt9rTbfCGWIVDG2qN/TNs+CUrI8dKvj7bI=;
        b=exgZZJ8Yw/2gEy/7mB0opD4EewOsEDmzGFxzFkXlS0ygnryVj79U6ThKseq3b8GSul
         owNx+J2INZmlrEGJi3VdrVo0H1XT/oouCj966PJYBMgkvBHdKya5ExXvX2fu7JSB9NxJ
         20ZOcCh9K3VcT++pGBMY8UvCNc2zAqdrQNxfi3TbBgrA+WPbniPle6ZtitsIzY50p7Qr
         cU4srSAl+1mYVDydjflaPVa2vo8KHL194rnqiXrUKbHq3RbuSzlaf822eUqZxbeKf0Re
         DU1qKipx+EX4MuzZFSFLDWf4iqDi7sWyjpZFFqQNnON0+TjpC+NoYpJI91QX18P5yqxk
         lWjQ==
X-Gm-Message-State: ABuFfoiF8THByp+kk/vu5sRcCRCm32ndq31WypI2hdmChu6RhcOaC8sH
        VzCw7lVtk1C2PWjYOJ7XkTPQS9g/vas=
X-Google-Smtp-Source: ACcGV63IEf58R+KLekGZgZT0K0BuHu6Zlug6fS+8p3vaemq45QqA8lsXEqdU7RfrP0IjMws0XPZRLA==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr7729900wrh.72.1538727218578;
        Fri, 05 Oct 2018 01:13:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:37 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/9] patchable function pointers for pluggable crypto routines
Date:   Fri,  5 Oct 2018 10:13:24 +0200
Message-Id: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux's crypto API is widely regarded as being difficult to use for cases
where support for asynchronous accelerators or runtime dispatch of algorithms
(i.e., passed in as a string) are not needed. This leads to kludgy code and
also to actual security issues [0], although arguably, using AES in the wrong
mode can be done using any kind of crypto abstraction.

At the moment, the Zinc library [1] is being proposed as a solution for that,
and while it does address the usability problems, it does a lot more than
that, and what we end up with is a lot less flexible than what we have now.

Currently, arch specific implementations (based on SIMD or optimized
assembler) live in arch/*/crypto, where each sub-community is in charge
of its own specialized versions of the various primitives (although still
under the purview of the crypto maintainer). Any proposal to change this
model should be judged on its own merit, and not blindly accepted as the
fallout of cleaning up some library code.

Also, Zinc removes the possibility to plug different versions of a routine,
and instead, keeps all versions in the same module. Currently, the kernel's
module support permits user land to take charge of the policies that decide
which version to use in which context (by loading or blacklisting modules).
Instead, Zinc moves to a model where the policy is hardcoded into the module
(e.g., ChaCha20 on ARM uses NEON unless on Cortex-A5 or A7). In the ARM
community, we have always attempted to avoid hardcoding policy like that:
the ARM SoC space is a very heteregeneous one, and putting policy like that
into the code will lead to an endless stream of patches from silicon vendors
that want tweaks for their cores into various parts of the kernel.

Creating monolithic modules for algorithms also makes it very difficult to
support driver based implementations. The kernel's driver model is heavily
based on modules, using alias strings to match drivers against the hardware.
As an example, there ARM ST platforms that support synchronous hardware based
CRC32, and plugging that into the monolithic Zinc model is difficult if not
impossible.

The primary justification for moving away from the module system is that it
depends heavily on function pointers, and in the post-Spectre world, those
are vulnerable and costly. For this reason, this series proposes a patchable
function pointer abstraction that, in its generic incarnation, consists
simply of function pointers and some plumbing to set or reset them (patch #1)

Patch #2 illustrates how architectures could optimize these abstractions by
using code patching techniques to get rid of the indirect calls, and use
fixed jumps instead. This has the side effect of making the function
pointer const, making it more robust as well.

The remainder of the series shows how we can use this abstraction to clean
up the CRC-T10DIF handling in the kernel, which is a pretty depressing
example of how cumbersome it is to expose crypto API algorithms as library
routines.

Note that the various arch specific implementations are kept in their
original place as modules, which can be automatically dispatched by udev
(as before) based on CPU feature bits.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Samuel Neves <sneves@dei.uc.pt>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org

[0] commit 428490e38b2e ("security/keys: rewrite all of big_key crypto")
[1] https://lore.kernel.org/lkml/20180925145622.29959-3-Jason@zx2c4.com/

Ard Biesheuvel (9):
  kernel: add support for patchable function pointers
  arm64: kernel: add arch support for patchable function pointers
  crypto: crc-t10dif - make crc_t10dif a static inline
  crypto: crc-t10dif - use patchable function pointer for core update
    routine
  crypto: crc-t10dif/arm64 - move PMULL based code into core library
  crypto: crc-t10dif/arm - move PMULL based code into core library
  crypto: crct10dif/generic - switch crypto API driver to core library
  crypto: crc-t10dif/powerpc - move PMULL based code into core library
  crypto: crc-t10dif/x86 - move PMULL based code into core library

 arch/Kconfig                                |   3 +
 arch/arm/crypto/crct10dif-ce-glue.c         |  78 +++-------
 arch/arm64/Kconfig                          |   1 +
 arch/arm64/crypto/crct10dif-ce-glue.c       |  61 ++------
 arch/arm64/include/asm/ffp.h                |  35 +++++
 arch/arm64/kernel/insn.c                    |  22 +++
 arch/powerpc/crypto/crct10dif-vpmsum_glue.c |  55 +-------
 arch/x86/crypto/crct10dif-pclmul_glue.c     |  98 ++-----------
 crypto/Kconfig                              |   1 +
 crypto/Makefile                             |   2 +-
 crypto/crct10dif_common.c                   |  82 -----------
 crypto/crct10dif_generic.c                  |   4 +-
 include/linux/crc-t10dif.h                  |  24 +++-
 include/linux/ffp.h                         |  43 ++++++
 lib/Kconfig                                 |   2 -
 lib/crc-t10dif.c                            | 149 +++++++-------------
 16 files changed, 235 insertions(+), 425 deletions(-)
 create mode 100644 arch/arm64/include/asm/ffp.h
 delete mode 100644 crypto/crct10dif_common.c
 create mode 100644 include/linux/ffp.h

-- 
2.11.0

