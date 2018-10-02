Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6CCC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD822064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD822064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbeJBUS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbeJBUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:56 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A138FB2F;
        Tue,  2 Oct 2018 13:35:32 +0000 (UTC)
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
Subject: [PATCH 4.9 01/94] crypto: skcipher - Fix -Wstringop-truncation warnings
Date:   Tue,  2 Oct 2018 06:24:15 -0700
Message-Id: <20181002132500.572685138@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -367,6 +367,7 @@ static int crypto_ablkcipher_report(stru
 	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
@@ -441,6 +442,7 @@ static int crypto_givcipher_report(struc
 	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -510,6 +510,7 @@ static int crypto_blkcipher_report(struc
 	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;


