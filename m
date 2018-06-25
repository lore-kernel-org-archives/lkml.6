Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D498C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3308226160
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoK3kKqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3308226160
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755783AbeFYVNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:13:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37508 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeFYVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so7030861pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kwaz9ZiWPqqFFPa8Ruto1w30icdNQNK+d0gZGLO5eRI=;
        b=IoK3kKqOEFknoDX0abloQQbmstnZYB55RYYQf9KQP7dXcLTBKgAT1I4w2wa6fpfkCL
         +qVy/8dQaZ/atX/z1SJ4rUFZ6fGPYkTOK+hKObzyZNbTgPjb3SrfnM3/Xqxc+YvxHNAA
         xYHhXXc3jcKqpcvbzC3pmAvximRd9J/mb+cPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kwaz9ZiWPqqFFPa8Ruto1w30icdNQNK+d0gZGLO5eRI=;
        b=FuBNLXB+6a7smWfKy4Tg+z6zI0dBeKnqvBFdHAxvoOVp5t87KInxSSLodgXb3suHZb
         yMH8zsTAivePiBho7uUsG02hIMSY02Eim/84WPz1GoueV1OlRZLomu9T3ChNp+RqJTxX
         nHwQxD+GT/L6hpga/xm5Zwx0cOHTrk7GHqubre3w3IshZziwLjcb15JMyb31yu51TnVS
         AD5g9mQQmIQiZ9fDdIKcfOIqs4+5nrEmbOOWqbeTfzyt3L53uvnIuO3PWe/e+KsUcjI9
         8hSUXOwOSHOtzDM/Z3kM9LT8mrya25F1svhwsKQ3Dm/XGPsRzS3T36jiSbwdtrE5LDap
         yCig==
X-Gm-Message-State: APt69E0g3M6YXC3PNW+zh4NMgcvbyGXFNczn/FLDUfeDA2LPYNPy5pjp
        Yn5TKxZFJJ/B7AAJgODGfIrfFQ==
X-Google-Smtp-Source: ADUXVKKWzeTKRK8ZnjMIvObqmtdaIvYKAyXHurKdHa96P5yexTnN9aR27+GSZj2emkP8TUW15o4hcg==
X-Received: by 2002:a63:9246:: with SMTP id s6-v6mr11125983pgn.35.1529961038495;
        Mon, 25 Jun 2018 14:10:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h8-v6sm19760277pgq.35.2018.06.25.14.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:35 -0700 (PDT)
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
Subject: [PATCH v2 00/11] crypto: Remove VLA usage
Date:   Mon, 25 Jun 2018 14:10:15 -0700
Message-Id: <20180625211026.15819-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
 include/crypto/hash.h                    | 12 ++++++++++--
 include/crypto/internal/hash.h           |  1 +
 include/crypto/internal/skcipher.h       |  1 +
 include/crypto/skcipher.h                |  4 +++-
 include/linux/compiler-gcc.h             |  1 -
 15 files changed, 75 insertions(+), 35 deletions(-)

-- 
2.17.1

