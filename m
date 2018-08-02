Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33075C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2A215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnB1PDZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE2A215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeHBXob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45873 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbeHBXo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:29 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so1602305pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GNjKbY5ZsFlS7okKuL/uoncybxaGeFHA8u2xuLLgPrM=;
        b=PnB1PDZyr0LI6H1AmKODZiJNnjwtQagA6Q374ft8hDE+C/RW8pYvrcndIJwgn6QfFl
         mnWE4mI5/AnOrw7Za7mbL8ygTgeUpuhRuUG10OTb2+f+QZwU7OCrY2vRKSWJ3fWeIxlA
         0yxa4KkIbaWA88w8iGtEWr7wAbMcU8pIrNEpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GNjKbY5ZsFlS7okKuL/uoncybxaGeFHA8u2xuLLgPrM=;
        b=o5ICN9hr+MvDCWG5897Soa3bReMwdi5rRmLgN7RpfCBkojUDl6XqGShmzbCw/hXTjq
         BDm/3jB+uX91ohd4iR7xJa6DOy6vKiOF9rzkPGA8nj6UGHSpZKMqS+eGcN11LiXRnpVS
         0sed+z5j5AnQBnM62Zrlq4lhpQSEHqxL2So9sJHjC8AeOrd7ih6EqyC9atqxvsAomABD
         vxCn0IgnRGVoIqb0ksSYDEAAVAJF8D645LqRW2Pq1UgJCz58T0yEUJUjqNkPLOzgRU1/
         z0SJGkl7c3qKuxepBQfxugwW8R3JZArAMYWXSfTR7guJ9YRyFRBcUrjykZfd8/zvObq6
         SJ4g==
X-Gm-Message-State: AOUpUlG7yA34ZStVqgYZ16JyLUH0GW9AcRQw03uGv+MDm5dA7LnIkAil
        SiZjgTMeHdLAzqVWZENhFG+jVQ==
X-Google-Smtp-Source: AAOMgpd4w5Hect/Hg1YLRVFnAvItEi7uazB1bZN6NFuqHl6ihaxNlMofsyNEVcx6R+NsjK3Z5uLFgw==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr1022663plo.225.1533246686527;
        Thu, 02 Aug 2018 14:51:26 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 21-v6sm4516808pgx.20.2018.08.02.14.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:51:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] crypto: add zbufsize() interface
Date:   Thu,  2 Aug 2018 14:51:09 -0700
Message-Id: <20180802215118.17752-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pstore was refactored to use the crypto compress API in:

  commit cb3bee0369bc ("pstore: Use crypto compress API")

nearly all the pstore-specific compression routines were replaced with
the existing crypto compression API. One case remained: calculating the
"worst case" compression sizes ahead of time so it could have a buffer
preallocated for doing compression (which was called "zbufsize").

To make pstore fully algorithm-agnostic, the compression API needs to
grow this functionality. This adds the interface to support querying the
"worst case" estimate, with a new "zbufsize" routine that each compressor
can implement.

This series adds the interface, updates each compressor, and refactors
pstore. (Though note, this is based on v4.18-rc2, and pstore will be
gaining zstd support during the v4.19 merge window, so the last patch
in this series will need to be coordinated, but I left it to show how
things would look right now.)

-Kees


Kees Cook (9):
  crypto: add zbufsize() interface
  crypto, 842: implement zbufsize()
  crypto, null: Implement zbufsize()
  crypto, lzo: Implement zbufsize()
  crypto, deflate: Implement zbufsize()
  crypto, zstd: Implement zbufsize()
  crypto, lz4: Implement zbufsize()
  crypto, lz4hc: Implement zbufsize()
  pstore: Use crypto_comp_zbufsize()

 crypto/842.c                        |  17 ++-
 crypto/compress.c                   |   9 ++
 crypto/crypto_null.c                |  10 +-
 crypto/deflate.c                    |  48 +++++++-
 crypto/lz4.c                        |  22 +++-
 crypto/lz4hc.c                      |  22 +++-
 crypto/lzo.c                        |  22 +++-
 crypto/zstd.c                       |  22 +++-
 fs/pstore/Kconfig                   |  91 +++++----------
 fs/pstore/inode.c                   |   2 -
 fs/pstore/internal.h                |   3 -
 fs/pstore/platform.c                | 171 ++++++----------------------
 include/crypto/internal/scompress.h |  11 ++
 include/linux/crypto.h              |  12 ++
 include/linux/sw842.h               |   9 ++
 15 files changed, 257 insertions(+), 214 deletions(-)

-- 
2.17.1

