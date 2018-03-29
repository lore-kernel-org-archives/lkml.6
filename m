Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeC2QHd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:07:33 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46324 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC2QHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:07:32 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 29 Mar 2018 10:07:21 -0600
Message-Id: <20180329160721.4691-5-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329160721.4691-1-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 4/4] nvmet-fc: Use new SGL alloc/free helper for requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helpers introduced earlier to allocate the SGLs for
the request.

To do this, we drop the appearantly redundant data_sg and data_sg_cnt
members as they are identical to the existing req.sg and req.sg_cnt.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/fc.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 9f2f8ab83158..00135ff7d1c2 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -74,8 +74,6 @@ struct nvmet_fc_fcp_iod {
 	struct nvme_fc_cmd_iu		cmdiubuf;
 	struct nvme_fc_ersp_iu		rspiubuf;
 	dma_addr_t			rspdma;
-	struct scatterlist		*data_sg;
-	int				data_sg_cnt;
 	u32				offset;
 	enum nvmet_fcp_datadir		io_dir;
 	bool				active;
@@ -1696,43 +1694,34 @@ EXPORT_SYMBOL_GPL(nvmet_fc_rcv_ls_req);
 static int
 nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 {
-	struct scatterlist *sg;
-	unsigned int nent;
 	int ret;
 
-	sg = sgl_alloc(fod->req.transfer_len, GFP_KERNEL, &nent);
-	if (!sg)
-		goto out;
+	ret = nvmet_req_alloc_sgl(&fod->req, &fod->queue->nvme_sq);
+	if (ret < 0)
+		return NVME_SC_INTERNAL;
 
-	fod->data_sg = sg;
-	fod->data_sg_cnt = nent;
-	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
+	ret = fc_dma_map_sg(fod->tgtport->dev, fod->req.sg, fod->req.sg_cnt,
 			    ((fod->io_dir == NVMET_FCP_WRITE) ?
 				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
 			    /* note: write from initiator perspective */
 	if (!ret)
-		goto out;
+		return NVME_SC_INTERNAL;
 
 	return 0;
-
-out:
-	return NVME_SC_INTERNAL;
 }
 
 static void
 nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 {
-	if (!fod->data_sg || !fod->data_sg_cnt)
+	if (!fod->req.sg || !fod->req.sg_cnt)
 		return;
 
-	fc_dma_unmap_sg(fod->tgtport->dev, fod->data_sg, fod->data_sg_cnt,
+	fc_dma_unmap_sg(fod->tgtport->dev, fod->req.sg, fod->req.sg_cnt,
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
-	sgl_free(fod->data_sg);
-	fod->data_sg = NULL;
-	fod->data_sg_cnt = 0;
-}
 
+	nvmet_req_free_sgl(&fod->req);
+}
 
 static bool
 queue_90percent_full(struct nvmet_fc_tgt_queue *q, u32 sqhd)
@@ -1871,7 +1860,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
 	fcpreq->fcp_error = 0;
 	fcpreq->rsplen = 0;
 
-	fcpreq->sg = &fod->data_sg[fod->offset / PAGE_SIZE];
+	fcpreq->sg = &fod->req.sg[fod->offset / PAGE_SIZE];
 	fcpreq->sg_cnt = DIV_ROUND_UP(tlen, PAGE_SIZE);
 
 	/*
@@ -2083,7 +2072,7 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
 		 * There may be a status where data still was intended to
 		 * be moved
 		 */
-		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
+		if ((fod->io_dir == NVMET_FCP_READ) && (fod->req.sg_cnt)) {
 			/* push the data over before sending rsp */
 			nvmet_fc_transfer_fcp_data(tgtport, fod,
 						NVMET_FCOP_READDATA);
@@ -2153,9 +2142,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
 
-	fod->data_sg = NULL;
-	fod->data_sg_cnt = 0;
-
 	ret = nvmet_req_init(&fod->req,
 				&fod->queue->nvme_cq,
 				&fod->queue->nvme_sq,
@@ -2178,8 +2164,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 			return;
 		}
 	}
-	fod->req.sg = fod->data_sg;
-	fod->req.sg_cnt = fod->data_sg_cnt;
 	fod->offset = 0;
 
 	if (fod->io_dir == NVMET_FCP_WRITE) {
-- 
2.11.0
