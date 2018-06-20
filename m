Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18160C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2787208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mdjKIohn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2787208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754864AbeFTTIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:08:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35667 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeFTTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so243587pgp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SuMZWhlsR8+I8IGAnwiA2oJhRXzAkkN3kNbB4AfznQA=;
        b=mdjKIohnlUJiDvDW3/KdSRxVU/GPzHbBkEZAHTlRyjJc3lNCP/23zfI/PeqkAOaZyj
         qKpjSXcJH9x1tyZgWHqgVSxwL/X3celjkeFOrM8OyWU8k1XNaxccmZjMttpgLX+rUKXO
         fu24Io3IL+TmvJfRB+O35dzKNO/KS6/B84fis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SuMZWhlsR8+I8IGAnwiA2oJhRXzAkkN3kNbB4AfznQA=;
        b=Ysy2FCI56ov51WCByi7MJsQoJrtCx6vvj6H5e2QThZqk4h/4kARuDetW8cgVgXRBOB
         CI6I0lXce3Y4WSMcNKbQaLiKqFcTy1giD27sKQnBM2/ceZ0oCLW146A0Tqq2ddNXbffi
         biB2NuVN+W6A9T6VD+Vc5Hcwu3VHA7fooKOR02HPC2aAs4xEpYyWmxCn42M8PObqps14
         /JJuVDkuluJ1IcG4m7dYJeGpOzA5ZCR01GxLxwElt2e0n3uyJGbr2ui5vZBT9dlLZld4
         TUA5FFEAuHY4EwxagYzOeUIu/N+JqCbnct4BqCl1xWtt2DMycbb5e+QbRI4PkKBkkv1J
         znhQ==
X-Gm-Message-State: APt69E1R13IkRWKUEZMMIFodPZ7pScvtUu1DkmGmdTj5Yl1XQsFuBDdq
        BSGTjNmNTE7RUNRslBLeaLbCNg==
X-Google-Smtp-Source: ADUXVKJbC14vLsK5gSCJYlijHeNLsksdrO+ElEb7ZsmCZQ/KE75x4TlByTmpJprD2209RbQodvOabw==
X-Received: by 2002:a63:b34e:: with SMTP id x14-v6mr19895374pgt.243.1529521459208;
        Wed, 20 Jun 2018 12:04:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g66-v6sm8589160pfk.99.2018.06.20.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] crypto: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:03:57 -0700
Message-Id: <20180620190408.45104-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
  crypto: shash: Remove VLA usage
  dm integrity: Remove VLA usage
  crypto: ahash: Remove VLA usage
  dm verity fec: Remove VLA usage
  crypto alg: Introduce max blocksize and alignmask
  crypto: cbc: Remove VLA usage
  crypto: xcbc: Remove VLA usage
  crypto: qat: Remove VLA usage
  crypto: shash: Remove VLA usage in unaligned hashing
  crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
  crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK

 crypto/ahash.c                           |  4 ++--
 crypto/algapi.c                          |  5 ++++-
 crypto/algif_hash.c                      |  2 +-
 crypto/shash.c                           | 27 ++++++++++++------------
 crypto/xcbc.c                            |  5 ++++-
 drivers/crypto/qat/qat_common/Makefile   |  2 ++
 drivers/crypto/qat/qat_common/qat_algs.c |  8 +++++--
 drivers/md/dm-integrity.c                | 23 ++++++++++++++------
 drivers/md/dm-verity-fec.c               |  5 ++++-
 include/crypto/cbc.h                     |  2 +-
 include/crypto/hash.h                    | 12 +++++++++--
 include/crypto/internal/hash.h           |  1 +
 include/crypto/internal/skcipher.h       |  1 +
 include/crypto/skcipher.h                |  4 +++-
 include/linux/crypto.h                   |  4 ++++
 15 files changed, 73 insertions(+), 32 deletions(-)

-- 
2.17.1

