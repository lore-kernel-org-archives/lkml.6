Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC7C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00E520876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00E520876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeJNX16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37226 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMI-0004cU-HK; Sun, 14 Oct 2018 16:31:10 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-0000Af-Vz; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.188861900@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 028/366] crypto: x86/cast5-avx - fix ECB encryption
 when long sg follows short one
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 8f461b1e02ed546fbd0f11611138da67fd85a30f upstream.

With ecb-cast5-avx, if a 128+ byte scatterlist element followed a
shorter one, then the algorithm accidentally encrypted/decrypted only 8
bytes instead of the expected 128 bytes.  Fix it by setting the
encryption/decryption 'fn' correctly.

Fixes: c12ab20b162c ("crypto: cast5/avx - avoid using temporary stack buffers")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/crypto/cast5_avx_glue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -67,8 +67,6 @@ static int ecb_crypt(struct blkcipher_de
 	void (*fn)(struct cast5_ctx *ctx, u8 *dst, const u8 *src);
 	int err;
 
-	fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
-
 	err = blkcipher_walk_virt(desc, walk);
 	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
@@ -80,6 +78,7 @@ static int ecb_crypt(struct blkcipher_de
 
 		/* Process multi-block batch */
 		if (nbytes >= bsize * CAST5_PARALLEL_BLOCKS) {
+			fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
 			do {
 				fn(ctx, wdst, wsrc);
 

