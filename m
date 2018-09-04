Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639CCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C72075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kjkifWd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9C72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeIDWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:42:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43099 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeIDWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:42:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6-v6so2000178plv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kBZ5Nc08uuOZ1+ex7PLIdfqPnNSMA5EyZHFudIbyO4A=;
        b=kjkifWd4UBgW+U8+Iup6H/H9VifYogpOmP3ntRKpVgiuXfNXLeiDQx5x+v2krl+lgU
         FBnfpBqverfFLePWSZYSNUgxCSvEtJMO3TLprvVPzEjE48cLmk5Ez/Cqu2qGPOdVWiCg
         lYMsqEuFmiTjwGC/2IbLUbjCbalM0/jaYIqYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kBZ5Nc08uuOZ1+ex7PLIdfqPnNSMA5EyZHFudIbyO4A=;
        b=R6ije8l7jelMIzZNN87tWwPofqQcrN2oEIQ50zVSMZqaCTAW4YqE6e8Fz0Q/TxV/u5
         DzZuTkXmNhV3Ec2WsiOxQggbQtFF55si3WRMthYDtX2HBo0nPQBLaaL/rZWa27ysbCPB
         jz2jVFRNmh/naaqUEGyLaxmNx8dj5HKr5V++6pGjxLzD0QJzUJdBVmkmG+J3Dh6sNjfg
         ml6EJYNmc/IhFawGOAA3mAnImel8qLsC1/JE/2m8uta5byxju771HacWaQOafOg6LYKL
         Wdy9BJswxuySBMOLWgaW/IQcg3yTiqRWG+kwaCE5+JjcUewBITlLaEJ6aVT0/+Njz6S/
         mXXQ==
X-Gm-Message-State: APzg51Afi8KkfxGTC5W6lejbQZPqapAAlW/tJURGzMzgMXAL3eumtofC
        2X9uUvv0M5oHo8nIn1gHKXTDdg==
X-Google-Smtp-Source: ANB0VdavgS5ocT6H+3NEB+OYua214T+VVG9/eA+J9QLvwQca1iUhm6dbqllPqeJdd/yoXlpSt+A/aw==
X-Received: by 2002:a17:902:904c:: with SMTP id w12-v6mr34900947plz.95.1536084994987;
        Tue, 04 Sep 2018 11:16:34 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p19-v6sm30484529pgh.60.2018.09.04.11.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 11:16:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] crypto: Remove VLA usage from skcipher
Date:   Tue,  4 Sep 2018 11:16:27 -0700
Message-Id: <20180904181629.20712-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes VLAs[1] from SKCIPHER_REQUEST_ON_STACK by making it possible
for crypto_skcipher_set_reqsize() to fail. Callers are updated to handle
the error condition.

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Kees Cook (2):
  crypto: skcipher: Allow crypto_skcipher_set_reqsize() to fail
  crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK

 crypto/cryptd.c                                |  7 +++++--
 crypto/ctr.c                                   |  7 +++++--
 crypto/cts.c                                   |  7 +++++--
 crypto/lrw.c                                   |  9 ++++++---
 crypto/simd.c                                  |  7 +++++--
 crypto/xts.c                                   | 11 ++++++++---
 drivers/crypto/amcc/crypto4xx_core.c           |  8 +++++++-
 drivers/crypto/cavium/nitrox/nitrox_algs.c     |  9 +++++++--
 drivers/crypto/ccree/cc_cipher.c               |  6 ++++--
 drivers/crypto/hisilicon/sec/sec_algs.c        |  5 ++++-
 drivers/crypto/inside-secure/safexcel_cipher.c |  5 ++++-
 drivers/crypto/marvell/cipher.c                |  4 +---
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c      |  4 +---
 include/crypto/internal/skcipher.h             |  7 ++++++-
 include/crypto/skcipher.h                      |  4 +++-
 15 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.17.1

