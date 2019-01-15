Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91424C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE0B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfAONni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:38 -0500
Received: from foss.arm.com ([217.140.101.70]:50726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfAONng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1773915AB;
        Tue, 15 Jan 2019 05:43:36 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55E1A3F70D;
        Tue, 15 Jan 2019 05:43:34 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Hadar Gat <hadar.gat@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] crypto: ccree: improve error handling
Date:   Tue, 15 Jan 2019 15:43:11 +0200
Message-Id: <20190115134318.28712-2-gilad@benyossef.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115134318.28712-1-gilad@benyossef.com>
References: <20190115134318.28712-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

pass the returned error code to the higher level functions

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 74 +++++++++++++---------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index dd948e1df9e5..32d2df36ced2 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -511,10 +511,8 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 	/* Map the src SGL */
 	rc = cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_nents,
 		       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
-	if (rc) {
-		rc = -ENOMEM;
+	if (rc)
 		goto cipher_exit;
-	}
 	if (mapped_nents > 1)
 		req_ctx->dma_buf_type = CC_DMA_BUF_MLLI;
 
@@ -528,12 +526,11 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 		}
 	} else {
 		/* Map the dst sg */
-		if (cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
-			      &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
-			      &dummy, &mapped_nents)) {
-			rc = -ENOMEM;
+		rc = cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
+			       &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
+			       &dummy, &mapped_nents);
+		if (rc)
 			goto cipher_exit;
-		}
 		if (mapped_nents > 1)
 			req_ctx->dma_buf_type = CC_DMA_BUF_MLLI;
 
@@ -1078,10 +1075,8 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 			       &areq_ctx->dst.nents,
 			       LLI_MAX_NUM_OF_DATA_ENTRIES, &dst_last_bytes,
 			       &dst_mapped_nents);
-		if (rc) {
-			rc = -ENOMEM;
+		if (rc)
 			goto chain_data_exit;
-		}
 	}
 
 	dst_mapped_nents = cc_get_sgl_nents(dev, req->dst, size_for_map,
@@ -1235,11 +1230,10 @@ int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 		}
 		areq_ctx->ccm_iv0_dma_addr = dma_addr;
 
-		if (cc_set_aead_conf_buf(dev, areq_ctx, areq_ctx->ccm_config,
-					 &sg_data, req->assoclen)) {
-			rc = -ENOMEM;
+		rc = cc_set_aead_conf_buf(dev, areq_ctx, areq_ctx->ccm_config,
+					  &sg_data, req->assoclen);
+		if (rc)
 			goto aead_map_failure;
-		}
 	}
 
 	if (areq_ctx->cipher_mode == DRV_CIPHER_GCTR) {
@@ -1299,10 +1293,8 @@ int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 		       (LLI_MAX_NUM_OF_ASSOC_DATA_ENTRIES +
 			LLI_MAX_NUM_OF_DATA_ENTRIES),
 		       &dummy, &mapped_nents);
-	if (rc) {
-		rc = -ENOMEM;
+	if (rc)
 		goto aead_map_failure;
-	}
 
 	if (areq_ctx->is_single_pass) {
 		/*
@@ -1386,6 +1378,7 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 	struct mlli_params *mlli_params = &areq_ctx->mlli_params;
 	struct buffer_array sg_data;
 	struct buff_mgr_handle *buff_mgr = drvdata->buff_mgr_handle;
+	int rc = 0;
 	u32 dummy = 0;
 	u32 mapped_nents = 0;
 
@@ -1405,18 +1398,18 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 	/*TODO: copy data in case that buffer is enough for operation */
 	/* map the previous buffer */
 	if (*curr_buff_cnt) {
-		if (cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
-				    &sg_data)) {
-			return -ENOMEM;
-		}
+		rc = cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
+				     &sg_data);
+		if (rc)
+			return rc;
 	}
 
 	if (src && nbytes > 0 && do_update) {
-		if (cc_map_sg(dev, src, nbytes, DMA_TO_DEVICE,
-			      &areq_ctx->in_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
-			      &dummy, &mapped_nents)) {
+		rc = cc_map_sg(dev, src, nbytes, DMA_TO_DEVICE,
+			       &areq_ctx->in_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
+			       &dummy, &mapped_nents);
+		if (rc)
 			goto unmap_curr_buff;
-		}
 		if (src && mapped_nents == 1 &&
 		    areq_ctx->data_dma_buf_type == CC_DMA_BUF_NULL) {
 			memcpy(areq_ctx->buff_sg, src,
@@ -1435,7 +1428,8 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 		/* add the src data to the sg_data */
 		cc_add_sg_entry(dev, &sg_data, areq_ctx->in_nents, src, nbytes,
 				0, true, &areq_ctx->mlli_nents);
-		if (cc_generate_mlli(dev, &sg_data, mlli_params, flags))
+		rc = cc_generate_mlli(dev, &sg_data, mlli_params, flags);
+		if (rc)
 			goto fail_unmap_din;
 	}
 	/* change the buffer index for the unmap function */
@@ -1451,7 +1445,7 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 	if (*curr_buff_cnt)
 		dma_unmap_sg(dev, areq_ctx->buff_sg, 1, DMA_TO_DEVICE);
 
-	return -ENOMEM;
+	return rc;
 }
 
 int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
@@ -1470,6 +1464,7 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	struct buffer_array sg_data;
 	struct buff_mgr_handle *buff_mgr = drvdata->buff_mgr_handle;
 	unsigned int swap_index = 0;
+	int rc = 0;
 	u32 dummy = 0;
 	u32 mapped_nents = 0;
 
@@ -1514,21 +1509,21 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	}
 
 	if (*curr_buff_cnt) {
-		if (cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
-				    &sg_data)) {
-			return -ENOMEM;
-		}
+		rc = cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
+				     &sg_data);
+		if (rc)
+			return rc;
 		/* change the buffer index for next operation */
 		swap_index = 1;
 	}
 
 	if (update_data_len > *curr_buff_cnt) {
-		if (cc_map_sg(dev, src, (update_data_len - *curr_buff_cnt),
-			      DMA_TO_DEVICE, &areq_ctx->in_nents,
-			      LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy,
-			      &mapped_nents)) {
+		rc = cc_map_sg(dev, src, (update_data_len - *curr_buff_cnt),
+			       DMA_TO_DEVICE, &areq_ctx->in_nents,
+			       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy,
+			       &mapped_nents);
+		if (rc)
 			goto unmap_curr_buff;
-		}
 		if (mapped_nents == 1 &&
 		    areq_ctx->data_dma_buf_type == CC_DMA_BUF_NULL) {
 			/* only one entry in the SG and no previous data */
@@ -1548,7 +1543,8 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 		cc_add_sg_entry(dev, &sg_data, areq_ctx->in_nents, src,
 				(update_data_len - *curr_buff_cnt), 0, true,
 				&areq_ctx->mlli_nents);
-		if (cc_generate_mlli(dev, &sg_data, mlli_params, flags))
+		rc = cc_generate_mlli(dev, &sg_data, mlli_params, flags);
+		if (rc)
 			goto fail_unmap_din;
 	}
 	areq_ctx->buff_index = (areq_ctx->buff_index ^ swap_index);
@@ -1562,7 +1558,7 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	if (*curr_buff_cnt)
 		dma_unmap_sg(dev, areq_ctx->buff_sg, 1, DMA_TO_DEVICE);
 
-	return -ENOMEM;
+	return rc;
 }
 
 void cc_unmap_hash_request(struct device *dev, void *ctx,
-- 
2.20.1

