Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013D21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D013D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeHPVr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:47:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeHPVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:47:55 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4372DCE8;
        Thu, 16 Aug 2018 18:47:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hadar Gat <hadar.gat@arm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.17 08/21] crypto: ccree - fix finup
Date:   Thu, 16 Aug 2018 20:45:18 +0200
Message-Id: <20180816171612.816465187@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171612.136242278@linuxfoundation.org>
References: <20180816171612.136242278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hadar Gat <hadar.gat@arm.com>

commit 26497e72a1aba4d27c50c4cbf0182db94e58a590 upstream.

finup() operation was incorrect, padding was missing.
Fix by setting the ccree HW to enable padding.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
[ gilad@benyossef.com: refactored for better code sharing ]
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_hash.c |   81 ++++++++---------------------------------
 1 file changed, 16 insertions(+), 65 deletions(-)

--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -602,7 +602,7 @@ static int cc_hash_update(struct ahash_r
 	return rc;
 }
 
-static int cc_hash_finup(struct ahash_request *req)
+static int cc_do_finup(struct ahash_request *req, bool update)
 {
 	struct ahash_req_ctx *state = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -619,15 +619,15 @@ static int cc_hash_finup(struct ahash_re
 	int rc;
 	gfp_t flags = cc_gfp_flags(&req->base);
 
-	dev_dbg(dev, "===== %s-finup (%d) ====\n", is_hmac ? "hmac" : "hash",
-		nbytes);
+	dev_dbg(dev, "===== %s-%s (%d) ====\n", is_hmac ? "hmac" : "hash",
+		update ? "finup" : "final", nbytes);
 
 	if (cc_map_req(dev, state, ctx)) {
 		dev_err(dev, "map_ahash_source() failed\n");
 		return -EINVAL;
 	}
 
-	if (cc_map_hash_request_final(ctx->drvdata, state, src, nbytes, 1,
+	if (cc_map_hash_request_final(ctx->drvdata, state, src, nbytes, update,
 				      flags)) {
 		dev_err(dev, "map_ahash_request_final() failed\n");
 		cc_unmap_req(dev, state, ctx);
@@ -646,67 +646,7 @@ static int cc_hash_finup(struct ahash_re
 
 	idx = cc_restore_hash(desc, ctx, state, idx);
 
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
-	dev_dbg(dev, "===== %s-final (%d) ====\n", is_hmac ? "hmac" : "hash",
-		nbytes);
-
-	if (cc_map_req(dev, state, ctx)) {
-		dev_err(dev, "map_ahash_source() failed\n");
-		return -EINVAL;
-	}
-
-	if (cc_map_hash_request_final(ctx->drvdata, state, src, nbytes, 0,
-				      flags)) {
-		dev_err(dev, "map_ahash_request_final() failed\n");
-		cc_unmap_req(dev, state, ctx);
-		return -ENOMEM;
-	}
-
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
-	/* "DO-PAD" must be enabled only when writing current length to HW */
+	/* Pad the hash */
 	hw_desc_init(&desc[idx]);
 	set_cipher_do(&desc[idx], DO_PAD);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
@@ -731,6 +671,17 @@ static int cc_hash_final(struct ahash_re
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


