Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeCMJ61 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:58:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeCMJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:58:25 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: ming.lei@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] nvme-pci: assign separate irq vectors for adminq and ioq1
Date: Tue, 13 Mar 2018 17:58:08 +0800
Message-Id: <1520935088-1343-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, adminq and ioq1 share the same irq vector which is set
affinity to cpu0. If a system allows cpu0 to be offlined, the adminq
will not be able work any more.

To fix this, assign separate irq vectors for adminq and ioq1. Set
.pre_vectors == 1 when allocate irq vectors, then assign the first
one to adminq which will have affinity cpumask with all possible
cpus. On the other hand, if controller has only legacy or single
-message MSI, we will setup adminq and 1 ioq and let them share
the only one irq vector.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
V2->V3
 - change changelog based on Ming's insights
 - some cleanup based on Andy's suggestions

V1->V2
 - add case to handle the scenario where there is only one irq
   vector
 - add nvme_ioq_vector to map ioq vector and qid

 drivers/nvme/host/pci.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b6f43b7..47c33f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -84,6 +84,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
 	unsigned max_qid;
+	unsigned int num_vecs;
 	int q_depth;
 	u32 db_stride;
 	void __iomem *bar;
@@ -139,6 +140,17 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
+static inline unsigned int nvme_ioq_vector(struct nvme_dev *dev,
+		unsigned int qid)
+{
+	/*
+	 * If controller has only legacy or single-message MSI, there will
+	 * be only 1 irq vector. At the moment, we setup adminq + 1 ioq
+	 * and let them share irq vector.
+	 */
+	return (dev->num_vecs == 1) ? 0 : qid;
+}
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -1457,7 +1469,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	}
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = nvme_ioq_vector(dev, qid);
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		goto release_vector;
@@ -1628,11 +1640,12 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max;
 	int ret = 0;
+	int vec;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
-		/* vector == qid - 1, match nvme_create_queue */
+		vec = nvme_ioq_vector(dev, i);
 		if (nvme_alloc_queue(dev, i, dev->q_depth,
-		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
+		     pci_irq_get_node(to_pci_dev(dev->dev), vec))) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -1913,6 +1926,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
+	struct irq_affinity affd = {.pre_vectors = 1};
+	int ret;
 
 	nr_io_queues = num_possible_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1949,11 +1964,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
+	dev->num_vecs = ret;
+	dev->max_qid = max(ret - 1, 1);
 
 	/*
 	 * Should investigate if there's a performance win from allocating
-- 
2.7.4
