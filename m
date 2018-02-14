Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162196AbeBNSct (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:32:49 -0500
Received: from mout.web.de ([212.227.15.4]:36395 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162181AbeBNScr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:32:47 -0500
Subject: [PATCH 2/2] crypto: caam: Use common error handling code in four
 functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9a9a602d-93da-457d-c37d-2acbb4b7b5d5@users.sourceforge.net>
Message-ID: <3c2905a1-b3a4-be87-618e-8562d3a5d8b4@users.sourceforge.net>
Date: Wed, 14 Feb 2018 19:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9a9a602d-93da-457d-c37d-2acbb4b7b5d5@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:o8nSh23sQ+gl1Uw6uKdQo4vm389oajtuRWaa/MMARP4mzBlwels
 hc+JHRcG1o80Jl/Bucb+M53gH9r7lIv4jPM/CHcF6fpSdqhykDKASfSjUzSzbDKrLmjvddw
 Lr2Lz1XE4of4jUAx4dC62fNE/D6mD3IwcLsv4KcElxpdWNFa9uP71/bCO8jkK0fDPRd3v3x
 JfxTZ7kceGJ//HPLCmLZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SGBkP+NNq9Y=:jwkgJiFPRLVJl4dBvJxLxO
 FjSG725i7cEMl2Oyfb+iminxieNXjjHOKWpgG4OcuHScWAMbFKHPCk3nXlUTCrXw/DqJWBSSS
 F/q/omxBREJFcpxCXIeotCguLMFYRl49jnc36qqtCe0QJMBhqv9STg0VRJCuowofG655J86zP
 WBE6V+s6NAPP4eWAiwVkmi2g1ZNkpzYzXLI8ipiqt5Z36rpvFvRJQrG9NVUvSZuTGz4IB4VF4
 XkKFW74FN0w2n1+bJXVIgnb+jKOLUi0KQyDUDkaYS7VFkGlwB1kojBV2iN7nLTQFHppjVF9pd
 IOlYMZJjX2tA6antPFHabYVwTHX88qGMd7wb4Al8z9iaxZXAbFF9dzC6eAXd1YwMFJOJyuzoI
 Vu7UFWeBKvVmWvbaWiwE98FD5DWBRCjptxZy5jG8DKQMt33HsCzfwxJSmC7PKuRTw9vcIoxm+
 zCmdB6blZJt/7kRbWu/GITG6tLE4XqSNCfUE7nWb8wr/Ad5Cn64XZoQchkr6TUgkpjXHz+AJg
 qZIOtSZIijNkdrmpyjHq8bYz0/dkaKU5INNi9pRgJQkn+rxg7tZVKSdcTK/i8ismWgvQ7zdv0
 l8DczwISxcN5B0cJWNWVrYV3yYyIYdNo8SroOIdRXRNZBlwB3eusy1HIdPdl9Km4psKZkytk9
 Wccvay3yIUP7freP8ry57BWENms4I7nGZrqxDwgCIENNZrLhS8Yv/LzvuArJMlH3JvGWSptz+
 x7vR8SGbkXuAqyfL7YfgikMiKoN7xbgzMWCm914lKMVwIjFIJ4UtF8orohXHrCNNixCi2msQs
 p7li5TRL6khHZJv3Y8+EYs5PUxW56CrvSh6Y/IS92xGRFaVqac=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 19:14:49 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/caam/caamalg.c  | 32 ++++++++++++++++----------------
 drivers/crypto/caam/caamhash.c | 23 ++++++++++-------------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d1f25a90552a..3d26c44040c7 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1560,11 +1560,8 @@ static struct ablkcipher_edesc *ablkcipher_edesc_alloc(struct ablkcipher_request
 	/* allocate space for base edesc and hw desc commands, link tables */
 	edesc = kzalloc(sizeof(*edesc) + desc_bytes + sec4_sg_bytes,
 			GFP_DMA | flags);
-	if (!edesc) {
-		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents,
-			   iv_dma, ivsize, 0, 0);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!edesc)
+		goto unmap_caam;
 
 	edesc->src_nents = src_nents;
 	edesc->dst_nents = dst_nents;
@@ -1587,10 +1584,8 @@ static struct ablkcipher_edesc *ablkcipher_edesc_alloc(struct ablkcipher_request
 					    sec4_sg_bytes, DMA_TO_DEVICE);
 	if (dma_mapping_error(jrdev, edesc->sec4_sg_dma)) {
 		dev_err(jrdev, "unable to map S/G table\n");
-		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents,
-			   iv_dma, ivsize, 0, 0);
 		kfree(edesc);
-		return ERR_PTR(-ENOMEM);
+		goto unmap_caam;
 	}
 
 	edesc->iv_dma = iv_dma;
@@ -1603,6 +1598,11 @@ static struct ablkcipher_edesc *ablkcipher_edesc_alloc(struct ablkcipher_request
 
 	*iv_contig_out = in_contig;
 	return edesc;
+
+unmap_caam:
+	caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents,
+		   iv_dma, ivsize, 0, 0);
+	return ERR_PTR(-ENOMEM);
 }
 
 static int ablkcipher_encrypt(struct ablkcipher_request *req)
