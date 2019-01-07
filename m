Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB54C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A712620665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865766;
	bh=otWSsJZkcjmw2PwiMD4MV50rXJA7Lhjl7cUo5tPk3hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mYdPgaY4MEMjavloW4oNH+18GtSVibe8fApBHhLwhWhrNb9EwiyI8a9wwraVYSPmx
	 F29sKV9OtNmuT4+hmYYxqZOnMDa9lby1/fX9BxNW0WB1sAa5002qrHdUXeG//0wxEX
	 5XQcFkvJPFjo8WsIU7ByueAZ8dXlQ8KXkHXuzrTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfAGM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfAGM4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2A320651;
        Mon,  7 Jan 2019 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865763;
        bh=otWSsJZkcjmw2PwiMD4MV50rXJA7Lhjl7cUo5tPk3hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij9n2Ay4RsJiNJSl4MLVFabZaT4aMEBJEu395itiWtO6pOq/wysTCoV5KdBpXaRVk
         l5uGMih/M91Ke9wDywFuJnndPnD3QZy7CvXzs8gD9NccAMKdBRGS3GHdGH8+/+pZqb
         aSYqf5dx+Uqlpi4Ls/LPlxLiqm5BRIWnponA7O1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 120/170] crypto: cavium/nitrox - fix a DMA pool free failure
Date:   Mon,  7 Jan 2019 13:32:27 +0100
Message-Id: <20190107104507.118674287@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

commit 7172122be6a4712d699da4d261f92aa5ab3a78b8 upstream.

In crypto_alloc_context(), a DMA pool is allocated through dma_pool_alloc()
to hold the crypto context. The meta data of the DMA pool, including the
pool used for the allocation 'ndev->ctx_pool' and the base address of the
DMA pool used by the device 'dma', are then stored to the beginning of the
pool. These meta data are eventually used in crypto_free_context() to free
the DMA pool through dma_pool_free(). However, given that the DMA pool can
also be accessed by the device, a malicious device can modify these meta
data, especially when the device is controlled to deploy an attack. This
can cause an unexpected DMA pool free failure.

To avoid the above issue, this patch introduces a new structure
crypto_ctx_hdr and a new field chdr in the structure nitrox_crypto_ctx hold
the meta data information of the DMA pool after the allocation. Note that
the original structure ctx_hdr is not changed to ensure the compatibility.

Cc: <stable@vger.kernel.org>
Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/cavium/nitrox/nitrox_algs.c |   12 +++++++-----
 drivers/crypto/cavium/nitrox/nitrox_lib.c  |   22 +++++++++++++++++-----
 drivers/crypto/cavium/nitrox/nitrox_req.h  |    7 +++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

--- a/drivers/crypto/cavium/nitrox/nitrox_algs.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_algs.c
@@ -73,7 +73,7 @@ static int flexi_aes_keylen(int keylen)
 static int nitrox_skcipher_init(struct crypto_skcipher *tfm)
 {
 	struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(tfm);
-	void *fctx;
+	struct crypto_ctx_hdr *chdr;
 
 	/* get the first device */
 	nctx->ndev = nitrox_get_first_device();
@@ -81,12 +81,14 @@ static int nitrox_skcipher_init(struct c
 		return -ENODEV;
 
 	/* allocate nitrox crypto context */
-	fctx = crypto_alloc_context(nctx->ndev);
-	if (!fctx) {
+	chdr = crypto_alloc_context(nctx->ndev);
+	if (!chdr) {
 		nitrox_put_device(nctx->ndev);
 		return -ENOMEM;
 	}
-	nctx->u.ctx_handle = (uintptr_t)fctx;
+	nctx->chdr = chdr;
+	nctx->u.ctx_handle = (uintptr_t)((u8 *)chdr->vaddr +
+					 sizeof(struct ctx_hdr));
 	crypto_skcipher_set_reqsize(tfm, crypto_skcipher_reqsize(tfm) +
 				    sizeof(struct nitrox_kcrypt_request));
 	return 0;
@@ -102,7 +104,7 @@ static void nitrox_skcipher_exit(struct
 
 		memset(&fctx->crypto, 0, sizeof(struct crypto_keys));
 		memset(&fctx->auth, 0, sizeof(struct auth_keys));
-		crypto_free_context((void *)fctx);
+		crypto_free_context((void *)nctx->chdr);
 	}
 	nitrox_put_device(nctx->ndev);
 
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -146,12 +146,19 @@ static void destroy_crypto_dma_pool(stru
 void *crypto_alloc_context(struct nitrox_device *ndev)
 {
 	struct ctx_hdr *ctx;
+	struct crypto_ctx_hdr *chdr;
 	void *vaddr;
 	dma_addr_t dma;
 
+	chdr = kmalloc(sizeof(*chdr), GFP_KERNEL);
+	if (!chdr)
+		return NULL;
+
 	vaddr = dma_pool_alloc(ndev->ctx_pool, (GFP_KERNEL | __GFP_ZERO), &dma);
-	if (!vaddr)
+	if (!vaddr) {
+		kfree(chdr);
 		return NULL;
+	}
 
 	/* fill meta data */
 	ctx = vaddr;
@@ -159,7 +166,11 @@ void *crypto_alloc_context(struct nitrox
 	ctx->dma = dma;
 	ctx->ctx_dma = dma + sizeof(struct ctx_hdr);
 
-	return ((u8 *)vaddr + sizeof(struct ctx_hdr));
+	chdr->pool = ndev->ctx_pool;
+	chdr->dma = dma;
+	chdr->vaddr = vaddr;
+
+	return chdr;
 }
 
 /**
@@ -168,13 +179,14 @@ void *crypto_alloc_context(struct nitrox
  */
 void crypto_free_context(void *ctx)
 {
-	struct ctx_hdr *ctxp;
+	struct crypto_ctx_hdr *ctxp;
 
 	if (!ctx)
 		return;
 
-	ctxp = (struct ctx_hdr *)((u8 *)ctx - sizeof(struct ctx_hdr));
-	dma_pool_free(ctxp->pool, ctxp, ctxp->dma);
+	ctxp = ctx;
+	dma_pool_free(ctxp->pool, ctxp->vaddr, ctxp->dma);
+	kfree(ctxp);
 }
 
 /**
--- a/drivers/crypto/cavium/nitrox/nitrox_req.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_req.h
@@ -181,12 +181,19 @@ struct flexi_crypto_context {
 	struct auth_keys auth;
 };
 
+struct crypto_ctx_hdr {
+	struct dma_pool *pool;
+	dma_addr_t dma;
+	void *vaddr;
+};
+
 struct nitrox_crypto_ctx {
 	struct nitrox_device *ndev;
 	union {
 		u64 ctx_handle;
 		struct flexi_crypto_context *fctx;
 	} u;
+	struct crypto_ctx_hdr *chdr;
 };
 
 struct nitrox_kcrypt_request {


