Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4F821476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2wLIT5S9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4F821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeJKXGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1FB2087A;
        Thu, 11 Oct 2018 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272326;
        bh=6ezUZqydmzw0gOHEyo4U1SJMV52Sf/xcrY9sV4JYB/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wLIT5S9Cf3M8OOAEkE5qcxbUgsxgRsnzeZ47YKqX6ndDrvqVFaVGZgbOZWsn0Z10
         brmGpxkRs3lWm/ZAiDPW81oL6gy9XXUG3W3gSZjFh/ii0x+MSmn8hP2anylxyMwusW
         Fs9ZHUBsTxDwtCJc1wrihLrQY3lzZHSzr5h7yR2g=
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
Subject: [PATCH 3.18 020/120] crypto: skcipher - Fix -Wstringop-truncation warnings
Date:   Thu, 11 Oct 2018 17:33:21 +0200
Message-Id: <20181011152550.491340556@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -382,6 +382,7 @@ static int crypto_ablkcipher_report(stru
 	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
@@ -463,6 +464,7 @@ static int crypto_givcipher_report(struc
 	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -514,6 +514,7 @@ static int crypto_blkcipher_report(struc
 	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;


