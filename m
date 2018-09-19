Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF78ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B326214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iBiQXIDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B326214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeISHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41060 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbeISHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so1858698plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bzc7SOhJndGNfuYmqUejdXgCMuN2YiZoA93MK8WGTm0=;
        b=iBiQXIDsapS8WWwOmxDVdUik9BiUsnHFhhKUnyOzLHzGfl669TUQxmtVbVdVgfW/2i
         +HCHvEsBzwCYFTMErQcrYfQ1MLrNynSWdlabA/TexSvrglb7bzlvgAJZbcFhMyJ3gXM7
         +34ke6hWDH29T2gixl9ivPQ4RaVxcvIKvzbWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bzc7SOhJndGNfuYmqUejdXgCMuN2YiZoA93MK8WGTm0=;
        b=gRryt0daes+2xytLRHODUeJUrbxHd/wDKFmP0z5TDvDfVn4R05ytHd0PNtnorvCPm1
         2AsUv7tAXHTk625mgpJiYz8hlGUsvxZP9ktOWEGdr7TnMmctoTRZLDLql47QSiYVFSPY
         hFAyoj34KICcAkWTCMyEHu7L+0kLLsV+LdmGyA2dQ2gYJB6Q741ydj0jvaMQyU2VlpG/
         HNjlHCXH0TktL4Kf0HmYrzbhNPDYr/MvZBEwMVCnzFVuSXE4O+MLPJhy/Sc3eGQSzIhZ
         8P0Z5J7vg631a+zZq5Ti5Uqx2m3wCjq+9o4Nnp5GsUa/WjLSOLESJJ5X1wHBKc+Sw2GR
         gPfQ==
X-Gm-Message-State: APzg51Drj+wTR+QrjiWkPuswSfHzzDOqTX/0AKqBN58fNd+CYv3dIsP6
        9a+ULgCff/lvW5Z3KjfX7x/5rg==
X-Google-Smtp-Source: ANB0VdaqQ1R3gR589tV8RbyFpuy1N9Y6lC57vm+zJ6F5cQsmBQg0cIbDTSOvQ8bg0a2v5+EHSK/Jcw==
X-Received: by 2002:a17:902:7e06:: with SMTP id b6-v6mr32564211plm.230.1537323067539;
        Tue, 18 Sep 2018 19:11:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r81-v6sm26691126pfa.18.2018.09.18.19.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 00/23] crypto: skcipher - Remove VLA usage
Date:   Tue, 18 Sep 2018 19:10:37 -0700
Message-Id: <20180919021100.3380-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the full follow-up to earlier discussions[1] that suggested
adding a new struct crypto_sync_skcipher to handle the VLA removal from
SKCIPHER_REQUEST_ON_STACK.

This series is effectively a no-op change: everything is a wrapper
around struct crypto_skcipher, but provides compile-time enforcement
for not putting an ASYNC skcipher on the stack, which allows us to
declare the on-stack requests with a fixed stack size.

[1] https://lkml.kernel.org/r/CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com

-Kees

