Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F87C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62ED215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhU0h6e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62ED215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHGXfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43180 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGXfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id a14-v6so26546pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GJBSyw+dCuiZTzIvf1Q9003/4LB0dv3naSdwyLa2ocs=;
        b=RhU0h6e98v41YBg0ZTy8pO+7Hiags6PuRwMgeEBw9I/NLCb+XYXweLoCxCsuliDc4A
         3pUYLszLvcrk+tYgO+zdpYA/XCCHQeztK476GkPzZkjuGR60QW1HvAxJPTOZf6XaRQVZ
         WxDWr9BY50M30cdj00cqiZNpSu5xVgPt55vl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GJBSyw+dCuiZTzIvf1Q9003/4LB0dv3naSdwyLa2ocs=;
        b=IYes4mK2X5vBZlWa6AyLDvhHMO/QZIe1Cld7JFSTTjr6RhsYblqEBqIB8Xz7BphlZ/
         vghIZ5ew0XNXIHIx8weZXIRZRq7OWjBnfkKBA2l6NDfchjuQzNl8MvP/sYzvvr8nRoER
         /8DrikanW5CFsC5BaXg1pSflMGR4qIOhHOAFR8/LfGFu1od+5fVaeyK7gB+cxeYtRWUl
         JA16IJssQmeKJrbySLc6XOx8oNE0ZCHUCDdVg42STVhuocOyCPvoWGwJBJHHYBGcYYqk
         +ztFnwuifavfXeTpuMvPCHATXDEs7R67vwqKRbyDUZGE0FfiBVOFg+9+GyCUAjto4sr6
         OMEQ==
X-Gm-Message-State: AOUpUlG49qReCkpeOKfbuYzVbtK/9jLK09deN+N30+MA+bjjlZsHo9YM
        G/XYrKK7ASF7kDh0zNl3SiGWByqKTRE=
X-Google-Smtp-Source: AA+uWPzzE9O/ThxdIf3TXndmKi44F3o9HTp6DWG1ku2hgDcUrYWab4GHX8PQ3ep49GXiFs/XqCZTXw==
X-Received: by 2002:a62:9f85:: with SMTP id v5-v6mr81135pfk.27.1533676728213;
        Tue, 07 Aug 2018 14:18:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x87-v6sm4465849pfa.143.2018.08.07.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        qat-linux@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/9] crypto: Remove VLA usage
Date:   Tue,  7 Aug 2018 14:18:34 -0700
Message-Id: <20180807211843.47586-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8 cover letter:

I continue to hope this can land in v4.19, but I realize that's unlikely.
It would be nice, though, if some of the "trivial" patches could get taken
(e.g. cbc, xcbc, ccm VLA removals) so I don't have to keep repeating them.
*fingers crossed*

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

v8:
- remove "impossible condition" BUG-check in cbc.

v7:
- refresh and reorganize without ahash->shash conversions
- merge hash maximums for both shash and ahash

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
 include/crypto/cbc.h                     |  2 +-
 include/crypto/hash.h                    |  6 ++++-
 include/crypto/internal/skcipher.h       |  1 +
 include/crypto/skcipher.h                |  4 ++-
 include/linux/compiler-gcc.h             |  1 -
 15 files changed, 79 insertions(+), 38 deletions(-)

-- 
2.17.1

