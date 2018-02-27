Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeB0IrV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 03:47:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55296 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeB0IrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 03:47:20 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
Date: Tue, 27 Feb 2018 16:46:17 +0800
Message-Id: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, adminq and ioq0 share the same irq vector. This is
unfair for both amdinq and ioq0.
 - For adminq, its completion irq has to be bound on cpu0.
 - For ioq0, when the irq fires for io completion, the adminq irq
   action has to be checked also.

To improve this, allocate separate irq vectors for adminq and
ioq0, and not set irq affinity for adminq one.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73036d2..7f421b7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,7 +1456,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	}
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = qid;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
@@ -1909,6 +1909,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
+	struct irq_affinity affd = {.pre_vectors = 1};
+	int ret;
 
 	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1945,11 +1947,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
-			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	if (ret <= 0)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
+	dev->max_qid = ret - 1;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
-- 
2.7.4
