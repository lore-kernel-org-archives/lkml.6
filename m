Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC862C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875C72075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QK5+saYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875C72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIGDgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:36:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33015 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIGDgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:36:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so5982683pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=54lVbIo1lDuCzb67uTyjPcUEOxnRHWhERg6k2kB4aPw=;
        b=QK5+saYE4Z5USdkq1zbsNBAYLnzqWCyoVg4HRYIuK7XPgFcGLCW4A7smQFmjJiu0Ft
         V21wW7yOZIodYJCX0hjyP31aqBfg7b2SzyNvgK8XjRQpWMCRsu2/Tl6YDE8WMbjwb6xl
         exwn3dXT49Pnj0OmyHhXnf4rR3AX/s+Y4/Blo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=54lVbIo1lDuCzb67uTyjPcUEOxnRHWhERg6k2kB4aPw=;
        b=g+MjbaNaNHhsk+Rt5KOqZLOEpICByJ0LitiX74MAgRdK/9zhoa7DZN+f2CU4Vo82+W
         MA9mqgs3HKYxrPxpaHcZ/0hi+dZhy0XD5LvP+9O9cCgmGvzQqQQyLDROGgYZSumgeegE
         81MypQRmytTZJLW/Jo0ffrKvRostcMIoT72/ervQE4NhXa36OIfw2zQoF6ZpBIPPk5Pi
         0LjVZz0z8tt6fFHKKx4ru0F8x4seMAAoXDn9mPrtfSxMMt432A7TIop2Kqz90bekKWL3
         IauI+Hfm1J4uRcjxMyNrRntSXOgmf8tYSfCTrYry4sPt4pLl+XpTzS9h8qYFsGFego54
         Q3fQ==
X-Gm-Message-State: APzg51AOQZ8xc/GZbthQamtSN5IOeKrxm/m3GkDxiV239xKYZDgcBo4R
        ebBh1SjfEyIJ8kS8LsFlLK7S9Q==
X-Google-Smtp-Source: ANB0Vda85UoUNLCHyDbUfpwrzSzQ7QzZiO3WbEwSFwIhi2cKd31czDvTVhRpkJuPO7lXxee+lT2xoA==
X-Received: by 2002:a63:d645:: with SMTP id d5-v6mr5176531pgj.450.1536274742889;
        Thu, 06 Sep 2018 15:59:02 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d6-v6sm10777007pgt.66.2018.09.06.15.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 15:59:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
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
Subject: [PATCH v2 0/4] crypto: skcipher - Remove VLA usage
Date:   Thu,  6 Sep 2018 15:58:50 -0700
Message-Id: <20180906225854.40989-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes VLAs[1] from SKCIPHER_REQUEST_ON_STACK by making sure that
on-stack requests are being used only on non-ASYNC algorithms and that
enough space has been reserved.

v2:
- Instead of globally failing large reqsizes, limit to only non-ASYNC users
  of the on-stack request.
- Remove unused tfm argument after VLA removal.

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Kees Cook (4):
  crypto: skcipher - Consolidate encrypt/decrypt sanity check
  crypto: skcipher - Enforce non-ASYNC for on-stack requests
  crypto: skcipher - Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
  crypto: skcipher - Remove unused argument to SKCIPHER_REQUEST_ON_STACK()

 arch/s390/crypto/aes_s390.c                   |  8 +-
 arch/x86/crypto/fpu.c                         |  4 +-
 crypto/algif_aead.c                           |  2 +-
 crypto/authenc.c                              |  2 +-
 crypto/authencesn.c                           |  2 +-
 crypto/cryptd.c                               |  4 +-
 crypto/echainiv.c                             |  2 +-
 crypto/gcm.c                                  |  2 +-
 crypto/seqiv.c                                |  2 +-
 drivers/block/cryptoloop.c                    |  2 +-
 drivers/crypto/axis/artpec6_crypto.c          |  2 +-
 drivers/crypto/ccp/ccp-crypto-aes-xts.c       |  2 +-
 drivers/crypto/chelsio/chcr_algo.c            |  2 +-
 drivers/crypto/mxs-dcp.c                      |  2 +-
 drivers/crypto/omap-aes.c                     |  2 +-
 drivers/crypto/picoxcell_crypto.c             |  2 +-
 drivers/crypto/qce/ablkcipher.c               |  2 +-
 drivers/crypto/sahara.c                       |  8 +-
 drivers/crypto/vmx/aes_cbc.c                  |  4 +-
 drivers/crypto/vmx/aes_ctr.c                  |  2 +-
 drivers/crypto/vmx/aes_xts.c                  |  2 +-
 drivers/net/ppp/ppp_mppe.c                    |  6 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  4 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c   |  4 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  4 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |  4 +-
 drivers/usb/wusbcore/crypto.c                 |  2 +-
 include/crypto/skcipher.h                     | 74 ++++++++++++++-----
 net/ceph/crypto.c                             |  2 +-
 net/mac802154/llsec.c                         |  4 +-
 net/rxrpc/rxkad.c                             | 10 +--
 net/sunrpc/auth_gss/gss_krb5_crypto.c         | 14 ++--
 net/wireless/lib80211_crypt_tkip.c            |  4 +-
 net/wireless/lib80211_crypt_wep.c             |  4 +-
 34 files changed, 116 insertions(+), 80 deletions(-)

-- 
2.17.1

