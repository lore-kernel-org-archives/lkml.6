Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7120C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0CF20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgbn1GZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0CF20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJIBpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJIBpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:45:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A172087D;
        Mon,  8 Oct 2018 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023564;
        bh=8ymrmvLYEl3oKhbQyTlfL/sJyVEOwzQ55ZTZkypJEjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fgbn1GZ1neV0yw3bT7w8yD/UTmMAJ+BGs04mwUUat3Rp3pAKakiC1jg/SpM+vURJZ
         w2cfY/DLhl+GJrOZeAvvguSaT1/51I3BXgixs5y3VWSek1yIZInXI4sNaAHM1KXOrM
         t3WJA74dj4rJCkVt9dAJtw/1bTa9ykxq05wyntxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 001/113] crypto: skcipher - Fix -Wstringop-truncation warnings
Date:   Mon,  8 Oct 2018 20:30:02 +0200
Message-Id: <20181008175530.936308092@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit cefd769fd0192c84d638f66da202459ed8ad63ba ]

As of GCC 9.0.0 the build is reporting warnings like:

    crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
    crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
      strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       sizeof(rblkcipher.geniv));
       ~~~~~~~~~~~~~~~~~~~~~~~~~

This means the strnycpy might create a non null terminated string.  Fix this by
explicitly performing '\0' termination.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/ablkcipher.c |    2 ++
 crypto/blkcipher.c  |    1 +
 2 files changed, 3 insertions(+)

--- a/crypto/ablkcipher.c
+++ b/crypto/ablkcipher.c
@@ -384,6 +384,7 @@ static int crypto_ablkcipher_report(stru
 	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
@@ -465,6 +466,7 @@ static int crypto_givcipher_report(struc
 	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -515,6 +515,7 @@ static int crypto_blkcipher_report(struc
 	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;


