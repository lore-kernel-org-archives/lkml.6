Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEB421531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+87Y9tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEB421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeHCApx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:45:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43018 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbeHCApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:45:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so2125907pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lw1x6/XXm0lKXP9nlcp75yHGkurHRFg6rUCxMz3zWcw=;
        b=G+87Y9txjkKex5p4nQPg8DFpWzDVHI99Z36eo9cmFvI0MpZiXOXcH41b4/+jayE7RI
         LuCn8uhmrdRdTO6+rbN3fEZHowc8vSA9577z5TIJElRHr0ABv3OkiSQjUtbRpq/445+G
         fZaeHlqntKxW6SKEZY9gXAS08sEiQWgKgvK+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lw1x6/XXm0lKXP9nlcp75yHGkurHRFg6rUCxMz3zWcw=;
        b=da/4CpXcAMKTAwNT7nQxk6AkKlHKihCz/qbguhHQvFdcAG1zXASAy9wB60je50eFY+
         iQIafFJ1bYVFDl4WHHl4+hsxL5NqO4HLXJSdp2XYkl8PNnHxHqU9zjFQQFxEsSbXLg30
         C9onzyo7AlIzcaA+4xL+kYrFZOrvJJoPiBVCpi7Rn4KKcULqPzICk1lD9K4W5J5sAc6e
         WN9wdJ9dohLx8XT4Xhz3rXYWjgrPW7aIFl8cI7nxgea/jyVsyfHQRrygTveCM3tARmeB
         305Xi3S9dCI8r6O4lDRWJmAb36XCaPhctDTNdh75XBq2JhiZ7sDvoT3wuBBHd8bJ3TZc
         H7cw==
X-Gm-Message-State: AOUpUlG9RJsqfgcy3OVh2p2xDEfvaGjBz7Cttl2hOk+W7c0ZBP9DQiJk
        IjE+WlU706FTX7shTNMIU0SUbA==
X-Google-Smtp-Source: AAOMgpf6POfbDGJKBxUqZiJ0GIdfhMEqOf0U3K0rG+LM2MBDBbsTeGr/XVHjTkHRxwDzM1g3P0YQSQ==
X-Received: by 2002:aa7:850b:: with SMTP id v11-v6mr1428270pfn.165.1533250320176;
        Thu, 02 Aug 2018 15:52:00 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s184-v6sm4345186pfb.56.2018.08.02.15.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:51:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/9] crypto: Remove VLA usage
Date:   Thu,  2 Aug 2018 15:51:43 -0700
Message-Id: <20180802225152.19194-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7 cover letter:

Since the ahash->shash conversions are going via separate trees, I've
removed those patches from this series. In the meantime, this contains
all the remaining patches for getting rid of almost all VLAs in crypto.
I'd _really_ like to get this landed for v4.19. Any chance of that
happening?

Series cover letter:

This is nearly the last of the VLA removals[1], but it's one of the
largest because crypto gets used in lots of places. After looking
through code, usage, reading the threads Gustavo started, and comparing
the use-cases to the other VLA removals that have landed in the kernel,
I think this series is likely the best way forward to shut the door on
VLAs forever.

For background, the crypto stack usage is for callers to do an immediate
bit of work that doesn't allocate new memory. This means that other VLA
removal techniques (like just using kmalloc) aren't workable, and the
next common technique is needed: examination of maximum stack usage and
the addition of sanity checks. This series does that, and in several
cases, these maximums were already implicit in the code.

This series is intended to land via the crypto tree for 4.19, though it
touches dm, networking, and a few other things as well, since there are
dependent patches (new crypto #defines being used, etc).

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Changelog:

v7:
- refresh and reorganization without ahash->shash conversions

v6:
- make xcbc blocksize unconditional
- add ahash-to-shash conversion patch series to entirely remove
  AHASH_REQUEST_ON_STACK from the kernel

v5:
- limit AHASH_REQUEST_ON_STACK size only to non-async hash wrapping.
- sanity-check ahash reqsize only when doing shash wrapping.
- remove frame_warn changes in favor of shash conversions and other fixes.
- send ahash to shash conversion patches and other fixes separately.

v4:
- add back *_REQUEST_ON_STACK patches.
- programmatically find stack sizes for *_REQUEST_ON_STACK patches.
- whitelist some code that trips FRAME_WARN on 32-bit builds.
- fix alignment patches.

v3:
- drop *_REQUEST_ON_STACK patches. The rest of this series is pretty
  straight-forward, and I'd like to get them tested in -next while
  we continue to chip away at the *_REQUEST_ON_STACK VLA removal patches
  separately. "Part 2" will continue with those.

v2:
- use 512 instead of PAGE_SIZE / 8 to avoid bloat on large-page archs.
- swtich xcbc to "16" max universally.
- fix typo in bounds check for dm buffer size.
- examine actual reqsizes for skcipher and ahash instead of guessing.
- improve names and comments for alg maxes


Ard Biesheuvel (1):
  crypto: ccm: Remove VLA usage

Kees Cook (8):
  crypto: xcbc: Remove VLA usage
  crypto: cbc: Remove VLA usage
  crypto: hash: Remove VLA usage
  dm: Remove VLA usage from hashes
  crypto alg: Introduce generic max blocksize and alignmask
  crypto: qat: Remove VLA usage
  crypto: shash: Remove VLA usage in unaligned hashing
  crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK

 crypto/ahash.c                           |  4 +--
 crypto/algapi.c                          |  7 ++++-
 crypto/algif_hash.c                      |  2 +-
 crypto/ccm.c                             |  9 ++++---
 crypto/shash.c                           | 33 ++++++++++++++----------
 crypto/xcbc.c                            |  8 +++---
 drivers/crypto/qat/qat_common/qat_algs.c |  8 ++++--
 drivers/md/dm-integrity.c                | 23 ++++++++++++-----
 drivers/md/dm-verity-fec.c               |  5 +++-
 include/crypto/algapi.h                  |  4 ++-
 include/crypto/cbc.h                     |  4 ++-
 include/crypto/hash.h                    |  6 ++++-
 include/crypto/internal/skcipher.h       |  1 +
 include/crypto/skcipher.h                |  4 ++-
 include/linux/compiler-gcc.h             |  1 -
 15 files changed, 81 insertions(+), 38 deletions(-)

-- 
2.17.1

