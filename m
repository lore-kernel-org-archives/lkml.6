Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0A120645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqnpC9rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0A120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbeJICGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbeJICGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A1D204FD;
        Mon,  8 Oct 2018 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024805;
        bh=y+LqplVdF2cmIOdDO8LOJjkBqAmHPa2qVUCEhX9ciIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqnpC9rOtWBChT57y6ruNU3ev+NmDX5XcQuT9Wg4TKBueW7tL8tj25ONSu9MRGfwr
         7TpH1MqO28+ziI8cN/3fDAvPGdZJs/OJfid1djBzxkIn7lmb9ZgxE380Ousi2g1QGW
         So6Ml9dL6b4bGNxiHXAck5giyRmhIHm/6KkAy+TM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 159/168] crypto: chelsio - Fix memory corruption in DMA Mapped buffers.
Date:   Mon,  8 Oct 2018 20:32:19 +0200
Message-Id: <20181008175626.097727728@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harsh Jain <harsh@chelsio.com>

commit add92a817e60e308a419693413a38d9d1e663aff upstream.

Update PCI Id in "cpl_rx_phys_dsgl" header. In case pci_chan_id and
tx_chan_id are not derived from same queue, H/W can send request
completion indication before completing DMA Transfer.

Herbert, It would be good if fix can be merge to stable tree.
For 4.14 kernel, It requires some update to avoid mege conficts.

Cc: <stable@vger.kernel.org>
Signed-off-by: Harsh Jain <harsh@chelsio.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/chelsio/chcr_algo.c   |   32 ++++++++++++++++++++++----------
 drivers/crypto/chelsio/chcr_crypto.h |    2 ++
 2 files changed, 24 insertions(+), 10 deletions(-)

--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -367,7 +367,8 @@ static inline void dsgl_walk_init(struct
 	walk->to = (struct phys_sge_pairs *)(dsgl + 1);
 }
 
-static inline void dsgl_walk_end(struct dsgl_walk *walk, unsigned short qid)
+static inline void dsgl_walk_end(struct dsgl_walk *walk, unsigned short qid,
+				 int pci_chan_id)
 {
 	struct cpl_rx_phys_dsgl *phys_cpl;
 
@@ -385,6 +386,7 @@ static inline void dsgl_walk_end(struct
 	phys_cpl->rss_hdr_int.opcode = CPL_RX_PHYS_ADDR;
 	phys_cpl->rss_hdr_int.qid = htons(qid);
 	phys_cpl->rss_hdr_int.hash_val = 0;
+	phys_cpl->rss_hdr_int.channel = pci_chan_id;
 }
 
 static inline void dsgl_walk_add_page(struct dsgl_walk *walk,
@@ -718,7 +720,7 @@ static inline void create_wreq(struct ch
 		FILL_WR_RX_Q_ID(ctx->dev->rx_channel_id, qid,
 				!!lcb, ctx->tx_qidx);
 
-	chcr_req->ulptx.cmd_dest = FILL_ULPTX_CMD_DEST(ctx->dev->tx_channel_id,
+	chcr_req->ulptx.cmd_dest = FILL_ULPTX_CMD_DEST(ctx->tx_chan_id,
 						       qid);
 	chcr_req->ulptx.len = htonl((DIV_ROUND_UP(len16, 16) -
 				     ((sizeof(chcr_req->wreq)) >> 4)));
@@ -1339,16 +1341,23 @@ static int chcr_device_init(struct chcr_
 				    adap->vres.ncrypto_fc);
 		rxq_perchan = u_ctx->lldi.nrxq / u_ctx->lldi.nchan;
 		txq_perchan = ntxq / u_ctx->lldi.nchan;
-		rxq_idx = ctx->dev->tx_channel_id * rxq_perchan;
-		rxq_idx += id % rxq_perchan;
-		txq_idx = ctx->dev->tx_channel_id * txq_perchan;
-		txq_idx += id % txq_perchan;
 		spin_lock(&ctx->dev->lock_chcr_dev);
-		ctx->rx_qidx = rxq_idx;
-		ctx->tx_qidx = txq_idx;
+		ctx->tx_chan_id = ctx->dev->tx_channel_id;
 		ctx->dev->tx_channel_id = !ctx->dev->tx_channel_id;
 		ctx->dev->rx_channel_id = 0;
 		spin_unlock(&ctx->dev->lock_chcr_dev);
+		rxq_idx = ctx->tx_chan_id * rxq_perchan;
+		rxq_idx += id % rxq_perchan;
+		txq_idx = ctx->tx_chan_id * txq_perchan;
+		txq_idx += id % txq_perchan;
+		ctx->rx_qidx = rxq_idx;
+		ctx->tx_qidx = txq_idx;
+		/* Channel Id used by SGE to forward packet to Host.
+		 * Same value should be used in cpl_fw6_pld RSS_CH field
+		 * by FW. Driver programs PCI channel ID to be used in fw
+		 * at the time of queue allocation with value "pi->tx_chan"
+		 */
+		ctx->pci_chan_id = txq_idx / txq_perchan;
 	}
 out:
 	return err;
@@ -2503,6 +2512,7 @@ void chcr_add_aead_dst_ent(struct aead_r
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct dsgl_walk dsgl_walk;
 	unsigned int authsize = crypto_aead_authsize(tfm);
+	struct chcr_context *ctx = a_ctx(tfm);
 	u32 temp;
 
 	dsgl_walk_init(&dsgl_walk, phys_cpl);
@@ -2512,7 +2522,7 @@ void chcr_add_aead_dst_ent(struct aead_r
 	dsgl_walk_add_page(&dsgl_walk, IV, &reqctx->iv_dma);
 	temp = req->cryptlen + (reqctx->op ? -authsize : authsize);
 	dsgl_walk_add_sg(&dsgl_walk, req->dst, temp, req->assoclen);
-	dsgl_walk_end(&dsgl_walk, qid);
+	dsgl_walk_end(&dsgl_walk, qid, ctx->pci_chan_id);
 }
 
 void chcr_add_cipher_src_ent(struct ablkcipher_request *req,
@@ -2544,6 +2554,8 @@ void chcr_add_cipher_dst_ent(struct ablk
 			     unsigned short qid)
 {
 	struct chcr_blkcipher_req_ctx *reqctx = ablkcipher_request_ctx(req);
+	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(wrparam->req);
+	struct chcr_context *ctx = c_ctx(tfm);
 	struct dsgl_walk dsgl_walk;
 
 	dsgl_walk_init(&dsgl_walk, phys_cpl);
@@ -2552,7 +2564,7 @@ void chcr_add_cipher_dst_ent(struct ablk
 	reqctx->dstsg = dsgl_walk.last_sg;
 	reqctx->dst_ofst = dsgl_walk.last_sg_len;
 
-	dsgl_walk_end(&dsgl_walk, qid);
+	dsgl_walk_end(&dsgl_walk, qid, ctx->pci_chan_id);
 }
 
 void chcr_add_hash_src_ent(struct ahash_request *req,
--- a/drivers/crypto/chelsio/chcr_crypto.h
+++ b/drivers/crypto/chelsio/chcr_crypto.h
@@ -255,6 +255,8 @@ struct chcr_context {
 	struct chcr_dev *dev;
 	unsigned char tx_qidx;
 	unsigned char rx_qidx;
+	unsigned char tx_chan_id;
+	unsigned char pci_chan_id;
 	struct __crypto_ctx crypto_ctx[0];
 };
 


