Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbeDWXch (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:32:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41936 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932567AbeDWXbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:31:05 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 23 Apr 2018 17:30:45 -0600
Message-Id: <20180423233046.21476-14-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, keith.busch@intel.com, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 13/14] nvmet-rdma: Use new SGL alloc/free helper for requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helpers introduced in the previous patch to allocate
the SGLs for the request.

Seeing we use req.transfer_len as the length of the SGL it is
set earlier and cleared on any error. It also seems to be unnecessary
to accumulate the length as the map_sgl functions should only ever
be called once.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/rdma.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d579a7..f7a3459d618f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -430,7 +430,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 	}
 
 	if (rsp->req.sg != &rsp->cmd->inline_sg)
-		sgl_free(rsp->req.sg);
+		nvmet_req_free_sgl(&rsp->req);
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
 		nvmet_rdma_process_wr_wait_list(queue);
@@ -564,24 +564,24 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 {
 	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
 	u64 addr = le64_to_cpu(sgl->addr);
-	u32 len = get_unaligned_le24(sgl->length);
 	u32 key = get_unaligned_le32(sgl->key);
 	int ret;
 
+	rsp->req.transfer_len = get_unaligned_le24(sgl->length);
+
 	/* no data command? */
-	if (!len)
+	if (!rsp->req.transfer_len)
 		return 0;
 
-	rsp->req.sg = sgl_alloc(len, GFP_KERNEL, &rsp->req.sg_cnt);
-	if (!rsp->req.sg)
-		return NVME_SC_INTERNAL;
+	ret = nvmet_req_alloc_sgl(&rsp->req, &rsp->queue->nvme_sq);
+	if (ret < 0)
+		goto error_out;
 
 	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
 			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
 			nvmet_data_dir(&rsp->req));
 	if (ret < 0)
-		return NVME_SC_INTERNAL;
-	rsp->req.transfer_len += len;
+		goto error_out;
 	rsp->n_rdma += ret;
 
 	if (invalidate) {
@@ -590,6 +590,10 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	}
 
 	return 0;
+
+error_out:
+	rsp->req.transfer_len = 0;
+	return NVME_SC_INTERNAL;
 }
 
 static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
-- 
2.11.0
