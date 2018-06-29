Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7227996
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mRNDiYEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF7227996
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030421AbeF2Aay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:30:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34671 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbeF2A2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so3564244plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D1PO0mHJn+Uhua2TuGkTgdAGX+rVxwv+vJva+LYJL8Q=;
        b=mRNDiYEmj8sIeSmuZ4nP1kNb1EglEu547ClBWhtRJDWrMnZlTRrA/g/gB71w7v824x
         oLzo2SKM25DcWCBHiqulZbV6h2XFmthkD9RMrlTtLZ4ehJrWJAz8j2KFNuVNteyoVafc
         wJPDdIZNfjfyxrK+IYAjkjzlmQIVkMQEMWiYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D1PO0mHJn+Uhua2TuGkTgdAGX+rVxwv+vJva+LYJL8Q=;
        b=jVeSeKSHW7YTtLDRZs36XW6b9r/yGMzXJBB0Rr+bh4aSmBlqJiICGR92z700kmxP0o
         F7EzHNg60CoFoH7Mn+5ctJPLl/DGC0PjIHK0930kIkPH84ngnWg+r+dLRh/irwsmHJBD
         PNuCFevVth0roZo6xc35W78AgUtKduaAamuVDMT/fdyfyTqrq1O9Jj9vqrCWo6aslM4c
         86qiT9P/brJyXqIFoh2B8S/MoscSaMNOOQLEmEsZfj4GZVV0V+PA0O243dWMXLQKlLAD
         DqdD3vyfLU8fNRmHchexiu9vTE8tuYPIWWNWmR89XpDdKJIfiWDAx+r9+lFi2z8ieMKs
         5WyA==
X-Gm-Message-State: APt69E28jlWXIL7ltkytfNWCDliCLlzTrVUpOmQUhSCAbWxEotuXTvv5
        98aSxq7UR5WmqPA9QMiWns+vfw==
X-Google-Smtp-Source: ADUXVKIpCZ80o+sUAY9BLdjVApfIdemqLbdjpsSjVTvOsHLq0gekl8DAHdkoI1M17dV3s58nwS3N9g==
X-Received: by 2002:a17:902:246a:: with SMTP id m39-v6mr12620548plg.141.1530232130503;
        Thu, 28 Jun 2018 17:28:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v16-v6sm6432653pfn.105.2018.06.28.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:48 -0700 (PDT)
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
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] Crypto: Remove VLA usage (part 1)
Date:   Thu, 28 Jun 2018 17:28:34 -0700
Message-Id: <20180629002843.31095-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This series is intended to land via the crypto tree, though it touches
dm as well, since there are dependent patches (new crypto #defines
being used).

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Kees Cook (9):
  crypto: xcbc: Remove VLA usage
  crypto: cbc: Remove VLA usage
  crypto: shash: Remove VLA usage
  dm integrity: Remove VLA usage
  crypto: ahash: Remove VLA usage
  dm verity fec: Remove VLA usage
  crypto alg: Introduce generic max blocksize and alignmask
  crypto: qat: Remove VLA usage
  crypto: shash: Remove VLA usage in unaligned hashing

 crypto/ahash.c                           |  4 ++--
 crypto/algapi.c                          |  7 ++++++-
 crypto/algif_hash.c                      |  2 +-
 crypto/shash.c                           | 25 +++++++++++-------------
 crypto/xcbc.c                            |  9 +++++++--
 drivers/crypto/qat/qat_common/qat_algs.c |  8 ++++++--
 drivers/md/dm-integrity.c                | 23 ++++++++++++++++------
 drivers/md/dm-verity-fec.c               |  5 ++++-
 include/crypto/algapi.h                  |  4 +++-
 include/crypto/cbc.h                     |  4 +++-
 include/crypto/hash.h                    |  9 ++++++++-
 include/linux/compiler-gcc.h             |  1 -
 12 files changed, 68 insertions(+), 33 deletions(-)

-- 
2.17.1

