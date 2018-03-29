Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeC2QH4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:07:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC2QHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:07:35 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 29 Mar 2018 10:07:20 -0600
Message-Id: <20180329160721.4691-4-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329160721.4691-1-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the dma_map_sg call
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating an SGL, the fibre channel target uses the number
of entities mapped as the number of entities in a given scatter
gather list. This is incorrect.

The DMA-API-HOWTO document gives this note:

   The 'nents' argument to the dma_unmap_sg call must be
   the _same_ one you passed into the dma_map_sg call,
   it should _NOT_ be the 'count' value _returned_ from the
   dma_map_sg call.

The fc code only stores the count value returned form the dma_map_sg()
call and uses that value in the call to dma_unmap_sg().

The dma_map_sg() call will return a lower count than nents when multiple
SG entries were merged into one. This implies that there will be fewer
DMA address and length entries but the original number of page entries
in the SGL. So if this occurs, when the SGL reaches nvmet_execute_rw(),
a bio would be created with fewer than the total number of entries.

As odd as it sounds, and as far as I can tell, the number of SG entries
mapped does not appear to be used anywhere in the fc driver and therefore
there's no current need to store it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Fixes: c53432030d8642 ("nvme-fabrics: Add target support for FC transport")
---
 drivers/nvme/target/fc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 9b39a6cb1935..9f2f8ab83158 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1698,6 +1698,7 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 {
 	struct scatterlist *sg;
 	unsigned int nent;
+	int ret;
 
 	sg = sgl_alloc(fod->req.transfer_len, GFP_KERNEL, &nent);
 	if (!sg)
@@ -1705,10 +1706,12 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 
 	fod->data_sg = sg;
 	fod->data_sg_cnt = nent;
-	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
-				((fod->io_dir == NVMET_FCP_WRITE) ?
-					DMA_FROM_DEVICE : DMA_TO_DEVICE));
-				/* note: write from initiator perspective */
+	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
+			    ((fod->io_dir == NVMET_FCP_WRITE) ?
+				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
+			    /* note: write from initiator perspective */
+	if (!ret)
+		goto out;
 
 	return 0;
 
-- 
2.11.0
