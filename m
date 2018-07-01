Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9DA24486
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9DA24486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeGAHER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 03:04:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47370 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeGAHDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 03:03:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 350DD18A;
        Sun,  1 Jul 2018 00:03:46 -0700 (PDT)
Received: from sugar.benyossef.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5950B3F318;
        Sun,  1 Jul 2018 00:03:44 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] crypto: ccree: use CBC-CS3 CTS mode
Date:   Sun,  1 Jul 2018 08:02:38 +0100
Message-Id: <1530428560-4440-6-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530428560-4440-1-git-send-email-gilad@benyossef.com>
References: <1530428560-4440-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccree driver implemented NIST 800-38A CBC-CS2 ciphertext format,
which only reverses the last two blocks if the stolen ciphertext amount
are none zero. Move it to the kernel chosen format of CBC-CS3  which swaps
the final blocks unconditionally and rename it to "cts" now that it
complies with the kernel format and passes the self tests.

Ironically, the CryptoCell REE HW does just that, so the fix is dropping
the code that forced it to use plain CBC if the ciphertext was block
aligned.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 5d12372..7a80963 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -687,7 +687,7 @@ static int cc_cipher_process(struct skcipher_request *req,
 	struct device *dev = drvdata_to_dev(ctx_p->drvdata);
 	struct cc_hw_desc desc[MAX_ABLKCIPHER_SEQ_LEN];
 	struct cc_crypto_req cc_req = {};
-	int rc, cts_restore_flag = 0;
+	int rc;
 	unsigned int seq_len = 0;
 	gfp_t flags = cc_gfp_flags(&req->base);
 
@@ -719,13 +719,6 @@ static int cc_cipher_process(struct skcipher_request *req,
 		goto exit_process;
 	}
 
-	/*For CTS in case of data size aligned to 16 use CBC mode*/
-	if (((nbytes % AES_BLOCK_SIZE) == 0) &&
-	    ctx_p->cipher_mode == DRV_CIPHER_CBC_CTS) {
-		ctx_p->cipher_mode = DRV_CIPHER_CBC;
-		cts_restore_flag = 1;
-	}
-
 	/* Setup request structure */
 	cc_req.user_cb = (void *)cc_cipher_complete;
 	cc_req.user_arg = (void *)req;
@@ -770,9 +763,6 @@ static int cc_cipher_process(struct skcipher_request *req,
 	}
 
 exit_process:
-	if (cts_restore_flag)
-		ctx_p->cipher_mode = DRV_CIPHER_CBC_CTS;
-
 	if (rc != -EINPROGRESS && rc != -EBUSY) {
 		kzfree(req_ctx->backup_info);
 		kzfree(req_ctx->iv);
@@ -1026,8 +1016,8 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
-		.name = "cts1(cbc(paes))",
-		.driver_name = "cts1-cbc-paes-ccree",
+		.name = "cts(cbc(paes))",
+		.driver_name = "cts-cbc-paes-ccree",
 		.blocksize = AES_BLOCK_SIZE,
 		.type = CRYPTO_ALG_TYPE_ABLKCIPHER,
 		.template_skcipher = {
@@ -1261,8 +1251,8 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
-		.name = "cts1(cbc(aes))",
-		.driver_name = "cts1-cbc-aes-ccree",
+		.name = "cts(cbc(aes))",
+		.driver_name = "cts-cbc-aes-ccree",
 		.blocksize = AES_BLOCK_SIZE,
 		.type = CRYPTO_ALG_TYPE_ABLKCIPHER,
 		.template_skcipher = {
-- 
2.7.4

