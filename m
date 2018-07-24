Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDED920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDED920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbeGXPUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:20:36 -0400
Received: from foss.arm.com ([217.140.101.70]:52294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbeGXPUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:20:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C77B7A9;
        Tue, 24 Jul 2018 07:13:55 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22C13F237;
        Tue, 24 Jul 2018 07:13:53 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] crypto: ccree: remove cipher ivgen left overs
Date:   Tue, 24 Jul 2018 15:12:44 +0100
Message-Id: <1532441567-11694-3-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
References: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IV generation is not available via the skcipher interface.
Remove the left over support of it from the ablkcipher days.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_buffer_mgr.c |  8 ++------
 drivers/crypto/ccree/cc_cipher.c     | 11 -----------
 drivers/crypto/ccree/cc_cipher.h     |  1 -
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index b325774..dd948e1 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -454,9 +454,7 @@ void cc_unmap_cipher_request(struct device *dev, void *ctx,
 		dev_dbg(dev, "Unmapped iv: iv_dma_addr=%pad iv_size=%u\n",
 			&req_ctx->gen_ctx.iv_dma_addr, ivsize);
 		dma_unmap_single(dev, req_ctx->gen_ctx.iv_dma_addr,
-				 ivsize,
-				 req_ctx->is_giv ? DMA_BIDIRECTIONAL :
-				 DMA_TO_DEVICE);
+				 ivsize, DMA_TO_DEVICE);
 	}
 	/* Release pool */
 	if (req_ctx->dma_buf_type == CC_DMA_BUF_MLLI &&
@@ -498,9 +496,7 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 		dump_byte_array("iv", (u8 *)info, ivsize);
 		req_ctx->gen_ctx.iv_dma_addr =
 			dma_map_single(dev, (void *)info,
-				       ivsize,
-				       req_ctx->is_giv ? DMA_BIDIRECTIONAL :
-				       DMA_TO_DEVICE);
+				       ivsize, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, req_ctx->gen_ctx.iv_dma_addr)) {
 			dev_err(dev, "Mapping iv %u B at va=%pK for DMA failed\n",
 				ivsize, info);
diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index eb99633..64740dd 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -743,14 +743,6 @@ static int cc_cipher_process(struct skcipher_request *req,
 	cc_setup_cipher_data(tfm, req_ctx, dst, src, nbytes, req, desc,
 			     &seq_len);
 
-	/* do we need to generate IV? */
-	if (req_ctx->is_giv) {
-		cc_req.ivgen_dma_addr[0] = req_ctx->gen_ctx.iv_dma_addr;
-		cc_req.ivgen_dma_addr_len = 1;
-		/* set the IV size (8/16 B long)*/
-		cc_req.ivgen_size = ivsize;
-	}
-
 	/* STAT_PHASE_3: Lock HW and push sequence */
 
 	rc = cc_send_request(ctx_p->drvdata, &cc_req, desc, seq_len,
@@ -775,7 +767,6 @@ static int cc_cipher_encrypt(struct skcipher_request *req)
 {
 	struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
 
-	req_ctx->is_giv = false;
 	req_ctx->backup_info = NULL;
 
 	return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_ENCRYPT);
@@ -807,8 +798,6 @@ static int cc_cipher_decrypt(struct skcipher_request *req)
 		req_ctx->backup_info = NULL;
 	}
 
-	req_ctx->is_giv = false;
-
 	return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_DECRYPT);
 }
 
diff --git a/drivers/crypto/ccree/cc_cipher.h b/drivers/crypto/ccree/cc_cipher.h
index 68444cf..4dbc0a1 100644
--- a/drivers/crypto/ccree/cc_cipher.h
+++ b/drivers/crypto/ccree/cc_cipher.h
@@ -22,7 +22,6 @@ struct cipher_req_ctx {
 	u32 out_mlli_nents;
 	u8 *backup_info; /*store iv for generated IV flow*/
 	u8 *iv;
-	bool is_giv;
 	struct mlli_params mlli_params;
 };
 
-- 
2.7.4

