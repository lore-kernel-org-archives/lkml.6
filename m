Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BC3208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFRqd4aI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BC3208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbeGQEwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40714 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbeGQEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so8396462pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Z5Bt8w1FWlfFrHcBVrOM+ClUStFhbI+Y1ZodLgd//8E=;
        b=KFRqd4aIZqhgVsnmop43d3o5Qm5rmBHxz5CPgQzhxmwkxA9iVhCH+3iaYEw7WIenA6
         3uCgKRDA8cJHJsA+O1ZLORt/TZ8esB3H+6/mE0YmrUuMh2esD1HUfaJS6NPfKHKK4tfs
         J4CKUOdira1hr99ozia9YZ74fFp5sgWZ6Un+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z5Bt8w1FWlfFrHcBVrOM+ClUStFhbI+Y1ZodLgd//8E=;
        b=LWzpG3Gerk+Wy4xQm18BH0Dy+PXzohJOl44kRdmhNDPZGoveUud7Ez3XjKkI22UNez
         bIVB9e+ShVv3mhH32Q4EKRqtY/dZXG73jYwm32sYE9irLtezcGZXCtr9+PsPwGY1vasU
         7l/qLFKQbSVN3ikjteZ7FnKj5wEv7hJYOgyKDfIMhZmA2FIuSjdB7l90L2e+3XR4oNbW
         IX33CukWGRYT9pZ5RUKE2uz64xi17BMp1AGmx6YCTCJUCScrzNT66qmN1mBbnRzd1A9Y
         YQ+b0vR+ZeKcNv69SEMK0cuhiJucE8wfekeqR+dR5qvY4bD/OLTekfp9rmUs1akaYEU6
         Tyrg==
X-Gm-Message-State: AOUpUlHeMNgLyLE2qHen7uOW44yoFp3CVl73oxqXPlcI50YZ/0BmnZY/
        lgc7x0r0zzxZxPOYRxRgBIDBuw==
X-Google-Smtp-Source: AAOMgpdOxCMyMtu9/xyNd8PeyINSuceJd+8KI9J0QBQfNsoptomg6ilyNpK+mftm80LZmpAeFd+xQg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr18870pgd.326.1531801318201;
        Mon, 16 Jul 2018 21:21:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h10-v6sm43493964pfj.78.2018.07.16.21.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/11] crypto: Remove VLA usage
Date:   Mon, 16 Jul 2018 21:21:39 -0700
Message-Id: <20180717042150.37761-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Kees Cook (11):
  crypto: xcbc: Remove VLA usage
  crypto: cbc: Remove VLA usage
  crypto: shash: Remove VLA usage
  dm integrity: Remove VLA usage
  crypto: ahash: Remove VLA usage
  dm verity fec: Remove VLA usage
  crypto alg: Introduce generic max blocksize and alignmask
  crypto: qat: Remove VLA usage
  crypto: shash: Remove VLA usage in unaligned hashing
  crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
  crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK

 crypto/ahash.c                           |  4 +--
 crypto/algapi.c                          |  7 +++-
 crypto/algif_hash.c                      |  2 +-
 crypto/shash.c                           | 42 +++++++++++++++---------
 crypto/xcbc.c                            |  9 +++--
 drivers/crypto/qat/qat_common/qat_algs.c |  8 +++--
 drivers/md/dm-integrity.c                | 23 +++++++++----
 drivers/md/dm-verity-fec.c               |  5 ++-
 include/crypto/algapi.h                  |  4 ++-
 include/crypto/cbc.h                     |  4 ++-
 include/crypto/hash.h                    | 19 +++++++++--
 include/crypto/internal/skcipher.h       |  1 +
 include/crypto/skcipher.h                |  4 ++-
 include/linux/compiler-gcc.h             |  1 -
 14 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.17.1

