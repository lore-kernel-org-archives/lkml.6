Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967670AbeEXJvS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:51:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36250 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967312AbeEXJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:51:10 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme-pci: set nvmeq->cq_vector after alloc cq/sq
Date: Thu, 24 May 2018 17:51:33 +0800
Message-Id: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805240119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently nvmeq->cq_vector is set before alloc cq/sq. If the alloc
cq/sq command timeout, nvme_suspend_queue will invoke free_irq
for the nvmeq because the cq_vector is valid, this will cause warning
'Trying to free already-free IRQ xxx'. set nvmeq->cq_vector after
alloc cq/sq successes to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190..70b79f2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1070,7 +1070,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 }
 
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue *nvmeq)
+						struct nvme_queue *nvmeq, int cq_vector)
 {
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
@@ -1085,7 +1085,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
-	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
+	c.create_cq.irq_vector = cpu_to_le16(cq_vector);
 
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
@@ -1459,6 +1459,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
+	int cq_vector;
 
 	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
@@ -1471,15 +1472,21 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
 	 */
-	nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
-	result = adapter_alloc_cq(dev, qid, nvmeq);
+	cq_vector = dev->num_vecs == 1 ? 0 : qid;
+	result = adapter_alloc_cq(dev, qid, nvmeq, cq_vector);
 	if (result < 0)
-		goto release_vector;
+		goto out;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
 		goto release_cq;
 
+	/*
+	 * set cq_vector after alloc cq/sq, otherwise, if alloc cq/sq command
+	 * timeout, nvme_suspend_queue will invoke free_irq for it and cause warning
+	 * 'Trying to free already-free IRQ xxx'
+	 */
+	nvmeq->cq_vector = cq_vector;
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
@@ -1487,13 +1494,13 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 
 	return result;
 
- release_sq:
+release_sq:
+	nvmeq->cq_vector = -1;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
- release_cq:
+release_cq:
 	adapter_delete_cq(dev, qid);
- release_vector:
-	nvmeq->cq_vector = -1;
+out:
 	return result;
 }
 
-- 
2.7.4
