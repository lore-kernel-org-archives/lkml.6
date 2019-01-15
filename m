Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5057BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1953D2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570329;
	bh=Zwi+oRvU88y+FQGDFnwaTRKc+z1ifsN7OGj8AkAl4QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YtmgjjGZsnTCtbSBVUHUXwx6sNhXD+Z6p3NstFDKfZpsB6X0siAvom37GGuzbzGG1
	 yjxOTXWO9anDfhZA/XudmJ20Ai+uFttjUE0ya/dwcgjs8sXOEXt1QtJxYqUP06T953
	 q34kXGQomjGgzBx/YDGKxMgC9OQOXTokmOqQDIJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfAOQir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbfAOQio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D23A20873;
        Tue, 15 Jan 2019 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570324;
        bh=Zwi+oRvU88y+FQGDFnwaTRKc+z1ifsN7OGj8AkAl4QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1cf+M9yNwcpcuDrMTKe5tFQpXmN5fGdEY/s4Sie3OsdpkinJrZLG1epA7jcPkVSn
         iR/1RriOoByEg5iYdtyIqgl2EGpM7XjLZxAEjTyADQLbC3E2BUpOE6E4dw+Q9j79nq
         tmq3gu7Q1apDP3Z1RMDXXwUVJtc5BO2r1k2AtEQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.4 49/51] crypto: cts - fix crash on short inputs
Date:   Tue, 15 Jan 2019 17:35:45 +0100
Message-Id: <20190115154854.089548717@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Eric Biggers <ebiggers@google.com>

[It's a minimal fix for a bug that was fixed incidentally by a large
refactoring in v4.8.]

In the CTS template, when the input length is <= one block cipher block
(e.g. <= 16 bytes for AES) pass the correct length to the underlying CBC
transform rather than one block.  This matches the upstream behavior and
makes the encryption/decryption operation correctly return -EINVAL when
1 <= nbytes < bsize or succeed when nbytes == 0, rather than crashing.

This was fixed upstream incidentally by a large refactoring,
commit 0605c41cc53c ("crypto: cts - Convert to skcipher").  But
syzkaller easily trips over this when running on older kernels, as it's
easily reachable via AF_ALG.  Therefore, this patch makes the minimal
fix for older kernels.

Cc: linux-crypto@vger.kernel.org
Fixes: 76cb9521795a ("[CRYPTO] cts: Add CTS mode required for Kerberos AES support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/cts.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/crypto/cts.c
+++ b/crypto/cts.c
@@ -137,8 +137,8 @@ static int crypto_cts_encrypt(struct blk
 	lcldesc.info = desc->info;
 	lcldesc.flags = desc->flags;
 
-	if (tot_blocks == 1) {
-		err = crypto_blkcipher_encrypt_iv(&lcldesc, dst, src, bsize);
+	if (tot_blocks <= 1) {
+		err = crypto_blkcipher_encrypt_iv(&lcldesc, dst, src, nbytes);
 	} else if (nbytes <= bsize * 2) {
 		err = cts_cbc_encrypt(ctx, desc, dst, src, 0, nbytes);
 	} else {
@@ -232,8 +232,8 @@ static int crypto_cts_decrypt(struct blk
 	lcldesc.info = desc->info;
 	lcldesc.flags = desc->flags;
 
-	if (tot_blocks == 1) {
-		err = crypto_blkcipher_decrypt_iv(&lcldesc, dst, src, bsize);
+	if (tot_blocks <= 1) {
+		err = crypto_blkcipher_decrypt_iv(&lcldesc, dst, src, nbytes);
 	} else if (nbytes <= bsize * 2) {
 		err = cts_cbc_decrypt(ctx, desc, dst, src, 0, nbytes);
 	} else {


