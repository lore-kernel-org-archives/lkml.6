Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B08C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC33720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JA5B9Ujw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC33720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbeGKUmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42974 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389955AbeGKUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so7505309pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jj0pkfTBIjWct087fskH5x0QMPDXl7/gpbVHYmY2BxQ=;
        b=JA5B9UjwK47KRcFfEkfXlTgfcPAJi1Ot399s36UQ1hjXdbEnpwN9Y2QjEtSpYWGu8Z
         Vq6jQ78EdfMu/g94oRkQr1SwgAZLEWiShfSN46/qoT6AVR/klrLTP0kw99n2ianXxUBf
         L+FT3qA1rGzxeVhBaDNQhGBz3jmd8GxX8B3ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jj0pkfTBIjWct087fskH5x0QMPDXl7/gpbVHYmY2BxQ=;
        b=hcio3TYiPSqItbtd5hIWeM4J4X8yOx0hoDQAs1ze74gz66hTZULRtJiXImydiqVsS+
         Wv0GUQcx88rmSkiQSAdksRbq/KV+23dk+Lpy79gMGnipljI0ryGwXboGuKguKt0TbjfN
         aW6pJYmsp+8fC0tUgb1fApGPebKLUegw9aJeBvL6RVl8qGl1HbsgHG1lTQyCsPTMOW2y
         F+3GI2bao+wtC/3192D43jqkerbEn/xWYms2QVOa9AAWDbJZuqFl51RCh+IgjydNYVJW
         ku5P+1awQVut/MVLf/1Trl4hHO2MAF2LIwaq1P+/kLXMTW6ptAksWXs4MXr3AP99lr5C
         R0sQ==
X-Gm-Message-State: AOUpUlE5dVoZ31GouUqWp9/mr04+koPmi7tDNr6GikyH24N+o0Kyf8rM
        q2YcW7t4VdoDg+aBXk7LDF273mnug60=
X-Google-Smtp-Source: AAOMgpdesdEN21SelZ93VIMvuBX2Tc4TqnnZdyinnzXuk5oPSfLX7cMCRjp9A1iRJ/x7YcIEBD5yXw==
X-Received: by 2002:a62:5d55:: with SMTP id r82-v6mr164956pfb.150.1531341387945;
        Wed, 11 Jul 2018 13:36:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s144-v6sm6461001pfs.123.2018.07.11.13.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/14] crypto: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:05 -0700
Message-Id: <20180711203619.1020-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


This is nearly the last of the VLA removals[1], but it's one of the
largest because crypto gets used in lots of places. After looking
through code, usage, reading the threads Gustavo started, and comparing
the use-cases to the other VLA removals that have landed in the kernel,
I think this series is likely the best way forward to shut the door on
VLAs forever.

As background, the crypto stack usage is for callers to do an immediate
bit of work that doesn't allocate new memory. This means that other VLA
removal techniques (like just using kmalloc) aren't workable, and the
next common technique is needed: examination of maximum stack usage and
the addition of sanity checks. This series does that, and in several
cases, these maximums were already implicit in the code.

This series is intended to land via the crypto tree for 4.19, though
it touches dm and a few other things as well, since there are dependent
patches (new crypto #defines being used, kbuild, etc).

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Kees Cook (14):
  crypto: xcbc: Remove VLA usage
  crypto: cbc: Remove VLA usage
  crypto: shash: Remove VLA usage
  dm integrity: Remove VLA usage
  crypto: ahash: Remove VLA usage
  dm verity fec: Remove VLA usage
  crypto alg: Introduce generic max blocksize and alignmask
  crypto: qat: Remove VLA usage
  crypto: shash: Remove VLA usage in unaligned hashing
  kbuild: Introduce FRAME_WARN_BUMP_FLAG
  treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
  crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
  rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
  crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK

 Makefile                                    |  6 ++++
 crypto/Makefile                             |  1 +
 crypto/ahash.c                              |  4 +--
 crypto/algapi.c                             |  7 ++++-
 crypto/algif_hash.c                         |  2 +-
 crypto/shash.c                              | 33 ++++++++++++---------
 crypto/xcbc.c                               |  9 ++++--
 drivers/block/drbd/Makefile                 |  2 ++
 drivers/crypto/qat/qat_common/qat_algs.c    |  8 +++--
 drivers/md/Makefile                         |  1 +
 drivers/md/dm-integrity.c                   | 23 ++++++++++----
 drivers/md/dm-verity-fec.c                  |  5 +++-
 drivers/net/ppp/Makefile                    |  1 +
 drivers/staging/rtl8192e/Makefile           |  1 +
 drivers/staging/rtl8192u/Makefile           |  1 +
 drivers/staging/rtl8192u/ieee80211/Makefile |  1 +
 include/crypto/algapi.h                     |  4 ++-
 include/crypto/cbc.h                        |  4 ++-
 include/crypto/hash.h                       | 12 ++++++--
 include/crypto/internal/hash.h              |  1 +
 include/crypto/internal/skcipher.h          |  1 +
 include/crypto/skcipher.h                   |  4 ++-
 include/linux/compiler-gcc.h                |  1 -
 net/rxrpc/Makefile                          |  1 +
 net/wireless/Makefile                       |  1 +
 25 files changed, 99 insertions(+), 35 deletions(-)

-- 
2.17.1