@@ -1768,11 +1768,8 @@ static struct ablkcipher_edesc *ablkcipher_giv_edesc_alloc(
 	sec4_sg_bytes = sec4_sg_ents * sizeof(struct sec4_sg_entry);
 	edesc = kzalloc(sizeof(*edesc) + desc_bytes + sec4_sg_bytes,
 			GFP_DMA | flags);
-	if (!edesc) {
-		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents,
-			   iv_dma, ivsize, 0, 0);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!edesc)
+		goto unmap_caam;
 
 	edesc->src_nents = src_nents;
 	edesc->dst_nents = dst_nents;
@@ -1795,10 +1792,8 @@ static struct ablkcipher_edesc *ablkcipher_giv_edesc_alloc(
 					    sec4_sg_bytes, DMA_TO_DEVICE);
 	if (dma_mapping_error(jrdev, edesc->sec4_sg_dma)) {
 		dev_err(jrdev, "unable to map S/G table\n");
-		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents,
-			   iv_dma, ivsize, 0, 0);
 		kfree(edesc);
-		return ERR_PTR(-ENOMEM);
+		goto unmap_caam;
 	}
 	edesc->iv_dma = iv_dma;
 
@@ -1811,6 +1806,11 @@ static struct ablkcipher_edesc *ablkcipher_giv_edesc_alloc(
 
 	*iv_contig_out = out_contig;
 	return edesc;
+
+unmap_caam:
+	caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents,
+		   iv_dma, ivsize, 0, 0);
+	return ERR_PTR(-ENOMEM);
 }
 
 static int ablkcipher_givencrypt(struct skcipher_givcrypt_request *creq)
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index dc269eba08ad..b5e43a1f38f0 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -371,16 +371,16 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, const u8 *key_in,
 				 DMA_TO_DEVICE);
 	if (dma_mapping_error(jrdev, src_dma)) {
 		dev_err(jrdev, "unable to map key input memory\n");
-		kfree(desc);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_desc;
 	}
 	dst_dma = dma_map_single(jrdev, (void *)key_out, digestsize,
 				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, dst_dma)) {
 		dev_err(jrdev, "unable to map key output memory\n");
 		dma_unmap_single(jrdev, src_dma, *keylen, DMA_TO_DEVICE);
-		kfree(desc);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_desc;
 	}
 
 	/* Job descriptor to perform unkeyed hash on key_in */
@@ -419,7 +419,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, const u8 *key_in,
 	dma_unmap_single(jrdev, dst_dma, digestsize, DMA_FROM_DEVICE);
 
 	*keylen = digestsize;
-
+free_desc:
 	kfree(desc);
 
 	return ret;
@@ -1070,11 +1070,8 @@ static int ahash_digest(struct ahash_request *req)
 
 	ret = ahash_edesc_add_src(ctx, edesc, req, mapped_nents, 0, 0,
 				  req->nbytes);
-	if (ret) {
-		ahash_unmap(jrdev, edesc, req, digestsize);
-		kfree(edesc);
-		return ret;
-	}
+	if (ret)
+		goto unmap_hash;
 
 	desc = edesc->hw_desc;
 
@@ -1082,9 +1079,8 @@ static int ahash_digest(struct ahash_request *req)
 						digestsize);
 	if (dma_mapping_error(jrdev, edesc->dst_dma)) {
 		dev_err(jrdev, "unable to map dst\n");
-		ahash_unmap(jrdev, edesc, req, digestsize);
-		kfree(edesc);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto unmap_hash;
 	}
 
 #ifdef DEBUG
@@ -1096,6 +1092,7 @@ static int ahash_digest(struct ahash_request *req)
 	if (!ret) {
 		ret = -EINPROGRESS;
 	} else {
+unmap_hash:
 		ahash_unmap(jrdev, edesc, req, digestsize);
 		kfree(edesc);
 	}
-- 
2.16.1