Kees Cook (23):
  crypto: skcipher - Introduce crypto_sync_skcipher
  gss_krb5: Remove VLA usage of skcipher
  lib80211: Remove VLA usage of skcipher
  mac802154: Remove VLA usage of skcipher
  s390/crypto: Remove VLA usage of skcipher
  x86/fpu: Remove VLA usage of skcipher
  block: cryptoloop: Remove VLA usage of skcipher
  libceph: Remove VLA usage of skcipher
  ppp: mppe: Remove VLA usage of skcipher
  rxrpc: Remove VLA usage of skcipher
  wusb: Remove VLA usage of skcipher
  crypto: ccp - Remove VLA usage of skcipher
  crypto: vmx - Remove VLA usage of skcipher
  crypto: null - Remove VLA usage of skcipher
  crypto: cryptd - Remove VLA usage of skcipher
  crypto: sahara - Remove VLA usage of skcipher
  crypto: qce - Remove VLA usage of skcipher
  crypto: artpec6 - Remove VLA usage of skcipher
  crypto: chelsio - Remove VLA usage of skcipher
  crypto: mxs-dcp - Remove VLA usage of skcipher
  crypto: omap-aes - Remove VLA usage of skcipher
  crypto: picoxcell - Remove VLA usage of skcipher
  crypto: skcipher - Remove SKCIPHER_REQUEST_ON_STACK()

 arch/s390/crypto/aes_s390.c                   | 48 +++++-----
 arch/x86/crypto/fpu.c                         | 30 ++++---
 crypto/algif_aead.c                           | 12 +--
 crypto/authenc.c                              |  8 +-
 crypto/authencesn.c                           |  8 +-
 crypto/cryptd.c                               | 32 +++----
 crypto/crypto_null.c                          | 11 ++-
 crypto/echainiv.c                             |  4 +-
 crypto/gcm.c                                  |  8 +-
 crypto/seqiv.c                                |  4 +-
 crypto/skcipher.c                             | 24 +++++
 drivers/block/cryptoloop.c                    | 22 ++---
 drivers/crypto/axis/artpec6_crypto.c          | 19 ++--
 drivers/crypto/ccp/ccp-crypto-aes-xts.c       | 13 +--
 drivers/crypto/ccp/ccp-crypto.h               |  2 +-
 drivers/crypto/chelsio/chcr_algo.c            | 27 +++---
 drivers/crypto/chelsio/chcr_crypto.h          |  2 +-
 drivers/crypto/mxs-dcp.c                      | 21 +++--
 drivers/crypto/omap-aes.c                     | 17 ++--
 drivers/crypto/omap-aes.h                     |  2 +-
 drivers/crypto/picoxcell_crypto.c             | 21 +++--
 drivers/crypto/qce/ablkcipher.c               | 13 ++-
 drivers/crypto/qce/cipher.h                   |  2 +-
 drivers/crypto/sahara.c                       | 31 ++++---
 drivers/crypto/vmx/aes_cbc.c                  | 22 ++---
 drivers/crypto/vmx/aes_ctr.c                  | 18 ++--
 drivers/crypto/vmx/aes_xts.c                  | 18 ++--
 drivers/net/ppp/ppp_mppe.c                    | 27 +++---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  | 34 ++++----
 drivers/staging/rtl8192e/rtllib_crypt_wep.c   | 28 +++---
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 34 ++++----
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 26 +++---
 drivers/usb/wusbcore/crypto.c                 | 16 ++--
 include/crypto/internal/geniv.h               |  2 +-
 include/crypto/null.h                         |  2 +-
 include/crypto/skcipher.h                     | 74 +++++++++++++++-
 include/linux/sunrpc/gss_krb5.h               | 30 +++----
 net/ceph/crypto.c                             | 12 +--
 net/ceph/crypto.h                             |  2 +-
 net/mac802154/llsec.c                         | 16 ++--
 net/mac802154/llsec.h                         |  2 +-
 net/rxrpc/ar-internal.h                       |  2 +-
 net/rxrpc/rxkad.c                             | 44 +++++-----
 net/sunrpc/auth_gss/gss_krb5_crypto.c         | 87 ++++++++++---------
 net/sunrpc/auth_gss/gss_krb5_keys.c           |  9 +-
 net/sunrpc/auth_gss/gss_krb5_mech.c           | 53 ++++++-----
 net/sunrpc/auth_gss/gss_krb5_seqnum.c         | 18 ++--
 net/sunrpc/auth_gss/gss_krb5_wrap.c           | 20 ++---
 net/wireless/lib80211_crypt_tkip.c            | 34 ++++----
 net/wireless/lib80211_crypt_wep.c             | 28 +++---
 50 files changed, 563 insertions(+), 476 deletions(-)

-- 
2.17.1

