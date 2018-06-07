Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GwApItnzGFt6MwAAmS7hNA
	; Thu, 07 Jun 2018 08:59:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7C1456089E; Thu,  7 Jun 2018 08:59:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3FC3607DC;
	Thu,  7 Jun 2018 08:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3FC3607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbeFGI7C (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:59:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbeFGI7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:59:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8A515AB;
        Thu,  7 Jun 2018 01:59:00 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.45.48.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F4C93F59D;
        Thu,  7 Jun 2018 01:58:58 -0700 (PDT)
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, stable@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ccree: fix iv copying for small buffers
Date: Thu,  7 Jun 2018 09:58:47 +0100
Message-Id: <1528361927-4172-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are copying our last cipher block into the request for use as IV as
required by the Crypto API but we failed to handle correctly the case the
buffer we are working on is smaller than a block. Fix it by calculating
how much we need to copy based on buffer size.

CC: stable@vger.kernel.org
Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
Reported by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index d2810c1..a07547f 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -616,9 +616,18 @@ static void cc_cipher_complete(struct device *dev, void *cc_req, int err)
 		memcpy(req->iv, req_ctx->backup_info, ivsize);
 		kzfree(req_ctx->backup_info);
 	} else if (!err) {
-		scatterwalk_map_and_copy(req->iv, req->dst,
-					 (req->cryptlen - ivsize),
-					 ivsize, 0);
+		unsigned int len;
+
+		if (req->cryptlen > ivsize) {
+			len = req->cryptlen - ivsize;
+		} else {
+			memset(req->iv, 0, ivsize);
+			len = 0;
+			ivsize = req->cryptlen;
+
+		}
+
+		scatterwalk_map_and_copy(req->iv, req->dst, len, ivsize, 0);
 	}
 
 	skcipher_request_complete(req, err);
@@ -755,17 +764,26 @@ static int cc_cipher_decrypt(struct skcipher_request *req)
 	struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
 	unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
 	gfp_t flags = cc_gfp_flags(&req->base);
+	unsigned int len;
 
 	/*
 	 * Allocate and save the last IV sized bytes of the source, which will
 	 * be lost in case of in-place decryption and might be needed for CTS.
 	 */
-	req_ctx->backup_info = kmalloc(ivsize, flags);
+	req_ctx->backup_info = kzalloc(ivsize, flags);
 	if (!req_ctx->backup_info)
 		return -ENOMEM;
 
-	scatterwalk_map_and_copy(req_ctx->backup_info, req->src,
-				 (req->cryptlen - ivsize), ivsize, 0);
+
+	if (req->cryptlen > ivsize) {
+		len = req->cryptlen - ivsize;
+	} else {
+		len = 0;
+		ivsize = req->cryptlen;
+	}
+
+	scatterwalk_map_and_copy(req_ctx->backup_info, req->src, len, ivsize,
+				 0);
 	req_ctx->is_giv = false;
 
 	return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_DECRYPT);
-- 
2.7.4
