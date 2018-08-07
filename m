Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D6C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732862172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732862172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbeHGVJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388973AbeHGVJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE5B1D01;
        Tue,  7 Aug 2018 18:53:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.14 16/21] nvmet-fc: fix target sgl list on large transfers
Date:   Tue,  7 Aug 2018 20:51:30 +0200
Message-Id: <20180807172331.700247908@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

commit d082dc1562a2ff0947b214796f12faaa87e816a9 upstream.

The existing code to carve up the sg list expected an sg element-per-page
which can be very incorrect with iommu's remapping multiple memory pages
to fewer bus addresses. To hit this error required a large io payload
(greater than 256k) and a system that maps on a per-page basis. It's
possible that large ios could get by fine if the system condensed the
sgl list into the first 64 elements.

This patch corrects the sg list handling by specifically walking the
sg list element by element and attempting to divide the transfer up
on a per-sg element boundary. While doing so, it still tries to keep
sequences under 256k, but will exceed that rule if a single sg element
is larger than 256k.

Fixes: 48fa362b6c3f ("nvmet-fc: simplify sg list handling")
Cc: <stable@vger.kernel.org> # 4.14
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/nvme/target/fc.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -58,8 +58,8 @@ struct nvmet_fc_ls_iod {
 	struct work_struct		work;
 } __aligned(sizeof(unsigned long long));
 
+/* desired maximum for a single sequence - if sg list allows it */
 #define NVMET_FC_MAX_SEQ_LENGTH		(256 * 1024)
-#define NVMET_FC_MAX_XFR_SGENTS		(NVMET_FC_MAX_SEQ_LENGTH / PAGE_SIZE)
 
 enum nvmet_fcp_datadir {
 	NVMET_FCP_NODATA,
@@ -74,6 +74,7 @@ struct nvmet_fc_fcp_iod {
 	struct nvme_fc_cmd_iu		cmdiubuf;
 	struct nvme_fc_ersp_iu		rspiubuf;
 	dma_addr_t			rspdma;
+	struct scatterlist		*next_sg;
 	struct scatterlist		*data_sg;
 	int				data_sg_cnt;
 	u32				total_length;
@@ -1000,8 +1001,7 @@ nvmet_fc_register_targetport(struct nvme
 	INIT_LIST_HEAD(&newrec->assoc_list);
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
-	newrec->max_sg_cnt = min_t(u32, NVMET_FC_MAX_XFR_SGENTS,
-					template->max_sgl_segments);
+	newrec->max_sg_cnt = template->max_sgl_segments;
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
@@ -1717,6 +1717,7 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_f
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
 				/* note: write from initiator perspective */
+	fod->next_sg = fod->data_sg;
 
 	return 0;
 
@@ -1874,24 +1875,49 @@ nvmet_fc_transfer_fcp_data(struct nvmet_
 				struct nvmet_fc_fcp_iod *fod, u8 op)
 {
 	struct nvmefc_tgt_fcp_req *fcpreq = fod->fcpreq;
+	struct scatterlist *sg = fod->next_sg;
 	unsigned long flags;
-	u32 tlen;
+	u32 remaininglen = fod->total_length - fod->offset;
+	u32 tlen = 0;
 	int ret;
 
 	fcpreq->op = op;
 	fcpreq->offset = fod->offset;
 	fcpreq->timeout = NVME_FC_TGTOP_TIMEOUT_SEC;
 
-	tlen = min_t(u32, tgtport->max_sg_cnt * PAGE_SIZE,
-			(fod->total_length - fod->offset));
+	/*
+	 * for next sequence:
+	 *  break at a sg element boundary
+	 *  attempt to keep sequence length capped at
+	 *    NVMET_FC_MAX_SEQ_LENGTH but allow sequence to
+	 *    be longer if a single sg element is larger
+	 *    than that amount. This is done to avoid creating
+	 *    a new sg list to use for the tgtport api.
+	 */
+	fcpreq->sg = sg;
+	fcpreq->sg_cnt = 0;
+	while (tlen < remaininglen &&
+	       fcpreq->sg_cnt < tgtport->max_sg_cnt &&
+	       tlen + sg_dma_len(sg) < NVMET_FC_MAX_SEQ_LENGTH) {
+		fcpreq->sg_cnt++;
+		tlen += sg_dma_len(sg);
+		sg = sg_next(sg);
+	}
+	if (tlen < remaininglen && fcpreq->sg_cnt == 0) {
+		fcpreq->sg_cnt++;
+		tlen += min_t(u32, sg_dma_len(sg), remaininglen);
+		sg = sg_next(sg);
+	}
+	if (tlen < remaininglen)
+		fod->next_sg = sg;
+	else
+		fod->next_sg = NULL;
+
 	fcpreq->transfer_length = tlen;
 	fcpreq->transferred_length = 0;
 	fcpreq->fcp_error = 0;
 	fcpreq->rsplen = 0;
 
-	fcpreq->sg = &fod->data_sg[fod->offset / PAGE_SIZE];
-	fcpreq->sg_cnt = DIV_ROUND_UP(tlen, PAGE_SIZE);
-
 	/*
 	 * If the last READDATA request: check if LLDD supports
 	 * combined xfr with response.


