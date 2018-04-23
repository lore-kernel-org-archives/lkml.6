Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeDWXck (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:32:40 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41938 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932643AbeDWXbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Date: Mon, 23 Apr 2018 17:30:44 -0600
Message-Id: <20180423233046.21476-13-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, keith.busch@intel.com, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 12/14] nvmet: Introduce helper functions to allocate and free request SGLs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to allocate and free the SGL in a struct nvmet_req:

int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
void nvmet_req_free_sgl(struct nvmet_req *req)

This will be expanded in a future patch to implement peer-to-peer
memory DMAs and should be common with all target drivers. The presently
unused 'sq' argument in the alloc function will be necessary to
decide whether to use peer-to-peer memory and obtain the correct
provider to allocate the memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 18 ++++++++++++++++++
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f172fd..75d44bc3e8d3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -575,6 +575,24 @@ void nvmet_req_execute(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_execute);
 
+int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
+{
+	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
+	if (!req->sg)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
+
+void nvmet_req_free_sgl(struct nvmet_req *req)
+{
+	sgl_free(req->sg);
+	req->sg = NULL;
+	req->sg_cnt = 0;
+}
+EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
+
 static inline bool nvmet_cc_en(u32 cc)
 {
 	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84ab21f8..10b162615a5e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -273,6 +273,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 void nvmet_req_uninit(struct nvmet_req *req);
 void nvmet_req_execute(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
+int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq);
+void nvmet_req_free_sgl(struct nvmet_req *req);
 
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
-- 
2.11.0
