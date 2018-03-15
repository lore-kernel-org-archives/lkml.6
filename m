Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeCOPkh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:40:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60522 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752831AbeCOPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:40:34 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH 07/12] crypto: inside-secure - improve the send error path
Date: Thu, 15 Mar 2018 16:38:46 +0100
Message-Id: <20180315153851.9958-8-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315153851.9958-1-antoine.tenart@bootlin.com>
References: <20180315153851.9958-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the send error path as it wasn't handling all error
cases. A new label is added, and some of the goto are updated to point
to the right labels, so that the code is more robust to errors.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index bb2be12a8f4a..ef3e0c1c0f2c 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -279,7 +279,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 					   sglen, len, ctx->base.ctxr_dma);
 		if (IS_ERR(cdesc)) {
 			ret = PTR_ERR(cdesc);
-			goto cdesc_rollback;
+			goto unmap_sg;
 		}
 		n_cdesc++;
 
@@ -303,7 +303,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 					 DMA_FROM_DEVICE);
 	if (dma_mapping_error(priv->dev, req->result_dma)) {
 		ret = -EINVAL;
-		goto cdesc_rollback;
+		goto unmap_sg;
 	}
 
 	/* Add a result descriptor */
@@ -324,6 +324,9 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	return 0;
 
 unmap_result:
+	dma_unmap_single(priv->dev, req->result_dma, req->state_sz,
+			 DMA_FROM_DEVICE);
+unmap_sg:
 	dma_unmap_sg(priv->dev, areq->src, req->nents, DMA_TO_DEVICE);
 cdesc_rollback:
 	for (i = 0; i < n_cdesc; i++)
-- 
2.14.3
