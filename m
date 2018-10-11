Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAE6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014952148C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezjSkt3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014952148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbeJKXO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbeJKXO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1E32098A;
        Thu, 11 Oct 2018 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272802;
        bh=Lwj6ETESWY2a9mvPpg0eNqgrWlAn/Yv6u8721nkJf6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezjSkt3L9mfJFne4yn5qAm2ni280lQhecqRtqaleDAcjy5gDnnePh4q42uq30dv+t
         WhoaV7i0rQEc7FRBynxdLePnuVCGvsqJ08ASgI8nWhyHFlEchDWmLyvXjL7CG407DB
         JvHejF3uHGp2loi1tuGwFANyvp6ZPGUw/yW79XEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 37/45] crypto: chelsio - Fix memory corruption in DMA Mapped buffers.
Date:   Thu, 11 Oct 2018 17:40:04 +0200
Message-Id: <20181011152510.543202213@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/crypto/chelsio/chcr_algo.c   |   41 +++++++++++++++++++++++------------
 drivers/crypto/chelsio/chcr_crypto.h |    2 +
 2 files changed, 29 insertions(+), 14 deletions(-)

--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -384,7 +384,8 @@ static inline int is_hmac(struct crypto_
 
 static void write_phys_cpl(struct cpl_rx_phys_dsgl *phys_cpl,
 			   struct scatterlist *sg,
-			   struct phys_sge_parm *sg_param)
+			   struct phys_sge_parm *sg_param,
+			   int pci_chan_id)
 {
 	struct phys_sge_pairs *to;
 	unsigned int len = 0, left_size = sg_param->obsize;
@@ -402,6 +403,7 @@ static void write_phys_cpl(struct cpl_rx
 	phys_cpl->rss_hdr_int.opcode = CPL_RX_PHYS_ADDR;
 	phys_cpl->rss_hdr_int.qid = htons(sg_param->qid);
 	phys_cpl->rss_hdr_int.hash_val = 0;
+	phys_cpl->rss_hdr_int.channel = pci_chan_id;
 	to = (struct phys_sge_pairs *)((unsigned char *)phys_cpl +
 				       sizeof(struct cpl_rx_phys_dsgl));
 	for (i = 0; nents && left_size; to++) {
@@ -418,7 +420,8 @@ static void write_phys_cpl(struct cpl_rx
 static inline int map_writesg_phys_cpl(struct device *dev,
 					struct cpl_rx_phys_dsgl *phys_cpl,
 					struct scatterlist *sg,
-					struct phys_sge_parm *sg_param)
+					struct phys_sge_parm *sg_param,
+					int pci_chan_id)
 {
 	if (!sg || !sg_param->nents)
 		return -EINVAL;
@@ -428,7 +431,7 @@ static inline int map_writesg_phys_cpl(s
 		pr_err("CHCR : DMA mapping failed\n");
 		return -EINVAL;
 	}
-	write_phys_cpl(phys_cpl, sg, sg_param);
+	write_phys_cpl(phys_cpl, sg, sg_param, pci_chan_id);
 	return 0;
 }
 
@@ -608,7 +611,7 @@ static inline void create_wreq(struct ch
 				is_iv ? iv_loc : IV_NOP, !!lcb,
 				ctx->tx_qidx);
 
-	chcr_req->ulptx.cmd_dest = FILL_ULPTX_CMD_DEST(ctx->dev->tx_channel_id,
+	chcr_req->ulptx.cmd_dest = FILL_ULPTX_CMD_DEST(ctx->tx_chan_id,
 						       qid);
 	chcr_req->ulptx.len = htonl((DIV_ROUND_UP((calc_tx_flits_ofld(skb) * 8),
 					16) - ((sizeof(chcr_req->wreq)) >> 4)));
@@ -698,7 +701,8 @@ static struct sk_buff *create_cipher_wr(
 	sg_param.obsize =  wrparam->bytes;
 	sg_param.qid = wrparam->qid;
 	error = map_writesg_phys_cpl(&u_ctx->lldi.pdev->dev, phys_cpl,
-				       reqctx->dst, &sg_param);
+				       reqctx->dst, &sg_param,
+				       ctx->pci_chan_id);
 	if (error)
 		goto map_fail1;
 
@@ -1228,16 +1232,23 @@ static int chcr_device_init(struct chcr_
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
@@ -2066,7 +2077,8 @@ static struct sk_buff *create_authenc_wr
 	sg_param.obsize = req->cryptlen + (op_type ? -authsize : authsize);
 	sg_param.qid = qid;
 	error = map_writesg_phys_cpl(&u_ctx->lldi.pdev->dev, phys_cpl,
-					reqctx->dst, &sg_param);
+					reqctx->dst, &sg_param,
+					ctx->pci_chan_id);
 	if (error)
 		goto dstmap_fail;
 
@@ -2389,7 +2401,7 @@ static struct sk_buff *create_aead_ccm_w
 	sg_param.obsize = req->cryptlen + (op_type ? -authsize : authsize);
 	sg_param.qid = qid;
 	error = map_writesg_phys_cpl(&u_ctx->lldi.pdev->dev, phys_cpl,
-				 reqctx->dst, &sg_param);
+				 reqctx->dst, &sg_param, ctx->pci_chan_id);
 	if (error)
 		goto dstmap_fail;
 
@@ -2545,7 +2557,8 @@ static struct sk_buff *create_gcm_wr(str
 	sg_param.obsize = req->cryptlen + (op_type ? -authsize : authsize);
 	sg_param.qid = qid;
 	error = map_writesg_phys_cpl(&u_ctx->lldi.pdev->dev, phys_cpl,
-					  reqctx->dst, &sg_param);
+					  reqctx->dst, &sg_param,
+					  ctx->pci_chan_id);
 	if (error)
 		goto dstmap_fail;
 
--- a/drivers/crypto/chelsio/chcr_crypto.h
+++ b/drivers/crypto/chelsio/chcr_crypto.h
@@ -222,6 +222,8 @@ struct chcr_context {
 	struct chcr_dev *dev;
 	unsigned char tx_qidx;
 	unsigned char rx_qidx;
+	unsigned char tx_chan_id;
+	unsigned char pci_chan_id;
 	struct __crypto_ctx crypto_ctx[0];
 };
 


