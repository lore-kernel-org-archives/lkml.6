Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088DCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C270A2702F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C270A2702F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeF1HdH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:33:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934128AbeF1HdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B0BED1;
        Thu, 28 Jun 2018 00:33:02 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.45.48.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2E703F5C0;
        Thu, 28 Jun 2018 00:33:00 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: ccree: fix finup
Date:   Thu, 28 Jun 2018 08:32:51 +0100
Message-Id: <1530171175-31960-2-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
References: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

finup() operation was incorrect, padding was missing.
Fix by setting the ccree HW to enable padding.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
[ gilad@benyossef.com: refactored for better code sharing ]
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org
---
 drivers/crypto/ccree/cc_hash.c | 81 +++++++++---------------------------------
 1 file changed, 16 insertions(+), 65 deletions(-)

diff --git a/drivers/crypto/ccree/cc_hash.c b/drivers/crypto/ccree/cc_hash.c
index 96ff777..e4ebde0 100644
--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -602,66 +602,7 @@ static int cc_hash_update(struct ahash_request *req)
 	return rc;
 }
 
-static int cc_hash_finup(struct ahash_request *req)
-{
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
-	u32 digestsize = crypto_ahash_digestsize(tfm);
-	struct scatterlist *src = req->src;
-	unsigned int nbytes = req->nbytes;
-	u8 *result = req->result;
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
-	bool is_hmac = ctx->is_hmac;
-	struct cc_crypto_req cc_req = {};
-	struct cc_hw_desc desc[CC_MAX_HASH_SEQ_LEN];
-	unsigned int idx = 0;
-	int rc;
-	gfp_t flags = cc_gfp_flags(&req->base);
-
-	dev_dbg(dev, "===== %s-finup (%d) ====\n", is_hmac ? "hmac" : "hash",
-		nbytes);
-
-	if (cc_map_req(dev, state, ctx)) {
-		dev_err(dev, "map_ahash_source() failed\n");
-		return -EINVAL;
-	}
-
-	if (cc_map_hash_request_final(ctx->drvdata, state, src, nbytes, 1,
-				      flags)) {
-		dev_err(dev, "map_ahash_request_final() failed\n");
-		cc_unmap_req(dev, state, ctx);
-		return -ENOMEM;
-	}
-	if (cc_map_result(dev, state, digestsize)) {
-		dev_err(dev, "map_ahash_digest() failed\n");
-		cc_unmap_hash_request(dev, state, src, true);
-		cc_unmap_req(dev, state, ctx);
-		return -ENOMEM;
-	}
-
-	/* Setup request structure */
-	cc_req.user_cb = cc_hash_complete;
-	cc_req.user_arg = req;
-
-	idx = cc_restore_hash(desc, ctx, state, idx);
-
-	if (is_hmac)
-		idx = cc_fin_hmac(desc, req, idx);
-
-	idx = cc_fin_result(desc, req, idx);
-
-	rc = cc_send_request(ctx->drvdata, &cc_req, desc, idx, &req->base);
-	if (rc != -EINPROGRESS && rc != -EBUSY) {
-		dev_err(dev, "send_request() failed (rc=%d)\n", rc);
-		cc_unmap_hash_request(dev, state, src, true);
-		cc_unmap_result(dev, state, digestsize, result);
-		cc_unmap_req(dev, state, ctx);
-	}
-	return rc;
-}
-
-static int cc_hash_final(struct ahash_request *req)
+static int cc_do_finup(struct ahash_request *req, bool update)
 {
 	struct ahash_req_ctx *state = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -678,21 +619,20 @@ static int cc_hash_final(struct ahash_request *req)
 	int rc;
 	gfp_t flags = cc_gfp_flags(&req->base);
 
-	dev_dbg(dev, "===== %s-final (%d) ====\n", is_hmac ? "hmac" : "hash",
-		nbytes);
+	dev_dbg(dev, "===== %s-%s (%d) ====\n", is_hmac ? "hmac" : "hash",
+		update ? "finup" : "final", nbytes);
 
 	if (cc_map_req(dev, state, ctx)) {
 		dev_err(dev, "map_ahash_source() failed\n");
 		return -EINVAL;
 	}
 
-	if (cc_map_hash_request_final(ctx->drvdata, state, src, nbytes, 0,
+	if (cc_map_hash_request_final(ctx->drvdata, state, src, nbytes, update,
 				      flags)) {
 		dev_err(dev, "map_ahash_request_final() failed\n");
 		cc_unmap_req(dev, state, ctx);
 		return -ENOMEM;
 	}
-
 	if (cc_map_result(dev, state, digestsize)) {
 		dev_err(dev, "map_ahash_digest() failed\n");
 		cc_unmap_hash_request(dev, state, src, true);
@@ -706,7 +646,7 @@ static int cc_hash_final(struct ahash_request *req)
 
 	idx = cc_restore_hash(desc, ctx, state, idx);
 
-	/* "DO-PAD" must be enabled only when writing current length to HW */
+	/* Pad the hash */
 	hw_desc_init(&desc[idx]);
 	set_cipher_do(&desc[idx], DO_PAD);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
@@ -731,6 +671,17 @@ static int cc_hash_final(struct ahash_request *req)
 	return rc;
 }
 
+static int cc_hash_finup(struct ahash_request *req)
+{
+	return cc_do_finup(req, true);
+}
+
+
+static int cc_hash_final(struct ahash_request *req)
+{
+	return cc_do_finup(req, false);
+}
+
 static int cc_hash_init(struct ahash_request *req)
 {
 	struct ahash_req_ctx *state = ahash_request_ctx(req);
-- 
2.7.4

