Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeD0Iq4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:46:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35423 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932324AbeD0Iqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:46:54 -0400
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Binderman <dcb314@hotmail.com>, Radu Alexe <radu.alexe@nxp.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam - fix size of RSA prime factor q
Date: Fri, 27 Apr 2018 11:40:11 +0300
Message-Id: <20180427084011.26234-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <AM4PR08MB28197AB3772FC2932C58EBFC9C8E0@AM4PR08MB2819.eurprd08.prod.outlook.com>
References: <AM4PR08MB28197AB3772FC2932C58EBFC9C8E0@AM4PR08MB2819.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo where size of RSA prime factor q is using the size of
prime factor p.

Cc: <stable@vger.kernel.org> # 4.13+
Fixes: 52e26d77b8b3 ("crypto: caam - add support for RSA key form 2")
Fixes: 4a651b122adb ("crypto: caam - add support for RSA key form 3")
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 6f990139f324..578ea63a3109 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -66,7 +66,7 @@ static void rsa_priv_f2_unmap(struct device *dev, struct rsa_edesc *edesc,
 	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_priv_f2_pdb *pdb = &edesc->pdb.priv_f2;
 	size_t p_sz = key->p_sz;
-	size_t q_sz = key->p_sz;
+	size_t q_sz = key->q_sz;
 
 	dma_unmap_single(dev, pdb->d_dma, key->d_sz, DMA_TO_DEVICE);
 	dma_unmap_single(dev, pdb->p_dma, p_sz, DMA_TO_DEVICE);
@@ -83,7 +83,7 @@ static void rsa_priv_f3_unmap(struct device *dev, struct rsa_edesc *edesc,
 	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_priv_f3_pdb *pdb = &edesc->pdb.priv_f3;
 	size_t p_sz = key->p_sz;
-	size_t q_sz = key->p_sz;
+	size_t q_sz = key->q_sz;
 
 	dma_unmap_single(dev, pdb->p_dma, p_sz, DMA_TO_DEVICE);
 	dma_unmap_single(dev, pdb->q_dma, q_sz, DMA_TO_DEVICE);
@@ -397,7 +397,7 @@ static int set_rsa_priv_f2_pdb(struct akcipher_request *req,
 	struct rsa_priv_f2_pdb *pdb = &edesc->pdb.priv_f2;
 	int sec4_sg_index = 0;
 	size_t p_sz = key->p_sz;
-	size_t q_sz = key->p_sz;
+	size_t q_sz = key->q_sz;
 
 	pdb->d_dma = dma_map_single(dev, key->d, key->d_sz, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, pdb->d_dma)) {
@@ -472,7 +472,7 @@ static int set_rsa_priv_f3_pdb(struct akcipher_request *req,
 	struct rsa_priv_f3_pdb *pdb = &edesc->pdb.priv_f3;
 	int sec4_sg_index = 0;
 	size_t p_sz = key->p_sz;
-	size_t q_sz = key->p_sz;
+	size_t q_sz = key->q_sz;
 
 	pdb->p_dma = dma_map_single(dev, key->p, p_sz, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, pdb->p_dma)) {
-- 
2.16.2
