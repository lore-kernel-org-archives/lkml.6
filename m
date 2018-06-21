Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0871C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5666E20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5666E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeFULt2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:49:28 -0400
Received: from foss.arm.com ([217.140.101.70]:48908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933130AbeFULt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:49:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566331435;
        Thu, 21 Jun 2018 04:49:26 -0700 (PDT)
Received: from ssg-dev-vb.kfn.arm.com (unknown [10.45.48.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 310863F578;
        Thu, 21 Jun 2018 04:49:24 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ofir Drang <ofir.drang@arm.com>,
        Gilad Ben-Yossef <gilad.BenYossef@arm.com>,
        Hadar Gat <hadar.gat@arm.com>, stable@vger.kernel.org
Subject: [PATCH] crypto: ccree: fix finup
Date:   Thu, 21 Jun 2018 12:47:32 +0100
Message-Id: <1529581652-31294-1-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

finup() operation was incorrect, padding was missing.
Fix by setting the ccree HW to enable padding.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Cc: stable@vger.kernel.org
---
 drivers/crypto/ccree/cc_hash.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccree/cc_hash.c b/drivers/crypto/ccree/cc_hash.c
index 96ff777..e8bb934 100644
--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -500,8 +500,12 @@ static int cc_hash_digest(struct ahash_request *req)
 }
 
 static int cc_restore_hash(struct cc_hw_desc *desc, struct cc_hash_ctx *ctx,
-			   struct ahash_req_ctx *state, unsigned int idx)
+			   struct ahash_req_ctx *state, unsigned int idx,
+			   bool hash_padding)
 {
+	enum cc_hash_conf_pad pad_conf = hash_padding ? HASH_PADDING_ENABLED :
+			HASH_PADDING_DISABLED;
+
 	/* Restore hash digest */
 	hw_desc_init(&desc[idx]);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
@@ -514,7 +518,7 @@ static int cc_restore_hash(struct cc_hw_desc *desc, struct cc_hash_ctx *ctx,
 	/* Restore hash current length */
 	hw_desc_init(&desc[idx]);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
-	set_cipher_config1(&desc[idx], HASH_PADDING_DISABLED);
+	set_cipher_config1(&desc[idx], pad_conf);
 	set_din_type(&desc[idx], DMA_DLLI, state->digest_bytes_len_dma_addr,
 		     ctx->drvdata->hash_len_sz, NS_BIT);
 	set_flow_mode(&desc[idx], S_DIN_to_HASH);
@@ -572,7 +576,7 @@ static int cc_hash_update(struct ahash_request *req)
 	cc_req.user_cb = cc_update_complete;
 	cc_req.user_arg = req;
 
-	idx = cc_restore_hash(desc, ctx, state, idx);
+	idx = cc_restore_hash(desc, ctx, state, idx, false);
 
 	/* store the hash digest result in context */
 	hw_desc_init(&desc[idx]);
@@ -644,7 +648,7 @@ static int cc_hash_finup(struct ahash_request *req)
 	cc_req.user_cb = cc_hash_complete;
 	cc_req.user_arg = req;
 
-	idx = cc_restore_hash(desc, ctx, state, idx);
+	idx = cc_restore_hash(desc, ctx, state, idx, true);
 
 	if (is_hmac)
 		idx = cc_fin_hmac(desc, req, idx);
@@ -704,7 +708,7 @@ static int cc_hash_final(struct ahash_request *req)
 	cc_req.user_cb = cc_hash_complete;
 	cc_req.user_arg = req;
 
-	idx = cc_restore_hash(desc, ctx, state, idx);
+	idx = cc_restore_hash(desc, ctx, state, idx, false);
 
 	/* "DO-PAD" must be enabled only when writing current length to HW */
 	hw_desc_init(&desc[idx]);
-- 
2.7.4

