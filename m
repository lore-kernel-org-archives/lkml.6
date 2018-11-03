Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA378C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A930E20847
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpjINm/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A930E20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeKDHJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeKDHJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:09:53 -0500
Received: from sol.hsd1.wa.comcast.net (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6661204FD;
        Sat,  3 Nov 2018 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541282240;
        bh=MEm+oRzl5F9XPKYzzN3UBxB7Jl8L/BkoBbZX0zgNs3M=;
        h=From:To:Cc:Subject:Date:From;
        b=QpjINm/noMgUyN8oCKWXnb5E/0PN3y+0LpAVE1rJMVVes8oovPKEqmUtuJa/EJxvD
         DjVyZTwx442TGfHsSdVkBhjUL1EZVGEB++2Y1WLVhawiAPSRCHiJEJ34TljKu/8KVq
         xNUUf3UwdLuV9J2nYuT9VX29KAdrO671kJgzSgZo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: crypto_user reporting fixes and cleanups
Date:   Sat,  3 Nov 2018 14:55:59 -0700
Message-Id: <20181103215603.16250-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes all the information leaks in crypto_user reporting,
removes some redundant reporting functions, and makes some changes to
reduce the chance of similar information leaks in the future.  Patch 2
is based on a patch already sent by Corentin Labbe, but it was
incomplete so I fixed it.

Corentin Labbe (1):
  crypto: crypto_user_stat - Zeroize whole structure given to user space

Eric Biggers (3):
  crypto: crypto_user - fix leaking uninitialized memory to userspace
  crypto: crypto_user - remove redundant reporting functions
  crypto: crypto_user - clean up report structure copying

 crypto/ablkcipher.c       |  32 ++++------
 crypto/acompress.c        |  10 +---
 crypto/aead.c             |  14 ++---
 crypto/ahash.c            |  12 ++--
 crypto/akcipher.c         |  11 ++--
 crypto/blkcipher.c        |  16 ++---
 crypto/crypto_user_base.c |  95 +++++------------------------
 crypto/crypto_user_stat.c | 123 ++++++++++++++------------------------
 crypto/kpp.c              |  10 +---
 crypto/rng.c              |  12 ++--
 crypto/scompress.c        |  11 ++--
 crypto/shash.c            |  12 ++--
 crypto/skcipher.c         |  15 ++---
 13 files changed, 116 insertions(+), 257 deletions(-)

-- 
2.19.1

