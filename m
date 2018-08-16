Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64558C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA42147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA42147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeHPVsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:48:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeHPVsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:09 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BE21D29;
        Thu, 16 Aug 2018 18:47:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 10/22] crypto: ccree - fix iv handling
Date:   Thu, 16 Aug 2018 20:45:26 +0200
Message-Id: <20180816171556.918039934@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 00904aa0cd59a36d659ec93d272309e2174bcb5b upstream.

We were copying our last cipher block into the request for use as IV for
all modes of operations. Fix this by discerning the behaviour based on
the mode of operation used: copy ciphertext for CBC, update counter for
CTR.

CC: stable@vger.kernel.org
Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
Reported by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_cipher.c |  111 +++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 27 deletions(-)

--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -593,34 +593,82 @@ static void cc_setup_cipher_data(struct
 	}
 }
 
+/*
+ * Update a CTR-AES 128 bit counter
+ */
+static void cc_update_ctr(u8 *ctr, unsigned int increment)
+{
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
+	    IS_ALIGNED((unsigned long)ctr, 8)) {
+
+		__be64 *high_be = (__be64 *)ctr;
+		__be64 *low_be = high_be + 1;
+		u64 orig_low = __be64_to_cpu(*low_be);
+		u64 new_low = orig_low + (u64)increment;
+
+		*low_be = __cpu_to_be64(new_low);
+
+		if (new_low < orig_low)
+			*high_be = __cpu_to_be64(__be64_to_cpu(*high_be) + 1);
+	} else {
+		u8 *pos = (ctr + AES_BLOCK_SIZE);
+		u8 val;
+		unsigned int size;
+
+		for (; increment; increment--)
+			for (size = AES_BLOCK_SIZE; size; size--) {
+				val = *--pos + 1;
+				*pos = val;
+				if (val)
+					break;
+			}
+	}
+}
+
 static void cc_cipher_complete(struct device *dev, void *cc_req, int err)
 {
 	struct skcipher_request *req = (struct skcipher_request *)cc_req;
 	struct scatterlist *dst = req->dst;
 	struct scatterlist *src = req->src;
 	struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	struct crypto_skcipher *sk_tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(sk_tfm);
+	struct cc_cipher_ctx *ctx_p = crypto_tfm_ctx(tfm);
+	unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
+	unsigned int len;
 
-	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
-	kzfree(req_ctx->iv);
+	switch (ctx_p->cipher_mode) {
+	case DRV_CIPHER_CBC:
+		/*
+		 * The crypto API expects us to set the req->iv to the last
+		 * ciphertext block. For encrypt, simply copy from the result.
+		 * For decrypt, we must copy from a saved buffer since this
+		 * could be an in-place decryption operation and the src is
+		 * lost by this point.
+		 */
+		if (req_ctx->gen_ctx.op_type == DRV_CRYPTO_DIRECTION_DECRYPT)  {
+			memcpy(req->iv, req_ctx->backup_info, ivsize);
+			kzfree(req_ctx->backup_info);
+		} else if (!err) {
+			len = req->cryptlen - ivsize;
+			scatterwalk_map_and_copy(req->iv, req->dst, len,
+						 ivsize, 0);
+		}
+		break;
+
+	case DRV_CIPHER_CTR:
+		/* Compute the counter of the last block */
+		len = ALIGN(req->cryptlen, AES_BLOCK_SIZE) / AES_BLOCK_SIZE;
+		cc_update_ctr((u8 *)req->iv, len);
+		break;
 
-	/*
-	 * The crypto API expects us to set the req->iv to the last
-	 * ciphertext block. For encrypt, simply copy from the result.
-	 * For decrypt, we must copy from a saved buffer since this
-	 * could be an in-place decryption operation and the src is
-	 * lost by this point.
-	 */
-	if (req_ctx->gen_ctx.op_type == DRV_CRYPTO_DIRECTION_DECRYPT)  {
-		memcpy(req->iv, req_ctx->backup_info, ivsize);
-		kzfree(req_ctx->backup_info);
-	} else if (!err) {
-		scatterwalk_map_and_copy(req->iv, req->dst,
-					 (req->cryptlen - ivsize),
-					 ivsize, 0);
+	default:
+		break;
 	}
 
+	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
+	kzfree(req_ctx->iv);
+
 	skcipher_request_complete(req, err);
 }
 
@@ -752,20 +800,29 @@ static int cc_cipher_encrypt(struct skci
 static int cc_cipher_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *sk_tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(sk_tfm);
+	struct cc_cipher_ctx *ctx_p = crypto_tfm_ctx(tfm);
 	struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
 	unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
 	gfp_t flags = cc_gfp_flags(&req->base);
+	unsigned int len;
 
-	/*
-	 * Allocate and save the last IV sized bytes of the source, which will
-	 * be lost in case of in-place decryption and might be needed for CTS.
-	 */
-	req_ctx->backup_info = kmalloc(ivsize, flags);
-	if (!req_ctx->backup_info)
-		return -ENOMEM;
+	if (ctx_p->cipher_mode == DRV_CIPHER_CBC) {
+
+		/* Allocate and save the last IV sized bytes of the source,
+		 * which will be lost in case of in-place decryption.
+		 */
+		req_ctx->backup_info = kzalloc(ivsize, flags);
+		if (!req_ctx->backup_info)
+			return -ENOMEM;
+
+		len = req->cryptlen - ivsize;
+		scatterwalk_map_and_copy(req_ctx->backup_info, req->src, len,
+					 ivsize, 0);
+	} else {
+		req_ctx->backup_info = NULL;
+	}
 
-	scatterwalk_map_and_copy(req_ctx->backup_info, req->src,
-				 (req->cryptlen - ivsize), ivsize, 0);
 	req_ctx->is_giv = false;
 
 	return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_DECRYPT);


