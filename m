Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C777ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D3720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJygc/Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D3720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbeGXR7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:59:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35930 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbeGXR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id d14-v6so986588pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XDw0a+jCaRK07DPwSkSUufRYjzCRo7QSPtOCTbdYGig=;
        b=DJygc/ZuxYg2AQ0JUqgfs8uSOmuzC2wxtA9su7QqdjIBMjpPTjtoqTkFsjjOkK13tX
         DZND+IYwF3ufwEU6d4yCv9al5NkBEhjAgW0Bw1NgqL+cWS6cK4iz3fEyyRcI1i8khmPc
         4DJ1U/NXRloXV+JQTjlVXGvHO9J7bQhoArsTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XDw0a+jCaRK07DPwSkSUufRYjzCRo7QSPtOCTbdYGig=;
        b=h/Ob0X4osUpbrhGnVZANw2DiBHBwp94k5FfY/13HmmXGo2ZM6CSz4QAIPTgTFR2DVh
         58IH7oCJsYmMV/FDPJa8iB4d+ngDeV/57lRo5L7/EUIl6rMe8XvGqKRMaunpelO2SNMw
         zSJ0GXNRd74ucfupR2m53/LC3mKeD1M/DsumytPIuySKzbfH3mDobpbStr6NdoCq6BMX
         CBr2bE4tUNkw4SQvvvEQK9fFe+wGx1F8JJDm21k7gSTnrlHlKa+LrlRNQIMx4bqLxYI+
         CpRqQ3bRlq2JGMKrr2LmaKIGrqsXjPxHwQ+s1od+V2Hrkoa0FPYr8DTxL+hfmHm86MUt
         ZIZg==
X-Gm-Message-State: AOUpUlF1i6+Q/DuuXyFAuLzafCM1QWXsfu7LlG5BUfbmZoEYqHlf5FC3
        mwVh8a5uiMbYr+CtQwXrD+Q9dA==
X-Google-Smtp-Source: AAOMgpejwAxrjuI1z2QcP7sAwD36/xBj0gpdarxw/C4svHwjAhOwWLvU80FDlLknSYQwJO4HAZbEtw==
X-Received: by 2002:a63:7703:: with SMTP id s3-v6mr17343122pgc.339.1532450987414;
        Tue, 24 Jul 2018 09:49:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d123-v6sm17965601pfa.22.2018.07.24.09.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:49:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        qat-linux@intel.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/18] crypto: Remove VLA usage
Date:   Tue, 24 Jul 2018 09:49:18 -0700
Message-Id: <20180724164936.37477-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For newly added CCs on this series: your Ack/Review would be very
welcome! Especially for the ahash-to-shash conversion patches.

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

Ard Biesheuvel (1):
  crypto: ccm: Remove VLA usage

Kees Cook (17):
  crypto: xcbc: Remove VLA usage
  crypto: cbc: Remove VLA usage
  crypto: hash: Remove VLA usage
  dm: Remove VLA usage from hashes
  crypto alg: Introduce generic max blocksize and alignmask
  crypto: qat: Remove VLA usage
  crypto: shash: Remove VLA usage in unaligned hashing
  crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
  ppp: mppe: Remove VLA usage
  x86/power/64: Remove VLA usage
  dm crypt: Convert essiv from ahash to shash
  drbd: Convert from ahash to shash
  wireless/lib80211: Convert from ahash to shash
  staging: rtl8192u: ieee80211: Convert from ahash to shash
  staging: rtl8192e: ieee80211: Convert from ahash to shash
  rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
  crypto: Remove AHASH_REQUEST_ON_STACK

 arch/x86/power/hibernate_64.c                 | 36 +++++++-----
 crypto/ahash.c                                |  4 +-
 crypto/algapi.c                               |  7 ++-
 crypto/algif_hash.c                           |  2 +-
 crypto/ccm.c                                  |  9 ++-
 crypto/shash.c                                | 33 ++++++-----
 crypto/xcbc.c                                 |  8 ++-
 drivers/block/drbd/drbd_int.h                 | 13 +++--
 drivers/block/drbd/drbd_main.c                | 14 ++---
 drivers/block/drbd/drbd_nl.c                  | 39 ++++---------
 drivers/block/drbd/drbd_receiver.c            | 35 +++++------
 drivers/block/drbd/drbd_worker.c              | 56 ++++++++----------
 drivers/crypto/qat/qat_common/qat_algs.c      |  8 ++-
 drivers/md/dm-crypt.c                         | 31 +++++-----
 drivers/md/dm-integrity.c                     | 23 ++++++--
 drivers/md/dm-verity-fec.c                    |  5 +-
 drivers/net/ppp/ppp_mppe.c                    | 56 +++++++++---------
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  | 56 +++++++++---------
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 57 +++++++++---------
 include/crypto/algapi.h                       |  4 +-
 include/crypto/cbc.h                          |  4 +-
 include/crypto/hash.h                         | 11 ++--
 include/crypto/internal/skcipher.h            |  1 +
 include/crypto/skcipher.h                     |  4 +-
 include/linux/compiler-gcc.h                  |  1 -
 net/rxrpc/rxkad.c                             | 25 ++++----
 net/wireless/lib80211_crypt_tkip.c            | 58 +++++++++----------
 27 files changed, 313 insertions(+), 287 deletions(-)

-- 
2.17.1

