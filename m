Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D47720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D47720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbeGXPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:20:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52304 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbeGXPUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:20:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE717A9;
        Tue, 24 Jul 2018 07:13:58 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66B23F237;
        Tue, 24 Jul 2018 07:13:56 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: ccree: zero all of request ctx before use
Date:   Tue, 24 Jul 2018 15:12:45 +0100
Message-Id: <1532441567-11694-4-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
References: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain error path req_ctx->iv was being freed despite
not being allocated because it was not initialized to NULL.
Rather than play whack a mole with the structure various
field, zero it before use.

This fixes a kernel panic that may occur if an invalid
buffer size was requested triggering the bug above.

Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 64740dd..9da0ecc 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -767,7 +767,7 @@ static int cc_cipher_encrypt(struct skcipher_request *req)
 {
 	struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
 
-	req_ctx->backup_info = NULL;
+	memset(req_ctx, 0, sizeof(*req_ctx));
 
 	return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_ENCRYPT);
 }
@@ -782,6 +782,8 @@ static int cc_cipher_decrypt(struct skcipher_request *req)
 	gfp_t flags = cc_gfp_flags(&req->base);
 	unsigned int len;
 
+	memset(req_ctx, 0, sizeof(*req_ctx));
+
 	if (ctx_p->cipher_mode == DRV_CIPHER_CBC) {
 
 		/* Allocate and save the last IV sized bytes of the source,
@@ -794,8 +796,6 @@ static int cc_cipher_decrypt(struct skcipher_request *req)
 		len = req->cryptlen - ivsize;
 		scatterwalk_map_and_copy(req_ctx->backup_info, req->src, len,
 					 ivsize, 0);
-	} else {
-		req_ctx->backup_info = NULL;
 	}
 
 	return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_DECRYPT);
-- 
2.7.4

